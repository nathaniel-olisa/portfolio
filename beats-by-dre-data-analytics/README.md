# 🎧 Data Analytics Externship – Beats by Dre

## Overview
Analyzed consumer sentiment from survey data and online product reviews to uncover trends in user satisfaction, product performance, and brand perception.

## Objectives
- Extract actionable insights from customer feedback.
- Identify product strengths and weaknesses through sentiment analysis.
- Support product development and marketing strategy with data-driven recommendations.

## Tools & Libraries
- **Language:** Python
- **Libraries:** pandas, numpy, nltk, vaderSentiment, matplotlib, seaborn, wordcloud
- **Techniques:** Data cleaning, EDA, sentiment analysis, topic exploration, visualization

## Methodology
### 1) Data Cleaning
```python
import pandas as pd
df = pd.read_csv("customer_reviews.csv")
df = df.dropna(subset=["review"])
df["review"] = df["review"].str.strip()
```

### 2) Sentiment Analysis
```python
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
analyzer = SentimentIntensityAnalyzer()
df["sentiment_score"] = df["review"].apply(lambda x: analyzer.polarity_scores(x)["compound"])
```

### 3) Sentiment Categorization
```python
def label_sentiment(score):
    if score >= 0.05:
        return "Positive"
    elif score <= -0.05:
        return "Negative"
    return "Neutral"

df["sentiment_label"] = df["sentiment_score"].apply(label_sentiment)
```

### 4) Visualization
```python
import matplotlib.pyplot as plt
import seaborn as sns

ax = sns.countplot(x="sentiment_label", data=df)
ax.set_title("Sentiment Distribution")
plt.savefig("sentiment_distribution.png", bbox_inches="tight")
```

### 5) Insights (examples to tailor)
- Positive sentiment dominated reviews; negative feedback emphasized battery life and comfort.
- Word-clouds and keyword frequencies revealed recurring themes tied to specific product lines.

## Repo Structure
```text
/data                        # raw or processed reviews (remove PII)
/notebooks                   # Jupyter notebooks
/outputs                     # charts and artifacts
README.md
```

## Outputs (place your files/screens here)
- 📊 `outputs/sentiment_distribution.png`
- ☁ `outputs/wordcloud_positive.png`
- ☁ `outputs/wordcloud_negative.png`
