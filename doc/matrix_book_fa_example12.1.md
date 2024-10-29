---
title: "مثال ۱۲-۱: توزیع نرمال چندمتغیره (رسم نمودار سه‌بعدی)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۱۲-۱: توزیع نرمال چندمتغیره (رسم نمودار سه‌بعدی)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۳۲۷ کتاب)**

این مثال مشابه با [مثال ۷-۲](matrix_book_fa_example7.2) است و بیشتر با هدف نمایش شکل تابع نرمال دومتغیره طراحی شده است. اگر این مثال را مطالعه کنید، متوجه خواهید شد که نیاز به تابعی برای محاسبهٔ ارتفاع نمودار (در اینجا  چگالی نرمال  دومتغیره) داریم. بنابراین، صرفاً این تابع و نتیجهٔ رسم نمودار را گزارش می‌کنیم. تابع زیر را برای محاسبهٔ ارتفاع نمودار ملاحظه کنید:

``` r
> bivariate_normal_pdf <- function(x, y, mean_x, mean_y,
+                                  var_x, var_y, corr) {
+   mean_vector <- c(mean_x, mean_y)
+   covariance_matrix <- matrix(
+     c(
+       var_x, corr * sqrt(var_x * var_y),
+       corr * sqrt(var_x * var_y), var_y
+     ),
+     nrow = 2
+   )
+   mvtnorm::dmvnorm(cbind(x, y),
+     mean = mean_vector,
+     sigma = covariance_matrix
+   )
+ }
```
برای محاسبهٔ ارزش تابع چگالی احتمال از بستهٔ `mvnorm` <span dir="ltr">(Genz, Bretz, Miwa et al., 2024)</span> استفاده کرده‌ایم (به نصب‌شدن نیاز دارد).  تابع فوق، میانگین‌ها، واریانس‌ها، و ضریب همبستگی میان دو متغیر را می‌گیرد و ارزش تابع چگالی احتمال را بازمی‌گرداند. در ادامه، تابع را برای یک مجموعهٔ پارامتر رسم می‌کنیم.



``` r
> par <- par(mar = c(2, 2, 2, 2) + 0.1)
> 
> n <- 10
> x <- y <- seq(-3, 3, length.out = n)
> x_mat <- y_mat <- matrix(nrow = n, ncol = n)
> for (i in 1:n) {
+   x_mat[i, ] <- x
+   y_mat[, i] <- y
+ }
> z_mat <- outer(x, y, bivariate_normal_pdf,
+   mean_x = 1, mean_y = -1, var_x = 1, var_y = 2, corr = -0.6
+ )
> 
> plot3D::surf3D(x_mat, y_mat, z_mat,
+   colkey = FALSE, bty = "b2",
+   col = gray(seq(0.8, 0, length.out = 100))
+ )
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_multivariate_normal-1.svg" style="display: block; margin: auto;" />
(نسبت به کد در کتاب و با هدف نمایش بهتر، پارامتر `n` تغییر کرده است).


### References

[1] A. Genz, F. Bretz, T. Miwa, et al. _mvtnorm: Multivariate Normal and t
Distributions_. R package version 1.3-1. 2024.
<http://mvtnorm.R-forge.R-project.org>.


<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۱۱-۴: خوشه‌بندی $k$-میانگین (مثالی دیگر از رسم نمودار)](matrix_book_fa_example11.4.html)
- [مثال ۱۲-۲: توزیع لگاریتم نرمال (تمرین کدنویسی)](matrix_book_fa_example12.2.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)
