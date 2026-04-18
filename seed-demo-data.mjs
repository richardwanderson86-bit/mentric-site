import { chromium } from 'playwright';

const BASE_URL = 'http://localhost:5173';
const API_URL = 'http://localhost:5173/api';
const EMAIL = 'richard.anderson-practice2@mentric.com';
const PASSWORD = 'Password1!';

// Realistic demo data
const DEMO_COACHEES = [
  { firstName: 'Sophie', lastName: 'Whitfield', email: 'sophie.whitfield@demo.com' },
  { firstName: 'James', lastName: 'Hargreaves', email: 'james.hargreaves@demo.com' },
  { firstName: 'Priya', lastName: 'Chakraborty', email: 'priya.chakraborty@demo.com' },
  { firstName: 'Marcus', lastName: 'Thornton', email: 'marcus.thornton@demo.com' },
  { firstName: 'Eleanor', lastName: 'Fitzpatrick', email: 'eleanor.fitzpatrick@demo.com' },
  { firstName: 'Daniel', lastName: 'Osei', email: 'daniel.osei@demo.com' },
  { firstName: 'Charlotte', lastName: 'Bellingham', email: 'charlotte.bellingham@demo.com' },
  { firstName: 'Aiden', lastName: 'Murray', email: 'aiden.murray@demo.com' },
];

const DEMO_PROGRAMMES = [
  { name: 'Senior Leadership Development', description: 'A structured programme for emerging senior leaders focusing on strategic thinking, executive presence, and organisational impact.' },
  { name: 'New Manager Coaching', description: 'Supporting first-time managers through the transition from individual contributor to people leader.' },
  { name: 'Women in Leadership', description: 'Empowering women leaders to develop their authentic leadership voice and navigate organisational dynamics with confidence.' },
];

const DEMO_GOALS = [
  { title: 'Develop executive presence in board meetings', description: 'Build confidence and authority when presenting to the executive team and board of directors.', priority: 'High', category: 'Leadership' },
  { title: 'Improve delegation and trust in the team', description: 'Move from doing to leading — develop the ability to delegate effectively while maintaining quality.', priority: 'High', category: 'Management' },
  { title: 'Build a personal leadership brand', description: 'Define and communicate a clear leadership identity that resonates across the organisation.', priority: 'Medium', category: 'Personal Development' },
  { title: 'Navigate difficult conversations with confidence', description: 'Develop frameworks and confidence for handling underperformance, conflict, and sensitive feedback.', priority: 'High', category: 'Communication' },
  { title: 'Strengthen strategic thinking capability', description: 'Move beyond operational detail to think strategically about long-term team and business direction.', priority: 'Medium', category: 'Strategy' },
  { title: 'Create a sustainable work-life balance', description: 'Establish boundaries and routines that support high performance without burnout.', priority: 'Medium', category: 'Wellbeing' },
  { title: 'Develop coaching skills within the team', description: 'Learn to adopt a coaching approach in day-to-day management conversations.', priority: 'Low', category: 'Leadership' },
  { title: 'Increase visibility across the organisation', description: 'Build relationships and profile beyond the immediate team to increase influence and career progression.', priority: 'Medium', category: 'Career Development' },
];

const DEMO_MILESTONES = [
  ['Identify key stakeholders and board dynamics', 'Practise presenting to a trusted peer', 'Deliver first board presentation with feedback'],
  ['Audit current workload for delegation opportunities', 'Delegate three key tasks with clear briefs', 'Review outcomes and adjust approach'],
  ['Complete personal values exercise', 'Draft leadership statement', 'Share with three trusted colleagues for feedback'],
  ['Practise SBI feedback model in low-stakes conversations', 'Have two planned difficult conversations', 'Reflect on outcomes and adjust approach'],
  ['Block weekly strategic thinking time', 'Present a strategic proposal to leadership', 'Integrate strategic lens into team planning'],
  ['Track energy levels for two weeks', 'Establish three non-negotiable boundaries', 'Review and refine after one month'],
  ['Complete coaching skills workshop', 'Use coaching approach in three 1:1s', 'Gather feedback from direct reports'],
  ['Map key relationships across the organisation', 'Attend two cross-functional meetings', 'Volunteer for a visible project or initiative'],
];

const DEMO_RESOURCES = [
  { title: 'The Coaching Habit — Summary & Key Takeaways', description: 'A practical overview of Michael Bungay Stanier\'s seven essential coaching questions for leaders.', type: 3, url: 'https://www.example.com/coaching-habit-summary' },
  { title: 'Building Executive Presence: A Guide', description: 'Research-backed strategies for developing gravitas, communication, and appearance in leadership roles.', type: 3, url: 'https://www.example.com/executive-presence' },
  { title: 'Delegation Framework Template', description: 'A structured template for delegating tasks effectively, including clarity of outcome, authority level, and check-in cadence.', type: 3, url: 'https://www.example.com/delegation-framework' },
  { title: 'Reflective Practice: A Coach\'s Guide', description: 'How to build a regular reflective practice that deepens self-awareness and improves coaching outcomes.', type: 3, url: 'https://www.example.com/reflective-practice' },
  { title: 'SBI Feedback Model — Video Walkthrough', description: 'A 12-minute video demonstrating the Situation-Behaviour-Impact feedback model in real coaching scenarios.', type: 1, url: 'https://www.example.com/sbi-model-video' },
  { title: 'Strengths-Based Leadership Assessment', description: 'A self-assessment tool for identifying and leveraging leadership strengths in the workplace.', type: 3, url: 'https://www.example.com/strengths-assessment' },
];

async function run() {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({
    viewport: { width: 1440, height: 900 },
  });
  const page = await context.newPage();

  // Login
  console.log('🔐 Logging in...');
  await page.goto(`${BASE_URL}/login`);
  await page.waitForSelector('#email', { timeout: 10000 });
  await page.fill('#email', EMAIL);
  await page.fill('#password', PASSWORD);
  await page.click('button[type="submit"]');
  await page.waitForURL((url) => !url.pathname.includes('/login'), { timeout: 15000 });
  console.log(`   Logged in → ${page.url()}`);
  await page.waitForTimeout(2000);

  // Get cookies for API calls
  const cookies = await context.cookies();
  const csrfCookie = cookies.find(c => c.name === 'XSRF-TOKEN' || c.name === 'csrf-token' || c.name.toLowerCase().includes('csrf'));
  const cookieHeader = cookies.map(c => `${c.name}=${c.value}`).join('; ');

  // Helper for API calls
  async function apiPost(endpoint, body) {
    const headers = {
      'Content-Type': 'application/json',
      'Cookie': cookieHeader,
    };
    if (csrfCookie) {
      headers['X-CSRF-Token'] = decodeURIComponent(csrfCookie.value);
    }
    const response = await page.request.post(`${API_URL}${endpoint}`, {
      data: body,
      headers,
    });
    if (!response.ok()) {
      const text = await response.text();
      throw new Error(`${response.status()} ${response.statusText()}: ${text}`);
    }
    return response.json();
  }

  async function apiGet(endpoint) {
    const response = await page.request.get(`${API_URL}${endpoint}`);
    if (!response.ok()) {
      const text = await response.text();
      throw new Error(`${response.status()} ${response.statusText()}: ${text}`);
    }
    return response.json();
  }

  // Step 1: Get existing clients
  console.log('\n📋 Getting existing data...');
  let clients = [];
  try {
    const clientData = await apiGet('/clients?pageSize=100&includeDrafts=true');
    clients = clientData.items || clientData || [];
    console.log(`   Found ${clients.length} client(s): ${clients.map(c => `${c.name} (${c.id})`).join(', ')}`);
  } catch (e) {
    console.log(`   Clients fetch: ${e.message.substring(0, 80)}`);
  }
  const clientId = clients.length > 0 ? clients[0].id : undefined;
  console.log(`   Using client ID: ${clientId}`);

  // Get existing programmes
  let existingProgrammes = [];
  try {
    const progData = await apiGet('/programmes');
    existingProgrammes = progData.items || progData || [];
    console.log(`   Found ${existingProgrammes.length} existing programme(s): ${existingProgrammes.map(p => `${p.name} (${p.id})`).join(', ')}`);
  } catch (e) {
    console.log(`   Programmes fetch: ${e.message.substring(0, 80)}`);
  }

  // Step 2: Create programmes
  console.log('\n📂 Creating programmes...');
  const createdProgrammes = [];
  for (const prog of DEMO_PROGRAMMES) {
    try {
      const existing = existingProgrammes.find(p => p.name === prog.name);
      if (existing) {
        console.log(`   ⏭ "${prog.name}" already exists`);
        createdProgrammes.push(existing);
        continue;
      }
      const body = { ...prog, isDraft: false };
      if (clientId) body.clientId = clientId;
      const result = await apiPost('/programmes', body);
      createdProgrammes.push(result);
      console.log(`   ✓ Created "${prog.name}"`);
    } catch (e) {
      console.log(`   ✗ Failed to create "${prog.name}": ${e.message}`);
    }
  }

  // Step 3: Invite coachees
  console.log('\n👥 Inviting coachees...');
  const invitedCoachees = [];
  for (const coachee of DEMO_COACHEES) {
    try {
      const body = { ...coachee };
      if (clientId) body.clientId = clientId;
      // Assign to first programme if available
      if (createdProgrammes.length > 0) {
        body.programmeId = createdProgrammes[Math.floor(Math.random() * createdProgrammes.length)].id;
      }
      const result = await apiPost('/invitations/coachee', body);
      invitedCoachees.push(result);
      console.log(`   ✓ Invited ${coachee.firstName} ${coachee.lastName}`);
    } catch (e) {
      console.log(`   ⏭ ${coachee.firstName} ${coachee.lastName}: ${e.message.substring(0, 80)}`);
    }
  }

  // Step 4: Get all coachees from programmes
  console.log('\n🔍 Getting coachee list...');
  let allCoachees = [];
  const allProgrammes = [...existingProgrammes, ...createdProgrammes];
  const seenIds = new Set();
  for (const prog of allProgrammes) {
    try {
      const data = await apiGet(`/programmes/${prog.id}/coachees?pageSize=100`);
      const coachees = data.items || data || [];
      for (const c of coachees) {
        const id = c.id || c.coacheeId || c.userId;
        if (id && !seenIds.has(id)) {
          seenIds.add(id);
          allCoachees.push(c);
        }
      }
    } catch (e) {
      // Skip
    }
  }
  console.log(`   Found ${allCoachees.length} coachee(s) across programmes`);
  if (allCoachees.length > 0) {
    console.log(`   Names: ${allCoachees.map(c => `${c.firstName || c.name || 'unknown'} ${c.lastName || ''}`).join(', ')}`);
  }

  // Step 5: Create goals for coachees
  console.log('\n🎯 Creating goals...');
  let goalIndex = 0;
  for (const coachee of allCoachees.slice(0, 6)) {
    const coacheeId = coachee.id || coachee.coacheeId || coachee.userId;
    if (!coacheeId) continue;

    // Create 1-2 goals per coachee
    const numGoals = Math.random() > 0.5 ? 2 : 1;
    for (let i = 0; i < numGoals && goalIndex < DEMO_GOALS.length; i++) {
      const goal = DEMO_GOALS[goalIndex];
      const milestones = DEMO_MILESTONES[goalIndex] || [];
      try {
        const targetDate = new Date();
        targetDate.setMonth(targetDate.getMonth() + 3);

        const result = await apiPost('/goals', {
          coacheeId,
          title: goal.title,
          description: goal.description,
          priority: goal.priority,
          category: goal.category,
          targetDate: targetDate.toISOString(),
          initialConfidence: 30 + Math.floor(Math.random() * 30),
          targetConfidence: 80 + Math.floor(Math.random() * 20),
          milestones: milestones.map((m, idx) => {
            const dueDate = new Date();
            dueDate.setMonth(dueDate.getMonth() + 1 + idx);
            return { title: m, dueDate: dueDate.toISOString() };
          }),
        });
        console.log(`   ✓ Goal: "${goal.title}" → ${coachee.firstName || 'coachee'}`);
      } catch (e) {
        console.log(`   ✗ Goal failed: ${e.message.substring(0, 80)}`);
      }
      goalIndex++;
    }
  }

  // Step 6: Create sessions
  console.log('\n📅 Creating sessions...');
  const now = new Date();
  for (let i = 0; i < Math.min(allCoachees.length, 5); i++) {
    const coachee = allCoachees[i];
    const coacheeId = coachee.id || coachee.coacheeId || coachee.userId;
    if (!coacheeId) continue;

    // Create an upcoming session
    const sessionDate = new Date(now);
    sessionDate.setDate(sessionDate.getDate() + 2 + i * 3); // Spread across next 2 weeks
    sessionDate.setHours(9 + i, 0, 0, 0);

    try {
      await apiPost('/sessions', {
        coacheeId,
        scheduledAt: sessionDate.toISOString(),
        durationMinutes: [45, 60, 60, 90, 45][i],
        location: 1, // Virtual
        meetingPlatformType: 0, // Manual
        meetingLink: 'https://zoom.us/j/demo',
        agenda: [
          'Review progress on leadership development goals. Discuss upcoming board presentation.',
          'Monthly check-in. Discuss delegation challenges and team dynamics.',
          'Explore personal leadership brand and organisational visibility.',
          'Deep dive on difficult conversations framework. Role-play exercises.',
          'Review 360 feedback results and create development plan.',
        ][i],
        inviteFireflies: false,
      });
      console.log(`   ✓ Session: ${coachee.firstName || 'coachee'} on ${sessionDate.toLocaleDateString('en-GB')}`);
    } catch (e) {
      console.log(`   ✗ Session failed: ${e.message.substring(0, 80)}`);
    }
  }

  // Step 7: Create resources
  console.log('\n📚 Creating resources...');
  for (const resource of DEMO_RESOURCES) {
    try {
      await apiPost('/resources', {
        ...resource,
        scope: 'Personal',
      });
      console.log(`   ✓ Resource: "${resource.title}"`);
    } catch (e) {
      console.log(`   ✗ Resource failed: ${e.message.substring(0, 80)}`);
    }
  }

  console.log('\n✅ Demo data seeded! Ready for screenshots.');
  await browser.close();
}

run().catch(console.error);
