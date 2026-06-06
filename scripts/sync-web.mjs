import { cp, mkdir, rm } from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const rootDir = path.resolve(__dirname, '..');
const webDir = path.join(rootDir, 'www');

const entriesToCopy = [
  'index.html',
  'styles.css',
  'app-config.js',
  'assets'
];

await rm(webDir, { recursive: true, force: true });
await mkdir(webDir, { recursive: true });

for (const entry of entriesToCopy) {
  const source = path.join(rootDir, entry);
  const destination = path.join(webDir, entry);
  await cp(source, destination, { recursive: true });
}

console.log(`Web assets copiados a ${webDir}`);
