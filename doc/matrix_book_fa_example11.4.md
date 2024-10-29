---
title: "مثال ۱۱-۴: خوشه‌بندی $k$-میانگین (مثالی دیگر از رسم نمودار)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۱۱-۴: خوشه‌بندی $k$-میانگین (مثالی دیگر از رسم نمودار)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۳۲۰ کتاب)**

در **R**، تابع `kmeans()` ابزار مناسبی برای انجام خوشه‌بندی `k`-میانگین است. در ابتدا، یک مجموعه دادهٔ مصنوعی می‌سازیم.  	

``` r
> set.seed(123)
> n <- 100
> centers <- matrix(
+   data = c(
+     2, 2, # center of first cluster
+     -2, -2 # center of second cluster
+   ),
+   ncol = 2, byrow = TRUE
+ )
> data <- rbind(
+   matrix(rnorm(2 * n, mean = centers[1, ]), ncol = 2),
+   matrix(rnorm(2 * n, mean = centers[2, ]), ncol = 2)
+ )
> result <- kmeans(data, centers = 2)
> print(result$centers)
```

```
#        [,1]      [,2]
# 1 -1.879535 -2.036223
# 2  2.090406  1.892453
```

داده‌های مصنوعی از دو متغیر تشکیل می‌شوند؛  بااین‌حال از یک جا به بعد، داده‌ها حول یک مرکز متفاوت پخش می‌شوند. اکنون، کد زیر را ملاحظه کنید:



``` r
> plot(data,
+   col = result$cluster, xlab = "X1",
+   ylab = "X2", asp = 1
+ )
> symbols(centers,
+   circles = c(2, 2), inches = 0.5, add = TRUE,
+   fg = "blue"
+ )
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_clustering-1.svg" style="display: block; margin: auto;" />

در نوشتن این کد، از تعداد خوشه‌ها اطلاع داریم. اگر چنین اطلاعاتی وجود نداشته باشد، می‌توان راهکارهای مختلفی را دنبال کرد. به‌عنوان تمرین، نمودار را برای زمانی ترسیم کنید که الگوریتم داده‌ها را به سه خوشه تقسیم‌بندی می‌کند.




<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۱۱-۳: تحلیل مؤلفهٔ اصلی (رسم نمودار)](matrix_book_fa_example11.3.html)
- [مثال ۱۲-۱: توزیع نرمال چندمتغیره (رسم نمودار سه‌بعدی)](matrix_book_fa_example12.1.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)
