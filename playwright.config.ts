import { defineConfig, devices } from '@playwright/test';

const authFile = '.playwright-auth.json';

export default defineConfig({
  testDir: './Tests/playwright/specs',
  timeout: 30_000,
  expect: { timeout: 10_000 },
  retries: process.env.CI ? 2 : 0,
  workers: 1,
  reporter: [['list'], ['html', { open: 'never' }]],
  use: {
    baseURL: 'http://web',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
    video: 'on-first-retry',
  },
  projects: [
    {
      name: 'setup',
      testDir: './Tests/playwright',
      testMatch: /auth\.setup\.ts/,
    },
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
      dependencies: [],
    },
    {
      name: 'chromium-backend',
      use: { ...devices['Desktop Chrome'], storageState: authFile },
      dependencies: ['setup'],
      testMatch: /backend-.*\.spec\.ts/,
    },
  ],
});