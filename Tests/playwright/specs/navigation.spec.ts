import { test, expect } from '@playwright/test';

test.describe('Navigation', () => {
  test('main nav shows visible pages', async ({ page }) => {
    await page.goto('/');
    const nav = page.locator('.ud-nav');
    await expect(nav).toBeVisible();
    // nav_hide=0 pages appear; imprint and privacy (nav_hide=1) do not
    await expect(nav.getByRole('link', { name: 'Hawkins Field Guide' })).toBeVisible();
    await expect(nav.getByRole('link', { name: 'Survival Kit' })).toBeVisible();
    await expect(nav.getByRole('link', { name: 'Strange Questions' })).toBeVisible();
    await expect(nav.getByRole('link', { name: 'Imprint' })).not.toBeVisible();
    await expect(nav.getByRole('link', { name: 'Privacy' })).not.toBeVisible();
  });

  test('brand link returns to root', async ({ page }) => {
    await page.goto('/hawkins-field-guide');
    await page.locator('.ud-brand').click();
    await expect(page).toHaveURL('/');
  });

  test('active page link carries aria-current', async ({ page }) => {
    await page.goto('/hawkins-field-guide');
    const activeLink = page.locator('.ud-nav a[aria-current="page"]');
    await expect(activeLink).toBeVisible();
    await expect(activeLink).toHaveText('Hawkins Field Guide');
  });

  test('skip link is present and targets #ud-content', async ({ page }) => {
    await page.goto('/');
    const skip = page.locator('.ud-skip-link');
    await expect(skip).toHaveAttribute('href', '#ud-content');
  });

  test('footer is present on landing page', async ({ page }) => {
    await page.goto('/');
    const footer = page.locator('.ud-footer');
    await expect(footer).toBeVisible();
    await expect(footer.locator('.ud-footer__tagline')).toHaveText('The veil is thin. The signal persists.');
  });
});

test.describe('Sub-pages', () => {
  test('Hawkins Field Guide loads', async ({ page }) => {
    await page.goto('/hawkins-field-guide');
    await expect(page).toHaveTitle(/Hawkins Field Guide/i);
    // Stage / portal area contains the page heading
    await expect(page.locator('.ud-main')).toContainText('Hawkins Field Guide');
  });

  test('Survival Kit loads', async ({ page }) => {
    await page.goto('/survival-kit');
    await expect(page).toHaveTitle(/Survival Kit/i);
    await expect(page.locator('.ud-main')).toContainText('Survival Kit');
  });

  test('Strange Questions loads', async ({ page }) => {
    await page.goto('/strange-questions');
    await expect(page).toHaveTitle(/Strange Questions/i);
  });

  test('Imprint is accessible by direct URL', async ({ page }) => {
    await page.goto('/imprint');
    await expect(page).toHaveTitle(/Imprint/i);
  });
});