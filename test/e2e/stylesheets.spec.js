import { test, expect } from '@playwright/test';

test.describe('Stylesheets Rendering', () => {
  test.beforeEach(async ({ page }) => {
    // Navigate to the home page
    await page.goto('/');
  });

  test('should load tailwind stylesheet', async ({ page }) => {
    // Get all link tags with rel="stylesheet"
    const stylesheetLinks = await page.locator('link[rel="stylesheet"]').all();
    
    expect(stylesheetLinks.length).toBeGreaterThan(0);

    // Verify at least one stylesheet link contains "tailwind"
    const tailwindLink = await page.locator('link[rel="stylesheet"][href*="tailwind"]').first();
    await expect(tailwindLink).toBeVisible();
  });

  test('should load application stylesheet', async ({ page }) => {
    const appLink = await page.locator('link[rel="stylesheet"][href*="application"]').first();
    await expect(appLink).toBeVisible();
  });

  test('should apply bg-gray-900 and text-white to body', async ({ page }) => {
    const body = page.locator('body');

    // Check that body has the correct classes
    await expect(body).toHaveClass(/bg-gray-900/);
    await expect(body).toHaveClass(/text-white/);
  });

  test('should compute correct background color from bg-gray-900 class', async ({ page }) => {
    const body = page.locator('body');

    // Get computed background color
    const bgColor = await body.evaluate((el) => {
      return window.getComputedStyle(el).backgroundColor;
    });

    // bg-gray-900 should be a very dark gray
    // Tailwind's gray-900 is #111827
    expect(bgColor).toMatch(/rgb\(17,\s*24,\s*39\)|#111827/i);
  });

  test('should compute correct text color from text-white class', async ({ page }) => {
    const body = page.locator('body');

    // Get computed text color
    const textColor = await body.evaluate((el) => {
      return window.getComputedStyle(el).color;
    });

    // text-white should be #ffffff or rgb(255, 255, 255)
    expect(textColor).toMatch(/rgb\(255,\s*255,\s*255\)|#ffffff/i);
  });

  test('should have container with mx-auto and px-5 classes', async ({ page }) => {
    const main = page.locator('main');

    await expect(main).toHaveClass(/container/);
    await expect(main).toHaveClass(/mx-auto/);
    await expect(main).toHaveClass(/px-5/);
  });

  test('should compute correct margin from mx-auto class', async ({ page }) => {
    const main = page.locator('main');

    const marginLeft = await main.evaluate((el) => {
      return window.getComputedStyle(el).marginLeft;
    });

    const marginRight = await main.evaluate((el) => {
      return window.getComputedStyle(el).marginRight;
    });

    // mx-auto should set margin-left and margin-right to auto
    expect(marginLeft).toBe('auto');
    expect(marginRight).toBe('auto');
  });

  test('should have padding from px-5 class', async ({ page }) => {
    const main = page.locator('main');

    const paddingLeft = await main.evaluate((el) => {
      return window.getComputedStyle(el).paddingLeft;
    });

    const paddingRight = await main.evaluate((el) => {
      return window.getComputedStyle(el).paddingRight;
    });

    // px-5 should set padding-left and padding-right to 1.25rem (20px)
    expect(paddingLeft).toBe('20px');
    expect(paddingRight).toBe('20px');
  });

  test('should have mt-28 (margin-top) on main', async ({ page }) => {
    const main = page.locator('main');

    const marginTop = await main.evaluate((el) => {
      return window.getComputedStyle(el).marginTop;
    });

    // mt-28 should set margin-top to 7rem (112px)
    expect(marginTop).toBe('112px');
  });

  test('should verify turbo-frame display styling', async ({ page }) => {
    // Check if there are any turbo-frame elements and verify their computed styles
    const turboFrames = await page.locator('turbo-frame').all();
    
    if (turboFrames.length > 0) {
      const display = await turboFrames[0].evaluate((el) => {
        return window.getComputedStyle(el).display;
      });

      // turbo-frame is styled to display: block
      expect(display).toBe('block');
    }
  });

  test('should verify notice alert styles', async ({ page }) => {
    // Check if notice element exists and has correct classes
    const notice = page.locator('#notice');
    
    if (await notice.isVisible()) {
      await expect(notice).toHaveClass(/bg-green-50/);
      await expect(notice).toHaveClass(/text-green-500/);
      await expect(notice).toHaveClass(/rounded-lg/);
    }
  });

  test('should verify error alert styles', async ({ page }) => {
    // Check if error element exists and has correct classes
    const error = page.locator('#error');
    
    if (await error.isVisible()) {
      await expect(error).toHaveClass(/bg-red-50/);
      await expect(error).toHaveClass(/text-red-500/);
      await expect(error).toHaveClass(/rounded-lg/);
    }
  });

  test('should have no stylesheet loading errors', async ({ page, context }) => {
    const errors = [];

    // Listen for console errors
    page.on('console', (msg) => {
      if (msg.type() === 'error') {
        errors.push(msg.text());
      }
    });

    // Listen for request failures
    page.on('response', (response) => {
      if (response.url().includes('.css') && response.status() >= 400) {
        errors.push(`CSS file failed to load: ${response.url()} (${response.status()})`);
      }
    });

    // Wait a moment for any async errors
    await page.waitForLoadState('networkidle');

    // Should not have any stylesheet-related errors
    const stylesheetErrors = errors.filter((e) => 
      e.toLowerCase().includes('stylesheet') || 
      e.toLowerCase().includes('.css')
    );
    expect(stylesheetErrors).toHaveLength(0);
  });

  test('should verify all stylesheet links resolve correctly', async ({ page }) => {
    const stylesheetLinks = await page.locator('link[rel="stylesheet"]').all();

    for (const link of stylesheetLinks) {
      const href = await link.getAttribute('href');
      
      if (href && !href.startsWith('data:')) {
        const response = await page.request.head(href, { timeout: 5000 }).catch(() => null);
        
        if (response) {
          expect(response.status()).toBe(200);
        }
      }
    }
  });
});
