# 🎧 Beats by Dre – Wireless Speaker Consumer Insights (Externship)

**Role:** Data Analytics Extern (Consumer Insights)  
**Scope:** Survey + Amazon review analysis → sentiment, feature insights, competitive positioning → business recommendations

---

## 1) Executive Summary

I analyzed consumer feedback from a cleaned wireless speaker **survey (20 responses)** and **thousands of Amazon reviews** to understand what drives satisfaction/dissatisfaction and where Beats can differentiate. The evidence points to strong enthusiasm for **sound quality** and **value**, with recurring friction around **battery life, connectivity, and durability**. I translated these findings into concrete product and go-to-market recommendations.

---

## 2) Business Context

The wireless speaker market is crowded (JBL, Bose, Sony, Anker). Beats has brand heat and design leadership, but consumers demand **capable + reliable** hardware at compelling price points. This project maps what customers actually say and how they behave—so product and marketing can act with confidence.

---

## 3) Data Sources

- **Survey (cleaned):** `Cleaned  Wireless  Speakers Survey (Responses) - First 20 Responses (1).csv`  
- **Amazon reviews (processed):** `Cleaned_Speaker_Reviews_EDA.csv`, `Final_Speaker_Reviews_Visualized.csv`  
- **Notebook:** `amazon_reviews_eda.ipynb`  
- **Executive dashboard:** `beats-executive-dashboard.tsx`  
- **Deck:** `Consumer-Insights-Wireless-Speaker-Market (2).pptx`

> All files live in this folder so viewers can open them directly on GitHub.

---

## 4) Data Cleaning & Preparation

- Removed nulls/dupes, standardized brand/model names, normalized ratings, stripped HTML/emoji.
- Engineered sentiment features (VADER/TextBlob), tokenized text, and prepared visual exports.

---

## 5) Exploratory Data Analysis (EDA)

**Overall rating distribution (skews high, with a visible tail of friction):**
<img src="histogram_rating_distribution.png" width="100%">

**Review volume by model (where customers are talking most):**
<img src="countplot_reviews_per_model.png" width="100%">

**Ratings spread by brand & by model (consistency and outliers):**
<img src="boxplot_rating_by_brand.png" width="100%">
<img src="boxplot_ratings_by_model.png" width="100%">

**Reviewer behavior patterns (variance across frequent profiles):**
<img src="boxplot_rating_by_profile_id.png" width="100%">

---

## 6) Sentiment Analysis (NLP)

I used **VADER** (categories) and **TextBlob** (polarity/subjectivity) to score review text.

**Common language across all reviews (what people actually talk about):**
<img src="wordcloud_reviews.png" width="100%">

**Most frequent words within 5-star reviews (what delights customers):**
<img src="barplot_top_words_5star.png" width="100%">

**Sentiment category counts (positive dominates, but negatives flag real issues):**
<img src="sentiment_category_count.png" width="100%">

**Polarity distribution & relationship to subjectivity (many opinions contain actionable details):**
<img src="sentiment_histogram_alt.png" width="100%">
<img src="polarity_vs_subjectivity.png" width="100%">

---

## 7) Comparative & Correlation Insights

**Average rating by brand (competitive posture over time/sets):**
<img src="lineplot_avg_rating_by_brand.png" width="100%">

**Attribute relationships (what moves with what):**
<img src="correlation_heatmap.png" width="100%">

**Engagement vs. score (helpful votes aren’t just “5-star cheerleading”):**
<img src="scatter_helpful_vs_rating.png" width="100%">

---

## 8) What Customers Actually Say (Themes)

- **Loved:** sound quality, bass, easy setup, portability, brand experience.  
- **Pain points:** battery life (especially under heavy use), Bluetooth drop-offs, durability (scratches/knocks), perceived price/value gaps.  
- **Channel behavior:** shoppers gravitate to **Amazon** and price-transparent retailers; D2C needs stronger value incentives.

---

## 9) Recommendations

**Product**
- Prioritize **battery optimization** and **connection stability**; ruggedize the enclosure (drop/water resistance).
- Tiered lineup:
  - **Entry ($79–$99):** “value-premium” play to win volume against JBL/Anker.
  - **Core ($149–$179):** long battery, strong bass, IP rating; flagship sound.
- Ship firmware telemetry to monitor connection/battery issues post-launch.

**Marketing**
- Lead with **sound quality + long battery**; position value clearly vs. JBL.
- Leverage **Amazon presence** (A+ content, video, reviews program); focus electronics retail for displays.
- Influencer/UGC emphasizing workouts, dorm/desk setups, and small-space sound.

**CX/Support**
- Proactive replacements for early defects; visible commitment to durability.
- Setup guides for Bluetooth reliability across OS/device versions.

---

## 10) Deliverables

- **Notebook (EDA & NLP):** `amazon_reviews_eda.ipynb`
- **Executive dashboard (React + TypeScript):** `beats-executive-dashboard.tsx`
- **Stakeholder deck (PPT):** `Consumer-Insights-Wireless-Speaker-Market (2).pptx`
- **Datasets:**  
  - `Final_Speaker_Reviews_Visualized.csv`  
  - `Cleaned_Speaker_Reviews_EDA.csv`  
  - `Cleaned  Wireless  Speakers Survey (Responses) - First 20 Responses (1).csv`

---

## Appendix — Additional Visuals

**Additional sentiment & correlation exhibits:**
<img src="wordcloud_positive_reviews.png" width="100%">
<img src="sentiment_category_count.png" width="100%">
<img src="correlation_heatmap.png" width="100%">


