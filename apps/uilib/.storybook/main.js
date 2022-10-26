module.exports = {
  stories: ['../src/components/**/*.story.@(js|jsx|ts|tsx)'],
  addons: ['@storybook/addon-links', '@storybook/addon-essentials', '@storybook/addon-interactions', '@storybook/addon-notes/register'],
  framework: '@storybook/html',
  core: {
    builder: 'webpack5',
    enableCrashReports: true, // 👈 Appends the crash reports to the telemetry events
  },
};
