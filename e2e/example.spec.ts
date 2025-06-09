import { test, expect, Page } from '@playwright/test';

// Helper function to navigate and check the page title
async function checkHomepageTitle(page: Page, expectedTitle: RegExp) {
  await page.goto('http://localhost:4200');
  await expect(page).toHaveTitle(expectedTitle);
}

// Helper function to check if an element is visible by selector
async function expectElementVisible(page: Page, selector: string) {
  const element = page.locator(selector);
  await expect(element).toBeVisible();
}

// Your main test suite
test.describe('Angular Homepage Tests', () => {
  test('homepage loads and has correct title', async ({ page }) => {
    await checkHomepageTitle(page, /Angular/);
  });

  test('should display the main header', async ({ page }) => {
    await page.goto('http://localhost:4200');
    // Adjust selector to your actual header or element you want to test
    await expectElementVisible(page, 'h1');
  });

  test('navigation menu item works', async ({ page }) => {
    await page.goto('http://localhost:4200');
    // Example: Click a nav link and check URL or element on new page
    await page.click('nav >> text=About'); // Adjust selector and text accordingly
    await expect(page).toHaveURL(/about/);
    await expectElementVisible(page, 'h2:has-text("About")'); // Check About page heading
  });
});
