-- ============================================================
-- Extended Demo Data Seed
-- Adds lots more sessions + goal progress for rich analytics
-- Run AFTER the original seed-db.sql
-- ============================================================

BEGIN;

-- Coach ID and Org ID
-- Coach: fd312740-6b33-48a5-9e09-fc302bfa90cd
-- Org: 2a2b4f35-01d0-435a-b1b8-885a67daab87

-- ============================================================
-- 1. ADD MANY MORE COMPLETED SESSIONS (spread across 6 months)
-- Status: 0=Scheduled, 1=InProgress, 2=Completed, 3=Cancelled
-- Location: 0=InPerson, 1=Online
-- MeetingPlatformType: 0=None, 1=Zoom, 2=Teams
-- ============================================================

-- Delete old sessions so we start clean with good date spread
DELETE FROM "Sessions" WHERE "OrganisationId" = '2a2b4f35-01d0-435a-b1b8-885a67daab87';

INSERT INTO "Sessions" ("Id", "CoachId", "CoacheeId", "OrganisationId", "ProgrammeId", "ScheduledAt", "DurationMinutes", "Status", "Location", "MeetingLink", "MeetingPlatformType", "FirefliesInvited", "Agenda", "Notes", "SharedNotes", "TrackIndividualProgress", "AiSharedWithCoachee", "IsDeleted", "CreatedAt", "UpdatedAt", "Reminder1hSent", "Reminder24hSent")
VALUES
  -- ========== Sophie Whitfield (demo-coachee-001) — 8 sessions ==========
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-001', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a',
   '2026-03-18 10:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Initial chemistry session and goal setting',
   'Excellent first session. Sophie is highly motivated and clear on her development areas. Agreed to focus on executive presence and stakeholder management.',
   'We agreed on two key areas: executive presence and stakeholder relationships.', false, false, false, '2026-03-15 09:00:00+00', '2026-03-18 11:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-001', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a',
   '2026-04-08 10:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Review stakeholder mapping exercise',
   'Sophie completed the stakeholder map. Identified three key allies on the board. Practised opening for next presentation.',
   'Good progress on stakeholder relationships. Preparation plan agreed for board meeting.', false, false, false, '2026-04-01 09:00:00+00', '2026-04-08 11:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-001', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a',
   '2026-04-29 10:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Board presentation debrief and peer feedback review',
   'Board presentation went well. Sophie received positive feedback from three directors. Confidence is growing noticeably.',
   'Great progress on executive presence. Moving to leadership brand development.', false, false, false, '2026-04-22 09:00:00+00', '2026-04-29 11:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-001', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a',
   '2026-05-20 10:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Leadership brand workshop — values and visibility',
   'Explored personal leadership brand. Sophie identified three core values and how they show up in her leadership style.',
   'Leadership brand framework drafted. Action: present values to direct reports next week.', false, false, false, '2026-05-13 09:00:00+00', '2026-05-20 11:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-001', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a',
   '2026-06-10 10:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Mid-programme review and goal recalibration',
   'Significant progress across both goals. Stakeholder relationships transformed. Recalibrated targets for H2.',
   'Mid-point review complete. On track for all objectives.', false, false, false, '2026-06-03 09:00:00+00', '2026-06-10 11:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-001', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a',
   '2026-07-01 10:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Difficult conversations — preparing for restructure announcement',
   'Sophie needs to communicate a team restructure. Practised messaging and anticipated reactions. Very well prepared.',
   'Restructure communication plan ready. Follow-up booked for debrief.', false, false, false, '2026-06-24 09:00:00+00', '2026-07-01 11:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-001', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a',
   '2026-07-22 10:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Restructure debrief. Resilience and energy management.',
   'Restructure handled brilliantly. Team morale stayed high. Now focusing on sustaining energy through the change period.',
   'Restructure complete. Focusing on sustainable leadership practices.', false, false, false, '2026-07-15 09:00:00+00', '2026-07-22 11:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-001', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a',
   '2026-08-12 10:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Review progress against original goals. Plan for final quarter.',
   'Outstanding progress. Sophie has exceeded expectations on executive presence. Leadership brand is now well established.',
   'Q3 review complete. Strong momentum heading into final quarter.', false, false, false, '2026-08-05 09:00:00+00', '2026-08-12 11:00:00+00', true, true),

  -- ========== James Hargreaves (demo-coachee-002) — 7 sessions ==========
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-002', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a',
   '2026-04-01 14:00:00+00', 45, 2, 1, 'https://teams.microsoft.com/demo', 2, false,
   'Explore delegation challenges and workload',
   'James recognises he holds on to too much. Identified three tasks to delegate this week. Discussed briefing framework.',
   'Action: delegate three tasks using RACI framework by next session.', false, false, false, '2026-03-25 09:00:00+00', '2026-04-01 15:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-002', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a',
   '2026-04-22 14:00:00+00', 45, 2, 1, 'https://teams.microsoft.com/demo', 2, false,
   'Review delegation outcomes. Team coaching approach.',
   'Delegation going well. Team responded positively. James now keen to develop coaching skills for his own 1:1s.',
   'Delegation experiment working. Next focus: coaching approach in 1:1 meetings.', false, false, false, '2026-04-15 09:00:00+00', '2026-04-22 15:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-002', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a',
   '2026-05-13 14:00:00+00', 45, 2, 1, 'https://teams.microsoft.com/demo', 2, false,
   'Coaching skills for managers. Active listening practice.',
   'Practised GROW model in role-play scenarios. James is a natural coach, just needed the framework.',
   'GROW framework practised. James to use in next three 1:1s.', false, false, false, '2026-05-06 09:00:00+00', '2026-05-13 15:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-002', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a',
   '2026-06-03 14:00:00+00', 45, 2, 1, 'https://teams.microsoft.com/demo', 2, false,
   'Review 1:1 coaching outcomes. Team engagement survey results.',
   'Team engagement scores up 15%. Direct reports report feeling more supported. James is visibly more confident.',
   'Team engagement improving. Continue coaching approach in 1:1s.', false, false, false, '2026-05-27 09:00:00+00', '2026-06-03 15:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-002', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a',
   '2026-06-24 14:00:00+00', 45, 2, 1, 'https://teams.microsoft.com/demo', 2, false,
   'Strategic thinking. Moving from technical to strategic leadership.',
   'James tends to default to problem-solving mode. Explored how to step back and think more strategically.',
   'Working on strategic perspective. Weekly thinking time blocked in calendar.', false, false, false, '2026-06-17 09:00:00+00', '2026-06-24 15:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-002', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a',
   '2026-07-15 14:00:00+00', 45, 2, 1, 'https://teams.microsoft.com/demo', 2, false,
   'Stakeholder management. Building influence beyond engineering.',
   'Mapped key stakeholders across the business. Identified two cross-functional relationships to develop.',
   'Cross-functional relationship plan created. Coffee meetings booked.', false, false, false, '2026-07-08 09:00:00+00', '2026-07-15 15:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-002', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a',
   '2026-08-05 14:00:00+00', 60, 2, 1, 'https://teams.microsoft.com/demo', 2, false,
   'Mid-year review. Promotion readiness discussion.',
   'Significant growth. James has been shortlisted for Director role. Discussed interview preparation and leadership narrative.',
   'Promotion conversation ongoing. Strong candidate for Director.', false, false, false, '2026-07-29 09:00:00+00', '2026-08-05 15:00:00+00', true, true),

  -- ========== Priya Chakraborty (demo-coachee-003) — 6 sessions ==========
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-003', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98',
   '2026-04-14 09:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Strategic thinking and goal alignment',
   'Priya has strong analytical skills but gets pulled into operational detail. Created weekly strategic thinking block.',
   'Established weekly strategic time. Will present strategy proposal next month.', false, false, false, '2026-04-07 09:00:00+00', '2026-04-14 10:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-003', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98',
   '2026-05-05 09:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Review strategy proposal draft. Visibility strategy.',
   'Strategy proposal is strong. Discussed presenting for maximum impact. Started mapping key relationships.',
   'Strategy proposal ready for review. Building cross-functional visibility.', false, false, false, '2026-04-28 09:00:00+00', '2026-05-05 10:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-003', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98',
   '2026-05-26 09:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Client relationship skills. Consultative approach.',
   'Priya is excellent technically but needs to build more rapport with clients. Practised consultative questioning.',
   'Working on consultative skills. Role-play exercises booked for next time.', false, false, false, '2026-05-19 09:00:00+00', '2026-05-26 10:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-003', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98',
   '2026-06-16 09:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Client presentation debrief. Building thought leadership.',
   'Client presentation went brilliantly. Priya received excellent feedback. Discussing thought leadership opportunities.',
   'Client work going well. Exploring internal thought leadership platform.', false, false, false, '2026-06-09 09:00:00+00', '2026-06-16 10:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-003', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98',
   '2026-07-07 09:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Career planning. Partner track discussion.',
   'Priya is clear she wants to make Partner. Mapped out the requirements and identified two gaps to close.',
   'Partner track plan created. Two development areas identified.', false, false, false, '2026-06-30 09:00:00+00', '2026-07-07 10:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-003', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98',
   '2026-08-04 09:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Mentoring others. Building a personal board of advisors.',
   'Priya has started mentoring two junior consultants. Also building her advisory network. Great momentum.',
   'Mentoring underway. Advisory network taking shape.', false, false, false, '2026-07-28 09:00:00+00', '2026-08-04 10:00:00+00', true, true),

  -- ========== Marcus Thornton (demo-coachee-004) — 6 sessions ==========
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-004', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98',
   '2026-04-07 11:00:00+00', 90, 2, 0, NULL, 0, false,
   'Difficult conversations: SBI feedback model introduction',
   'Marcus practised three difficult conversation scenarios. Growing in confidence. Has two real conversations planned.',
   'Role-play exercises completed. Two real conversations planned.', false, false, false, '2026-03-31 09:00:00+00', '2026-04-07 12:30:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-004', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98',
   '2026-04-28 11:00:00+00', 60, 2, 0, NULL, 0, false,
   'Debrief on difficult conversations. Refine approach.',
   'Both conversations went better than expected. Marcus used SBI effectively. One team member responded very positively.',
   'Excellent progress. Confidence has grown significantly.', false, false, false, '2026-04-21 09:00:00+00', '2026-04-28 12:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-004', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98',
   '2026-05-19 11:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Team performance. Setting expectations and accountability.',
   'Marcus has been too lenient with underperformers. Discussed how to set clear expectations without being punitive.',
   'Performance framework agreed. Clear expectations being set with team.', false, false, false, '2026-05-12 09:00:00+00', '2026-05-19 12:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-004', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98',
   '2026-06-09 11:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Operational efficiency. Process improvement mindset.',
   'Identified three process bottlenecks in operations. Marcus created an improvement plan with quick wins.',
   'Process improvement plan underway. Three quick wins identified.', false, false, false, '2026-06-02 09:00:00+00', '2026-06-09 12:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-004', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98',
   '2026-07-14 11:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Leading through change. Restructure communication planning.',
   'Operations restructure on the horizon. Marcus is preparing well. Communication plan drafted.',
   'Change leadership plan in place. Marcus feeling well prepared.', false, false, false, '2026-07-07 09:00:00+00', '2026-07-14 12:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-004', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98',
   '2026-08-11 11:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Post-restructure review. Team morale and engagement.',
   'Restructure handled confidently. Team morale stable. Marcus has grown enormously in his leadership presence.',
   'Restructure complete. Team engaged. Strong leadership growth.', false, false, false, '2026-08-04 09:00:00+00', '2026-08-11 12:00:00+00', true, true),

  -- ========== Eleanor Fitzpatrick (demo-coachee-005) — 5 sessions ==========
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-005', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '0d9f9b11-3af7-456c-a6a3-de7373612fe9',
   '2026-05-06 15:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Work-life balance and boundary setting',
   'Eleanor is working 60+ hour weeks. Identified root causes: inability to say no, perfectionism, unclear delegation.',
   'Three boundary-setting actions agreed for this week.', false, false, false, '2026-04-29 09:00:00+00', '2026-05-06 16:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-005', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '0d9f9b11-3af7-456c-a6a3-de7373612fe9',
   '2026-05-27 15:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Energy audit results. Sustainable working patterns.',
   'Energy audit revealed key drains: unnecessary meetings, email checking, and late-night work. Created new daily structure.',
   'New daily structure in place. Cutting three recurring meetings.', false, false, false, '2026-05-20 09:00:00+00', '2026-05-27 16:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-005', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '0d9f9b11-3af7-456c-a6a3-de7373612fe9',
   '2026-06-17 15:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Assertiveness and saying no. Practice scenarios.',
   'Practised saying no in three realistic scenarios. Eleanor found it uncomfortable but acknowledged the necessity.',
   'Assertiveness practice underway. Three scenarios handled this week.', false, false, false, '2026-06-10 09:00:00+00', '2026-06-17 16:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-005', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '0d9f9b11-3af7-456c-a6a3-de7373612fe9',
   '2026-07-08 15:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Building a high-performing finance team. Talent development.',
   'Eleanor wants to develop her team so she can step back from the detail. Discussed talent mapping and succession planning.',
   'Talent mapping complete. Two team members identified for development.', false, false, false, '2026-07-01 09:00:00+00', '2026-07-08 16:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-005', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '0d9f9b11-3af7-456c-a6a3-de7373612fe9',
   '2026-08-05 15:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Progress review. Hours down, impact up.',
   'Working hours down to 45 per week. Team is stepping up. Eleanor is happier and more effective. Real transformation.',
   'Significant improvement in work-life balance. Team performing well independently.', false, false, false, '2026-07-29 09:00:00+00', '2026-08-05 16:00:00+00', true, true),

  -- ========== Daniel Osei (demo-coachee-006) — 5 sessions ==========
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-006', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '9fe1f1b3-86eb-4bb7-a21c-71dda9ddda3c',
   '2026-04-15 16:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Product vision and strategic direction',
   'Daniel has strong product instincts but needs to articulate vision more clearly to stakeholders.',
   'Working on vision communication. Presentation drafted for exec team.', false, false, false, '2026-04-08 09:00:00+00', '2026-04-15 17:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-006', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '9fe1f1b3-86eb-4bb7-a21c-71dda9ddda3c',
   '2026-05-13 16:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Cross-functional influence. Working with engineering and sales.',
   'Daniel struggles with sales team alignment. Explored how to build bridges without compromising product integrity.',
   'Sales alignment improving. Joint planning session scheduled.', false, false, false, '2026-05-06 09:00:00+00', '2026-05-13 17:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-006', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '9fe1f1b3-86eb-4bb7-a21c-71dda9ddda3c',
   '2026-06-10 16:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Data-driven decision making. Product metrics framework.',
   'Built a product metrics framework. Daniel now has clear KPIs for each product area.',
   'Metrics framework complete. Dashboard being built by analytics team.', false, false, false, '2026-06-03 09:00:00+00', '2026-06-10 17:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-006', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '9fe1f1b3-86eb-4bb7-a21c-71dda9ddda3c',
   '2026-07-08 16:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Managing up. Board reporting and executive communication.',
   'Daniel needs to improve exec communication. Practised board update format: problem, data, recommendation.',
   'Board communication framework practised. Next board meeting in two weeks.', false, false, false, '2026-07-01 09:00:00+00', '2026-07-08 17:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-006', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '9fe1f1b3-86eb-4bb7-a21c-71dda9ddda3c',
   '2026-08-12 16:00:00+00', 60, 2, 1, 'https://zoom.us/j/demo', 1, false,
   'Board presentation debrief. Product strategy sign-off.',
   'Board presentation was a success. Product strategy signed off with full support. Daniel is thriving.',
   'Product strategy approved. Daniel growing into a true product leader.', false, false, false, '2026-08-05 09:00:00+00', '2026-08-12 17:00:00+00', true, true),

  -- ========== Aiden Murray (demo-coachee-008) — 4 sessions ==========
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-008', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '05e55e8e-03ff-41be-97d6-15df5b4610d7',
   '2026-05-20 11:00:00+00', 60, 2, 1, 'https://teams.microsoft.com/demo', 2, false,
   'Consultative selling skills. Moving from pitching to advising.',
   'Aiden tends to jump to solutions. Practised asking deeper questions and listening before recommending.',
   'Working on consultative approach. Three client meetings this week to practise.', false, false, false, '2026-05-13 09:00:00+00', '2026-05-20 12:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-008', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '05e55e8e-03ff-41be-97d6-15df5b4610d7',
   '2026-06-17 11:00:00+00', 60, 2, 1, 'https://teams.microsoft.com/demo', 2, false,
   'Client relationship management. Building trust and rapport.',
   'Two of three client conversations went well. Aiden noticed the difference when he listened more. One client gave great feedback.',
   'Client feedback positive. Trust-building approach working.', false, false, false, '2026-06-10 09:00:00+00', '2026-06-17 12:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-008', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '05e55e8e-03ff-41be-97d6-15df5b4610d7',
   '2026-07-15 11:00:00+00', 60, 2, 1, 'https://teams.microsoft.com/demo', 2, false,
   'Negotiation skills. Commercial conversations.',
   'Aiden avoids pricing conversations. Practised three scenarios where he leads with value before discussing cost.',
   'Pricing confidence improving. Value-led approach practised.', false, false, false, '2026-07-08 09:00:00+00', '2026-07-15 12:00:00+00', true, true),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-008', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '05e55e8e-03ff-41be-97d6-15df5b4610d7',
   '2026-08-12 11:00:00+00', 60, 2, 1, 'https://teams.microsoft.com/demo', 2, false,
   'Pipeline management and forecasting confidence.',
   'Pipeline is looking strong. Aiden is now forecasting with more accuracy and confidence. Commercial acumen growing.',
   'Pipeline growing. Forecasting accuracy improved.', false, false, false, '2026-08-05 09:00:00+00', '2026-08-12 12:00:00+00', true, true),

  -- ========== UPCOMING SESSIONS (next 2-3 weeks) ==========
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-001', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a',
   '2026-09-10 10:00:00+00', 60, 0, 1, 'https://zoom.us/j/demo', 1, false,
   'Q3 wrap-up. Preparing for year-end review.', NULL, NULL, false, false, false, '2026-09-03 09:00:00+00', '2026-09-03 09:00:00+00', false, false),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-002', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a',
   '2026-09-11 14:00:00+00', 45, 0, 1, 'https://teams.microsoft.com/demo', 2, false,
   'Director interview preparation. Leadership narrative.', NULL, NULL, false, false, false, '2026-09-04 09:00:00+00', '2026-09-04 09:00:00+00', false, false),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-003', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98',
   '2026-09-12 09:00:00+00', 60, 0, 1, 'https://zoom.us/j/demo', 1, false,
   'Partner track update. Sponsor engagement strategy.', NULL, NULL, false, false, false, '2026-09-05 09:00:00+00', '2026-09-05 09:00:00+00', false, false),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-004', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98',
   '2026-09-15 11:00:00+00', 60, 0, 1, 'https://zoom.us/j/demo', 1, false,
   'Team performance review preparation.', NULL, NULL, false, false, false, '2026-09-08 09:00:00+00', '2026-09-08 09:00:00+00', false, false),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-005', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '0d9f9b11-3af7-456c-a6a3-de7373612fe9',
   '2026-09-16 15:00:00+00', 60, 0, 1, 'https://zoom.us/j/demo', 1, false,
   'Sustainability check. Energy and boundaries review.', NULL, NULL, false, false, false, '2026-09-09 09:00:00+00', '2026-09-09 09:00:00+00', false, false),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-006', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '9fe1f1b3-86eb-4bb7-a21c-71dda9ddda3c',
   '2026-09-17 16:00:00+00', 60, 0, 1, 'https://zoom.us/j/demo', 1, false,
   'Product roadmap review and H2 planning.', NULL, NULL, false, false, false, '2026-09-10 09:00:00+00', '2026-09-10 09:00:00+00', false, false),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-008', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '05e55e8e-03ff-41be-97d6-15df5b4610d7',
   '2026-09-18 11:00:00+00', 60, 0, 1, 'https://teams.microsoft.com/demo', 2, false,
   'Q3 commercial review and pipeline planning.', NULL, NULL, false, false, false, '2026-09-11 09:00:00+00', '2026-09-11 09:00:00+00', false, false),

  -- A couple in late September too
  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-001', '2a2b4f35-01d0-435a-b1b8-885a67daab87', '2d7b5fca-bfa9-4df5-bf0e-8f9f75cc9d0a',
   '2026-09-24 10:00:00+00', 60, 0, 1, 'https://zoom.us/j/demo', 1, false,
   'Final quarter planning. Legacy and lasting impact.', NULL, NULL, false, false, false, '2026-09-17 09:00:00+00', '2026-09-17 09:00:00+00', false, false),

  (gen_random_uuid(), 'fd312740-6b33-48a5-9e09-fc302bfa90cd', 'demo-coachee-003', '2a2b4f35-01d0-435a-b1b8-885a67daab87', 'bf514ef2-11ac-401f-b2a6-4e6c099f6e98',
   '2026-09-25 09:00:00+00', 60, 0, 1, 'https://zoom.us/j/demo', 1, false,
   'Partner nomination preparation.', NULL, NULL, false, false, false, '2026-09-18 09:00:00+00', '2026-09-18 09:00:00+00', false, false);


-- ============================================================
-- 2. UPDATE GOALS — more progress, more variety
-- ============================================================

-- Mark more goals as completed (Status 4 = Achieved)
UPDATE "Goals" SET "Status" = 4, "ProgressPercentage" = 100, "CurrentConfidence" = 90,
  "UpdatedAt" = NOW() - interval '10 days'
WHERE "OrganisationId" = '2a2b4f35-01d0-435a-b1b8-885a67daab87'
  AND "Status" IN (0, 1)
  AND "Id" IN (
    SELECT "Id" FROM "Goals"
    WHERE "OrganisationId" = '2a2b4f35-01d0-435a-b1b8-885a67daab87' AND "Status" IN (0, 1)
    LIMIT 3
  );

-- Bump progress on active goals
UPDATE "Goals" SET "ProgressPercentage" = LEAST("ProgressPercentage" + 25, 95),
  "CurrentConfidence" = LEAST(COALESCE("CurrentConfidence", 50) + 15, 95),
  "CurrentStage" = GREATEST("CurrentStage", 2),
  "UpdatedAt" = NOW() - interval '5 days'
WHERE "OrganisationId" = '2a2b4f35-01d0-435a-b1b8-885a67daab87'
  AND "Status" IN (1, 2);

-- Mark some milestones as complete
UPDATE "GoalMilestones" SET "IsCompleted" = true, "CompletedAt" = NOW() - interval '15 days'
WHERE "Id" IN (
  SELECT gm."Id" FROM "GoalMilestones" gm
  JOIN "Goals" g ON gm."GoalId" = g."Id"
  WHERE g."OrganisationId" = '2a2b4f35-01d0-435a-b1b8-885a67daab87'
    AND gm."IsCompleted" = false
  ORDER BY gm."DisplayOrder"
  LIMIT 15
);

COMMIT;
