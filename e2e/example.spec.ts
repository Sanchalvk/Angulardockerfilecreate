import { test, expect } from '@playwright/test';

test('should load homepage and display title', async ({ page }) => {
  await page.goto('http://localhost:4200');
  await expect(page).toHaveTitle(/Angular/); // Adjust regex to match actual title
});


