# 🎧 Beats by Dre – Wireless Speaker Consumer Insights (Externship)

**Role:** Data Analytics Extern | **Focus:** Survey + Amazon reviews → sentiment, EDA, strategy

---

## Executive Summary
Customers love **sound quality** and **value**; friction clusters around **battery life**, **connectivity**, and **durability**. Recommend an entry product at **$79–$99** and a core model at **$149–$179**, with marketing that leads on **sound + battery** and channels that prioritize **Amazon**.

---

## Data & Methods
- **Data:** Survey (n=20), Amazon reviews (thousands)  
- **Repo note:** To keep this repo lightweight, I included **sample subsets** of the large review datasets (`part01` only). The full datasets were used for analysis and are available upon request.
- **Tools:** Python (pandas, nltk, TextBlob), Matplotlib/Seaborn, React/TS for dashboard  
- **Tasks:** Cleaning, EDA, sentiment scoring (VADER/TextBlob), comparative analysis, storytelling

## Project Structure
```
/data           → Cleaned datasets & survey responses
/notebooks      → Jupyter notebooks (EDA, sentiment, correlation)
/visuals        → All generated charts & word clouds
/dashboard      → Executive dashboard (React + TypeScript)
/docs           → Presentation deck & text summary reports
```
---

## What the Data Shows

**1) Ratings skew high, with a meaningful tail of friction**  
<img src="histogram_rating_distribution.png" width="100%">

**2) Where the conversation is happening (models with the most reviews)**  
<img src="countplot_reviews_per_model.png" width="100%">

**3) What delights customers (language inside 5-star reviews)**  
<img src="barplot_top_words_5star.png" width="100%">

**4) Positive sentiment dominates—but negatives flag real product issues**  
<img src="sentiment_category_count.png" width="100%">

**5) Beats is competitive, but reliability/value win the category**  
<img src="lineplot_avg_rating_by_brand.png" width="100%">

---

## Recommendations

**Product**  
- Improve **battery life** and **Bluetooth stability**; ruggedize enclosure.  
- Two-tier pricing (Entry **$79–$99**, Core **$149–$179**) to compete with JBL/Anker while preserving premium feel.

**Marketing**  
- Lead with **sound + battery** value; amplify on **Amazon** with rich PDP content and review strategy.

**Customer Experience**  
- Tighten setup guidance, surface firmware updates, and reinforce warranty/durability commitments.

---
## Main Analysis Highlights
1. **Sentiment Distribution** – Categorized reviews as Positive, Neutral, or Negative using TextBlob and VADER sentiment analysis.
2. **Brand Ratings** – Compared average ratings across major speaker brands.
3. **Top Words in Reviews** – Identified common keywords in 5-star reviews to understand what drives positive feedback.
4. **Rating Patterns** – Analyzed the distribution of ratings to spot trends in customer satisfaction.

---

## Deliverables

### **Live Dashboard**
- [Beats Executive Dashboard](https://claude.ai/public/artifacts/5c27cc3c-9b86-4e2a-97fb-1cff99c99343?fullscreen=false)

### **Notebooks**
- [Amazon Reviews EDA](./amazon_reviews_eda.ipynb)
- [Gemini Speaker Review Insights](./Gemini_Speaker_Review_Insights_WITH_KEY.ipynb)
- [Speaker Review Correlation Analysis](./Speaker_Review_Correlation_Analysis.ipynb)

### **Datasets**
- [Final Speaker Reviews Visualized](./Final_Speaker_Reviews_Visualized.csv)
- [Cleaned Speaker Reviews EDA](./Cleaned_Speaker_Reviews_EDA.csv)
- [Cleaned Wireless Speakers Survey](./Cleaned%20Wireless%20Speakers%20Survey%20(Responses)%20-%20First%2020%20Responses%20(1).csv)

> To reproduce the full analysis locally, use the complete datasets. The notebook will run on the sample files for demonstration (subset) or on the full data for full fidelity.
---

## Extra Visuals & Insights

### **1. Review Text Insights**
**Top Words in 5-Star Reviews**
<img src="./beats_extra_visuals_partA/barplot_top_words_5star.png" width="250">
Shows the most frequently mentioned words in 5-star reviews, highlighting “sound” and “quality” as key drivers of satisfaction.

**Most Common Words in All Reviews**
<img src="./beats_extra_visuals_partA/wordcloud_reviews.png" width="250">
Word cloud illustrating common themes across all reviews, with emphasis on sound, earbuds, and battery life.

---

### **2. Brand & Model Analysis**
**Average Rating by Speaker Brand**
<img src="./beats_extra_visuals_partB/lineplot_avg_rating_by_brand.png" width="250">
Compares average product ratings across brands, revealing competitors that outperform or underperform Beats.

**Number of Reviews per Speaker Model**
<img src="./beats_extra_visuals_partB/countplot_reviews_per_model.png" width="250">
Displays review volume by specific speaker models, helping identify market leaders.

**Ratings by Speaker Model**
<img src="./beats_extra_visuals_partB/boxplot_ratings_by_model.png" width="250">
Visualizes rating spread for each model, showing consistency and variability in customer satisfaction.

**Rating Distribution by Brand**
<img src="./beats_extra_visuals_partB/boxplot_rating_by_brand.png" width="250">
Highlights differences in customer experience across brands through rating spread.

---

### **3. Reviewer Behavior**
**Helpful Count vs. Rating**
<img src="./beats_extra_visuals_partC/scatter_helpful_vs_rating.png" width="250">
Analyzes whether highly-rated reviews are marked as more helpful.

**Rating Distribution by Top 10 Reviewers**
<img src="./beats_extra_visuals_partC/boxplot_rating_by_profile_id.png" width="250">
Shows rating behavior of the top 10 most active reviewers.

**Rating Distribution**
<img src="./beats_extra_visuals_partC/histogram_rating_distribution.png" width="250">
Reveals how ratings are distributed overall, with a spike in perfect scores.

**Sentiment Category Counts**
<img src="./beats_extra_visuals_partC/sentiment_category_count.png" width="250">
Breakdown of reviews into positive, neutral, and negative sentiment categories.

---

## Key Takeaways
- **Sound quality** is the most significant factor influencing positive reviews.
- Beats has strong competition from brands like Bose and JBL in average ratings.
- Customer sentiment is overwhelmingly positive, though improvement opportunities exist in battery life and connectivity.
