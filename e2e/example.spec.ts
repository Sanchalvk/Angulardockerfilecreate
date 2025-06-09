import { test, expect, Page } from '@playwright/test';

async function expectElementVisible(page: Page, selector: string) {
  await page.waitForLoadState('networkidle'); // Important for Angular
  const element = page.locator(selector);
  await expect(element).toBeVisible({ timeout: 10000 });
}

test.describe('Angular Homepage Tests', () => {
  test('should load homepage and show title', async ({ page }) => {
    await page.goto('http://localhost:4200');
    await expect(page).toHaveTitle(/Angular|Login/i);
  });

  test('should display the Login button', async ({ page }) => {
    await page.goto('http://localhost:4200');
    await expectElementVisible(page, 'text=Login'); // works for <button>, <a>, etc.
  });

  test('should navigate to Courses page', async ({ page }) => {
    await page.goto('http://localhost:4200');
    const link = page.locator('a:has-text("Courses")');
    await expect(link).toBeVisible({ timeout: 10000 });
    await link.click();
    await expect(page).toHaveURL(/courses/);
    await expectElementVisible(page, 'h2:has-text("Courses")');
  });
});
