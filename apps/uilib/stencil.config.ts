import { Config } from '@stencil/core';
import { envPlugin } from './env.plugin';
import { sass } from '@stencil/sass';
import { postcss } from '@stencil-community/postcss';
import autoprefixer from 'autoprefixer';
import { reactOutputTarget as react } from '@stencil/react-output-target';
import { readFileSync } from 'fs';

const customComponentReadmeFooter = readFileSync('docs/custom-component-readme-footer.md', 'utf-8');

export const config: Config = {
  namespace: 'uilib',
  globalStyle: 'src/styles/index.scss',
  outputTargets: [
    react({
      componentCorePackage: 'uilib',
      proxiesFile: '../client/components/stencil-generated/index.ts',
      includeDefineCustomElements: true,
    }),
    {
      type: 'dist',
      esmLoaderPath: '../loader',
    },
    {
      type: 'dist-custom-elements',
    },
    {
      type: 'docs-readme',
      footer: customComponentReadmeFooter,
    },
    {
      type: 'www',
      serviceWorker: null, // disable service workers
    },
  ],
  plugins: [
    envPlugin(),
    sass(),
    postcss({
      plugins: [autoprefixer()],
    }),
  ],
};
