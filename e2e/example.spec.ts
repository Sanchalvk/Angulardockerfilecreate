import { test, expect } from '@playwright/test';

test('should load homepage and display title', async ({ page }) => {
  await page.goto('http://localhost:4200');
  await expect(page).toHaveTitle(/Angular/); // Adjust regex to match actual title
});

test('should display Login button', async ({ page }) => {
  await page.goto('http://localhost:4200');
  const loginButton = page.locator('button:has-text("Login")');
  await expect(loginButton).toBeVisible(); // Fails if text/case is wrong
});
