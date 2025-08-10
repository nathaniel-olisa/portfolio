# earnings_analysis_clean.R
# Clean, reproducible version aligned to the term paper (Financial Specialists; ACS 2009–2013)

# install.packages(c("car","plyr","spatstat","broom","sandwich","lmtest"))

library(car)        # recode
library(plyr)       # count
library(spatstat)   # weighted.median
library(broom)      # tidy()
library(sandwich)   # robust vcov
library(lmtest)     # coeftest()

# 1) Load prepared ACS subset (contains: YEAR, OCC1990, INCEARN, DEGFIELDD, PERWT, CPI99, AGE, SEX, etc.)
# NOTE: Do not commit microdata to GitHub. Place EarningsMajor.RData next to this project before running.
load("EarningsMajor.RData")  # produced by your workflow

# Inflation adjustment (as in your original script)
subset2$INCEARNadj <- subset2$INCEARN * subset2$CPI99 * 1.430

# 2) Filter to Financial Specialists, 2009–2013, age 23–50
df <- subset(subset2, OCC1990 == 25 & YEAR >= 2009 & YEAR <= 2013 & AGE > 22 & AGE < 51)

# 3) Recode majors (excerpt for top categories used in the paper)
df$major <- recode(df$DEGFIELDD,
                   "5501='Economics'; 6205='Business Economics'; 6207='Finance'; 6203='Business Management and Administration';
                    6201='Accounting'; 6200='General Business'; 6206='Marketing and Marketing Research';
                    3700='Mathematics'; 2102='Computer Science'; 6402='History'; 5200='Psychology'; 6107='Nursing';
                    5506='Political Science and Government'; 6103='Health and Medical Admin Services'")

# 4) Indicators
df$ECON   <- ifelse(df$DEGFIELDD %in% c(5501, 6205), 1, 0)  # Economics or Business Econ
df$FEMALE <- ifelse(df$SEX == "Female" | df$SEX == 2, 1, 0)

# 5) Weighted descriptives by major
get_wmean   <- function(x) weighted.mean(x$INCEARNadj, w = x$PERWT, na.rm = TRUE)
get_wmedian <- function(x) weighted.median(x$INCEARNadj, w = x$PERWT, na.rm = TRUE)

# Example: write descriptive table (optional)
# library(ddply) # plyr provides ddply
tab <- ddply(df, .(major), summarize,
             freq = length(INCEARNadj),
             cumul_percent = 100 * freq / sum(freq),
             mean  = get_wmean(df[df$major == major,]),
             median= get_wmedian(df[df$major == major,]))
tab <- tab[order(-tab$freq),]
write.csv(tab, "outputs/earnings_by_major_desc.csv", row.names = FALSE)

# 6) OLS models (weights via PERWT; robust SEs)
m_short <- lm(INCEARNadj ~ ECON,            data = df, weights = PERWT)
m_long  <- lm(INCEARNadj ~ ECON + FEMALE,   data = df, weights = PERWT)
m_aux   <- lm(FEMALE     ~ ECON,            data = df, weights = PERWT)

robust <- function(m) coeftest(m, vcov = vcovHC(m, type = "HC1"))
print(robust(m_short))
print(robust(m_long))
print(robust(m_aux))

# OVB check
gamma <- coef(m_long)["FEMALE"]
pi1   <- coef(m_aux)["ECON"]
ovb   <- gamma * pi1
cat("\nOVB estimate (gamma * pi1): ", round(ovb, 2), "\n")
