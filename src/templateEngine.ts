import ejs from 'ejs';
import fs from 'fs-extra';
import path from 'node:path';

export interface TemplateContext {
  projectName: string;
  packageName: string;
  org: string;
  welcomeMessage: string;
  includeNotes: boolean;
  description?: string;
  [key: string]: string | boolean | number | undefined;
}

const EJS_EXTENSIONS = new Set(['.dart', '.md', '.yaml', '.yml', '.env', '.example', '.gitkeep']);

function shouldRender(filePath: string): boolean {
  const ext = path.extname(filePath);
  const base = path.basename(filePath);
  if (base === 'pubspec.patch.yaml') return true;
  return EJS_EXTENSIONS.has(ext) || base.startsWith('.env');
}

export async function copyAndRenderTemplates(
  srcDir: string,
  destDir: string,
  context: TemplateContext,
): Promise<void> {
  const entries = await fs.readdir(srcDir, { withFileTypes: true });

  for (const entry of entries) {
    const srcPath = path.join(srcDir, entry.name);
    const destPath = path.join(destDir, entry.name);

    if (entry.isDirectory()) {
      await fs.ensureDir(destPath);
      await copyAndRenderTemplates(srcPath, destPath, context);
    } else if (entry.isFile()) {
      if (shouldRender(srcPath)) {
        const template = await fs.readFile(srcPath, 'utf8');
        const rendered = ejs.render(template, context, { filename: srcPath });
        await fs.ensureDir(path.dirname(destPath));
        await fs.writeFile(destPath, rendered, 'utf8');
      } else {
        await fs.copy(srcPath, destPath);
      }
    }
  }
}
