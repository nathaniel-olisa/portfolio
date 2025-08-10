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

## Extra Visuals (Thumbnail Tour)

### A. Review Text Insights
<div>
  <p><img src="./beats_extra_visuals_partC/wordcloud_reviews.png" width="250"><br/>
  **All Reviews Word Cloud:** Dominant themes are *sound*, *earbud/speaker*, and *battery life*.</p>

  <p><img src="./beats_extra_visuals_partC/wordcloud_positive_reviews.png" width="250"><br/>
  **Positive Word Cloud:** Praise clusters around *sound quality*, *bass*, and *comfort/ease of use*.</p>

  <p><img src="./beats_extra_visuals_partA/barplot_top_words_5star.png" width="250"><br/>
  **Top Words in 5★ Reviews:** Confirms that *sound* and *quality* drive high ratings.</p>
</div>

### B. Brand & Model Analysis
<div>
  <p><img src="./beats_extra_visuals_partB/boxplot_ratings_by_model.png" width="250"><br/>
  **Ratings by Model:** Spread shows which models deliver consistent satisfaction vs. volatility.</p>

  <p><img src="./beats_extra_visuals_partB/boxplot_rating_by_brand.png" width="250"><br/>
  **Ratings by Brand:** Highlights where Beats sits relative to JBL/Bose/Sony on experience consistency.</p>

  <p><img src="./beats_extra_visuals_partB/countplot_reviews_per_model.png" width="250"><br/>
  **Reviews per Model:** Identifies high-visibility models shaping overall brand perception.</p>
</div>

### C. Reviewer Behavior & Relationships
<div>
  <p><img src="./beats_extra_visuals_partB/scatter_helpful_vs_rating.png" width="250"><br/>
  **Helpful vs. Rating:** Useful reviews aren’t always 5★ — detailed critical feedback gets traction.</p>

  <p><img src="./beats_extra_visuals_partB/correlation_heatmap.png" width="250"><br/>
  **Correlation Heatmap:** Longer reviews tend to earn more helpful votes; ratings are fairly independent.</p>

  <p><img src="./beats_extra_visuals_partC/sentiment_histogram_alt.png" width="250"><br/>
  **Polarity Distribution:** Reviews skew positive, but a negative tail marks actionable issues.</p>

  <p><img src="./beats_extra_visuals_partC/polarity_vs_subjectivity.png" width="250"><br/>
  **Polarity vs. Subjectivity:** Many opinions include objective details — good for product fixes.</p>

  <p><img src="./beats_extra_visuals_partC/boxplot_rating_by_profile_id.png" width="250"><br/>
  **Top Reviewers’ Ratings:** A few prolific reviewers show tighter (or harsher) scoring patterns.</p>
</div>

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
