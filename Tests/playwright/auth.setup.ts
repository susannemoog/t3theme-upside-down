import { test as setup } from '@playwright/test';

const authFile = '.playwright-auth.json';

setup('authenticate as admin', async ({ page }) => {
  await page.goto('/typo3/');
  await page.locator('[name="username"]').fill('admin');
  // userident is a hidden field populated by JS from the visible password input
  await page.locator('.t3js-login-password-field').fill('Password.1');

  await Promise.all([
    page.waitForURL(/\/typo3\/(?!$)/),   // wait for URL to change away from login root
    page.locator('[type="submit"]').click(),
  ]);

  await page.context().storageState({ path: authFile });
});
