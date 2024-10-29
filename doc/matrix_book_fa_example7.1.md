---
title: "مثال ۷-۱: تفسیر هندسی فرم خطی در \\\\(\\mathbb{R}^2\\\\) (رسم شکل)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۷-۱: تفسیر هندسی فرم خطی در \\(\mathbb{R}^2\\) (رسم شکل)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۲۳۷ کتاب)**

در این مثال نسبتاً طولانی، علاوه بر اینکه تلاش می‌کنیم ویژگی‌های هندسی تبدیل خطی۷-۱ (صفحهٔ ۲۳۴ در کتاب) را توضیح دهیم، همچنین تمرینی نیز دربارهٔ رسم نمودار در **R**  خواهیم داشت. بحث در مورد چرخش، انعکاس، و تغییر مقیاس در فضای $\mathbb{R}^2$ است. برای نمایش این تغییرات در یک نمودار، در ابتدا تابعی  می‌نویسیم که یک بیضی در صفحهٔ مختصات ترسیم کند. رویکرد همانند [مثال ۳-۲](matrix_book_fa_example3.2) است. پس، کد زیر را ملاحظه کنید:


``` r
> plot.ellipse <- function(A = diag(2), axisXY = c(1, 1),
+                          posX = 0, posY = 0,
+                          new.plot = TRUE, ...) {
+   theta <- seq(0, 2 * pi, length.out = 100)
+   x <- posX + axisXY[1] * cos(theta) + axisXY[1]
+   y <- posY + axisXY[2] * sin(theta) + axisXY[2]
+   X <- A %*% rbind(x, y)
+   if (new.plot) {
+     default_args <- list(type = "l", xlab = NA, ylab = NA)
+   } else {
+     default_args <- list()
+   }
+   user_args <- list(...)
+   args <- modifyList(default_args, user_args)
+   if (new.plot) {
+     do.call("plot", c(list(X[1, ], X[2, ]), args))
+   } else {
+     do.call("lines", c(list(X[1, ], X[2, ]), args))
+   }
+ }
```

نام ورودی‌های تابع تقریباً گویاست و با هدف خلاصه نگه‌داشتن این متن، توضیحاتی اضافه نمی‌شود. بخشی از منطق تابع فوق، با توجه به فرمول بیضی به‌دست می‌آید. بخش دیگر با توجه به هدف ما که تبدیل خطی نقاط است، توضیح داده می‌شود (منظور ورودی `A` و ضرب ماتریسی `A %*% rbind(x, y)` است). بخش نهایی نیز به نحوهٔ رسم توابع در سیستم‌های کامپیوتری مربوط می‌شود، که معمولاً با مشخص‌کردن نقاط و وصل‌کردن آن‌ها به یکدیگر  انجام می‌پذیرد. در تابع فوق و در خط اول، ۱۰۰ نقطه بین صفر تا $2\pi$  انتخاب می‌شود.  اگر تعداد نقاط مناسب نباشد، منحنی‌ها به‌شکل صاف و یکدست در شکل نمایش داده نخواهد شد و شکستگی خواهیم دید. عدد ۱۰۰ برای هدف ما مناسب است. در نهایت، تابع `plot()` را فرامی‌خوانیم تا `x`ها و `y`ها را در صفحهٔ مختصات $x-y$ ترسیم کند.

به‌عنوان تمرین، (و برای یادآوریِ بحثِ [مثال ۳-۲](matrix_book_fa_example3.2))، به این پرسش پاسخ دهید که آیا می‌توانید مقدار `length.out` را نیز به‌عنوان یک ورودی در `...` وارد کنید؟ همچنین، توضیح دهید که چرا نباید پارامترهای تابع `plot()` را در حالتی `new.plot=FALSE` است در `...` تعریف کنیم؟ 

با در دست داشتن ابزار رسم بیضی فوق، ایدهٔ اصلی آن است که بیضی‌هایی  در صفحهٔ مختصات رسم کنیم. سپس، تغییرات آن‌ها را به‌ازای تبدیل‌های خطی مختلف بررسی کنیم. موارد زیر را ملاحظه کنید:

### چرخش
 کد زیر و نتیجهٔ آن را ملاحظه کنید:

``` r
> axisXY <- c(2, 1)
> theta <- pi / 10
> A <- matrix(
+   data = c(cos(theta), sin(theta), -sin(theta), cos(theta)),
+   nrow = 2
+ )
> print(A)
```

```
#           [,1]       [,2]
# [1,] 0.9510565 -0.3090170
# [2,] 0.3090170  0.9510565
```

``` r
> plot.ellipse(
+   axisXY = axisXY,
+   lwd = 2, xlim = c(-1, 4), ylim = c(-1, 4)
+ )
> plot.ellipse(A,
+   col = "red", lty = 2, axisXY = axisXY,
+   new.plot = FALSE
+ )
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_linear_form_rotation-1.svg" style="display: block; margin: auto;" />

### بازتاب
 کد زیر و نتیجهٔ آن را ملاحظه کنید:


``` r
> m <- 1
> A <- 1 / (1 + m^2) *
+   matrix(
+     data = c(1 - m^2, 2 * m, 2 * m, m^2 - 1),
+     nrow = 2
+   )
> print(A)
```

```
#      [,1] [,2]
# [1,]    0    1
# [2,]    1    0
```

``` r
> plot.ellipse(
+   axisXY = axisXY, ylim = c(0, 5),
+   xlim = c(0, 5), lwd = 2
+ )
> plot.ellipse(A,
+   col = "red", lty = 2,
+   axisXY = axisXY,
+   new.plot = FALSE
+ )
> lines(c(-100, 100), m * c(-100, 100), lty = 3)
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_linear_form_reflection-1.svg" style="display: block; margin: auto;" />

### تغییر مقیاس
کد زیر و نتیجهٔ آن را ملاحظه کنید:


``` r
> A <- matrix(c(0.9, 0, 0, 1.5), nrow = 2)
> print(A)
```

```
#      [,1] [,2]
# [1,]  0.9  0.0
# [2,]  0.0  1.5
```

``` r
> plot.ellipse(
+   axisXY = axisXY, ylim = c(0, 5),
+   xlim = c(0, 5), lwd = 2
+ )
> plot.ellipse(A,
+   col = "red", lty = 2, axisXY = axisXY,
+   new.plot = FALSE
+ )
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_linear_form_scale-1.svg" style="display: block; margin: auto;" />
 



<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۶-۲: دایرهٔ واحد در صفحهٔ مختلط (تمرین برنامه‌نویسی)](matrix_book_fa_example6.2.html)
- [مثال ۷-۲: فرم درجهٔ دو (معرفی توابع گروه `apply()` و رسم یک تابع سه‌بعدی)](matrix_book_fa_example7.2.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)
