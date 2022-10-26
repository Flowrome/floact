import markdown from './readme.md';

export default {
  title: 'Documentation/Readme',
  parameters: {
    notes: { markdown },
  },
};

export const Readme = () => {
  const docReadme = document.createElement('doc-readme');
  return docReadme;
};
