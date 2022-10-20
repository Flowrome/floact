require('dotenv').config({
  path: `../../envs/.env.${process.env.ENV || 'production'}`,
});

const {writeFileSync} = require('fs')

envPlugin = () => {
  const toSearch = 'FLOWROME_UILIB_';
  const uiEnvVarsKeys = Object.keys(process.env).filter(key => key.indexOf(toSearch) > -1);
  const toWrite = {};
  uiEnvVarsKeys.forEach(key => {
    toWrite[key.replace(toSearch, '')] = process.env[key];
  });
  writeFileSync('./src/env.ts', `export const env = ${JSON.stringify(toWrite)}`)
};

module.exports = { envPlugin };
