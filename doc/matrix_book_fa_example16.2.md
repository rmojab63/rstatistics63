---
title: "مثال ۱۶-۲: مدل روند خطی محلی (مدل‌سازی)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۱۶-۲: مدل روند خطی محلی (مدل‌سازی)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۴۷۲ کتاب)**

در این مثال، یک مدل روند خطی محلی تخمین می‌زنیم.  برای این منظور،‌  داده‌های فصلیِ درآمد هر سهم  جانسون‌جانسون را که در `datasets::JohnsonJohnson` وجود دارد، به‌کار می‌بریم. برای تخمین، از بستهٔ نرم‌افزاری `dlm` <span dir="ltr">(Petris, 2022)</span> استفاده می‌کنیم. کد زیر فرایند مدل‌سازی و تخمین را نشان می‌دهد:

``` r
> y <- datasets::JohnsonJohnson
> buildModel <- function(param) {
+   dlm::dlmModPoly(
+     order = 2, dV = exp(param[1]),
+     dW = exp(param[2:3])
+   )
+ }
> initParam <- c(0.1, 0.1, 0.1)
> fit <- dlm::dlmMLE(y = y, parm = initParam, build = buildModel)
> print(exp(fit$par))
```

```
# [1] 8.356586e-01 3.756995e-09 6.209250e-04
```
مدل موردنظر دارای سه پارامتر است که واریانس اجزای خطا در معادلات را نشان می‌دهد. این کد این پارامترها را با استفاده از تابع `dlmMLE()`  و همان‌طور که از نام مشخص است، روش حداکثر درست‌نمایی تخمین می‌زند. این تابع  به پارامتری با نام `build` نیاز دارد تا با استفاده از آن و به‌ازای بردار پارامترها در تکرار فعلی الگوریتم حداکثر دست‌نمایی، مدل را بسازد. تابع `buildModel` به این دلیل نوشته شده است. درون این تابع، از دستور `dlmModPoly()` استفاده می‌کنیم. `dV` واریانس خطا در معادلهٔ مشاهدات و `dW` قطر  ماتریس واریانس در معادلهٔ وضعیت است. انتخاب تابع `exp()` برای وضع محدودیت مثبت‌بودن واریانس و برخی دیگر از ملاحظات  نظیر پایداری محاسبات است. 

مدل را می‌توان برای اهداف بسیاری نظیر تفسیر تخمین‌ها یا پیش‌بینی و غیره به‌کار برد. در ادامه به‌منظور توضیح برخی از مفاهیم، برآوردها را در نمودار و در کنار مشاهدات واقعی ترسیم می‌کنیم. کد زیر را ملاحظه کنید:

``` r
> mod <- buildModel(fit$par)
> filtered <- dlm::dlmFilter(y, mod)
> smoothed <- dlm::dlmSmooth(filtered)
```
در خط اول، مدل فضای وضعیت را با استفاده از تابعی که پیش‌تر نوشتیم و با استفاده از تخمین‌های حداکثر درست‌نمایی می‌سازیم. در خط دوم، فیلتر کالمن را با توجه به مجموعهٔ مشاهدات $y$ محاسبه می‌کنیم. سپس، از این نتایج برای هموارسازی استفاده می‌کنیم. سری `smoothed` میانگین و واریانس توزیع شرطی متغیرهای وضعیت به‌شرط کل مشاهدات را دربرمی‌گیرد. البته در بستهٔ نرم‌افزاری `dlm`، از تجزیهٔ ارزش منفرد (نگاه کنید به: قضیهٔ ۱۶-۶، صفحهٔ ۴۵۹ در کتاب) استفاده می‌شود. بنابراین، محاسبهٔ انحراف‌معیار، چند خط کد به‌صورت زیر نیاز دارد:

``` r
> sd_smoothed <- sapply(2:length(smoothed$U.S), function(i) {
+   V <- smoothed$U.S[[i]] %*% diag(smoothed$D.S[i, ]^2) %*%
+     t(smoothed$U.S[[i]])
+   sqrt(V[1, 1])
+ })
```

تمرکز بر متغیر حالت اول یعنی روند قرار دارد. به این دلیل است که تنها `V[1,1]` را برمی‌گردانیم. همچنین، به عدد `2` در تابع `sapply()` توجه کنید؛ این یعنی اولین مشاهده را کنار می‌گذاریم، زیرا مربوط به زمان $0$ است. آنچه باقی می‌ماند محاسبهٔ فاصلهٔ اطمینان و ترسیم نمودارهای موردنظر است.

``` r
> par <- par(mar = c(2, 2, 2, 2) + 0.1)
> ys <- ts(smoothed$s[-1, 1], start = c(1960, 1), frequency = 4)
> plot(cbind(y, ys), plot.type = "s", col = c("black", "red"), lwd = c(2, 2))
> sd_smoothed <- ts(sd_smoothed, start = c(1960, 1), frequency = 4)
> upper_bound <- smoothed$s[-1, 1] + 1.96 * sd_smoothed
> lower_bound <- smoothed$s[-1, 1] - 1.96 * sd_smoothed
> lines(upper_bound, col = "blue", lty = 2)
> lines(lower_bound, col = "blue", lty = 2)
> 
> legend("topleft",
+   legend = c("Actual", "Trend (marginal)", "95% CI"),
+   lwd = c(2, 2, 1), lty = c(1, 1, 2), col = c("black", "red", "blue"), cex = 0.8
+ )
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_local_linear-1.svg" style="display: block; margin: auto;" />
توزیع فوق هموارسازی نهایی یعنی $\operatorname{P}(\dot{\boldsymbol{\alpha}}\_t|\mathbf{y}\_{1:n})$ است. توزیع $\operatorname{P}(\dot{\boldsymbol{\alpha}}\_{1:n}|\mathbf{y}\_{1:n})$ یعنی مشترک هموارسازی را می‌توان با شبیه‌سازی با استفاده از تابع `dlm::dlmBSample` محاسبه کرد. کد زیر را مطالعه کنید:

``` r
> n <- 100
> samples <- matrix(nrow = n, ncol = length(y) + 1)
> for (i in 1:n) {
+   samples[i, ] <- dlm::dlmBSample(filtered)[, 1]
+ }
> sample_sum <- sapply(
+   1:(length(y) + 1),
+   function(i) {
+     c(
+       mean(samples[, i]),
+       quantile(samples[, i],
+         probs = c(0.025, 0.975)
+       )
+     )
+   }
+ )
```

 


### References

[1] G. Petris. _dlm: Bayesian and Likelihood Analysis of Dynamic Linear Models_.
R package version 1.1-6. 2022. <https://CRAN.R-project.org/package=dlm>.


<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۱۶-۱: کالمن فیلتر و هموارسازی (تمرین برنامه‌نویسی)](matrix_book_fa_example16.1.html)
- [مثال ۱۶-۳: مدل‌سازی با عوامل فصلی (مدل‌سازی با بستهٔ نرم‌افزاری `dlm`)](matrix_book_fa_example16.3.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)
