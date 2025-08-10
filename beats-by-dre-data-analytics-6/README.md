# 🎧 Beats by Dre – Consumer Review Sentiment Analysis & Market Insights

**Role:** Data Analytics Extern (Consumer Insights)  
**Scope:** Survey + Amazon review analysis → sentiment, feature insights, competitive positioning → business recommendations

---

## 1) Executive Summary
I analyzed consumer feedback from a cleaned wireless speaker **survey (20 responses)** and **thousands of Amazon reviews** to understand what drives satisfaction/dissatisfaction and where Beats can differentiate. The evidence points to strong enthusiasm for **sound quality** and **value**, with recurring friction around **battery life, connectivity, and durability**. The findings below translate into concrete product and go-to-market recommendations.

---

## 2) Project Structure
```
/data           → Cleaned datasets & survey responses
/notebooks      → Jupyter notebooks (EDA, sentiment, correlation)
/visuals        → All generated charts & word clouds
/dashboard      → Executive dashboard (React + TypeScript)
/docs           → Presentation deck & text summary reports
```

---

## 3) Data Sources
- **Survey (cleaned):** `/data/Cleaned  Wireless  Speakers Survey (Responses) - First 20 Responses (1).csv`
- **Amazon reviews (processed):** `/data/Cleaned_Speaker_Reviews_EDA.csv`, `/data/Final_Speaker_Reviews_Visualized.csv`
- **Notebooks:** see `/notebooks` for full code and analysis
- **Executive dashboard:** `/dashboard/beats-executive-dashboard.tsx`
- **Deck:** `/docs/Consumer-Insights-Wireless-Speaker-Market (2).pptx`
- **Brand comparison notes:** `/docs/Gemini_Speaker_Insights_Summary.txt`

---

## 4) Exploratory Data Analysis (EDA)

**Overall rating distribution (skews high, with a tail of friction):**  
<img src="visuals/histogram_rating_distribution.png" width="100%">

**Review volume by model (where customers are talking most):**  
<img src="visuals/countplot_reviews_per_model.png" width="100%">

**Ratings spread by brand & by model (consistency and outliers):**  
<img src="visuals/boxplot_rating_by_brand.png" width="100%">
<img src="visuals/boxplot_ratings_by_model.png" width="100%">

**Reviewer behavior patterns (variance across frequent profiles):**  
<img src="visuals/boxplot_rating_by_profile_id.png" width="100%">

---

## 5) Sentiment Analysis (NLP)

I used **VADER/TextBlob** to score review text (polarity & subjectivity) and categorize sentiment.  
**Common language across all reviews (what people actually talk about):**  
<img src="visuals/wordcloud_reviews.png" width="100%">

**Most frequent words within 5★ reviews (what delights customers):**  
<img src="visuals/barplot_top_words_5star.png" width="100%">

**Sentiment category counts (positive dominates, but negatives flag real issues):**  
<img src="visuals/sentiment_category_count.png" width="100%">

**Polarity distribution & relationship to subjectivity (many opinions contain actionable details):**  
<img src="visuals/sentiment_histogram_alt.png" width="100%">
<img src="visuals/polarity_vs_subjectivity.png" width="100%">

---

## 6) Comparative & Correlation Insights

**Average rating by brand (competitive posture):**  
<img src="visuals/lineplot_avg_rating_by_brand.png" width="100%">

**Attribute relationships (what moves with what):**  
<img src="visuals/correlation_heatmap.png" width="100%">

**Engagement vs. score (helpful votes aren’t just “5★ cheerleading”):**  
<img src="visuals/scatter_helpful_vs_rating.png" width="100%">

---

## 7) What Customers Actually Say (Themes)

- **Loved:** sound quality, bass, easy setup, portability, brand experience.  
- **Pain points:** battery life (especially under heavy use), Bluetooth drop-offs, durability (scratches/knocks), perceived price/value gaps.  
- **Channel behavior:** shoppers gravitate to **Amazon** and price-transparent retailers; D2C needs stronger value incentives.

A qualitative comparison of Bose, Sony, and Beats summaries appears in `/docs/Gemini_Speaker_Insights_Summary.txt`.

---

## 8) Recommendations

**Product**
- Prioritize **battery optimization** and **connection stability**; ruggedize the enclosure (IP rating).
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

## 9) How to Reproduce

1. Open notebooks in `/notebooks` to view EDA, sentiment, and correlation analysis.  
2. Visual assets are exported to `/visuals`.  
3. Stakeholder deck is in `/docs`.  
4. React dashboard source in `/dashboard`.

---
