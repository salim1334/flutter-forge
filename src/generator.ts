import fs from 'fs-extra';
import path from 'node:path';
import YAML from 'yaml';
import { copyAndRenderTemplates, type TemplateContext } from './templateEngine.js';
import { getTemplatesDir } from './utils/paths.js';
import { log, spinner } from './utils/logger.js';

const FORGE_DEPS: Record<string, string> = {
  get: '^4.6.6',
  sqflite: '^2.4.1',
  path: '^1.9.0',
  intl: '^0.20.2',
  logger: '^2.5.0',
  google_fonts: '^6.2.1',
  flutter_dotenv: '^5.2.1',
  connectivity_plus: '^6.1.4',
  device_info_plus: '^11.3.3',
};

const FORGE_DEV_DEPS: Record<string, string> = {
  flutter_lints: '^5.0.0',
};

function sortKeys<T>(obj: Record<string, T>): Record<string, T> {
  return Object.fromEntries(
    Object.entries(obj).sort(([a], [b]) => a.localeCompare(b)),
  ) as Record<string, T>;
}

export async function mergePubspec(
  projectPath: string,
  context: TemplateContext,
): Promise<void> {
  const pubspecPath = path.join(projectPath, 'pubspec.yaml');
  const content = await fs.readFile(pubspecPath, 'utf8');
  const doc = YAML.parse(content) as Record<string, unknown>;

  doc.description = context.description ?? doc.description;

  const deps = (doc.dependencies as Record<string, unknown>) ?? {};
  for (const [name, version] of Object.entries(FORGE_DEPS)) {
    if (!deps[name]) deps[name] = version;
  }
  doc.dependencies = sortKeys(deps);

  const devDeps = (doc.dev_dependencies as Record<string, unknown>) ?? {};
  for (const [name, version] of Object.entries(FORGE_DEV_DEPS)) {
    if (!devDeps[name]) devDeps[name] = version;
  }
  doc.dev_dependencies = sortKeys(devDeps);

  const assets = (doc.flutter as Record<string, unknown>)?.assets as string[] | undefined;
  const flutterSection = (doc.flutter as Record<string, unknown>) ?? {};
  const assetList = new Set(assets ?? []);
  assetList.add('assets/images/');
  assetList.add('.env');
  flutterSection.assets = Array.from(assetList);
  doc.flutter = flutterSection;

  await fs.writeFile(pubspecPath, YAML.stringify(doc), 'utf8');
}

export async function ensureEnvFiles(projectPath: string): Promise<void> {
  const examplePath = path.join(projectPath, '.env.example');
  const envPath = path.join(projectPath, '.env');
  if (!(await fs.pathExists(envPath)) && (await fs.pathExists(examplePath))) {
    await fs.copy(examplePath, envPath);
  }

  const gitignorePath = path.join(projectPath, '.gitignore');
  if (await fs.pathExists(gitignorePath)) {
    let gitignore = await fs.readFile(gitignorePath, 'utf8');
    if (!gitignore.includes('.env')) {
      gitignore += '\n# Environment secrets\n.env\n';
      await fs.writeFile(gitignorePath, gitignore, 'utf8');
    }
  }
}

export async function applyTemplates(
  projectPath: string,
  context: TemplateContext & { description?: string },
): Promise<void> {
  const spin = spinner('Applying Flutter Forge templates...');
  const templatesDir = getTemplatesDir();
  const libDest = path.join(projectPath, 'lib');

  await fs.remove(libDest);
  const testDest = path.join(projectPath, 'test');
  await fs.remove(testDest);
  await copyAndRenderTemplates(templatesDir, projectPath, context);

  await mergePubspec(projectPath, context);
  await ensureEnvFiles(projectPath);

  const imagesDir = path.join(projectPath, 'assets', 'images');
  await fs.ensureDir(imagesDir);
  const placeholder = path.join(imagesDir, '.gitkeep');
  if (!(await fs.pathExists(placeholder))) {
    await fs.writeFile(placeholder, '', 'utf8');
  }

  if (!context.includeNotes) {
    const notesDao = path.join(projectPath, 'lib', 'data', 'local', 'daos', 'notes_dao.dart');
    if (await fs.pathExists(notesDao)) {
      await fs.remove(notesDao);
    }
  }

  spin.succeed('Templates applied');
}

export async function isForgeProject(projectPath: string): Promise<boolean> {
  return fs.pathExists(path.join(projectPath, 'lib', 'routes', 'app_pages.dart'));
}
