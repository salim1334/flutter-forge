import { execa } from 'execa';
import { log, spinner } from './utils/logger.js';

export async function checkFlutterInstalled(): Promise<string> {
  try {
    const { stdout } = await execa('flutter', ['--version'], { timeout: 30_000 });
    const firstLine = stdout.split('\n')[0] ?? 'Flutter';
    return firstLine;
  } catch {
    throw new Error(
      'Flutter SDK not found. Install Flutter and ensure `flutter` is on your PATH.\n' +
        'https://docs.flutter.dev/get-started/install',
    );
  }
}

export async function runFlutterCreate(options: {
  projectName: string;
  org: string;
  platforms: string[];
  cwd: string;
}): Promise<void> {
  const spin = spinner('Running flutter create...');
  try {
    await execa(
      'flutter',
      [
        'create',
        '--org',
        options.org,
        '--platforms',
        options.platforms.join(','),
        options.projectName,
      ],
      { cwd: options.cwd, stdio: 'pipe' },
    );
    spin.succeed('Flutter project created');
  } catch (err) {
    spin.fail('flutter create failed');
    throw err;
  }
}

export async function runFlutterPubGet(projectPath: string): Promise<void> {
  const spin = spinner('Running flutter pub get...');
  try {
    await execa('flutter', ['pub', 'get'], { cwd: projectPath, stdio: 'pipe' });
    spin.succeed('Dependencies installed');
  } catch (err) {
    spin.fail('flutter pub get failed');
    throw err;
  }
}

export async function runFlutterAnalyze(projectPath: string): Promise<boolean> {
  const spin = spinner('Running flutter analyze...');
  try {
    await execa('flutter', ['analyze', '--no-fatal-infos'], {
      cwd: projectPath,
      stdio: 'pipe',
    });
    spin.succeed('flutter analyze passed');
    return true;
  } catch {
    spin.warn('flutter analyze reported issues (project may still run)');
    log.warn('Run `flutter analyze` locally to review warnings.');
    return false;
  }
}
