# Pepsi DCF Valuation Analysis

## Project Files
- [Download Excel DCF model](./pepsi-dcf-valuation-analysis.xlsx)
- [View selected screenshots](./screenshots/)

## Overview
I built a discounted cash flow (DCF) valuation model for PepsiCo to estimate intrinsic value using revenue forecasting, operating assumptions, WACC, terminal value, and free cash flow projections.

The purpose of the project was to practice building a full valuation model and turn financial statement data into a clear investment view.

## Business Question
Based on projected cash flows and discount rate assumptions, does PepsiCo appear undervalued, fairly valued, or overvalued compared to its current market price?

## Project Flow
1. Pulled historical revenue, cost, operating expense, depreciation, working capital, and debt/equity data.
2. Built forecast assumptions for revenue growth, cost structure, operating expenses, taxes, D&A, CapEx, and working capital.
3. Calculated projected unlevered free cash flow.
4. Built a WACC calculation using debt, equity, cost of debt, tax rate, beta, and market return assumptions.
5. Estimated terminal value and implied share price.
6. Compared implied value against the current share price to assess upside/downside.

## Key Model Inputs
| Metric | Assumption / Output |
|---|---:|
| Current Share Price | $142.62 |
| Implied Share Price | $165.78 |
| Estimated Upside | 16.2% |
| WACC Used | 6.56% |
| Terminal Growth Rate | 3.0% |
| FY24 Revenue | $91,854M |
| FY29 Forecast Revenue | $103,924M |
| Enterprise Value | $220,315M |
| Equity Value | $227,279M |
| Diluted Shares Outstanding | 1,371M |

## Key Findings
- The model produced an implied share price of about $165.78, compared to a current share price of $142.62.
- That implied roughly 16.2% upside under the base case.
- Revenue was forecasted to grow from about $91,854M in FY24 to about $103,924M in FY29.
- The valuation was highly sensitive to the WACC and terminal growth rate, which is why I treated the final output as a range rather than a single exact number.

## Recommendation
Based on the base case, the DCF suggested PepsiCo had moderate upside. I would not treat the model as a standalone buy recommendation, but it supported the idea that the stock may have been undervalued under conservative growth assumptions.

The main recommendation was to continue stress-testing:
1. Revenue growth assumptions.
2. Margin assumptions.
3. WACC sensitivity.
4. Terminal growth sensitivity.
5. Free cash flow consistency.

## Conclusion
This project helped me connect finance and analytics by turning raw financial statement data into a valuation output. More importantly, it showed me how much a valuation depends on the assumptions behind the model, especially discount rate, terminal value, and long-term growth.

## Skills Demonstrated
- DCF Valuation
- Financial Modeling
- Forecasting
- WACC Analysis
- Terminal Value Analysis
- Sensitivity Thinking
- Excel Modeling
