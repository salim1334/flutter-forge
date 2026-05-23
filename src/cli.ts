import { Command } from 'commander';
import { runCreate } from './commands/create.js';
import { runFeature } from './commands/feature.js';
import { printBanner } from './utils/logger.js';

export async function runCli(argv: string[]): Promise<void> {
  const program = new Command();

  program
    .name('flutter-forge')
    .description('Flutter Forge — production-ready Flutter starter CLI')
    .version('1.0.0');

  program
    .command('create')
    .description('Create a new Flutter Forge project')
    .argument('[project-name]', 'project directory name')
    .option('-y, --yes', 'use defaults')
    .option('--org <org>', 'bundle id organization')
    .option('--platforms <list>', 'comma-separated platforms')
    .option('--no-notes', 'skip notes demo table')
    .option('--dry-run', 'preview without writing')
    .option('--skip-flutter-create', 'templates only on existing project')
    .action(async (projectName: string | undefined, opts) => {
      const args: string[] = [];
      if (projectName) args.push(projectName);
      if (opts.yes) args.push('--yes');
      if (opts.org) args.push('--org', opts.org);
      if (opts.platforms) args.push('--platforms', opts.platforms);
      if (opts.noNotes) args.push('--no-notes');
      if (opts.dryRun) args.push('--dry-run');
      if (opts.skipFlutterCreate) args.push('--skip-flutter-create');
      await runCreate(args);
    });

  program
    .command('feature <name>')
    .description('Scaffold a new feature module and wire routes')
    .option('--with-model', 'include a model class')
    .option('--route <path>', 'custom route path')
    .option('--no-binding', 'skip GetX binding')
    .action(async (name: string, opts) => {
      printBanner();
      await runFeature(name, {
        withModel: opts.withModel,
        route: opts.route,
        noBinding: opts.noBinding,
      });
    });

  const args = argv.slice(2);
  if (args.length === 0) {
    program.help();
    return;
  }

  await program.parseAsync(argv);
}
