---
title: "مثال ۱۱-۳: تحلیل مؤلفهٔ اصلی (رسم نمودار)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۱۱-۳: تحلیل مؤلفهٔ اصلی (رسم نمودار)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۳۱۴ کتاب)**

تحلیل مؤلفهٔ اصلی برای بردارهایی معنا می‌دهد که با یکدیگر مرتبط باشند. کد زیر این داده‌ها را ایجاد می‌کند.

``` r
> set.seed(123)
> X <- matrix(rnorm(20), ncol = 2)
> X <- X %*% matrix(c(1, 1, 0, 1), ncol = 2)
> D <- as.data.frame(X)
```

به ضرب ماتریس برای ایجاد یک ارتباط و همبستگی میان داده‌های دو ستون دقت کنید. خط آخر، صرفاً برای اشاره به این موضوع گزارش شد که مدلِ استانداردِ ذخیرهٔ اطلاعات در **R**، استفاده از `data.frame` است. در این حالت، ستون‌ها شامل ویژگی‌های مختلف و سطرها متعلق به مشاهدات هستند (نگاه کنید به: [مثال ۱۱-۱](matrix_book_fa_example11.1)).

اکنون، داده‌ها را به‌گونه‌ای تغییر می‌دهیم که میانگین آن‌ها صفر شود. سپس، بردارهای ویژهٔ ماتریس واریانس را محاسبه می‌کنیم:


``` r
> Y <- scale(X, scale = FALSE)
> R <- eigen(t(Y) %*% Y)$vectors
```
تابع `scale()` درایه‌های هر ستون را از متوسط آن کم می‌کند. دربارهٔ نحوهٔ محاسبهٔ بردارهای ویژه نیز پیش‌تر در [مثال ۵-۱](matrix_book_fa_example5.1) صحبت کرده‌ایم. این بردارها جهتی را نشان می ‌دهد که در آن، واریانس تصویرها حداکثر است. البته، برای تحلیل مؤلفهٔ اصلی در **R**، تابع `pca()` نیز وجود دارد. کد زیر را ببینید:

``` r
> pca <- prcomp(X)
> all(abs(R - pca$rotation) < 1e-12)
```

```
# [1] TRUE
```
بنابراین، درون تابع `pca()`، فرایند مشابه با آنچه انجام دادیم طی می‌شود. البته، این تابع گزینه‌های بیشتری  در اختیار قرار می‌دهد. فارغ از ورودی‌های آن (که می‌توانید بررسی کنید)،  یکی از این گزینه‌ها به تعریف کلاس و بازنویسی توابع عمومی برای آن کلاس مربوط است (نگاه کنید به: [مثال ۴-۲](matrix_book_fa_example4.2)). نتیجهٔ کد زیر را ببینید:

``` r
> class(pca)
```

```
# [1] "prcomp"
```
مثلاً تابع `plot()` ازجملهٔ توابع عمومی است که  می‌توان برای کلاس‌های مختلف بازنویسی کرد (به‌عنوان تمرین، ارزش `pca` را رسم کنید و بررسی کنید نمودار ستونی چه‌چیزی را نشان می‌دهد). درهرحال در این بخش، به نوعی دیگر نتیجهٔ این تابع را رسم می‌کنیم.


``` r
> plot(X, xlab = "X1", ylab = "X2", main = "", asp = 1)
> lines(c(0, pca$rotation[1, 1]) * 10, c(0, pca$rotation[2, 1]) * 10,
+   col = "red"
+ )
> lines(c(0, -pca$rotation[1, 1]) * 10, c(0, -pca$rotation[2, 1]) * 10,
+   col = "red"
+ )
> lines(c(0, pca$rotation[1, 2]) * 10, c(0, pca$rotation[2, 2]) * 10,
+   col = "blue"
+ )
> lines(c(0, -pca$rotation[1, 2]) * 10, c(0, -pca$rotation[2, 2]) * 10,
+   col = "blue"
+ )
> 
> proj1 <- X %*% pca$rotation[, 1]
> proj2 <- X %*% pca$rotation[, 2]
> 
> for (i in 1:nrow(X)) {
+   points(proj1[i] * pca$rotation[1, 1], proj1[i] * pca$rotation[2, 1],
+     pch = 16, col = "red"
+   )
+   points(proj2[i] * pca$rotation[1, 2], proj2[i] * pca$rotation[2, 2],
+     pch = 16, col = "blue"
+   )
+   lines(rbind(X[i, ], c(proj1[i] * pca$rotation[1, 1], proj1[i] *
+     pca$rotation[2, 1])), col = "red", lty = 3)
+   lines(rbind(X[i, ], c(proj2[i] * pca$rotation[1, 2], proj2[i] *
+     pca$rotation[2, 2])), col = "blue", lty = 3)
+ }
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_pca-1.svg" style="display: block; margin: auto;" />
در کد مربوطه، خطوط متعامد بر هر دو بردار ویژه در حلقهٔ `for` ترسیم می‌شود. توجه کنید که چگونه تصویرها  بر بردار ویژهٔ اول از یکدیگر دور هستند (و واریانس بیشتری دارند). هر بردار دیگری انتخاب شود،  مثلاً با ۱ درجه تغییر در زاویه، این واریانس کوچک‌تر می‌شود. همچنین، توجه کنید که چگونه بردارهای ویژه بر یکدیگر عمودند. این بردارها را می‌توانید هم‌راستا با قطرهای یک بیضی ببینید که مشاهدات را دربرمی‌گیرند. در نهایت، توجه کنید که نقش ورودی `asp=1` در این نمایش مهم است. 

شما با توجه به کد مربوطه، ابزار لازم برای بررسی رفتار تحلیل مؤلفهٔ اصلی تحت فروض مختلف را دارید. به‌عنوان تمرین، تأثیر حذف میانگین از مشاهدات یا واحدکردن واریانس را بررسی کنید. همچنین در ابتدای بحث، دو متغیر همبسته ایجاد شد. بررسی کنید که اگر متغیرها ارتباطی با یکدیگر نداشته باشند، چه اتفاقی برای این تحلیل رخ می‌دهد.



<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۱۱-۲: محاسبهٔ آماره‌های توصیفی (معرفی برخی توابع و فرایندها)](matrix_book_fa_example11.2.html)
- [مثال ۱۱-۴: خوشه‌بندی $k$-میانگین (مثالی دیگر از رسم نمودار)](matrix_book_fa_example11.4.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)