import { Meta, StoryFn } from '@storybook/html';

export default {
  title: 'Documentation',
} as Meta;

export const Readme: StoryFn = (): HTMLElement => {
  const doc = document.createElement('doc-readme');
  return doc;
};
