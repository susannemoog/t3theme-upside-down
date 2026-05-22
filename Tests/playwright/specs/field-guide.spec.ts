import { test, expect } from '@playwright/test';

test.describe('Hawkins Field Guide', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/hawkins-field-guide');
  });

  test('storybeat blocks are present', async ({ page }) => {
    const beats = page.locator('.ud-storybeat');
    await expect(beats).toHaveCount(8);
  });

  test('THE RIFT block is present with content', async ({ page }) => {
    const beat = page.locator('.ud-storybeat', { hasText: 'THE RIFT' });
    await expect(beat).toBeVisible();
    await expect(beat).toContainText('November 1983');
  });

  test('threat level sidebar block is present', async ({ page }) => {
    await expect(page.locator('.ud-storybeat', { hasText: 'THREAT LEVEL: CRITICAL' })).toBeVisible();
  });

  test('CTA links to Survival Kit', async ({ page }) => {
    const cta = page.locator('a', { hasText: 'Get the Survival Kit' }).first();
    await expect(cta).toBeVisible();
    await cta.click();
    await expect(page).toHaveURL(/survival-kit/);
  });
});