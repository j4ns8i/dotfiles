import fs from 'node:fs';
import path from 'node:path';

/* All *.nix files under modules/ or machines/ are a valid commit type */
const modules = ['./modules', './machines']
  .flatMap(dir => fs.readdirSync(dir)
    .filter(f => f.endsWith('.nix'))
    .map(f => path.basename(f, '.nix')));

const Configuration = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [2, 'always', ['chore', 'nix', 'style', ...modules]],
  },
};

export default Configuration;
