-- ============================================================
-- Mentric Demo Data Seed Script
-- Cleans up test data and populates realistic demo content
-- ============================================================

BEGIN;

-- Config variables
-- Org: Practice Org 2
-- Coach: Richard Anderson (fd312740-6b33-48a5-9e09-fc302bfa90cd)
-- Org ID: 2a2b4f35-01d0-435a-b1b8-885a67daab87

-- ============================================================
-- 1. CLEAN UP TEST CLIENTS (rename dodgy ones)
-- ============================================================
UPDATE "Clients" SET "Name" = 'Barclays' WHERE "Id" = 'fddf212c-b274-4f6b-b226-783c6894b2e5'; -- was Acme
UPDATE "Clients" SET "Name" = 'Deloitte' WHERE "Id" = 'a67899df-c131-405d-bb86-c3dad658a26f'; -- was test client
UPDATE "Clients" SET "Name" = 'Unilever' WHERE "Id" = '44b14926-8a43-43b3-99e9-c246ba07aead'; -- was email client
UPDATE "Clients" SET "Name" = 'Astra Zeneca' WHERE "Id" = 'f0789df2-7689-4612-bcc9-c2d0e07ce3e3'; -- was Dom client
UPDATE "Clients" SET "Name" = 'BT Group' WHERE "Id" = '9b545cc3-dbec-443c-a0ad-9cfcc757c317'; -- was here is a new client
UPDATE "Clients" SET "Name" = 'Shell' WHERE "Id" = '76b7752f-5abc-47fd-a143-672c5ba230e2'; -- was kitchen

-- ============================================================
-- 2. RENAME TEST PROGRAMMES
-- ============================================================
UPDATE "Programmes" SET "Name" = 'Emerging Leaders 2026', "Description" = 'A 12-month programme developing high-potential managers into senior leaders through structured coaching and 360 feedback.' WHERE "Id" = '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a'; -- was Leadership
UPDATE "Programmes" SET "Name" = 'Executive Coaching', "Description" = 'One-to-one executive coaching for C-suite and senior directors focusing on strategic leadership and organisational impact.' WHERE "Id" = '9fe1f1b3-86eb-4bb7-a21c-71dda9ddda3c'; -- was Coke leaders
UPDATE "Programmes" SET "Name" = 'Graduate Talent Programme', "Description" = 'Supporting new graduates through their first year with coaching focused on professional identity, confidence, and career clarity.' WHERE "Id" = 'd4187324-d4e0-45e5-9b3d-23ac61573a25'; -- was coke programme again
UPDATE "Programmes" SET "Name" = 'Performance Coaching', "Description" = 'Targeted coaching for individuals identified for performance development, building capability and confidence.' WHERE "Id" = 'e4a49584-8ec8-4af0-93df-b15d456eb6e5'; -- was Nike Programme
UPDATE "Programmes" SET "Name" = 'Resilience & Wellbeing', "Description" = 'Coaching programme focused on building resilience, managing stress, and creating sustainable working practices.' WHERE "Id" = '4b1ee248-fa81-4a83-a10c-d68ba73fae15'; -- was test programme
UPDATE "Programmes" SET "Name" = 'Transition Coaching', "Description" = 'Supporting leaders through significant role transitions, restructures, and career pivots.' WHERE "Id" = '43e9e238-baf0-4ffb-8d77-1798e8f1ce34'; -- was Email client

-- ============================================================
-- 3. CREATE DEMO COACHEE USERS
-- ============================================================

-- Password hash for 'Password1!' (reused from existing user)
-- We need: user in AspNetUsers, role in AspNetUserRoles, CoacheeProfile, CoachingRelationship

-- Get the coachee role ID
-- First, let's create the users

INSERT INTO "AspNetUsers" ("Id", "OrganisationId", "Role", "FirstName", "LastName", "Email", "NormalizedEmail", "UserName", "NormalizedUserName", "EmailConfirmed", "PasswordHash", "SecurityStamp", "ConcurrencyStamp", "PhoneNumberConfirmed", "TwoFactorEnabled", "LockoutEnabled", "AccessFailedCount", "IsActive", "CreatedAt", "ShowEmailToCoachees", "ShowPhoneToCoachees", "ProfileCompleted", "FirstLoginCompleted", "IsDeleted", "JobTitle", "Department")
VALUES
  ('demo-coachee-001', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'coachee', 'Sophie', 'Whitfield', 'sophie.whitfield@demo.com', 'SOPHIE.WHITFIELD@DEMO.COM', 'sophie.whitfield@demo.com', 'SOPHIE.WHITFIELD@DEMO.COM', true, 'AQAAAAIAAYagAAAAEFjOoLkdKIg/NjrcPazrndf3UrWGuI6vJWAVCFgVvJPzzq9da9kiQuBixg3kveIs1A==', gen_random_uuid()::text, gen_random_uuid()::text, false, false, true, 0, true, NOW() - interval '90 days', false, false, true, true, false, 'Head of Marketing', 'Marketing'),
  ('demo-coachee-002', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'coachee', 'James', 'Hargreaves', 'james.hargreaves@demo.com', 'JAMES.HARGREAVES@DEMO.COM', 'james.hargreaves@demo.com', 'JAMES.HARGREAVES@DEMO.COM', true, 'AQAAAAIAAYagAAAAEFjOoLkdKIg/NjrcPazrndf3UrWGuI6vJWAVCFgVvJPzzq9da9kiQuBixg3kveIs1A==', gen_random_uuid()::text, gen_random_uuid()::text, false, false, true, 0, true, NOW() - interval '60 days', false, false, true, true, false, 'Engineering Manager', 'Technology'),
  ('demo-coachee-003', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'coachee', 'Priya', 'Chakraborty', 'priya.chakraborty@demo.com', 'PRIYA.CHAKRABORTY@DEMO.COM', 'priya.chakraborty@demo.com', 'PRIYA.CHAKRABORTY@DEMO.COM', true, 'AQAAAAIAAYagAAAAEFjOoLkdKIg/NjrcPazrndf3UrWGuI6vJWAVCFgVvJPzzq9da9kiQuBixg3kveIs1A==', gen_random_uuid()::text, gen_random_uuid()::text, false, false, true, 0, true, NOW() - interval '75 days', false, false, true, true, false, 'Senior Consultant', 'Strategy'),
  ('demo-coachee-004', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'coachee', 'Marcus', 'Thornton', 'marcus.thornton@demo.com', 'MARCUS.THORNTON@DEMO.COM', 'marcus.thornton@demo.com', 'MARCUS.THORNTON@DEMO.COM', true, 'AQAAAAIAAYagAAAAEFjOoLkdKIg/NjrcPazrndf3UrWGuI6vJWAVCFgVvJPzzq9da9kiQuBixg3kveIs1A==', gen_random_uuid()::text, gen_random_uuid()::text, false, false, true, 0, true, NOW() - interval '45 days', false, false, true, true, false, 'Operations Director', 'Operations'),
  ('demo-coachee-005', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'coachee', 'Eleanor', 'Fitzpatrick', 'eleanor.fitzpatrick@demo.com', 'ELEANOR.FITZPATRICK@DEMO.COM', 'eleanor.fitzpatrick@demo.com', 'ELEANOR.FITZPATRICK@DEMO.COM', true, 'AQAAAAIAAYagAAAAEFjOoLkdKIg/NjrcPazrndf3UrWGuI6vJWAVCFgVvJPzzq9da9kiQuBixg3kveIs1A==', gen_random_uuid()::text, gen_random_uuid()::text, false, false, true, 0, true, NOW() - interval '30 days', false, false, true, true, false, 'Finance Director', 'Finance'),
  ('demo-coachee-006', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'coachee', 'Daniel', 'Osei', 'daniel.osei@demo.com', 'DANIEL.OSEI@DEMO.COM', 'daniel.osei@demo.com', 'DANIEL.OSEI@DEMO.COM', true, 'AQAAAAIAAYagAAAAEFjOoLkdKIg/NjrcPazrndf3UrWGuI6vJWAVCFgVvJPzzq9da9kiQuBixg3kveIs1A==', gen_random_uuid()::text, gen_random_uuid()::text, false, false, true, 0, true, NOW() - interval '50 days', false, false, true, true, false, 'Product Lead', 'Product'),
  ('demo-coachee-007', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'coachee', 'Charlotte', 'Bellingham', 'charlotte.bellingham@demo.com', 'CHARLOTTE.BELLINGHAM@DEMO.COM', 'charlotte.bellingham@demo.com', 'CHARLOTTE.BELLINGHAM@DEMO.COM', true, 'AQAAAAIAAYagAAAAEFjOoLkdKIg/NjrcPazrndf3UrWGuI6vJWAVCFgVvJPzzq9da9kiQuBixg3kveIs1A==', gen_random_uuid()::text, gen_random_uuid()::text, false, false, true, 0, true, NOW() - interval '40 days', false, false, true, true, false, 'HR Business Partner', 'People'),
  ('demo-coachee-008', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'coachee', 'Aiden', 'Murray', 'aiden.murray@demo.com', 'AIDEN.MURRAY@DEMO.COM', 'aiden.murray@demo.com', 'AIDEN.MURRAY@DEMO.COM', true, 'AQAAAAIAAYagAAAAEFjOoLkdKIg/NjrcPazrndf3UrWGuI6vJWAVCFgVvJPzzq9da9kiQuBixg3kveIs1A==', gen_random_uuid()::text, gen_random_uuid()::text, false, false, true, 0, true, NOW() - interval '55 days', false, false, true, true, false, 'Sales Director', 'Sales')
ON CONFLICT ("Id") DO UPDATE SET "FirstName" = EXCLUDED."FirstName", "LastName" = EXCLUDED."LastName", "JobTitle" = EXCLUDED."JobTitle", "Department" = EXCLUDED."Department";

-- Add coachee role
INSERT INTO "AspNetUserRoles" ("UserId", "RoleId")
SELECT u."Id", r."Id" FROM "AspNetUsers" u, "AspNetRoles" r
WHERE u."Id" LIKE 'demo-coachee-%' AND r."NormalizedName" = 'COACHEE'
ON CONFLICT DO NOTHING;

-- Create coachee profiles
INSERT INTO "CoacheeProfiles" ("Id", "UserId", "Goals", "Background", "CreatedAt", "UpdatedAt")
SELECT gen_random_uuid(), "Id", 'Develop leadership capability and professional impact', 'Experienced professional seeking structured coaching to reach the next level', NOW(), NOW()
FROM "AspNetUsers" WHERE "Id" LIKE 'demo-coachee-%'
ON CONFLICT DO NOTHING;

-- ============================================================
-- 4. CREATE COACHING RELATIONSHIPS (assign Richard as coach)
-- ============================================================

-- Assign coachees to programmes and create coaching relationships
-- Sophie & James → Emerging Leaders (Barclays)
INSERT INTO "CoachingRelationships" ("Id", "OrganisationId", "CoachId", "CoacheeId", "ProgrammeId", "ClientId", "Status", "StartedAt", "CreatedAt", "UpdatedAt", "GoalOwnership", "JourneyOwnership", "StageProgression", "SessionBooking", "IsDeleted")
VALUES
  (gen_random_uuid(), '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-001', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a', 'fddf212c-b274-4f6b-b226-783c6894b2e5', 1, NOW() - interval '90 days', NOW() - interval '90 days', NOW(), 0, 0, 0, 0, false),
  (gen_random_uuid(), '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-002', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a', 'fddf212c-b274-4f6b-b226-783c6894b2e5', 1, NOW() - interval '60 days', NOW() - interval '60 days', NOW(), 0, 0, 0, 0, false),
  -- Priya & Marcus → Senior Leadership Dev (Barclays)
  (gen_random_uuid(), '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-003', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98', 'fddf212c-b274-4f6b-b226-783c6894b2e5', 1, NOW() - interval '75 days', NOW() - interval '75 days', NOW(), 0, 0, 0, 0, false),
  (gen_random_uuid(), '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-004', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98', 'fddf212c-b274-4f6b-b226-783c6894b2e5', 1, NOW() - interval '45 days', NOW() - interval '45 days', NOW(), 0, 0, 0, 0, false),
  -- Eleanor → Women in Leadership (Barclays)
  (gen_random_uuid(), '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-005', '0d9f9b11-3af7-456c-a6a3-de7373612fe9', 'fddf212c-b274-4f6b-b226-783c6894b2e5', 1, NOW() - interval '30 days', NOW() - interval '30 days', NOW(), 0, 0, 0, 0, false),
  -- Daniel → Executive Coaching (Coca Cola)
  (gen_random_uuid(), '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-006', '9fe1f1b3-86eb-4bb7-a21c-71dda9ddda3c', '5c51c19e-9b05-461a-93d3-3c2c9a613268', 1, NOW() - interval '50 days', NOW() - interval '50 days', NOW(), 0, 0, 0, 0, false),
  -- Charlotte → Performance Coaching (Nike)
  (gen_random_uuid(), '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-007', 'e4a49584-8ec8-4af0-93df-b15d456eb6e5', '9237f3f8-9812-4eff-8958-b8386d9ba76c', 1, NOW() - interval '40 days', NOW() - interval '40 days', NOW(), 0, 0, 0, 0, false),
  -- Aiden → New Manager Coaching (Barclays)
  (gen_random_uuid(), '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-008', '05e55e8e-03ff-41be-97d6-15df5b4610d7', 'fddf212c-b274-4f6b-b226-783c6894b2e5', 1, NOW() - interval '55 days', NOW() - interval '55 days', NOW(), 0, 0, 0, 0, false);

-- Also add to ClientCoachees
INSERT INTO "ClientCoachees" ("Id", "ClientId", "CoacheeId", "AddedById", "AddedAt", "IsActive")
VALUES
  (gen_random_uuid(), 'fddf212c-b274-4f6b-b226-783c6894b2e5', 'demo-coachee-001', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', NOW(), true),
  (gen_random_uuid(), 'fddf212c-b274-4f6b-b226-783c6894b2e5', 'demo-coachee-002', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', NOW(), true),
  (gen_random_uuid(), 'fddf212c-b274-4f6b-b226-783c6894b2e5', 'demo-coachee-003', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', NOW(), true),
  (gen_random_uuid(), 'fddf212c-b274-4f6b-b226-783c6894b2e5', 'demo-coachee-004', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', NOW(), true),
  (gen_random_uuid(), 'fddf212c-b274-4f6b-b226-783c6894b2e5', 'demo-coachee-005', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', NOW(), true),
  (gen_random_uuid(), '5c51c19e-9b05-461a-93d3-3c2c9a613268', 'demo-coachee-006', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', NOW(), true),
  (gen_random_uuid(), '9237f3f8-9812-4eff-8958-b8386d9ba76c', 'demo-coachee-007', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', NOW(), true),
  (gen_random_uuid(), 'fddf212c-b274-4f6b-b226-783c6894b2e5', 'demo-coachee-008', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', NOW(), true)
ON CONFLICT DO NOTHING;

-- ============================================================
-- 5. CREATE GOALS
-- ============================================================

INSERT INTO "Goals" ("Id", "OrganisationId", "CoacheeId", "CreatedById", "Title", "Description", "Category", "Priority", "TargetDate", "Status", "ProgressPercentage", "ConfidencePercentage", "BaselineConfidence", "BaselineDate", "CurrentConfidence", "TargetConfidence", "CurrentStage", "CreatedAt", "UpdatedAt", "IsDeleted", "ProgrammeId")
VALUES
  -- Sophie Whitfield - 2 goals
  (gen_random_uuid(), '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'demo-coachee-001', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'Develop executive presence in board meetings', 'Build confidence and authority when presenting to the executive team and board of directors.', 'Leadership', 2, NOW() + interval '90 days', 1, 45, 55, 30, NOW() - interval '80 days', 55, 85, 2, NOW() - interval '80 days', NOW() - interval '2 days', false, '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a'),
  (gen_random_uuid(), '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'demo-coachee-001', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'Build a personal leadership brand', 'Define and communicate a clear leadership identity that resonates across the organisation.', 'Personal Development', 1, NOW() + interval '120 days', 1, 25, 40, 25, NOW() - interval '60 days', 40, 80, 1, NOW() - interval '60 days', NOW() - interval '5 days', false, '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a'),
  -- James Hargreaves - 2 goals
  (gen_random_uuid(), '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'demo-coachee-002', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'Improve delegation and trust in the team', 'Move from doing to leading — develop the ability to delegate effectively while maintaining quality.', 'Management', 2, NOW() + interval '60 days', 1, 60, 65, 35, NOW() - interval '55 days', 65, 90, 2, NOW() - interval '55 days', NOW() - interval '1 day', false, '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a'),
  (gen_random_uuid(), '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'demo-coachee-002', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'Develop coaching skills within the team', 'Learn to adopt a coaching approach in day-to-day management conversations.', 'Leadership', 0, NOW() + interval '150 days', 1, 15, 30, 20, NOW() - interval '30 days', 30, 75, 1, NOW() - interval '30 days', NOW() - interval '7 days', false, '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a'),
  -- Priya Chakraborty - 2 goals
  (gen_random_uuid(), '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'demo-coachee-003', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'Strengthen strategic thinking capability', 'Move beyond operational detail to think strategically about long-term team and business direction.', 'Strategy', 1, NOW() + interval '75 days', 1, 50, 60, 30, NOW() - interval '70 days', 60, 85, 2, NOW() - interval '70 days', NOW() - interval '3 days', false, 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98'),
  (gen_random_uuid(), '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'demo-coachee-003', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'Increase visibility across the organisation', 'Build relationships and profile beyond the immediate team to increase influence and career progression.', 'Career Development', 1, NOW() + interval '100 days', 1, 35, 45, 25, NOW() - interval '50 days', 45, 80, 1, NOW() - interval '50 days', NOW() - interval '4 days', false, 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98'),
  -- Marcus Thornton - 1 goal
  (gen_random_uuid(), '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'demo-coachee-004', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'Navigate difficult conversations with confidence', 'Develop frameworks and confidence for handling underperformance, conflict, and sensitive feedback.', 'Communication', 2, NOW() + interval '45 days', 1, 70, 72, 40, NOW() - interval '40 days', 72, 90, 3, NOW() - interval '40 days', NOW() - interval '1 day', false, 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98'),
  -- Eleanor Fitzpatrick - 1 goal
  (gen_random_uuid(), '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'demo-coachee-005', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'Create a sustainable work-life balance', 'Establish boundaries and routines that support high performance without burnout.', 'Wellbeing', 1, NOW() + interval '60 days', 1, 40, 50, 20, NOW() - interval '25 days', 50, 85, 2, NOW() - interval '25 days', NOW() - interval '2 days', false, '0d9f9b11-3af7-456c-a6a3-de7373612fe9'),
  -- Daniel Osei - 1 goal
  (gen_random_uuid(), '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'demo-coachee-006', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'Build a product-led growth strategy', 'Develop the skills and frameworks to shift the product team towards a growth-oriented mindset.', 'Strategy', 2, NOW() + interval '80 days', 1, 30, 45, 25, NOW() - interval '45 days', 45, 85, 1, NOW() - interval '45 days', NOW() - interval '6 days', false, '9fe1f1b3-86eb-4bb7-a21c-71dda9ddda3c'),
  -- Charlotte Bellingham - 1 goal (achieved!)
  (gen_random_uuid(), '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'demo-coachee-007', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'Transition into HR leadership role', 'Navigate the move from HR Business Partner to Head of People, building credibility and vision.', 'Career Development', 2, NOW() - interval '10 days', 2, 100, 90, 35, NOW() - interval '35 days', 90, 85, 4, NOW() - interval '35 days', NOW() - interval '10 days', false, 'e4a49584-8ec8-4af0-93df-b15d456eb6e5'),
  -- Aiden Murray - 1 goal
  (gen_random_uuid(), '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'demo-coachee-008', 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'Develop consultative selling approach', 'Move from transactional selling to a consultative, relationship-driven approach that builds long-term client partnerships.', 'Sales', 2, NOW() + interval '50 days', 1, 55, 60, 30, NOW() - interval '50 days', 60, 85, 2, NOW() - interval '50 days', NOW() - interval '3 days', false, '05e55e8e-03ff-41be-97d6-15df5b4610d7');

-- Add milestones to goals
INSERT INTO "GoalMilestones" ("Id", "GoalId", "Title", "DueDate", "IsCompleted", "CompletedAt", "DisplayOrder", "IsSkipped", "CreatedAt", "UpdatedAt", "IsDeleted")
SELECT gen_random_uuid(), g."Id", m.title, m.due, m.completed, CASE WHEN m.completed THEN NOW() - interval '10 days' ELSE NULL END, m.ord, false, g."CreatedAt", NOW(), false
FROM "Goals" g
CROSS JOIN LATERAL (
  VALUES
    ('Identify key stakeholders', g."CreatedAt" + interval '30 days', true, 1),
    ('Practise with trusted peer', g."CreatedAt" + interval '60 days', CASE WHEN g."ProgressPercentage" > 40 THEN true ELSE false END, 2),
    ('Deliver and gather feedback', g."CreatedAt" + interval '90 days', false, 3)
) AS m(title, due, completed, ord)
WHERE g."CoacheeId" LIKE 'demo-coachee-%' AND g."IsDeleted" = false;

-- ============================================================
-- 6. CREATE SESSIONS (mix of past completed and upcoming)
-- ============================================================

INSERT INTO "Sessions" ("Id", "CoachId", "CoacheeId", "OrganisationId", "ProgrammeId", "ScheduledAt", "DurationMinutes", "Status", "Location", "MeetingLink", "MeetingPlatformType", "FirefliesInvited", "Agenda", "Notes", "SharedNotes", "TrackIndividualProgress", "AiSharedWithCoachee", "IsDeleted", "CreatedAt", "UpdatedAt", "Reminder1hSent", "Reminder24hSent")
VALUES
  -- Past completed sessions
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-001', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a', NOW() - interval '75 days', 60, 2, 1, 'https://zoom.us/j/demo', 1, false, 'Initial chemistry session and goal setting', 'Excellent first session. Sophie is highly motivated and clear on her development areas. Agreed to focus on executive presence first.', 'We agreed on two key development areas: executive presence and personal leadership brand.', false, false, false, NOW() - interval '80 days', NOW() - interval '75 days', true, true),
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-001', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a', NOW() - interval '45 days', 60, 2, 1, 'https://zoom.us/j/demo', 1, false, 'Review stakeholder mapping exercise. Discuss board meeting preparation.', 'Sophie completed the stakeholder mapping. Identified three key allies on the board. Practised opening for next presentation.', 'Good progress on stakeholder relationships. Preparation plan agreed for April board meeting.', false, false, false, NOW() - interval '50 days', NOW() - interval '45 days', true, true),
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-001', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a', NOW() - interval '15 days', 60, 2, 1, 'https://zoom.us/j/demo', 1, false, 'Post board-meeting debrief. Review feedback from peers.', 'Board presentation went well. Sophie received positive feedback. Now shifting focus to leadership brand work.', 'Great progress on executive presence. Moving to leadership brand development.', false, false, false, NOW() - interval '20 days', NOW() - interval '15 days', true, true),
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-002', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a', NOW() - interval '50 days', 45, 2, 1, 'https://teams.microsoft.com/demo', 2, false, 'Explore delegation challenges and current workload', 'James recognises he''s holding on to too much. Identified three tasks to delegate this week. Discussed briefing framework.', 'Action: delegate three tasks using the RACI framework by next session.', false, false, false, NOW() - interval '55 days', NOW() - interval '50 days', true, true),
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-002', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a', NOW() - interval '20 days', 45, 2, 1, 'https://teams.microsoft.com/demo', 2, false, 'Review delegation outcomes. Discuss team coaching approach.', 'Delegation going well — team responded positively. James now keen to develop coaching skills for 1:1s.', 'Delegation experiment working. Next focus: coaching approach in 1:1 meetings.', false, false, false, NOW() - interval '25 days', NOW() - interval '20 days', true, true),
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-003', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98', NOW() - interval '60 days', 60, 2, 1, 'https://zoom.us/j/demo', 1, false, 'Strategic thinking assessment and goal alignment', 'Priya has strong analytical skills but tends to get pulled into operational detail. Created a weekly strategic thinking block in her calendar.', 'Established weekly strategic thinking time. Will present a strategy proposal next month.', false, false, false, NOW() - interval '65 days', NOW() - interval '60 days', true, true),
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-003', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98', NOW() - interval '30 days', 60, 2, 1, 'https://zoom.us/j/demo', 1, false, 'Review strategic proposal draft. Discuss visibility strategy.', 'Strategy proposal is strong. Discussed how to present it for maximum impact. Also started mapping key relationships for visibility goal.', 'Strategy proposal ready for leadership review. Starting cross-functional relationship building.', false, false, false, NOW() - interval '35 days', NOW() - interval '30 days', true, true),
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-004', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98', NOW() - interval '35 days', 90, 2, 0, NULL, 0, false, 'Deep dive on SBI feedback model. Role-play exercises.', 'Marcus practised three difficult conversation scenarios. Growing in confidence. Has two real conversations planned for next week.', 'Role-play exercises completed. Two real conversations planned.', false, false, false, NOW() - interval '40 days', NOW() - interval '35 days', true, true),
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-004', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98', NOW() - interval '7 days', 60, 2, 1, 'https://zoom.us/j/demo', 1, false, 'Debrief on difficult conversations. Review and refine approach.', 'Both conversations went better than expected. Marcus used the SBI model effectively. One team member responded very positively.', 'Excellent progress. Confidence has grown significantly. Refining approach for more nuanced situations.', false, false, false, NOW() - interval '12 days', NOW() - interval '7 days', true, true),
  -- Upcoming sessions
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-001', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a', NOW() + interval '3 days', 60, 0, 1, 'https://zoom.us/j/demo', 1, false, 'Leadership brand workshop. Review values exercise output.', NULL, NULL, false, false, false, NOW() - interval '5 days', NOW(), true, true),
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-002', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a', NOW() + interval '5 days', 45, 0, 1, 'https://teams.microsoft.com/demo', 2, false, 'Review coaching 1:1 outcomes. Discuss team feedback.', NULL, NULL, false, false, false, NOW() - interval '3 days', NOW(), true, true),
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-003', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98', NOW() + interval '7 days', 60, 0, 1, 'https://zoom.us/j/demo', 1, false, 'Strategy proposal feedback debrief. Next steps on visibility.', NULL, NULL, false, false, false, NOW() - interval '2 days', NOW(), true, true),
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-005', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '0d9f9b11-3af7-456c-a6a3-de7373612fe9', NOW() + interval '4 days', 60, 0, 1, 'https://zoom.us/j/demo', 1, false, 'Boundary-setting review. Energy audit findings.', NULL, NULL, false, false, false, NOW() - interval '4 days', NOW(), true, true),
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-006', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '9fe1f1b3-86eb-4bb7-a21c-71dda9ddda3c', NOW() + interval '6 days', 90, 0, 1, 'https://zoom.us/j/demo', 1, false, 'Product-led growth framework review. Market analysis discussion.', NULL, NULL, false, false, false, NOW() - interval '3 days', NOW(), true, true),
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-008', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '05e55e8e-03ff-41be-97d6-15df5b4610d7', NOW() + interval '8 days', 60, 0, 1, 'https://teams.microsoft.com/demo', 2, false, 'Consultative selling techniques. Review client call recordings.', NULL, NULL, false, false, false, NOW() - interval '2 days', NOW(), true, true);

-- ============================================================
-- 7. RENAME EXISTING TEST COACHEES (clean up visible names)
-- ============================================================

-- Update any test-looking user names that appear in the org
UPDATE "AspNetUsers" SET "FirstName" = 'Olivia', "LastName" = 'Henderson', "JobTitle" = 'Programme Director', "Department" = 'Delivery'
WHERE "OrganisationId" = '2a2b4f35-01d0-435a-b1b8-885a67daab87' AND "FirstName" = 'richyy' AND "Role" = 'coachee';

UPDATE "AspNetUsers" SET "FirstName" = 'Tom', "LastName" = 'Richards', "JobTitle" = 'Team Lead', "Department" = 'Engineering'
WHERE "OrganisationId" = '2a2b4f35-01d0-435a-b1b8-885a67daab87' AND "FirstName" = 'test' AND "LastName" = 'user' AND "Role" = 'coachee';

UPDATE "AspNetUsers" SET "FirstName" = 'Emma', "LastName" = 'Blake', "JobTitle" = 'Client Services Manager', "Department" = 'Client Services'
WHERE "OrganisationId" = '2a2b4f35-01d0-435a-b1b8-885a67daab87' AND "FirstName" = 'Joe' AND "LastName" = 'Wicks';

UPDATE "AspNetUsers" SET "FirstName" = 'Hannah', "LastName" = 'Marsh', "JobTitle" = 'Talent Manager', "Department" = 'People'
WHERE "OrganisationId" = '2a2b4f35-01d0-435a-b1b8-885a67daab87' AND "FirstName" = 'nike' AND "LastName" = 'programme2';

UPDATE "AspNetUsers" SET "FirstName" = 'Raj', "LastName" = 'Patel', "JobTitle" = 'Commercial Director', "Department" = 'Commercial'
WHERE "OrganisationId" = '2a2b4f35-01d0-435a-b1b8-885a67daab87' AND "FirstName" = 'Nike' AND "LastName" = 'Programme';

UPDATE "AspNetUsers" SET "FirstName" = 'Lucy', "LastName" = 'Chen', "JobTitle" = 'UX Lead', "Department" = 'Design'
WHERE "OrganisationId" = '2a2b4f35-01d0-435a-b1b8-885a67daab87' AND "FirstName" = 'Coachee' AND "LastName" = 'One';

UPDATE "AspNetUsers" SET "FirstName" = 'Nathan', "LastName" = 'Williams', "JobTitle" = 'Regional Manager', "Department" = 'Operations'
WHERE "OrganisationId" = '2a2b4f35-01d0-435a-b1b8-885a67daab87' AND "FirstName" = 'invitecoachees36' AND "Role" = 'coachee';

-- Clean up any "Coachee Acme" type names
UPDATE "AspNetUsers" SET "FirstName" = 'Sarah', "LastName" = 'Campbell'
WHERE "OrganisationId" = '2a2b4f35-01d0-435a-b1b8-885a67daab87' AND "FirstName" = 'Coachee' AND "LastName" = 'Acme' AND "Id" NOT IN (SELECT "Id" FROM "AspNetUsers" WHERE "FirstName" = 'Coachee' AND "LastName" = 'Acme' OFFSET 1) AND "Role" = 'coachee';

-- Rename org for screenshots
UPDATE "Organisations" SET "Name" = 'Anderson Coaching' WHERE "Id" = '2a2b4f35-01d0-435a-b1b8-885a67daab87';

COMMIT;
