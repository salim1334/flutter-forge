import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

export function getPackageRoot(): string {
  return path.resolve(__dirname, '..', '..');
}

export function getTemplatesDir(): string {
  return path.join(getPackageRoot(), 'templates', 'flutter_app');
}

export function getFeatureTemplateDir(): string {
  return path.join(getPackageRoot(), 'templates', 'feature');
}
