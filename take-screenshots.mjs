import { chromium } from 'playwright';

const BASE_URL = 'http://localhost:5173';
const EMAIL = 'richard.anderson-practice2@mentric.com';
const PASSWORD = 'Password1!';
const OUTPUT_DIR = 'public/images';

const pages = [
  { name: 'dashboard', path: '/dashboard', delay: 3000 },
  { name: 'command-center', path: '/command-center', delay: 3000 },
  { name: 'goals-pipeline', path: '/goals/pipeline', delay: 3000 },
  { name: 'assessments', path: '/assessments', delay: 3000 },
  { name: 'analytics', path: '/analytics', delay: 3000 },
  { name: 'sessions', path: '/sessions', delay: 3000 },
  { name: 'coachees', path: '/coach/coachees', delay: 3000 },
  { name: 'resources', path: '/resources', delay: 3000 },
  { name: 'cpd', path: '/cpd', delay: 3000 },
  { name: 'messages', path: '/messages', delay: 3000 },
  { name: 'settings-branding', path: '/settings/branding', delay: 3000 },
  { name: 'programmes', path: '/programmes', delay: 3000 },
  { name: 'clients', path: '/clients', delay: 3000 },
];

async function run() {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({
    viewport: { width: 1440, height: 900 },
    deviceScaleFactor: 2,
  });
  const page = await context.newPage();

  // Login
  console.log('Logging in...');
  await page.goto(`${BASE_URL}/login`);
  await page.waitForSelector('#email', { timeout: 10000 });
  await page.fill('#email', EMAIL);
  await page.fill('#password', PASSWORD);
  await page.click('button[type="submit"]');

  // Wait for redirect after login
  await page.waitForURL((url) => !url.pathname.includes('/login'), { timeout: 15000 });
  console.log(`Logged in, redirected to: ${page.url()}`);

  // Wait a bit for the app to fully load
  await page.waitForTimeout(3000);

  // Take screenshots
  for (const p of pages) {
    try {
      console.log(`Navigating to ${p.path}...`);
      await page.goto(`${BASE_URL}${p.path}`, { waitUntil: 'networkidle', timeout: 15000 });
      await page.waitForTimeout(p.delay);

      // Dismiss any modals/banners that might be in the way
      try {
        const dismissButtons = page.locator('[aria-label="Dismiss"], [aria-label="Close"]');
        const count = await dismissButtons.count();
        for (let i = 0; i < count; i++) {
          await dismissButtons.nth(i).click().catch(() => {});
        }
      } catch (e) {
        // No dismiss buttons, that's fine
      }

      await page.screenshot({
        path: `${OUTPUT_DIR}/${p.name}.webp`,
        type: 'png',
      });
      console.log(`  ✓ ${p.name}.webp saved`);
    } catch (err) {
      console.log(`  ✗ ${p.name} failed: ${err.message}`);
    }
  }

  await browser.close();
  console.log('Done!');
}

run().catch(console.error);
