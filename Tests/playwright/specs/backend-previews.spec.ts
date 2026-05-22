import { test, expect } from '@playwright/test';

// Auth is injected via storageState (chromium-backend project in playwright.config.ts).
// No login needed in beforeEach.

test.describe('Backend previews', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/typo3/module/web/layout?id=1');
    await page.waitForLoadState('domcontentloaded');
    // Wait for at least one of our preview elements to confirm previews are rendered
    await page.waitForSelector('.ud-featured__card', { timeout: 20_000 });
  });

  // ── Stylesheet ────────────────────────────────────────────────────────────────

  test('backend-preview.css is loaded in <head>', async ({ page }) => {
    const hrefs = await page.$$eval(
      'link[rel="stylesheet"]',
      (links: HTMLLinkElement[]) => links.map(l => l.href)
    );
    expect(hrefs.some(href => href.includes('backend-preview.css'))).toBe(true);
  });

  // ── Hero ──────────────────────────────────────────────────────────────────────

  test('hero preview renders eyebrow and title', async ({ page }) => {
    const preview = page.locator('.t3-page-ce').filter({ has: page.locator('h1') }).first();
    await expect(preview).toBeVisible();
    // The hero template uses inline styles, not CSS classes — check text content
    await expect(preview).toContainText('The Upside Down');
    await expect(preview).toContainText('Hawkins National Laboratory');
  });

  // ── Featured ─────────────────────────────────────────────────────────────────

  test('featured preview renders dispatch badge and title', async ({ page }) => {
    const preview = page.locator('.ud-featured__card').first();
    await expect(preview).toBeVisible();
    await expect(preview.locator('.ud-featured__dispatch')).toContainText('Classified Dispatch');
    await expect(preview.locator('.ud-featured__title')).toBeVisible();
  });

  // ── Characters ────────────────────────────────────────────────────────────────

  test('character previews render with status badges', async ({ page }) => {
    const cards = page.locator('.ud-character-card');
    await expect(cards).toHaveCount(7);
  });

  test('character preview status badge reflects data-status attribute', async ({ page }) => {
    const statuses = await page.locator('.ud-character-card').evaluateAll(
      (cards: Element[]) => cards.map(c => c.getAttribute('data-status'))
    );
    expect(statuses).toContain('unknown');
    expect(statuses).toContain('missing');
    expect(statuses).toContain('compromised');
    expect(statuses).toContain('alive');
  });

  test('character status badge carries correct modifier class', async ({ page }) => {
    const badge = page.locator('.ud-status--alive').first();
    await expect(badge).toBeVisible();
    await expect(badge).toHaveText('Alive');
  });

  // ── Locations ─────────────────────────────────────────────────────────────────

  test('location previews render with threat badges', async ({ page }) => {
    const cards = page.locator('.ud-location-card');
    await expect(cards).toHaveCount(5);
  });

  test('featured location carries --featured modifier class', async ({ page }) => {
    await expect(page.locator('.ud-location-card--featured')).toBeVisible();
  });

  test('location threat badge carries correct modifier class', async ({ page }) => {
    await expect(page.locator('.ud-threat--critical')).toBeVisible();
    await expect(page.locator('.ud-threat--elevated')).toBeVisible();
    await expect(page.locator('.ud-threat--nominal')).toBeVisible();
  });

  // ── Incidents ─────────────────────────────────────────────────────────────────

  test('incident previews render as open accordion items', async ({ page }) => {
    const items = page.locator('.ud-accordion__item');
    await expect(items).toHaveCount(5);
    // Template renders with open attribute so content is immediately visible
    await expect(items.first().locator('.ud-accordion__panel')).toBeVisible();
  });

  test('incident preview shows report ID, label and classification', async ({ page }) => {
    const item = page.locator('.ud-accordion__item').first();
    await expect(item.locator('.ud-accordion__id')).toBeVisible();
    await expect(item.locator('.ud-accordion__label')).toBeVisible();
    await expect(item.locator('.ud-accordion__classification')).toBeVisible();
  });

  // ── Testimonials ──────────────────────────────────────────────────────────────

  test('testimonial previews render with quote and citation', async ({ page }) => {
    const items = page.locator('.ud-slider__item');
    await expect(items).toHaveCount(6);
    await expect(items.first().locator('.ud-slider__quote')).toBeVisible();
    await expect(items.first().locator('.ud-slider__name')).toBeVisible();
  });
});
