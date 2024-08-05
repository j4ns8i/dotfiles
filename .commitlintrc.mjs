import { readdir } from 'node:fs/promises';

const roles = await readdir('./roles')

const Configuration = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [2, 'always', ['chore', 'docs', 'feat', 'fix', 'revert']],
    'scope-enum': [2, 'always', ['ansible', 'deps', ...roles]],
  },
};

export default Configuration;
