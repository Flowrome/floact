import '!style-loader!css-loader!sass-loader!./styles/global.scss';
import { defineCustomElements } from '../loader';

defineCustomElements();

export const parameters = {
  actions: { argTypesRegex: '^on[A-Z].*' },
  layout: 'fullscreen',
  controls: {
    matchers: {
      color: /(background|color)$/i,
      date: /Date$/,
    },
  },
  previewTabs: {
    'storybook/docs/panel': {
      hidden: true,
    },
  },
};

export const decorators = [
  story => {
    const container = document.createElement('div');
    container.style.width = '100%';
    container.style.margin = '0';
    container.style.padding = '0';
    container.appendChild(story());
    return container;
  },
];
