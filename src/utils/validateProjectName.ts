import validateNpmPackageName from 'validate-npm-package-name';

const DART_PACKAGE_REGEX = /^[a-z][a-z0-9_]*$/;

export interface ValidationResult {
  valid: boolean;
  packageName: string;
  errors: string[];
}

export function toDartPackageName(name: string): string {
  return name
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9_]/g, '_')
    .replace(/_+/g, '_')
    .replace(/^_+|_+$/g, '')
    .replace(/^(\d)/, 'app_$1');
}

export function toPascalCase(snake: string): string {
  return snake
    .split('_')
    .filter(Boolean)
    .map((part) => part.charAt(0).toUpperCase() + part.slice(1))
    .join('');
}

export function toCamelCase(snake: string): string {
  const pascal = toPascalCase(snake);
  return pascal.charAt(0).toLowerCase() + pascal.slice(1);
}

export function validateProjectName(name: string): ValidationResult {
  const errors: string[] = [];
  const trimmed = name.trim();

  if (!trimmed) {
    return { valid: false, packageName: '', errors: ['Project name is required.'] };
  }

  const npmResult = validateNpmPackageName(trimmed);
  if (!npmResult.validForNewPackages) {
    errors.push(
      ...(npmResult.errors ?? ['Invalid project name for npm/Dart conventions.']),
    );
  }

  const packageName = toDartPackageName(trimmed);

  if (!packageName) {
    errors.push('Could not derive a valid Dart package name.');
  } else if (!DART_PACKAGE_REGEX.test(packageName)) {
    errors.push(
      `Dart package name "${packageName}" must be lowercase with underscores, starting with a letter.`,
    );
  }

  if (packageName.length > 64) {
    errors.push('Package name must be 64 characters or fewer.');
  }

  return {
    valid: errors.length === 0,
    packageName,
    errors,
  };
}
