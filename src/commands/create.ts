import fs from 'fs-extra';
import path from 'node:path';
import { Command } from 'commander';
import { applyTemplates } from '../generator.js';
import { promptCreateOptions } from '../prompts.js';
import {
  checkFlutterInstalled,
  runFlutterAnalyze,
  runFlutterCreate,
  runFlutterPubGet,
} from '../runner.js';
import { printBanner, printSuccess, log } from '../utils/logger.js';
import { validateProjectName } from '../utils/validateProjectName.js';

const WELCOME_MESSAGE =
  "We've already come halfway together — now let's build the rest.";

export interface CreateOptions {
  yes?: boolean;
  org?: string;
  platforms?: string;
  noNotes?: boolean;
  dryRun?: boolean;
  skipFlutterCreate?: boolean;
}

export async function runCreate(argv: string[]): Promise<void> {
  const program = new Command();
  program
    .name('create-flutter-forge')
    .argument('[project-name]', 'name of the project directory')
    .option('-y, --yes', 'use defaults without prompts')
    .option('--org <org>', 'organization / bundle id prefix')
    .option('--platforms <list>', 'comma-separated platforms', 'android,ios')
    .option('--no-notes', 'skip sample notes SQLite table')
    .option('--dry-run', 'print planned actions without writing')
    .option('--skip-flutter-create', 'only apply templates to existing project')
    .parse(argv, { from: 'user' });

  const opts = program.opts<CreateOptions>();
  const projectNameArg = program.args[0];

  printBanner();

  let projectName: string;
  let org: string;
  let platforms: string[];
  let includeNotes: boolean;
  let description: string;

  if (opts.yes) {
    projectName = projectNameArg ?? 'my_app';
    org = opts.org ?? 'com.example';
    platforms = (opts.platforms ?? 'android,ios').split(',').map((p) => p.trim());
    includeNotes = !opts.noNotes;
    description = 'A Flutter app forged with Flutter Forge.';
  } else {
    const answers = await promptCreateOptions(projectNameArg);
    projectName = answers.projectName;
    org = opts.org ?? answers.org;
    platforms = opts.platforms
      ? opts.platforms.split(',').map((p) => p.trim())
      : answers.platforms;
    includeNotes = opts.noNotes ? false : answers.includeNotes;
    description = answers.description;
  }

  const validation = validateProjectName(projectName);
  if (!validation.valid) {
    throw new Error(validation.errors.join('\n'));
  }

  const packageName = validation.packageName;
  const cwd = process.cwd();
  const projectPath = path.join(cwd, projectName);

  if (await fs.pathExists(projectPath) && !opts.skipFlutterCreate) {
    const files = await fs.readdir(projectPath);
    if (files.length > 0) {
      throw new Error(`Directory "${projectName}" already exists and is not empty.`);
    }
  }

  if (opts.dryRun) {
    log.info(`Would create project: ${projectName}`);
    log.info(`Package name: ${packageName}`);
    log.info(`Org: ${org}`);
    log.info(`Platforms: ${platforms.join(', ')}`);
    return;
  }

  const flutterVersion = await checkFlutterInstalled();
  log.info(flutterVersion);

  if (!opts.skipFlutterCreate) {
    await runFlutterCreate({ projectName, org, platforms, cwd });
  } else if (!(await fs.pathExists(projectPath))) {
    throw new Error(
      `--skip-flutter-create requires an existing project at ${projectPath}`,
    );
  }

  const context = {
    projectName,
    packageName,
    org,
    welcomeMessage: WELCOME_MESSAGE,
    includeNotes,
    description,
  };

  await applyTemplates(projectPath, context);
  await runFlutterPubGet(projectPath);
  await runFlutterAnalyze(projectPath);

  printSuccess(projectPath, projectName);
}
