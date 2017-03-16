library(AER)
library(foreign)
library(stargazer)

setwd("/Users/ztian/OneDrive/teaching/workshop/intro_org_RR/example")
classdata <- read.dta("./data/caschool.dta")

summary(classdata[c("testscr", "str", "el_pct", "expn_stu", "meal_pct")])

oldpar <- par(mfrow = c(2, 3))

plot(classdata$str, classdata$testscr, col = "red",
     main = "Student-teacher ratio vs test scores",
     xlab = "Student-teacher ratio", ylab = "Test scores")

plot(classdata$el_pct, classdata$testscr, col = "blue",
     main = "English learners vs test scores",
     xlab = "Percentage of English learners",
     ylab = "Test scores")

plot(classdata$expn_stu, classdata$testscr, col = "green3",
     main = "Expenditure per pupil vs test scores",
     xlab = "Expenditure per pupil",
     ylab = "Test scores")

plot(classdata$meal_pct, classdata$testscr, col = "maroon",
     main = "Free lunch vs test scores",
     xlab = "Percentage of students with free lunch",
     ylab = "Test scores")

plot(classdata$calw_pct, classdata$testscr, col = "darkorange1",
    main = "Public assistance vs test scores",
    xlab = "Percentage of students in public assistance",
    ylab = "Test scores")

par(oldpar)

model.76 <- testscr ~ str + I(expn_stu / 1000) + el_pct

res.model.76 <- lm(model.76, data = classdata)
summary(res.model.76)

# get some components of the results
bhat <- coef(res.model.76)
rsq <- summary(res.model.76)$r.squared
adj.rsq <- summary(res.model.76)$adj.r.squared

htvarm <- vcovHC(res.model.76, type = "HC1")

# homoskedasticity-only
coeftest(res.model.76)

# heteroskedasticity-robust, t distribution
cftest.t <- coeftest(res.model.76, vcov = htvarm)
cftest.t

# heteroskedasticity-robust, normal distribution
cftest.n <- coeftest(res.model.76, vcov = htvarm, df = Inf)
cftest.n

test1 <- linearHypothesis(res.model.76,
            c("str = 0", "I(expn_stu/1000) = 0"),
            vcov = htvarm, test = "F")
test1
test1.F <- test1$F[2]
test1.p <- test1$"Pr(>F)"[2]

# b1 + b2 = 0
test2 <- linearHypothesis(res.model.76,
            c("str + I(expn_stu/1000) = 0"),
            white.adjust = "hc1", test = "Chisq")
test2
test2.x <- test2$Chisq[2]
test2.p <- test2$"Pr(>Chisq)"[2]

# homoskedasticity-only F
test2.hm <- linearHypothesis(res.model.76,
            c("str + I(expn_stu/1000) = 0"),
            test = "F")
test2.hm

model1 <- lm(testscr ~ str, data = classdata)
model2 <- lm(testscr ~ str + el_pct, data = classdata)
model3 <- lm(testscr ~ str + el_pct + meal_pct, data = classdata)
model4 <- lm(testscr ~ str + el_pct + calw_pct, data = classdata)
model5 <- lm(testscr ~ str + el_pct + meal_pct + calw_pct, data = classdata)

hccm1 <- vcovHC(model1, type = "HC1")
se1 <- sqrt(diag(hccm1))

hccm2 <- vcovHC(model2, type = "HC1")
se2 <- sqrt(diag(hccm2))

hccm3 <- vcovHC(model3, type = "HC1")
se3 <- sqrt(diag(hccm3))

hccm4 <- vcovHC(model4, type = "HC1")
se4 <- sqrt(diag(hccm4))

hccm5 <- vcovHC(model5, type = "HC1")
se5 <- sqrt(diag(hccm5))

stargazer(model1, model2, model3, model4, model5,
          title = "Results of regressions of test scores and class size",
          covariate.labels = c("student-teacher ratio",
			       "percent English learners",
			       "percent eligible for subsidized lunch",
			       "percent on public assistance"),
          dep.var.caption = "average test scores in the district",
          se = list(se1, se2, se3, se4, se5), df = FALSE,
          font.size = "small",
          header = FALSE,
          label = "table:tbl71")
