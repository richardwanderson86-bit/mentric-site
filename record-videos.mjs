import { chromium } from 'playwright';
import { existsSync, mkdirSync, copyFileSync } from 'fs';

const BASE_URL = 'http://localhost:5173';
const EMAIL = 'richard.anderson-practice2@mentric.com';
const PASSWORD = 'Password1!';
const OUTPUT_DIR = 'public/videos';

// Helper: hide all EditorialBanners, modals and overlays via CSS injection
async function dismissOverlays(page) {
  await page.waitForTimeout(1500);

  // Inject CSS to hide all editorial banners (the coloured info bars at the top of each page)
  await page.addStyleTag({
    content: `
      /* Hide all editorial banners — the border-l-2 rounded-r-lg info bars */
      .border-l-2.rounded-r-lg { display: none !important; }
      /* Hide any toast notifications */
      [data-sonner-toaster] { display: none !important; }
    `
  });

  // Click dismiss on any remaining modals/dialogs
  const dismissButtons = page.locator('[aria-label="Dismiss"], [aria-label="Close"]');
  const count = await dismissButtons.count();
  for (let i = 0; i < count; i++) {
    await dismissButtons.nth(i).click().catch(() => {});
    await page.waitForTimeout(300);
  }

  await page.waitForTimeout(1000);
}

// Smooth eased scroll
async function smoothScroll(page, distance, duration) {
  await page.evaluate(
    ([dist, dur]) => {
      return new Promise((resolve) => {
        const start = window.scrollY;
        const startTime = performance.now();
        function step(now) {
          const elapsed = now - startTime;
          const progress = Math.min(elapsed / dur, 1);
          const ease = progress < 0.5
            ? 2 * progress * progress
            : 1 - Math.pow(-2 * progress + 2, 2) / 2;
          window.scrollTo(0, start + dist * ease);
          if (progress < 1) requestAnimationFrame(step);
          else resolve();
        }
        requestAnimationFrame(step);
      });
    },
    [distance, duration]
  );
}

// Each recording definition — slower, more deliberate pacing
const recordings = [
  {
    name: 'command-center',
    label: 'Command Centre',
    steps: async (page) => {
      await page.goto(`${BASE_URL}/command-center`, { waitUntil: 'networkidle' });
      await dismissOverlays(page);
      await page.waitForTimeout(3000);
      // Scroll all the way down the page
      await smoothScroll(page, 800, 6000);
      await page.waitForTimeout(2000);
      await smoothScroll(page, 800, 6000);
      await page.waitForTimeout(2000);
      await smoothScroll(page, 800, 6000);
      await page.waitForTimeout(2500);
      // Scroll back to top
      await smoothScroll(page, -2400, 5000);
      await page.waitForTimeout(2000);
    },
  },
  {
    name: 'goals-pipeline',
    label: 'Goals Pipeline',
    steps: async (page) => {
      await page.goto(`${BASE_URL}/goals/pipeline`, { waitUntil: 'networkidle' });
      await dismissOverlays(page);
      await page.waitForTimeout(3000);
      await smoothScroll(page, 800, 6000);
      await page.waitForTimeout(2000);
      await smoothScroll(page, 800, 6000);
      await page.waitForTimeout(2500);
      await smoothScroll(page, -1600, 5000);
      await page.waitForTimeout(2000);
    },
  },
  {
    name: 'assessments',
    label: 'Assessments — Template Builder',
    steps: async (page) => {
      await page.goto(`${BASE_URL}/assessments/new`, { waitUntil: 'networkidle' });
      await dismissOverlays(page);
      await page.waitForTimeout(3000);

      // Type a template name — slow, deliberate typing
      const nameInput = page.locator('input[placeholder*="e.g."], input[placeholder*="name"], input[placeholder*="title"]').first();
      if (await nameInput.isVisible({ timeout: 3000 }).catch(() => false)) {
        await nameInput.click();
        await page.waitForTimeout(500);
        await page.keyboard.type('Leadership Effectiveness Assessment', { delay: 60 });
        await page.waitForTimeout(2000);
      }

      // Scroll down to see the purpose cards
      await smoothScroll(page, 300, 3000);
      await page.waitForTimeout(2000);

      // Click the 'Development' purpose card
      const devCard = page.locator('text=Development').first();
      if (await devCard.isVisible({ timeout: 3000 }).catch(() => false)) {
        await devCard.click();
        await page.waitForTimeout(2500);
      }

      // Scroll to show the selection
      await smoothScroll(page, 200, 2000);
      await page.waitForTimeout(2000);

      // Click Next to go to Instructions step
      const nextBtn = page.locator('button:has-text("Next")').first();
      if (await nextBtn.isVisible({ timeout: 3000 }).catch(() => false)) {
        await nextBtn.click();
        await page.waitForTimeout(3500);
      }

      // Scroll the instructions step
      await smoothScroll(page, 250, 2500);
      await page.waitForTimeout(2000);

      // Click Next to Questions step
      const nextBtn2 = page.locator('button:has-text("Next")').first();
      if (await nextBtn2.isVisible({ timeout: 3000 }).catch(() => false)) {
        await nextBtn2.click();
        await page.waitForTimeout(3500);
      }

      // Show the questions step — linger
      await smoothScroll(page, 250, 2500);
      await page.waitForTimeout(3000);
      await smoothScroll(page, -250, 2000);
      await page.waitForTimeout(2000);
    },
  },
  {
    name: 'analytics',
    label: 'Analytics — AI Insights',
    steps: async (page) => {
      await page.goto(`${BASE_URL}/analytics?tab=insights`, { waitUntil: 'networkidle' });
      await dismissOverlays(page);
      await page.waitForTimeout(3000);

      // Click the Insights tab
      const insightsTab = page.locator('button:has-text("Insights"), [role="tab"]:has-text("Insights")').first();
      if (await insightsTab.isVisible({ timeout: 3000 }).catch(() => false)) {
        await insightsTab.click();
        await page.waitForTimeout(3000);
      }

      // Find and type into the AI query
      const queryInput = page.locator('textarea[placeholder*="Ask"], textarea[placeholder*="ask"], textarea[placeholder*="goals"], textarea[placeholder*="e.g."]').first();
      if (await queryInput.isVisible({ timeout: 3000 }).catch(() => false)) {
        await queryInput.click();
        await page.waitForTimeout(800);
        await page.keyboard.type('Which coachees have completed the most sessions?', { delay: 50 });
        await page.waitForTimeout(2500);

        // Submit
        const sendBtn = page.locator('button[type="submit"], button:has-text("Send"), button:has-text("Ask"), button[aria-label*="send"], button[aria-label*="Send"]').first();
        if (await sendBtn.isVisible({ timeout: 2000 }).catch(() => false)) {
          await sendBtn.click();
        } else {
          await page.keyboard.press('Enter');
        }
        await page.waitForTimeout(6000);
      }

      // Scroll to show the response
      await smoothScroll(page, 800, 6000);
      await page.waitForTimeout(2000);
      await smoothScroll(page, 800, 6000);
      await page.waitForTimeout(2500);
      await smoothScroll(page, -1600, 5000);
      await page.waitForTimeout(2000);
    },
  },
  {
    name: 'sessions',
    label: 'Sessions',
    steps: async (page) => {
      await page.goto(`${BASE_URL}/sessions`, { waitUntil: 'networkidle' });
      await dismissOverlays(page);
      await page.waitForTimeout(3000);
      await smoothScroll(page, 800, 6000);
      await page.waitForTimeout(2000);
      await smoothScroll(page, 800, 6000);
      await page.waitForTimeout(2500);
      await smoothScroll(page, -1600, 5000);
      await page.waitForTimeout(2000);
    },
  },
];

async function run() {
  if (!existsSync(OUTPUT_DIR)) mkdirSync(OUTPUT_DIR, { recursive: true });

  const browser = await chromium.launch({ headless: true });

  // Initial login to accept privacy policy / dismiss one-time gates
  const initCtx = await browser.newContext({
    viewport: { width: 1440, height: 900 },
    deviceScaleFactor: 2,
  });
  const initPage = await initCtx.newPage();
  console.log('Logging in (pre-warm)...');
  await initPage.goto(`${BASE_URL}/login`);
  await initPage.waitForSelector('#email', { timeout: 10000 });
  await initPage.fill('#email', EMAIL);
  await initPage.fill('#password', PASSWORD);
  await initPage.click('button[type="submit"]');
  await initPage.waitForURL((url) => !url.pathname.includes('/login'), { timeout: 15000 });
  await initPage.waitForTimeout(3000);
  await dismissOverlays(initPage);
  await initPage.waitForTimeout(2000);

  // Store cookies so subsequent contexts are already logged in
  let cookies = await initCtx.cookies();
  let storageState = await initCtx.storageState();
  await initPage.close();
  await initCtx.close();

  // Record each page
  for (const rec of recordings) {
    try {
      console.log(`Recording ${rec.label}...`);

      const ctx = await browser.newContext({
        viewport: { width: 1440, height: 900 },
        deviceScaleFactor: 2,
        recordVideo: { dir: '/tmp/mentric-videos', size: { width: 1440, height: 900 } },
        storageState,
      });
      await ctx.addCookies(cookies);
      // Verify login using a non-recording context first
      const checkCtx = await browser.newContext({ storageState });
      await checkCtx.addCookies(cookies);
      const checkPage = await checkCtx.newPage();
      await checkPage.goto(`${BASE_URL}/command-center`, { waitUntil: 'networkidle' });
      if (checkPage.url().includes('/login')) {
        await checkPage.waitForSelector('#email', { timeout: 10000 });
        await checkPage.fill('#email', EMAIL);
        await checkPage.fill('#password', PASSWORD);
        await checkPage.click('button[type="submit"]');
        await checkPage.waitForURL((url) => !url.pathname.includes('/login'), { timeout: 15000 });
        // Update cookies/storage after fresh login
        cookies = await checkCtx.cookies();
        storageState = await checkCtx.storageState();
      }
      await checkPage.close();
      await checkCtx.close();

      // Now start the recording context — goes straight to the target page
      const page = await ctx.newPage();
      await rec.steps(page);

      // Save the video
      const video = page.video();
      if (video) {
        const videoPath = await video.path();
        await page.close();
        await ctx.close();
        copyFileSync(videoPath, `${OUTPUT_DIR}/${rec.name}.webm`);
        console.log(`  ✓ ${rec.name}.webm saved`);
      }
    } catch (err) {
      console.log(`  ✗ ${rec.label} failed: ${err.message}`);
    }
  }

  await browser.close();
  console.log('Done! Videos saved to', OUTPUT_DIR);
}

run().catch(console.error);
