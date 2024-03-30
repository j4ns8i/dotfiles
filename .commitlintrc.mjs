import { readdir } from 'node:fs/promises';

const roles = await readdir('./roles')

const Configuration = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [2, 'always', ['docs', 'feat', 'fix', 'ops', 'refactor', 'revert', 'style']],
    'scope-enum': [2, 'always', ['ansible', 'deps', ...roles]],
  },
};

export default Configuration;
