import { readdir } from 'node:fs/promises';

const roles = await readdir('./roles')

const Configuration = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [2, 'always', ['ansible', 'chore', ...roles]],
  },
};

export default Configuration;
