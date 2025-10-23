# 🏀 Clippers Pricing & Attendance Analysis (2024–25 Season)

**Tools:** MySQL • Tableau • Excel  
**Goal:** Evaluate how the LA Clippers’ ticket pricing, attendance, and game-day revenue compare to league benchmarks.

---

## 📊 Project Overview

This project builds a **fully relational SQL database** using raw CSV data from the Clippers 2024–25 season, then connects it to Tableau for visual analysis.  
It provides insights into:
- Ticket sales performance and sell-through rates  
- Game attendance vs capacity trends  
- Resale market behavior  
- Ancillary revenue contributions (concessions, parking, merch)  
- League benchmark comparisons via a revenue index  

All data is modeled, cleaned, and visualized to simulate a **real-world pricing analyst workflow**.

---

## 🧱 Database Schema

Created five core tables (all included below 👇):

| Table | Description | File |
|-------|--------------|------|
| `game_info` | Game metadata (date, opponent, attendance, capacity) | [Games.csv](./Games.csv) |
| `ticket_inventory` | Ticket prices and sell-through by section | [Ticket_Inventory.csv](./Ticket_Inventory.csv) |
| `resale_data` | Average resale prices and volume | [Resale_Data.csv](./Resale_Data.csv) |
| `ancillary_revenue` | Revenue from concessions, merch, and parking | [Ancillary_Revenue.csv](./Ancillary_Revenue.csv) |
| `league_benchmarks` | League average prices, attendance, and revenue index | [League_Benchmarks.csv](./League_Benchmarks.csv) |

📘 SQL Build Script: [`clippers_pricing_model.sql`](./clippers_pricing_model.sql)  
📗 Excel Source File: [`Clippers Pricing Model.xlsx`](./Clippers%20Pricing%20Model.xlsx)

---

## 🧮 Tableau Dashboard

👉 [**View Interactive Dashboard on Tableau Public**](https://public.tableau.com/views/ClippersPricingAnalysisDashboard/ClippersTicketPricingAttendancePerformance202425?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

**Dashboard Views:**
1. **Attendance vs Capacity Fill Rate** – measures fan turnout per opponent  
2. **Revenue by Game** – combines ticket + ancillary revenue  
3. **League Comparison** – shows Clippers performance relative to league benchmarks  
4. *(Optional)* Revenue Index reference chart for quick benchmarking  

---

## 📈 Key Findings

- 🟢 **Marquee games (Lakers, Warriors, Celtics)** outperform the league average by 10–20% in revenue index.  
- 📊 **Sell-through rate** exceeds 95% across both Lower and Upper Bowl sections — indicating efficient pricing.  
- 💰 **Ancillary revenue** contributes roughly **35%** of total game-day earnings.  
- 🧩 **Resale markets** confirm pricing elasticity — premium games command strong secondary price lifts (up to +20%).  
- 🏟️ Attendance remains stable across non-marquee opponents, suggesting solid baseline fan demand.

---

## 💡 Insights for Strategy

- Optimize pricing tiers for high-demand opponents to capture resale value.  
- Leverage ancillary revenue streams in mid-tier matchups to maintain profitability.  
- Continue dynamic pricing and segmentation (section-based adjustments).  

---

## 🧠 Skills Demonstrated

**Data Modeling** • **SQL Joins** • **Data Cleaning** • **Dashboard Design** • **Business & Sports Analytics**

---

> 📁 *All source files, code, and Tableau links included for full project replication.*
