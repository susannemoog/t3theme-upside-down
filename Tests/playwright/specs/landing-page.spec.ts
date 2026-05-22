import { test, expect } from '@playwright/test';

test.beforeEach(async ({ page }) => {
  await page.goto('/');
});

// ── Hero ─────────────────────────────────────────────────────────────────────

test.describe('Hero', () => {
  test('renders the section', async ({ page }) => {
    const hero = page.locator('.ud-landing-hero');
    await expect(hero).toBeVisible();
    await expect(hero.locator('.ud-landing-hero__eyebrow')).toHaveText('Hawkins National Laboratory · Classified');
    await expect(hero.locator('h1.ud-landing-hero__title')).toHaveText('The Upside Down');
    await expect(hero.locator('.ud-landing-hero__subtitle')).toContainText('dimensional breach');
  });

  test('scroll link points to #ud-dispatch', async ({ page }) => {
    const link = page.locator('.ud-landing-hero__scroll');
    await expect(link).toHaveAttribute('href', '#ud-dispatch');
  });
});

// ── Featured dispatch ─────────────────────────────────────────────────────────

test.describe('Featured dispatch', () => {
  test('renders the card with CTA', async ({ page }) => {
    const featured = page.locator('.ud-featured');
    await expect(featured).toBeVisible();
    await expect(featured.locator('.ud-featured__dispatch')).toContainText('Classified Dispatch #00-Alpha');
    await expect(featured.locator('h2.ud-featured__title')).toHaveText('The Gate Has Been Reopened');
    await expect(featured.locator('.ud-featured__cta')).toHaveText('Read Mission Report');
  });

  test('section carries the scroll anchor id', async ({ page }) => {
    await expect(page.locator('#ud-dispatch')).toBeVisible();
  });
});

// ── Characters ────────────────────────────────────────────────────────────────

test.describe('Characters', () => {
  test('section header is present', async ({ page }) => {
    const section = page.locator('.ud-characters');
    await expect(section.locator('.ud-characters__kicker')).toHaveText('Hawkins Field Intel');
    await expect(section.locator('h2.ud-characters__title')).toHaveText('Residents: Current Status');
  });

  test('renders 7 character cards', async ({ page }) => {
    await expect(page.locator('.ud-character-card')).toHaveCount(7);
  });

  test('Jane Hopper card — unknown status', async ({ page }) => {
    const card = page.locator('.ud-character-card', { hasText: 'Jane Hopper' });
    await expect(card).toBeVisible();
    await expect(card.locator('.ud-character-card__role')).toHaveText('Subject 011 · Hawkins Lab');
    await expect(card.locator('.ud-character-card__status')).toHaveText('Unknown');
    await expect(card).toHaveAttribute('data-status', 'unknown');
  });

  test('Jim Hopper card — missing status', async ({ page }) => {
    const card = page.locator('.ud-character-card', { hasText: 'Jim Hopper' });
    await expect(card.locator('.ud-character-card__status')).toHaveText('Missing');
    await expect(card).toHaveAttribute('data-status', 'missing');
  });

  test('Billy Hargrove card — compromised status', async ({ page }) => {
    const card = page.locator('.ud-character-card', { hasText: 'Billy Hargrove' });
    await expect(card.locator('.ud-character-card__status')).toHaveText('Compromised');
    await expect(card).toHaveAttribute('data-status', 'compromised');
  });

  test('alive characters show correct status', async ({ page }) => {
    for (const name of ['Joyce Byers', 'Will Byers', 'Mike Wheeler', 'Dustin Henderson']) {
      const card = page.locator('.ud-character-card').filter({
        has: page.locator('.ud-character-card__name', { hasText: name }),
      });
      await expect(card.locator('.ud-character-card__status')).toHaveText('Alive');
      await expect(card).toHaveAttribute('data-status', 'alive');
    }
  });
});

// ── Locations ─────────────────────────────────────────────────────────────────

test.describe('Locations', () => {
  test('section header is present', async ({ page }) => {
    const section = page.locator('.ud-locations');
    await expect(section.locator('.ud-locations__kicker')).toHaveText('Active Investigation Sites');
    await expect(section.locator('h2.ud-locations__title')).toHaveText('Hawkins: Known Breach Points');
  });

  test('renders 5 location cards', async ({ page }) => {
    await expect(page.locator('.ud-location-card')).toHaveCount(5);
  });

  test('Hawkins Lab — featured + critical', async ({ page }) => {
    const card = page.locator('.ud-location-card', { hasText: 'Hawkins National Laboratory' });
    await expect(card).toBeVisible();
    await expect(card).toHaveClass(/ud-location-card--featured/);
    await expect(card.locator('.ud-location-card__threat')).toHaveText('Critical');
    await expect(card.locator('.ud-location-card__threat')).toHaveClass(/ud-threat--critical/);
    await expect(card.locator('.ud-location-card__coords')).toContainText('39.4614');
  });

  test('Mirkwood Forest — elevated threat', async ({ page }) => {
    const card = page.locator('.ud-location-card', { hasText: 'Mirkwood Forest' });
    await expect(card.locator('.ud-location-card__threat')).toHaveText('Elevated');
  });

  test('Hawkins Police Dept. — nominal threat', async ({ page }) => {
    const card = page.locator('.ud-location-card', { hasText: 'Hawkins Police Dept.' });
    await expect(card.locator('.ud-location-card__threat')).toHaveText('Nominal');
  });
});

// ── Incidents accordion ───────────────────────────────────────────────────────

test.describe('Incidents accordion', () => {
  test('section header is present', async ({ page }) => {
    const section = page.locator('.ud-accordion-section');
    await expect(section.locator('.ud-accordion-section__kicker')).toHaveText('Declassified Archives');
    await expect(section.locator('h2.ud-accordion-section__title')).toHaveText('Hawkins Incident Reports');
  });

  test('renders 5 accordion items', async ({ page }) => {
    await expect(page.locator('.ud-accordion__item')).toHaveCount(5);
  });

  test('first incident shows report ID and date', async ({ page }) => {
    const item = page.locator('.ud-accordion__item').first();
    await expect(item.locator('.ud-accordion__id')).toHaveText('#00-1983');
    await expect(item.locator('.ud-accordion__label')).toContainText('First Contact');
    await expect(item.locator('.ud-accordion__date')).toHaveText('Nov 1983');
  });

  test('accordion items can be opened and closed', async ({ page }) => {
    const item = page.locator('.ud-accordion__item').first();
    // Open
    await item.locator('.ud-accordion__trigger').click();
    await expect(item).toHaveAttribute('open', '');
    await expect(item.locator('.ud-accordion__panel')).toBeVisible();
    // Close
    await item.locator('.ud-accordion__trigger').click();
    await expect(item).not.toHaveAttribute('open', '');
  });

  test('classification label is shown in expanded panel', async ({ page }) => {
    const item = page.locator('.ud-accordion__item').first();
    await item.locator('.ud-accordion__trigger').click();
    await expect(item.locator('.ud-accordion__classification')).toContainText('Level 4');
  });
});

// ── Testimonials slider ───────────────────────────────────────────────────────

test.describe('Testimonials', () => {
  test('section header is present', async ({ page }) => {
    const section = page.locator('.ud-slider-section');
    await expect(section.locator('.ud-slider-section__kicker')).toHaveText('Intercepted Transmissions');
    await expect(section.locator('h2.ud-slider-section__title')).toHaveText('Witness Testimonials');
  });

  test('renders 6 slider items', async ({ page }) => {
    await expect(page.locator('.ud-slider__item')).toHaveCount(6);
  });

  test('Jim Hopper testimonial is present', async ({ page }) => {
    const item = page.locator('.ud-slider__item', { hasText: 'Chief Jim Hopper' });
    await expect(item).toBeAttached();
    await expect(item.locator('.ud-slider__kicker')).toHaveText('Field Report · HPDI-0047');
    await expect(item.locator('.ud-slider__name')).toHaveText('Chief Jim Hopper');
    await expect(item.locator('cite')).toContainText('Jim Hopper');
  });

  test('next button advances the slider', async ({ page }) => {
    const track = page.locator('.ud-slider__track');
    const nextBtn = page.locator('.ud-slider__btn--next');
    await expect(nextBtn).toBeEnabled();
    const scrollBefore = await track.evaluate(el => el.scrollLeft);
    await nextBtn.click();
    await page.waitForTimeout(400);
    const scrollAfter = await track.evaluate(el => el.scrollLeft);
    expect(scrollAfter).toBeGreaterThan(scrollBefore);
  });
});