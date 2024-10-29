---
title: "مثال ۱۶-۳: مدل‌سازی با عوامل فصلی (مدل‌سازی با بستهٔ نرم‌افزاری `dlm`)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۱۶-۳: مدل‌سازی با عوامل فصلی (مدل‌سازی با بستهٔ نرم‌افزاری `dlm`)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۴۷۹ کتاب)** 
 
در این مثال،   انتخاب مدل روند محلی با ترکیبات فصلی، برای مدل‌سازی داده‌های  فصلی مثال قبل (یعنی `datasets::JohnsonJohnson`) بحث می‌شود. اگرچه می‌توان گزینه‌های راحت‌تری نیز یافت، همچنان از بستهٔ `dlm` <span dir="ltr">(Petris, 2022)</span> استفاده می‌کنیم و تابع ساخت مدل را نیز خودمان پیاده‌سازی می‌کنیم. کد زیر را مطالعه کنید:


``` r
> buildModel <- function(param) {
+   p <- 5
+   GG1 <- matrix(c(1, 0, 1, 1), 2, 2)
+   GG2 <- matrix(0, p - 2, p - 2)
+   GG2[row(GG2) == col(GG2) + 1] <- 1
+   GG2[1, ] <- -1
+   dlm::dlm(
+     FF = matrix(c(1, 0, 1, rep(0, p - 3)), nrow = 1),
+     V = as.matrix(exp(param[1])),
+     GG = as.matrix(Matrix::bdiag(GG1, GG2)),
+     W = diag(c(exp(param[2:4]), 0, 0)),
+     m0 = matrix(0, p, 1),
+     C0 = matrix(10^7, p, p)
+   )
+ }
```
کد فوق  به توضیحات زیادی نیاز ندارد. از تابع عمومی `dlm()` استفاده کرده‌ایم. همچنین، برای ساختن ماتریس افرازشدهٔ قطری نیز از تابع `bdiag` در بستهٔ `Matrix` <span dir="ltr">(Bates, Maechler, and Jagan, 2024)</span> استفاده کرده‌ایم. ماتریس `GG` همان ماتریس $T$ در توضیحات است. نمادهای `FF`، `V`، و `W` نیز به‌ترتیب $Z$، $\boldsymbol{\Omega}$، و $\mathbf{Q}$ هستند.  ماتریس $\mathbf{R}$ را نمی‌توان تعریف کرد، اما از این بابت محدودیت نظری مثبت معین‌بودن ماتریس واریانس وجود ندارد و به‌طور ساده، واریانس‌ها را صفر می‌گذاریم.  `m0` و `C0` نیز مقدار موردانتظار و واریانس متغیر حالت در وضعیت اولیه است. پارامترها را مطابق با توضیحات متن  پارامتربندی کرده‌ایم. در اینجا، چهار پارامتر برای تخمین وجود دارد که واریانس اجزای اختلال هستند. همچنین، واریانس وضعیت اولیه را بسیار بزرگ انتخاب کرده‌ایم تا به مدل بفهمانیم که اطلاعات پیشینی در این زمینه نداریم. مطابق با مثال قبل، حالت‌های هموارسازی‌شده را در یک نمودار ترسیم می‌کنیم:


``` r
> y <- datasets::JohnsonJohnson
> initParam <- c(0.1, 0.1, 0.1, 0.1)
> fit <- dlm::dlmMLE(y = y, parm = initParam, build = buildModel)
> 
> mod <- buildModel(fit$par)
> filtered <- dlm::dlmFilter(y, mod)
> smoothed <- dlm::dlmSmooth(filtered)
> 
> par <- par(mar = c(2, 2, 2, 2) + 0.4)
> plot(cbind(y, smoothed$s[-1, c(1, 3)]),
+   plot.type = "s",
+   col = c("black", "red", "violet"),
+   lwd = c(2, 1, 1), lty = c(1, 3, 5)
+ )
> 
> 
> par(new = TRUE)
> plot(smoothed$s[-1, 2],
+   type = "l", yaxt = "n",
+   xaxt = "n", ylab = "", xlab = "", col = "blue", lwd = 1, lty = 5
+ )
> axis(side = 4)
> 
> legend("topleft", legend = c("واقعی", "سطح", "رشد (محور راست)", "فصلی"), lwd = c(2, 1, 1, 1), lty = c(1, 3, 5), col = c("black", "red", "blue", "violet"), cex = 0.8)
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_local_seasonal-1.svg" style="display: block; margin: auto;" />





### References

[1] D. Bates, M. Maechler, and M. Jagan. _Matrix: Sparse and Dense Matrix
Classes and Methods_. R package version 1.7-0. 2024.
<https://Matrix.R-forge.R-project.org>.

[2] G. Petris. _dlm: Bayesian and Likelihood Analysis of Dynamic Linear Models_.
R package version 1.1-6. 2022. <https://CRAN.R-project.org/package=dlm>.


<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۱۶-۲: مدل روند خطی محلی (مدل‌سازی)](matrix_book_fa_example16.2.html)
- [مثال ۱۷-۱: توزیع معکوس یک متغیر تصادفی (درک مفهوم با استفاده از کدنویسی)](matrix_book_fa_example17.1.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)
