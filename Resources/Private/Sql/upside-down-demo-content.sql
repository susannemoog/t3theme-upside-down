-- ============================================================
-- Upside Down theme — demo content seed
-- Idempotent: safe to run multiple times (DELETE + INSERT).
-- ============================================================

SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM pages     WHERE uid IN (1, 3, 4, 5, 6, 7);
DELETE FROM tt_content WHERE pid IN (1, 3, 4, 5, 6, 7);
DELETE FROM sys_file WHERE uid IN (1, 2, 3, 4, 5, 6);
DELETE FROM sys_file_reference WHERE uid_foreign IN (80, 81, 84, 85, 87, 88, 91, 100, 101, 102, 103, 104) AND fieldname = 'assets';

-- ─────────────────────────────────────────────────────────────
-- Pages
-- ─────────────────────────────────────────────────────────────

INSERT INTO pages
  (uid, pid, sorting, tstamp, crdate,
   perms_userid, perms_user, perms_group, perms_everybody,
   doktype, title, slug,
   is_siteroot, nav_hide,
   backend_layout, backend_layout_next_level)
VALUES
  -- Root / landing page
  (1, 0, 256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   1, 31, 31, 0,
   1, 'Upside Down', '/',
   1, 0,
   'pagets__UpsideLandingpage', 'pagets__UpsideContentpage'),
  -- Sub-pages
  (3, 1,  256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1, 31, 31, 0, 1, 'Hawkins Field Guide', '/hawkins-field-guide', 0, 0, 'pagets__UpsideContentpage', ''),
  (4, 1,  512, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1, 31, 31, 0, 1, 'Survival Kit',        '/survival-kit',        0, 0, 'pagets__UpsideContentpage', ''),
  (5, 1,  768, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1, 31, 31, 0, 1, 'Strange Questions',   '/strange-questions',   0, 0, 'pagets__UpsideContentpage', ''),
  (6, 1, 1024, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1, 31, 31, 0, 1, 'Imprint',             '/imprint',             0, 1, 'pagets__UpsideContentpage', ''),
  (7, 1, 1280, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 1, 31, 31, 0, 1, 'Privacy',             '/privacy',             0, 1, 'pagets__UpsideContentpage', '');

-- ─────────────────────────────────────────────────────────────
-- Home page — colPos 2 (Portal)
-- ─────────────────────────────────────────────────────────────

INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos,
   header, bodytext, frame_class,
   tx_themeupsidedown_cta_label, tx_themeupsidedown_cta_link)
VALUES
  (10, 1, 256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_storybeat', 2,
   'BREACH DETECTED',
   '<p>The dimensional barrier has been breached. Hawkins is no longer safe. Interdimensional anomalies are spreading across multiple sectors. Field operations are on standby.</p>',
   'bg-dark', 'Open the Field Guide', 't3://page?uid=3'),

  (11, 1, 512, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_storybeat', 2,
   'OPERATION UPSIDE DOWN',
   '<p>This is your operational briefing center. All classified intelligence on the Upside Down is maintained here for authorized personnel only.</p>',
   'bg-crimson', 'Get the Survival Kit', 't3://page?uid=4');

-- ─────────────────────────────────────────────────────────────
-- Home page — colPos 0 (Main)
-- ─────────────────────────────────────────────────────────────

INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos, header, bodytext, frame_class)
VALUES
  (20, 1, 256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 0,
   'Active Dispatches',
   '<p>Welcome to the Hawkins Field Operations Center. All classified intelligence on the Upside Down is maintained here for authorized personnel only.</p><ul><li><a href="t3://page?uid=3">Hawkins Field Guide</a> — maps and threat assessments</li><li><a href="t3://page?uid=4">Survival Kit</a> — essential equipment and protocols</li><li><a href="t3://page?uid=5">Strange Questions</a> — answers to the unexplained</li></ul>',
   'default');

-- ─────────────────────────────────────────────────────────────
-- Home page — colPos 10 (Footer — slides to all content pages)
-- ─────────────────────────────────────────────────────────────

INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos, header, bodytext, frame_class)
VALUES
  (39, 1,  256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 10,
   'Signal Channels',
   '<ul><li><a href="https://www.instagram.com/strangerthingstv/">Instagram</a></li><li><a href="https://www.facebook.com/StrangerThingsTV/">Facebook</a></li><li><a href="https://www.youtube.com/@Netflix">YouTube</a></li></ul>',
   'default'),

  (47, 1,  512, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 10,
   'Legal',
   '<ul><li><a href="t3://page?uid=6">Imprint</a></li><li><a href="t3://page?uid=7">Privacy</a></li></ul>',
   'default'),

  (48, 1,  768, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 10,
   'Field Signals',
   '<ul><li><a href="t3://page?uid=3#c31">The Rift</a></li><li><a href="t3://page?uid=3#c32">The Tunnels</a></li><li><a href="t3://page?uid=3#c33">Creel House</a></li></ul>',
   'default'),

  (49, 1, 1024, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 10,
   'Hot Zones',
   '<ul><li><a href="t3://page?uid=3#c35">Starcourt After Dark</a></li><li><a href="t3://page?uid=3#c36">The Lab Files</a></li><li><a href="t3://page?uid=3#c37">The Party''s Route</a></li></ul>',
   'default'),

  (50, 1, 1280, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 10,
   'Guides',
   '<ul><li><a href="t3://page?uid=4">Survival Kit</a></li><li><a href="t3://page?uid=5">Strange Questions</a></li></ul>',
   'default');

-- ─────────────────────────────────────────────────────────────
-- FAL — sys_file (SVG assets in fileadmin/upside-down/)
-- ─────────────────────────────────────────────────────────────

INSERT INTO sys_file
  (uid, pid, missing, storage, type, metadata,
   identifier, identifier_hash, folder_hash,
   extension, mime_type, name, sha1, size,
   creation_date, modification_date, last_indexed)
VALUES
  (1, 0, 0, 1, 2, 0,
   '/upside-down/lab-interior.svg',
   '6ba81323c099e3ef3ae892afaaef3a122ff45e30',
   '22106091eb0c84358dc8a03393c887c12b3a4d08',
   'svg', 'image/svg+xml', 'lab-interior.svg',
   'a77e193479975c8ff16452561fc33e90e83e855e', 1138,
   UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0),

  (2, 0, 0, 1, 2, 0,
   '/upside-down/gate-rift.svg',
   '1cfe6578eadbb33a4319d22cabaed1a5bd5a61e3',
   '22106091eb0c84358dc8a03393c887c12b3a4d08',
   'svg', 'image/svg+xml', 'gate-rift.svg',
   '85f30d2313be6286300d6254f9faab0802a4ef8d', 3203,
   UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0),

  (3, 0, 0, 1, 2, 0,
   '/upside-down/radio-scan.svg',
   '555f708233ba40b6a8cfad3655947c7bbe23b2cb',
   '22106091eb0c84358dc8a03393c887c12b3a4d08',
   'svg', 'image/svg+xml', 'radio-scan.svg',
   'f8dc036ee51f1add4d4a07806e87c367d0c58b7a', 1082,
   UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0),

  (4, 0, 0, 1, 2, 0,
   '/upside-down/bike-night.svg',
   '0a6c4b61200711e8eeab34b0822485a6404750fe',
   '22106091eb0c84358dc8a03393c887c12b3a4d08',
   'svg', 'image/svg+xml', 'bike-night.svg',
   '81cbb26045c3235f65a5272c15a681d264c97cfb', 1272,
   UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0),

  (5, 0, 0, 1, 2, 0,
   '/upside-down/demogorgon-silhouette.svg',
   '3488fe03247da4e50cb9181ce0835e0914f479c9',
   '22106091eb0c84358dc8a03393c887c12b3a4d08',
   'svg', 'image/svg+xml', 'demogorgon-silhouette.svg',
   '2eb9e4f69bfccf39b26daac81c498e57f79812c9', 2459,
   UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0),

  (6, 0, 0, 1, 2, 0,
   '/upside-down/evidence-board.svg',
   '0828b660cbfea5b0369b98db8b3e57e2ecc309a7',
   '22106091eb0c84358dc8a03393c887c12b3a4d08',
   'svg', 'image/svg+xml', 'evidence-board.svg',
   '8b8fb74ca91ccaf2e10709a26f0e3c1e015953c2', 1294,
   UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0);

-- ─────────────────────────────────────────────────────────────
-- Hawkins Field Guide (pid 3)
-- ─────────────────────────────────────────────────────────────

-- colPos 2 — Stage
INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos, header, subheader, frame_class)
VALUES
  (30, 3, 256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 2,
   'Hawkins Field Guide', 'Classified Intelligence Dossier', 'bg-dark');

-- colPos 0 — Main
INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos, header, bodytext, frame_class)
VALUES
  (45, 3, 256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 0,
   '',
   '<p>The Rift: the first breach left Hawkins unstable and exposed.</p><p>The Tunnels: a living network spreading under the town.</p><p>Creel House: psychic violence, grief, and persistent dread.</p><p>Starcourt After Dark: neon cover story, covert operation, hidden gate.</p><p>The Lab Files: redacted experiments and consequences that never ended.</p>',
   'default'),

  (31, 3, 512, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_storybeat', 0,
   'THE RIFT',
   '<p>First observed November 1983. A physical tear in the dimensional membrane, located within the Hawkins National Laboratory. Served as primary entry point for all subsequent anomalies recorded in the area.</p>',
   'bg-void'),

  (32, 3, 768, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_storybeat', 0,
   'THE TUNNELS',
   '<p>An organic underground network spreading beneath Hawkins. Connects key anomaly sites across a radius of several kilometers. Extreme caution advised — hive-mind organism detected. Avoid prolonged exposure.</p>',
   'bg-dark'),

  (33, 3, 1024, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_storybeat', 0,
   'CREEL HOUSE',
   '<p>The Creel House on Maple Street. Site of multiple psychic violence events spanning decades. Connected to the primary entity''s initial awakening and primary tether point in our dimension.</p>',
   'bg-crimson'),

  (35, 3, 1280, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_storybeat', 0,
   'STARCOURT AFTER DARK',
   '<p>The Starcourt Mall served as a neon-lit cover operation. Below its food court, a covert Soviet facility ran gate-opening experiments. The hidden gate was sealed, but structural damage to the barrier persists.</p>',
   'bg-void'),

  (36, 3, 1536, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_storybeat', 0,
   'THE LAB FILES',
   '<p>Hawkins National Laboratory, now decommissioned. Decades of redacted experiments created the conditions for the original breach. Key records were destroyed. Cross-reference field reports for partial reconstruction.</p>',
   'bg-dark'),

  (37, 3, 1792, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_storybeat', 0,
   'THE PARTY''S ROUTE',
   '<p>Multiple verified incursions by civilian operatives — the so-called Party. Their routes through the Upside Down remain the most complete record of internal geography available. Treat as primary field reference.</p>',
   'bg-crimson');

-- colPos 20 — Signal + Classified sidebar
INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos,
   header, bodytext, frame_class,
   tx_themeupsidedown_cta_label, tx_themeupsidedown_cta_link)
VALUES
  (34, 3, 256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_storybeat', 20,
   'THREAT LEVEL: CRITICAL',
   '<p>Multiple interdimensional entities active. Full evacuation protocols in effect for affected sectors. Do not approach anomaly sites without authorised field equipment.</p>',
   'bg-crimson', 'Get the Survival Kit', 't3://page?uid=4'),

  (82, 3, 512, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_storybeat', 20,
   'RESTRICTED ACCESS',
   '<p>This dossier has been partially declassified. Several field reports remain under review. Cross-reference with archive sector 7-G for supplementary material. Unauthorised access will be logged.</p>',
   'classified', '', '');

-- colPos 0 — Textmedia (images)
INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos, header, bodytext, frame_class, assets)
VALUES
  (80, 3, 2048, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'textmedia', 0,
   'Field Documentation — The Laboratory',
   '<p>Hawkins National Laboratory: sector D-7, sublevel 3. Infrastructure map redacted for field personnel. Note asymmetric blast damage on the east wall — consistent with the original breach event.</p>',
   'default', 1),

  (81, 3, 2304, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'textmedia', 0,
   'Gate Anatomy',
   '<p>The dimensional rift does not behave like physical matter. Its edges are stable at room temperature but collapse under sustained high-voltage current. Thermal mapping shows a consistent 4°C temperature drop in a 12-metre radius.</p>',
   'default', 1);

-- ─────────────────────────────────────────────────────────────
-- Survival Kit (pid 4)
-- ─────────────────────────────────────────────────────────────

-- colPos 2 — Stage
INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos, header, subheader, frame_class)
VALUES
  (40, 4, 256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 2,
   'Survival Kit', 'Everything you need to make it out alive', 'bg-dark');

-- colPos 0 — Main
INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos, header, bodytext, frame_class)
VALUES
  (41, 4, 256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 0,
   'Communications',
   '<p>Maintaining contact is your first priority.</p><ul><li>Two-way radio — CB channel 7</li><li>String-light early warning system</li><li>Battery backup — minimum 72 hours</li></ul>',
   'default'),

  (42, 4, 512, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 0,
   'Navigation',
   '<p>The Upside Down mirrors our world but not perfectly.</p><ul><li>Physical map — technology fails near rifts</li><li>Compass — note deviation near dimensional anomalies</li><li>Mark exit points clearly before entering</li></ul>',
   'default'),

  (43, 4, 768, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 0,
   'Defence',
   '<p>Light is your primary deterrent against Upside Down entities.</p><ul><li>High-lumen torch — minimum 2,000 lumens</li><li>Flares — carry a minimum of 6</li><li>UV lamp — disrupts spore propagation and slows organic growth</li></ul>',
   'default');

INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos,
   header, subheader, bodytext, frame_class,
   tx_themeupsidedown_cta_label, tx_themeupsidedown_cta_link)
VALUES
  (83, 4, 896, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_storybeat', 0,
   'INCOMING TRANSMISSION',
   'HAWKINS DISPATCH — 03:47',
   '<p>Signal received from sector 7. Morse-pattern transmission detected. Repeating cycle: 3 minutes. Source: unknown. DO NOT respond. Maintain radio silence. Continue monitoring on channel 7.</p>',
   'transmission', '', '');

INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos, header, bodytext, frame_class, assets)
VALUES
  (84, 4, 1024, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'textmedia', 0,
   'Communications Protocol',
   '<p>CB radio is your lifeline. The Upside Down generates electromagnetic interference that disrupts modern digital communications. Analogue radio on CB channel 7 remains functional within 200 metres of a rift. Keep batteries fresh — power drain near anomaly zones is significantly accelerated.</p>',
   'default', 1),

  (85, 4, 1280, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'textmedia', 0,
   'Night Movement',
   '<p>When visibility drops to zero, move slow and stay low. Pre-mapped routes reduce exposure time. Night operations require a second pair of eyes — never navigate solo after dark. The Upside Down does not follow our day/night cycle.</p>',
   'default', 1);

-- colPos 20 — Signal
INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos, header, bodytext, frame_class)
VALUES
  (44, 4, 256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_storybeat', 20,
   'DO NOT GO ALONE',
   '<p>No solo missions. The Upside Down disorients — without a tether, personnel have not returned. Buddy system is mandatory protocol. No exceptions.</p>',
   'bg-crimson');

-- ─────────────────────────────────────────────────────────────
-- Strange Questions (pid 5)
-- ─────────────────────────────────────────────────────────────

-- colPos 2 — Stage
INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos, header, subheader, frame_class)
VALUES
  (51, 5, 256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 2,
   'Strange Questions', 'Answers for those who have seen things', 'bg-dark');

-- colPos 0 — Main
INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos, header, bodytext, frame_class)
VALUES
  (52, 5,  256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 0,
   'What is the Upside Down?',
   '<p>A parallel dimension that mirrors our own world, but exists in a state of perpetual darkness and decay. It is inhabited by entities hostile to human life and sustained by an interdimensional hive organism.</p>',
   'default'),

  (53, 5,  512, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 0,
   'How do you enter it?',
   '<p>Dimensional rifts — physical tears in the membrane between worlds — serve as entry points. These are accompanied by supernatural cold, increased electromagnetic interference, and visible membrane distortion.</p>',
   'default'),

  (54, 5,  768, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 0,
   'Can a rift be closed?',
   '<p>Rifts have been closed before. High-voltage electromagnetic pulses applied to the breach perimeter have proven effective. However, closures are temporary if a primary entity with gate-creation abilities remains active in either dimension.</p>',
   'default'),

  (55, 5, 1024, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 0,
   'What are the vine structures?',
   '<p>The organic tendrils and tunnel networks visible in Upside Down infiltration zones are extensions of a hive-mind organism native to the dimension. They conduct sensory information to the central entity and can influence human nervous systems under prolonged exposure.</p>',
   'default');

INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos,
   header, bodytext, frame_class,
   tx_themeupsidedown_cta_label, tx_themeupsidedown_cta_link)
VALUES
  (86, 5, 1280, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_storybeat', 0,
   'BEYOND EXPLANATION',
   '<p>Some questions do not have simple answers. The phenomena observed in Hawkins require a new framework for understanding reality itself. Document what you see. Trust what you observe.</p>',
   'default', 'Open the Field Guide', 't3://page?uid=3');

INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos, header, bodytext, frame_class, assets)
VALUES
  (87, 5, 1536, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'textmedia', 0,
   'Entity Classification',
   '<p>Entities originating from the Upside Down are classified by behaviour, not morphology. Class-1 entities are direct threats. Class-2 are hive-network conduits. Class-3 require a host. All require the same precaution: distance and light.</p>',
   'default', 1),

  (88, 5, 1792, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'textmedia', 0,
   'Evidence Documentation',
   '<p>Every anomaly should be documented. Photograph before touching. Note temperature, electromagnetic readings, and any auditory phenomena. Evidence boards — connecting related anomalies with string — remain the most reliable correlation method available.</p>',
   'default', 1);

-- colPos 20 — Signal
INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos,
   header, bodytext, frame_class,
   tx_themeupsidedown_cta_label, tx_themeupsidedown_cta_link)
VALUES
  (56, 5, 256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_storybeat', 20,
   'STAY SCEPTICAL',
   '<p>Not every anomaly is supernatural. Exhaust conventional explanations first. But when the lights start flickering on their own — trust your instincts and consult the Field Guide.</p>',
   'bg-void', 'Open the Field Guide', 't3://page?uid=3');

-- ─────────────────────────────────────────────────────────────
-- Imprint (pid 6)
-- ─────────────────────────────────────────────────────────────

INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos, header, subheader, frame_class)
VALUES
  (60, 6, 256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 2, 'Imprint', '', 'bg-dark');

INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos, header, bodytext, frame_class)
VALUES
  (61, 6, 256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 0,
   'Publisher',
   '<p>Hawkins Field Operations Center<br>Hawkins, Indiana, USA</p><p>Contact: dispatch@hawkins-operations.example</p>',
   'default'),

  (62, 6, 512, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 0,
   'Responsible for Content',
   '<p>Chief Operations Officer<br>Hawkins Department of Energy (Field Division)</p>',
   'default');

-- ─────────────────────────────────────────────────────────────
-- Privacy (pid 7)
-- ─────────────────────────────────────────────────────────────

INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos, header, subheader, frame_class)
VALUES
  (70, 7, 256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 2, 'Privacy Policy', '', 'bg-dark');

INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos, header, bodytext, frame_class)
VALUES
  (71, 7,  256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 0,
   'Data Collection',
   '<p>This operations center collects only mission-critical data. No personal information is stored beyond active field assignments.</p>',
   'default'),

  (72, 7,  512, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 0,
   'Cookies',
   '<p>We use only essential cookies required for secure access to classified intelligence. No tracking, no profiling — we have enough to worry about already.</p>',
   'default'),

  (73, 7,  768, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'text', 0,
   'Contact',
   '<p>For data-related enquiries, contact: privacy@hawkins-operations.example</p>',
   'default');

-- ─────────────────────────────────────────────────────────────
-- Home page — colPos 1 (Hero)
-- ─────────────────────────────────────────────────────────────

INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos,
   header, subheader, bodytext)
VALUES
  (90, 1, 256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_hero', 1,
   'Hawkins National Laboratory · Classified',
   'The Upside Down',
   'A dimensional breach has been detected beneath Hawkins, Indiana. All field agents report to your designated coordinates. The gate is open.');

-- ─────────────────────────────────────────────────────────────
-- Home page — colPos 3 (Featured Dispatch)
-- ─────────────────────────────────────────────────────────────

INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos,
   header, subheader, bodytext, assets,
   tx_themeupsidedown_cta_label, tx_themeupsidedown_cta_link)
VALUES
  (91, 1, 256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_featured', 3,
   'Classified Dispatch #00-Alpha — Active Investigation',
   'The Gate Has Been Reopened',
   '<p>Seismic anomalies and electromagnetic interference consistent with an interdimensional breach have been recorded across Hawkins. Lab instruments confirm a secondary Gate event. The Hive Mind is reconstituting. This is not a drill.</p>',
   1,
   'Read Mission Report', 't3://page?uid=3');

-- ─────────────────────────────────────────────────────────────
-- Home page — colPos 30 (Characters)
-- ─────────────────────────────────────────────────────────────

INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos,
   header, subheader, bodytext,
   tx_themeupsidedown_character_faction, tx_themeupsidedown_character_status)
VALUES
  (92, 1, 256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_character', 30,
   'Jane Hopper', 'Subject 011 · Hawkins Lab',
   'Extraordinary telekinetic and remote-viewing abilities. Former test subject of Dr. Martin Brenner. Last seen near the Hawkins Gate during the final incursion. Whereabouts currently unconfirmed.',
   'Psychokinetic · The Party', 'unknown'),

  (93, 1, 512, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_character', 30,
   'Jim Hopper', 'Chief · Hawkins PD',
   'Former New York City police detective, returned to Hawkins as Chief of Police. Primary field contact during multiple Upside Down incursion events. Currently listed as MIA following Starcourt incident.',
   'Law Enforcement · Hawkins PD', 'missing'),

  (94, 1, 768, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_character', 30,
   'Joyce Byers', 'Civilian · Wheeler Residence',
   'Mother of Will Byers. First civilian to establish confirmed communication with the Upside Down via electromagnetic interference. Relocated family following Starcourt incident. Signal: active.',
   'Civilian · The Party', 'alive'),

  (95, 1, 1024, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_character', 30,
   'Will Byers', 'The Vessel · Byers Residence',
   'First confirmed survivor of extended exposure to the Upside Down. Served as a host for the Mind Flayer during the ''84 incursion. Retains residual sensitivity to interdimensional fluctuations.',
   'Survivor · The Party', 'alive'),

  (96, 1, 1280, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_character', 30,
   'Mike Wheeler', 'Party Leader · Wheeler Residence',
   'De facto leader of the Party. Established first contact with Subject 011. Consistently demonstrated strategic thinking under field conditions. No supernatural abilities — compensates with tenacity.',
   'Civilian · The Party', 'alive'),

  (97, 1, 1536, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_character', 30,
   'Dustin Henderson', 'AV Club · Hawkins Middle',
   'Hawkins AV Club founder and primary signals analyst. Established long-range radio contact with allied forces during the Starcourt incident. Expertise in electromagnetic theory and interdimensional communications.',
   'Intelligence · The Party', 'alive'),

  (98, 1, 1792, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_character', 30,
   'Billy Hargrove', 'Starcourt Operative · Pool Lifeguard',
   'Recruited as a primary host vessel for the Mind Flayer during the Starcourt incursion. Demonstrated residual autonomy in final moments. Field status: compromised. Considered extremely dangerous.',
   'Hawkins High · Starcourt', 'compromised');

-- ─────────────────────────────────────────────────────────────
-- Home page — colPos 40 (Locations)
-- ─────────────────────────────────────────────────────────────

INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos,
   header, bodytext, assets,
   tx_themeupsidedown_location_coords, tx_themeupsidedown_location_threat, tx_themeupsidedown_location_featured)
VALUES
  (100, 1, 256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_location', 40,
   'Hawkins National Laboratory',
   'Primary breach site and origin point of all documented Upside Down contact. Site of the original Gate, opened during the MKUltra-adjacent Hawkins experiments. Currently sealed — containment integrity: disputed.',
   1,
   '39.4614° N, 86.1347° W · SECTOR 7-A', 'critical', 1),

  (101, 1, 512, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_location', 40,
   'The Upside Down',
   'Parallel dimension existing in a state of permanent electromagnetic decay. Inhabited by the Hive Mind and its derivatives. Do not enter without full containment gear and a Geiger counter.',
   1,
   '39.4614° N, 86.1347° W · ALTERNATE', 'critical', 0),

  (102, 1, 768, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_location', 40,
   'Mirkwood Forest',
   'Dense forest adjacent to the Byers residence. Primary entry point for Demogorgon activity during the ''83 incident. Residual portal energy still detectable. Avoid after dark.',
   1,
   '39.4832° N, 86.1101° W · SECTOR 2', 'elevated', 0),

  (103, 1, 1024, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_location', 40,
   'Hawkins Police Dept.',
   'Primary civilian law enforcement hub. Served as command center during multiple containment operations. Evidence archive contains documented proof of Upside Down incursions — most records suppressed.',
   1,
   '39.4521° N, 86.1499° W · MAIN ST', 'nominal', 0),

  (104, 1, 1280, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_location', 40,
   'Starcourt Mall',
   'Former commercial centre converted to a Soviet-operated covert laboratory beneath its foundations. Site of the failed Gate re-opening attempt. Currently abandoned. Residual Flayed compound detected in sub-basement.',
   1,
   '39.4407° N, 86.1623° W · SECTOR 9', 'elevated', 0);

-- ─────────────────────────────────────────────────────────────
-- Home page — colPos 50 (Incidents)
-- ─────────────────────────────────────────────────────────────

INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos,
   header, bodytext,
   tx_themeupsidedown_incident_id, tx_themeupsidedown_incident_date, tx_themeupsidedown_incident_classification)
VALUES
  (110, 1, 256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_incident', 50,
   'First Contact — Byers Disappearance',
   '<p>At approximately 21:47 on November 6th, subject William Byers was reported missing by his mother, Joyce Byers, of 4802 Cherry Oak Drive, Hawkins, Indiana.</p><p>Concurrent investigation by civilian minors led to discovery of Subject 011 — a female juvenile with confirmed psychokinetic abilities. Subject 011 confirmed the existence of a parallel dimensional plane henceforth referred to as "The Upside Down."</p><p>Resolution: Subject Byers recovered from interdimensional stasis on November 12th. Gate at Hawkins National Laboratory identified as primary breach point. Status: Gate sealed by Subject 011. Incident report sealed by order of Dr. Martin Brenner.</p>',
   '#00-1983', 'Nov 1983', 'Classification: Level 4 — Restricted'),

  (111, 1, 512, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_incident', 50,
   'Demogorgon Perimeter Sightings — Lab Breach',
   '<p>Multiple Hawkins Lab personnel reported sightings of an entity consistent with the "Demogorgon" classification from the 1983 incident. Sightings clustered around the laboratory''s south perimeter and underground tunnel network access points.</p><p>Tunnels of biological origin discovered beneath Hawkins. Network appears to function as a mycelial nervous system connected to a central intelligence designated "The Mind Flayer." Tunnel growth rate estimated at 4–6 metres per week.</p><p>Resolution: Tunnel network cauterised via thermal intervention. One Demogorgon specimen terminated. Gate remains open — containment perimeter expanded.</p>',
   '#00-1984', 'Oct 1984', 'Classification: Level 5 — Top Secret'),

  (112, 1, 768, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_incident', 50,
   'Starcourt Incident — Mind Flayer Incursion',
   '<p>Soviet-operated covert research facility identified beneath Starcourt Mall, Hawkins, Indiana. Facility housed a particle accelerator designed to reopen a Gate to the Upside Down.</p><p>The Mind Flayer reestablished a corporeal presence in Hawkins using "Flayed" civilians — humans whose organic matter was absorbed into a biomass proxy form. At least 16 confirmed Flayed casualties.</p><p>Post-incident: Chief Hopper listed as MIA following the Gate closure event. The Byers family and Subject 011 relocated from Hawkins. Starcourt facility demolished.</p>',
   '#00-1985', 'Jul 1985', 'Classification: Level 5 — Cosmic Top Secret'),

  (113, 1, 1024, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_incident', 50,
   'Vecna Awakening — Hawkins Gate Crisis',
   '<p>A new interdimensional entity — designated Vecna, identified as Henry Creel / Subject 001 — initiated a series of psychic attacks targeting vulnerable individuals in Hawkins. Victims exhibited recurring nightmares, physical levitation, and cranial trauma. Fatalities: 4 confirmed.</p><p>Vecna demonstrated the ability to open Gates through targeted psychic kills. Four simultaneous deaths partially achieved a "Mega-Gate" on March 28th.</p><p>Resolution: Vecna neutralised via coordinated assault. Status: Gate open. Upside Down encroachment into Hawkins confirmed. Ongoing containment required.</p>',
   '#00-1986', 'Mar 1986', 'Classification: Level 6 — Eyes Only'),

  (114, 1, 1280, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_incident', 50,
   'Russian Kamchatka Facility — Gate Replication',
   '<p>Concurrent with the Hawkins Gate crisis, a secondary Soviet facility in Kamchatka, Russia was confirmed to be housing a functional Gate to the Upside Down and multiple live Demogorgon specimens.</p><p>Chief Hopper (MIA since July 1985) was found alive in Soviet custody at this facility. Recovery operation conducted by J. Byers and M. Murray in cooperation with former KGB operative A. Yuri.</p><p>Assessment: Soviet Upside Down research programme is more advanced than previously estimated. Recommend immediate escalation to DEFCON 3. This report is to be destroyed after reading.</p>',
   '#00-1986B', 'Mar 1986', 'Classification: Level 6 — Cosmic Top Secret · NATO Eyes Only');

-- ─────────────────────────────────────────────────────────────
-- Home page — colPos 60 (Testimonials)
-- ─────────────────────────────────────────────────────────────

INSERT INTO tt_content
  (uid, pid, sorting, tstamp, crdate, CType, colPos,
   header, subheader, bodytext,
   tx_themeupsidedown_testimonial_citation, tx_themeupsidedown_testimonial_location, tx_themeupsidedown_testimonial_clearance)
VALUES
  (120, 1, 256, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_testimonial', 60,
   'Chief Jim Hopper', 'Field Report · HPDI-0047',
   '"Whatever''s in those tunnels, it''s not from around here. And I''ve seen some things in my time — New York City in the seventies was no picnic. But this? This is different. This is wrong in a way that goes deeper than the bones."',
   'Jim Hopper · Hawkins Chief of Police · Nov 1984', 'Hawkins, Indiana', 'Clearance: Level 3'),

  (121, 1, 512, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_testimonial', 60,
   'Jane "Eleven" Hopper', 'Field Report · HPDI-0011',
   '"The gate. I can feel it. It''s still open. It bleeds through — like a wound that never closes. When I''m in the dark place I can hear it. The breathing. Something on the other side is always listening."',
   'Jane Hopper · Subject 011 · Mar 1986', 'Lenora Hills, California', 'Clearance: Level 5'),

  (122, 1, 768, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_testimonial', 60,
   'Joyce Byers', 'Civilian Statement · CIV-1983-14',
   '"He was trying to tell me something through the lights. I know how that sounds. I know exactly how that sounds. But I''m telling you — that was Will. It was my son. The lights were blinking and he was there."',
   'Joyce Byers · Civilian Witness · Nov 1983', 'Cherry Oak Drive, Hawkins', 'Clearance: None'),

  (123, 1, 1024, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_testimonial', 60,
   'Dustin Henderson', 'Field Report · HPDI-0088',
   '"The electromagnetic readings are off the charts. Classic interdimensional breach signature — I''ve cross-referenced with the ''83 and ''84 readings and the pattern is almost identical. Whatever opened this gate used the same frequency. Someone is doing this deliberately."',
   'Dustin Henderson · Hawkins AV Club · Jul 1985', 'Starcourt Roof, Hawkins', 'Clearance: Level 2'),

  (124, 1, 1280, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_testimonial', 60,
   'Dr. Samuel Owens', 'Official Statement · HNL-OWENS-22',
   '"[REDACTED BY ORDER OF HAWKINS NATIONAL LABORATORY — SECURITY CLEARANCE LEVEL 5 REQUIRED TO ACCESS FULL TRANSCRIPT. CONTACT YOUR FIELD SUPERVISOR. THIS STATEMENT IS CLASSIFIED UNDER EXECUTIVE ORDER 12333.]"',
   'Dr. Samuel Owens · HNL Medical Director · Oct 1984', 'Hawkins National Lab', 'Clearance: Level 5'),

  (125, 1, 1536, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(),
   'upside_testimonial', 60,
   'Murray Bauman', 'Independent Analysis · INV-BAUMAN-04',
   '"I''ve been saying it for years. Hawkins is not what it seems. The government knows. The lab knows. They''ve been running experiments on that land since the sixties. You follow the missing persons reports — you follow the money — and it all leads back to the same place."',
   'Murray Bauman · Independent Investigator · 1984', 'Sesser, Illinois', 'Clearance: None (Self-Issued)');

-- ─────────────────────────────────────────────────────────────
-- FAL — sys_file_reference (links SVGs to textmedia elements)
-- ─────────────────────────────────────────────────────────────

INSERT INTO sys_file_reference
  (uid, pid, tstamp, crdate, deleted, hidden,
   sys_language_uid, l10n_parent, sorting_foreign,
   uid_local, uid_foreign, tablenames, fieldname,
   title, alternative, description, link, crop)
VALUES
  -- Field Guide: lab-interior.svg → uid=80
  (1, 3, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 0,
   0, 0, 1,
   1, 80, 'tt_content', 'assets',
   NULL, NULL, NULL, '', ''),

  -- Field Guide: gate-rift.svg → uid=81
  (2, 3, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 0,
   0, 0, 1,
   2, 81, 'tt_content', 'assets',
   NULL, NULL, NULL, '', ''),

  -- Survival Kit: radio-scan.svg → uid=84
  (3, 4, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 0,
   0, 0, 1,
   3, 84, 'tt_content', 'assets',
   NULL, NULL, NULL, '', ''),

  -- Survival Kit: bike-night.svg → uid=85
  (4, 4, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 0,
   0, 0, 1,
   4, 85, 'tt_content', 'assets',
   NULL, NULL, NULL, '', ''),

  -- Strange Questions: demogorgon-silhouette.svg → uid=87
  (5, 5, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 0,
   0, 0, 1,
   5, 87, 'tt_content', 'assets',
   NULL, NULL, NULL, '', ''),

  -- Strange Questions: evidence-board.svg → uid=88
  (6, 5, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 0,
   0, 0, 1,
   6, 88, 'tt_content', 'assets',
   NULL, NULL, NULL, '', ''),

  -- Featured Dispatch: radio-scan.svg → uid=91
  (7, 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 0,
   0, 0, 1,
   3, 91, 'tt_content', 'assets',
   NULL, NULL, NULL, '', ''),

  -- Location: Hawkins Lab — lab-interior.svg → uid=100
  (8, 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 0,
   0, 0, 1,
   1, 100, 'tt_content', 'assets',
   NULL, 'Hawkins National Laboratory interior', NULL, '', ''),

  -- Location: The Upside Down — gate-rift.svg → uid=101
  (9, 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 0,
   0, 0, 1,
   2, 101, 'tt_content', 'assets',
   NULL, 'Dimensional rift gate', NULL, '', ''),

  -- Location: Mirkwood Forest — bike-night.svg → uid=102
  (10, 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 0,
   0, 0, 1,
   4, 102, 'tt_content', 'assets',
   NULL, 'Mirkwood forest at night', NULL, '', ''),

  -- Location: Hawkins PD — evidence-board.svg → uid=103
  (11, 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 0,
   0, 0, 1,
   6, 103, 'tt_content', 'assets',
   NULL, 'Hawkins Police Department evidence board', NULL, '', ''),

  -- Location: Starcourt Mall — demogorgon-silhouette.svg → uid=104
  (12, 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 0,
   0, 0, 1,
   5, 104, 'tt_content', 'assets',
   NULL, 'Starcourt Mall', NULL, '', '');

-- ─────────────────────────────────────────────────────────────
-- Reset AUTO_INCREMENT past seeded UIDs
-- ─────────────────────────────────────────────────────────────

ALTER TABLE pages               AUTO_INCREMENT = 100;
ALTER TABLE tt_content          AUTO_INCREMENT = 200;
ALTER TABLE sys_file            AUTO_INCREMENT = 100;
ALTER TABLE sys_file_reference  AUTO_INCREMENT = 100;

SET FOREIGN_KEY_CHECKS = 1;
