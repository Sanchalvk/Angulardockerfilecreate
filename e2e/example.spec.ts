// e2e/example.spec.ts
import { test, expect } from '@playwright/test';

test('home page should have title', async ({ page }) => {
  await page.goto('http://localhost:4200');
  await expect(page).toHaveTitle(/Angular/); // Adjust as needed
});
