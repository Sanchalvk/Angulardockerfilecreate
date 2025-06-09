import { test, expect, Page } from '@playwright/test';

async function expectElementVisible(page: Page, selector: string) {
  await page.waitForSelector(selector, { state: 'visible', timeout: 10000 });
  const element = page.locator(selector);
  await expect(element).toBeVisible();
}

test.describe('Angular Homepage Tests', () => {
  test('should load homepage and show title', async ({ page }) => {
    await page.goto('http://localhost:4200');
    await expect(page).toHaveTitle(/Angular|Login/i); // Adjust based on actual <title>
  });

  test('should display the Login button', async ({ page }) => {
    await page.goto('http://localhost:4200');
    await expectElementVisible(page, 'button:has-text("Login")'); // Update if it's a link or custom element
  });

  test('should navigate to Courses page', async ({ page }) => {
    await page.goto('http://localhost:4200');
    await page.click('a:has-text("Courses")'); // If it's a link, adjust to actual text
    await expect(page).toHaveURL(/courses/); // Update if the route is different
    await expectElementVisible(page, 'h2:has-text("Courses")'); // or whatever heading you use
  });
});
