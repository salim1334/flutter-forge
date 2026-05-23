import ejs from 'ejs';
import fs from 'fs-extra';
import path from 'node:path';
import { isForgeProject } from '../generator.js';
import { getFeatureTemplateDir } from '../utils/paths.js';
import { log, spinner } from '../utils/logger.js';
import {
  toCamelCase,
  toDartPackageName,
  toPascalCase,
  validateProjectName,
} from '../utils/validateProjectName.js';

export interface FeatureOptions {
  withModel?: boolean;
  route?: string;
  noBinding?: boolean;
}

export async function runFeature(
  featureName: string,
  options: FeatureOptions,
): Promise<void> {
  const projectPath = process.cwd();

  if (!(await isForgeProject(projectPath))) {
    throw new Error(
      'Not a Flutter Forge project. Run from a project with lib/routes/app_pages.dart',
    );
  }

  const validation = validateProjectName(featureName);
  if (!validation.valid) {
    throw new Error(validation.errors.join('\n'));
  }

  const featureSnake = validation.packageName;
  const featurePascal = toPascalCase(featureSnake);
  const featureCamel = toCamelCase(featureSnake);
  const routePath = options.route ?? `/${featureSnake.replace(/_/g, '-')}`;

  const featureDir = path.join(projectPath, 'lib', 'features', featureSnake);
  if (await fs.pathExists(featureDir)) {
    throw new Error(`Feature "${featureSnake}" already exists at ${featureDir}`);
  }

  const routesPath = path.join(projectPath, 'lib', 'routes', 'app_routes.dart');
  const routesContent = await fs.readFile(routesPath, 'utf8');
  if (routesContent.includes(`static const ${featureCamel}`)) {
    throw new Error(`Route for feature "${featureSnake}" already exists.`);
  }

  const pubspecPath = path.join(projectPath, 'pubspec.yaml');
  const pubspec = await fs.readFile(pubspecPath, 'utf8');
  const packageMatch = pubspec.match(/^name:\s*(\S+)/m);
  const packageName = packageMatch?.[1] ?? 'my_app';

  const context = {
    projectName: path.basename(projectPath),
    packageName,
    featureSnake,
    featurePascal,
    featureCamel,
    routePath,
    withModel: options.withModel ?? false,
    withBinding: !options.noBinding,
    org: 'com.example',
    welcomeMessage: '',
    includeNotes: false,
  };

  const spin = spinner(`Scaffolding feature "${featureSnake}"...`);
  await scaffoldFeatureFiles(featureDir, context);
  await wireRoutes(projectPath, context);
  spin.succeed(`Feature "${featureSnake}" created and wired to routes`);
  log.info(`  lib/features/${featureSnake}/`);
  log.info(`  Route: ${routePath}`);
}

async function renderTemplateFile(
  templateName: string,
  destPath: string,
  context: Record<string, unknown>,
): Promise<void> {
  const templatePath = path.join(getFeatureTemplateDir(), templateName);
  const template = await fs.readFile(templatePath, 'utf8');
  const rendered = ejs.render(template, context, { filename: templatePath });
  if (rendered.trim().length === 0) return;
  await fs.ensureDir(path.dirname(destPath));
  await fs.writeFile(destPath, rendered, 'utf8');
}

async function scaffoldFeatureFiles(
  featureDir: string,
  context: {
    featureSnake: string;
    featurePascal: string;
    withModel: boolean;
    withBinding: boolean;
    packageName: string;
  },
): Promise<void> {
  const { featureSnake, featurePascal, withModel, withBinding, packageName } = context;
  const ctx = { ...context, packageName };

  await fs.ensureDir(path.join(featureDir, 'widgets'));
  await fs.writeFile(path.join(featureDir, 'widgets', '.gitkeep'), '', 'utf8');

  await renderTemplateFile(
    'controller.dart',
    path.join(featureDir, 'controllers', `${featureSnake}_controller.dart`),
    ctx,
  );
  await renderTemplateFile(
    'view.dart',
    path.join(featureDir, 'views', `${featureSnake}_view.dart`),
    ctx,
  );

  if (withBinding) {
    await renderTemplateFile(
      'binding.dart',
      path.join(featureDir, 'bindings', `${featureSnake}_binding.dart`),
      ctx,
    );
  }

  if (withModel) {
    await renderTemplateFile(
      'model.dart',
      path.join(featureDir, 'models', `${featureSnake}_model.dart`),
      ctx,
    );
  }
}

async function wireRoutes(
  projectPath: string,
  context: {
    featureSnake: string;
    featurePascal: string;
    featureCamel: string;
    routePath: string;
    withBinding: boolean;
    packageName: string;
  },
): Promise<void> {
  const { featureSnake, featurePascal, featureCamel, routePath, withBinding, packageName } =
    context;

  const routesFile = path.join(projectPath, 'lib', 'routes', 'app_routes.dart');
  let routes = await fs.readFile(routesFile, 'utf8');

  const routeConst = `  static const ${featureCamel} = '${routePath}';`;
  routes = routes.replace(
    '// FORGE:ROUTES',
    `${routeConst}\n  // FORGE:ROUTES`,
  );
  await fs.writeFile(routesFile, routes, 'utf8');

  const pagesFile = path.join(projectPath, 'lib', 'routes', 'app_pages.dart');
  let pages = await fs.readFile(pagesFile, 'utf8');

  const bindingImport = withBinding
    ? `import 'package:${packageName}/features/${featureSnake}/bindings/${featureSnake}_binding.dart';\n`
    : '';
  const viewImport = `import 'package:${packageName}/features/${featureSnake}/views/${featureSnake}_view.dart';\n`;

  if (!pages.includes(viewImport.trim())) {
    pages = pages.replace(
      '// FORGE:IMPORTS',
      `${viewImport}${bindingImport}// FORGE:IMPORTS`,
    );
  }

  const bindingLine = withBinding ? `binding: ${featurePascal}Binding(),` : '';
  const pageEntry = `    GetPage(
      name: AppRoutes.${featureCamel},
      page: () => const ${featurePascal}View(),
      ${bindingLine}
      transition: Transition.rightToLeft,
    ),`;

  pages = pages.replace('// FORGE:PAGES', `${pageEntry}\n    // FORGE:PAGES`);
  await fs.writeFile(pagesFile, pages, 'utf8');
}
