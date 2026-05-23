#!/usr/bin/env node
import { runCreate } from '../dist/commands/create.js';

const args = process.argv.slice(2);
runCreate(args).catch((err) => {
  console.error(err instanceof Error ? err.message : err);
  process.exit(1);
});
