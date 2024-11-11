import { readdir } from 'node:fs/promises';
import path from 'node:path';

const modules =
  (await readdir('./modules'))
    .filter(f => f.endsWith('.nix'))
    .map(f => path.basename(f, '.nix'));

const Configuration = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [2, 'always', ['chore', 'nix', ...modules]],
  },
};

export default Configuration;
