---
title: "مثال ۱۴-۱: معادلهٔ تفاضلی خطی مرتبهٔ اول (تمرین برنامه‌نویسی)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۱۴-۱: معادلهٔ تفاضلی خطی مرتبهٔ اول (تمرین برنامه‌نویسی)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۳۷۴ کتاب)** 

در این مثال، روند تغییرات جواب یک معادلهٔ تفاضلی خطی مرتبهٔ اول با یک شرط اولیهٔ مشخص را در یک نمودار ترسیم می‌کنیم. آنچه مورد نیاز است تابعی است که بتواند با توجه به مقدار دنباله در دورهٔ $t$، ارزش دنباله در دورهٔ بعد را محاسبه کند. بنابراین، تابع زیر را می‌نویسیم:


``` r
> f_ode <- function(t, y, parms) {
+   b <- parms[["b"]]
+   e_t <- parms[["e_t"]]
+   b * y[t] + e_t(t)
+ }
```

ساختاری که به این تابع می‌دهیم، مشابه  ساختاری است که در فصل ۱۵ (صفحهٔ ۴۱۹ در کتاب) برای یک معادلهٔ دیفرانسیل موردنیاز است.  اکنون، مقدار اولیه و طول دامنه را تعیین می‌کنیم؛ سپس، با فراخوانی تابع فوق به‌صورت برگشتی، ارزش‌های دنبالهٔ جواب را به‌روزرسانی می‌کنیم. کد زیر را ببینید:


``` r
> y0 <- 1
> nspan <- 0:20
> y <- numeric(length(nspan))
> y[1] <- y0
> for (t in seq_along(nspan)[-1]) {
+   y[t] <- f_ode(t - 1, y,
+     parms = list(
+       b = 0.9,
+       e_t = function(t) {
+         0
+       }
+     )
+   )
+ }
```

در این دستورها، `y` همان دنبالهٔ جواب است که به‌صورت یک بردار تعریف شده است. به تعریف فرایند بازگشتی نیز دقت کنید. در ابتدا با استفاده از `y[1] <- y0`، شرط اولیه را به‌عنوان اولین عضو جواب تعیین می‌کنیم؛ سپس، در حلقهٔ `for`، با استفاده از `t-1`، هر ارزش را به‌عنوان تابعی از ارزش دورهٔ قبل از خود تعریف می‌کنیم. بقیهٔ خطوط را به‌عنوان تمرین توضیح دهید. همچنین به‌عنوان تمرین،  تأثیر غیرهمگن‌شدن معادله بر جواب را بررسی کنید.

اکنون، دنباله را با استفاده از کد زیر رسم می‌کنیم:

``` r
> plot(nspan, y, type = "o", main = "", xlab = "t", ylab = "y(t)")
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_difference_equation-1.svg" style="display: block; margin: auto;" />



<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۱۳-۳: تخمین مدل معادلات هم‌زمان (مفهوم صادرشدن اشیاء از یک بستهٔ نرم‌افزاری)](matrix_book_fa_example13.3.html)
- [مثال ۱۴-۲: تعادل در مدل تارعنکبوتی (تمرین برنامه‌نویسی)](matrix_book_fa_example14.2.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)