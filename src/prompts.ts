import inquirer from 'inquirer';
import { validateProjectName } from './utils/validateProjectName.js';

export interface CreatePromptAnswers {
  projectName: string;
  org: string;
  platforms: string[];
  includeNotes: boolean;
  description: string;
}

export async function promptCreateOptions(
  defaultName?: string,
): Promise<CreatePromptAnswers> {
  const answers = await inquirer.prompt<CreatePromptAnswers>([
    {
      type: 'input',
      name: 'projectName',
      message: 'Project name',
      default: defaultName ?? 'my_app',
      validate: (input: string) => {
        const result = validateProjectName(input);
        return result.valid || result.errors.join(' ');
      },
    },
    {
      type: 'input',
      name: 'org',
      message: 'Organization (bundle ID prefix)',
      default: 'com.example',
    },
    {
      type: 'checkbox',
      name: 'platforms',
      message: 'Platforms',
      choices: [
        { name: 'Android', value: 'android', checked: true },
        { name: 'iOS', value: 'ios', checked: true },
        { name: 'Web', value: 'web', checked: false },
        { name: 'Windows', value: 'windows', checked: false },
        { name: 'macOS', value: 'macos', checked: false },
        { name: 'Linux', value: 'linux', checked: false },
      ],
      validate: (v: string[]) => v.length > 0 || 'Select at least one platform',
    },
    {
      type: 'confirm',
      name: 'includeNotes',
      message: 'Include sample notes SQLite table?',
      default: true,
    },
    {
      type: 'input',
      name: 'description',
      message: 'Package description',
      default: 'A Flutter app forged with Flutter Forge.',
    },
  ]);

  return answers;
}
