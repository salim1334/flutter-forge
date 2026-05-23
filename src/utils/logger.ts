import chalk from 'chalk';
import ora, { type Ora } from 'ora';

export const log = {
  info: (msg: string) => console.log(chalk.cyan('ℹ'), msg),
  success: (msg: string) => console.log(chalk.green('✔'), msg),
  warn: (msg: string) => console.log(chalk.yellow('⚠'), msg),
  error: (msg: string) => console.error(chalk.red('✖'), msg),
  title: (msg: string) => console.log(chalk.bold.magenta(`\n${msg}\n`)),
};

export function spinner(text: string): Ora {
  return ora(text).start();
}

export function printBanner(): void {
  console.log(
    chalk.bold.cyan(`
  ╔═══════════════════════════════════════╗
  ║         Flutter Forge CLI             ║
  ║  Production-ready Flutter starter     ║
  ╚═══════════════════════════════════════╝
`),
  );
}

export function printSuccess(projectPath: string, projectName: string): void {
  console.log(chalk.green.bold('\n🎉 Project forged successfully!\n'));
  console.log(chalk.white('  Next steps:'));
  console.log(chalk.gray(`    cd ${projectName}`));
  console.log(chalk.gray('    flutter run'));
  console.log(chalk.gray(`    npx flutter-forge feature my_feature\n`));
  console.log(chalk.dim(`  Project path: ${projectPath}\n`));
}
