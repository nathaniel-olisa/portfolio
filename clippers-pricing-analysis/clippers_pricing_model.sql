SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';
/* ===========================
   PART A — SCHEMA + DATA LOAD
   =========================== */

/* 0) Allow local file loads (run once per session) */
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

/* 1) Recreate the database cleanly */
DROP DATABASE IF EXISTS clippers_pricing;
CREATE DATABASE clippers_pricing;
USE clippers_pricing;

/* 2) Create tables (columns match your CSVs exactly) */

/* Games.csv */
CREATE TABLE game_info (
  game_id    VARCHAR(10) PRIMARY KEY,
  `date`     DATETIME,                 -- e.g., 10/1/24 0:00
  opponent   VARCHAR(100),
  dayofweek  VARCHAR(10),
  marquee    CHAR(1),
  attendance INT,
  capacity   INT
);

/* Ticket_Inventory.csv */
CREATE TABLE ticket_inventory (
  game_id           VARCHAR(10),
  section           VARCHAR(50),
  ticket_type       VARCHAR(50),
  avg_price         DECIMAL(10,2),
  min_price         DECIMAL(10,2),
  max_price         DECIMAL(10,2),
  units_released    INT,
  units_sold        INT,
  sell_through_pct  DECIMAL(5,2),
  PRIMARY KEY (game_id, section, ticket_type)
);

/* Resale_Data.csv */
CREATE TABLE resale_data (
  game_id                    VARCHAR(10),
  section                    VARCHAR(50),
  avg_resale_price           DECIMAL(10,2),
  resale_volume              INT,
  primary_vs_resale_diff_pct DECIMAL(5,2),
  PRIMARY KEY (game_id, section)
);

/* Ancillary_Revenue.csv */
CREATE TABLE ancillary_revenue (
  game_id                   VARCHAR(10) PRIMARY KEY,
  concessions_per_fan       DECIMAL(10,2),
  merch_per_fan             DECIMAL(10,2),
  parking_per_fan           DECIMAL(10,2),
  premium_upgrades          DECIMAL(10,2),
  total_ancillary_revenue   DECIMAL(12,2)
);

/* League_Benchmarks.csv */
CREATE TABLE league_benchmarks (
  opponent        VARCHAR(50) PRIMARY KEY,
  avg_price       DECIMAL(10,2),
  avg_attendance  INT,
  revenue_index   DECIMAL(5,2),
  notes           VARCHAR(255)
);

/* 3) Load CSVs from your folder (exact paths) */

/* Games.csv */
LOAD DATA LOCAL INFILE '/Users/nathanielolisa/Desktop/clippers_cvs/Games.csv'
INTO TABLE game_info
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@Game_ID,@Date,@Opponent,@DayOfWeek,@Marquee,@Attendance,@Capacity)
SET game_id    = TRIM(@Game_ID),
    `date`     = STR_TO_DATE(REPLACE(@Date,'\r',''), '%m/%d/%y %H:%i'),
    opponent   = TRIM(@Opponent),
    dayofweek  = TRIM(@DayOfWeek),
    marquee    = UPPER(TRIM(@Marquee)),
    attendance = CAST(REPLACE(@Attendance,'\r','') AS SIGNED),
    capacity   = CAST(REPLACE(@Capacity,  '\r','') AS SIGNED);

/* Ticket_Inventory.csv  (watch the file name; no leading space) */
LOAD DATA LOCAL INFILE '/Users/nathanielolisa/Desktop/clippers_cvs/Ticket_Inventory.csv'
INTO TABLE ticket_inventory
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@Game_ID,@Section,@Ticket_Type,@Avg_Price,@Min_Price,@Max_Price,@Units_Released,@Units_Sold,@Sell_Through)
SET game_id           = TRIM(@Game_ID),
    section           = TRIM(@Section),
    ticket_type       = TRIM(@Ticket_Type),
    avg_price         = CAST(REPLACE(@Avg_Price, ',', '') AS DECIMAL(10,2)),
    min_price         = CAST(REPLACE(@Min_Price, ',', '') AS DECIMAL(10,2)),
    max_price         = CAST(REPLACE(@Max_Price, ',', '') AS DECIMAL(10,2)),
    units_released    = CAST(REPLACE(@Units_Released, ',', '') AS SIGNED),
    units_sold        = CAST(REPLACE(@Units_Sold, ',', '') AS SIGNED),
    sell_through_pct  = CAST(REPLACE(REPLACE(@Sell_Through, '%',''), ',', '') AS DECIMAL(5,2));

/* Resale_Data.csv */
LOAD DATA LOCAL INFILE '/Users/nathanielolisa/Desktop/clippers_cvs/Resale_Data.csv'
INTO TABLE resale_data
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@Game_ID,@Section,@Avg_Resale_Price,@Resale_Volume,@Primary_vs_Resale_Diff_pct)
SET game_id                    = TRIM(@Game_ID),
    section                    = TRIM(@Section),
    avg_resale_price           = CAST(REPLACE(@Avg_Resale_Price, ',', '') AS DECIMAL(10,2)),
    resale_volume              = CAST(REPLACE(@Resale_Volume, ',', '') AS SIGNED),
    primary_vs_resale_diff_pct = CAST(REPLACE(@Primary_vs_Resale_Diff_pct, '%', '') AS DECIMAL(5,2));

/* Ancillary_Revenue.csv */
LOAD DATA LOCAL INFILE '/Users/nathanielolisa/Desktop/clippers_cvs/Ancillary_Revenue.csv'
INTO TABLE ancillary_revenue
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@Game_ID,@Concessions_per_Fan,@Merch_per_Fan,@Parking_per_Fan,@Premium_Upgrades,@Total_Ancillary_Revenue)
SET game_id                 = TRIM(@Game_ID),
    concessions_per_fan     = CAST(REPLACE(@Concessions_per_Fan, ',', '') AS DECIMAL(10,2)),
    merch_per_fan           = CAST(REPLACE(@Merch_per_Fan, ',', '') AS DECIMAL(10,2)),
    parking_per_fan         = CAST(REPLACE(@Parking_per_Fan, ',', '') AS DECIMAL(10,2)),
    premium_upgrades        = CAST(REPLACE(@Premium_Upgrades, ',', '') AS DECIMAL(10,2)),
    total_ancillary_revenue = CAST(REPLACE(@Total_Ancillary_Revenue, ',', '') AS DECIMAL(12,2));

/* League_Benchmarks.csv */
LOAD DATA LOCAL INFILE '/Users/nathanielolisa/Desktop/clippers_cvs/League_Benchmarks.csv'
INTO TABLE league_benchmarks
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@Opponent,@Avg_Price,@Avg_Attendance,@Revenue_Index,@Notes)
SET opponent        = TRIM(@Opponent),
    avg_price       = CAST(REPLACE(@Avg_Price, ',', '') AS DECIMAL(10,2)),
    avg_attendance  = CAST(REPLACE(@Avg_Attendance, ',', '') AS SIGNED),
    revenue_index   = CAST(REPLACE(@Revenue_Index, ',', '') AS DECIMAL(5,2)),
    notes           = TRIM(@Notes);

/* 4) Quick sanity checks */
SELECT 'game_info' AS table_name, COUNT(*) AS `rows` FROM game_info
UNION ALL SELECT 'ticket_inventory', COUNT(*) FROM ticket_inventory
UNION ALL SELECT 'resale_data', COUNT(*) FROM resale_data
UNION ALL SELECT 'ancillary_revenue', COUNT(*) FROM ancillary_revenue
UNION ALL SELECT 'league_benchmarks', COUNT(*) FROM league_benchmarks;

SELECT * FROM game_info           LIMIT 5;
SELECT * FROM ticket_inventory    LIMIT 5;
SELECT * FROM resale_data         LIMIT 5;
SELECT * FROM ancillary_revenue   LIMIT 5;
SELECT * FROM league_benchmarks   LIMIT 5;

SELECT 'game_info' AS table_name, COUNT(*) AS `rows` FROM game_info
UNION ALL SELECT 'ticket_inventory', COUNT(*) FROM ticket_inventory
UNION ALL SELECT 'resale_data', COUNT(*) FROM resale_data
UNION ALL SELECT 'ancillary_revenue', COUNT(*) FROM ancillary_revenue
UNION ALL SELECT 'league_benchmarks', COUNT(*) FROM league_benchmarks;

USE clippers_pricing;

-- Normalize text fields to fix joins
UPDATE league_benchmarks SET opponent = TRIM(opponent);
UPDATE game_info SET opponent = TRIM(opponent);
UPDATE ticket_inventory SET section = TRIM(section);
UPDATE resale_data SET section = TRIM(section);

-- =============================
-- 1️⃣  RESALE AGGREGATE VIEW
-- =============================
DROP VIEW IF EXISTS v_resale_agg;
CREATE VIEW v_resale_agg AS
SELECT
  game_id,
  TRIM(section) AS section,
  AVG(avg_resale_price)            AS avg_resale_price,
  SUM(resale_volume)               AS total_resale_qty,
  AVG(primary_vs_resale_diff_pct)  AS avg_primary_vs_resale_diff_pct
FROM resale_data
GROUP BY game_id, TRIM(section);

-- =============================
-- 2️⃣  TICKET DETAIL VIEW
-- =============================
DROP VIEW IF EXISTS v_ticket_detail;
CREATE VIEW v_ticket_detail AS
SELECT
  g.game_id,
  g.`date`        AS game_date,
  g.opponent,
  g.dayofweek     AS day_of_week,
  g.marquee,
  g.attendance,
  g.capacity,
  ti.section,
  ti.ticket_type,
  ti.avg_price,
  ti.min_price,
  ti.max_price,
  ti.units_released,
  ti.units_sold,
  ti.sell_through_pct,
  ra.avg_resale_price,
  ra.total_resale_qty,
  (ti.avg_price * ti.units_sold) AS primary_revenue
FROM game_info g
LEFT JOIN ticket_inventory ti
  ON ti.game_id = g.game_id
LEFT JOIN v_resale_agg ra
  ON ra.game_id = ti.game_id
 AND LOWER(TRIM(ra.section)) = LOWER(TRIM(ti.section));

-- =============================
-- 3️⃣  GAME KPIs VIEW
-- =============================
DROP VIEW IF EXISTS v_game_kpis;
CREATE VIEW v_game_kpis AS
SELECT
  g.game_id,
  g.`date`                 AS game_date,
  g.opponent,
  g.dayofweek              AS day_of_week,
  g.marquee,
  g.attendance,
  g.capacity,
  COALESCE(ar.concessions_per_fan, 0)     AS concessions_per_fan,
  COALESCE(ar.merch_per_fan, 0)           AS merch_per_fan,
  COALESCE(ar.parking_per_fan, 0)         AS parking_per_fan,
  COALESCE(ar.premium_upgrades, 0)        AS premium_upgrades,
  COALESCE(ar.total_ancillary_revenue, 0) AS total_ancillary_revenue,
  SUM(ti.units_sold)                      AS total_tickets_sold,
  AVG(ti.avg_price)                       AS avg_ticket_price,
  SUM(ti.units_sold * ti.avg_price)       AS est_primary_revenue,
  (COALESCE(ar.total_ancillary_revenue,0) +
   SUM(ti.units_sold * ti.avg_price))     AS total_game_revenue
FROM game_info g
LEFT JOIN ticket_inventory ti ON ti.game_id = g.game_id
LEFT JOIN ancillary_revenue ar ON ar.game_id = g.game_id
GROUP BY
  g.game_id, g.`date`, g.opponent, g.dayofweek, g.marquee, g.attendance, g.capacity,
  ar.concessions_per_fan, ar.merch_per_fan, ar.parking_per_fan, ar.premium_upgrades, ar.total_ancillary_revenue;

-- =============================
-- 4️⃣  KPIs WITH LEAGUE BENCHMARKS
-- =============================
DROP VIEW IF EXISTS v_game_kpis_with_benchmarks;
CREATE VIEW v_game_kpis_with_benchmarks AS
SELECT
  k.*,
  lb.avg_price      AS league_avg_price_vs_opp,
  lb.avg_attendance AS league_avg_attendance_vs_opp,
  lb.revenue_index  AS league_revenue_index,
  lb.notes          AS league_notes
FROM v_game_kpis k
LEFT JOIN league_benchmarks lb
  ON LOWER(TRIM(lb.opponent)) = LOWER(TRIM(k.opponent));

-- =============================
-- 5️⃣  CLEAN FINAL VIEW FOR TABLEAU
-- =============================
CREATE OR REPLACE VIEW v_game_kpis_clean AS
SELECT
  game_id,
  game_date,
  opponent,
  day_of_week,
  marquee,
  COALESCE(attendance, 0)                AS attendance,
  COALESCE(capacity, 0)                  AS capacity,
  COALESCE(total_tickets_sold, 0)        AS total_tickets_sold,
  COALESCE(avg_ticket_price, 0)          AS avg_ticket_price,
  COALESCE(est_primary_revenue, 0)       AS est_primary_revenue,
  COALESCE(total_ancillary_revenue, 0)   AS total_ancillary_revenue,
  COALESCE(total_game_revenue, 0)        AS total_game_revenue,
  COALESCE(league_avg_price_vs_opp, 0)   AS league_avg_price_vs_opp,
  COALESCE(league_avg_attendance_vs_opp,0) AS league_avg_attendance_vs_opp,
  COALESCE(league_revenue_index, 1.0)    AS league_revenue_index,
  COALESCE(league_notes, 'N/A')          AS league_notes
FROM v_game_kpis_with_benchmarks;

SELECT * FROM v_game_kpis_clean LIMIT 10;

SELECT DISTINCT g.opponent
FROM game_info g
LEFT JOIN league_benchmarks lb
  ON LOWER(TRIM(g.opponent)) = LOWER(TRIM(lb.opponent))
WHERE lb.opponent IS NULL;

SELECT * FROM v_game_kpis_clean;


