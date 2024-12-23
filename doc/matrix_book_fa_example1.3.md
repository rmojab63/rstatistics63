---
title: "مثال ۱-۳: جمع دو ماتریس (نوشتن یک تابع)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۱-۳: جمع دو ماتریس (نوشتن یک تابع)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۱۹ کتاب)**

برای جمع‌کردن دو یا چند ماتریس در **R**، کافی است از علامت `+` بین آن‌ها استفاده کنیم. برای آنکه با  مفهوم و ساختار یک تابع یا `function` در **R** آشنا شویم، این عملیات را با نوشتن یک تابع انجام می‌دهیم. کد زیر را ملاحظه کنید:

``` r
> matrix.sum <- function(A, B) {
+   stopifnot(dim(A) == dim(B))
+   C <- A + B
+   C # return result
+ }
```
این تابع در حالت کلی  با آنچه تاکنون با نام‌های `matrix()`، `all()`، و غیره استفاده کرده‌ایم، متفاوت نیست. دارای نام `matrix.sum` است. این  نام مناسبی به‌نظر می‌آید، زیرا نام باید تا حد ممکن تابع را معرفی کند. ورودی‌های تابع  پس از کلیدواژهٔ `function` لیست می‌شود. بدنهٔ تابع درون دو کروشه، یعنی به‌جای سه‌نقطه در نمایش `\{...\}` قرار می‌گیرد.

یک تابع باید در ابتدا شروط موردنیاز خود را بررسی کند و در صورت رعایت‌نشدن آن‌ها، عملیات را متوقف کند و خطاها یا اخطارهایی را به استفاده‌کننده بدهد. در خط اول تابع، از دستور `stopifnot()` استفاده شده است. این دستور، متن خطا را در صورت برقرارنبودن شرط ورودی، به‌طور خودکار تولید می‌کند. در اینجا، چک می‌شود تا جمع مطابق با تعریف جمع ماتریس‌ها باشد. پس از بررسی شروط لازم، دستورات اصلی تابع برای رسیدن به خروجی نوشته می‌شود. در اینجا در خط دوم، دو ماتریس ورودی را با یکدیگر جمع کرده‌ایم. در نهایت، خروجی تابع معرفی می‌گردد. مناسب است که توضیحاتی برای دستورات مختلف،  قبل از اجرای دستور یا در همان خط مقابل دستور ارائه شود. توضیح یا comment در **R**، پس از نماد  `#` نوشته می‌شود. یک توضیح توسط نرم‌افزار اجرا نمی‌شود. در خط آخر، یک نمونه از این توضیحات نوشته شده است. در مثال زیر، از تابع فوق   استفاده می‌کنیم:

``` r
> A <- matrix(1, 2, 2)
> matrix.sum(A, A)
```

```
#      [,1] [,2]
# [1,]    2    2
# [2,]    2    2
```
به یاد  بسپارید که تابع باید در محیط تعریف شود. این کار را می‌توانید با اجراکردن خط اول تابع یا با `source` کردن فایلی که حاوی این تابع است، انجام دهید. محیط `RStudio` برای استفاده از دستور `source` گزینه‌هایی مناسبی دارد. همچنین، برای آنکه تابع کامل شود، حداقل دو گام دیگر نیز نیاز است: اولاً، شما باید این تابع را معرفی کنید. این شامل معرفی ورودی‌های تابع، منطق آن، خروجی‌های آن،‌ ارائهٔ مثال، و غیره می‌شود. استفاده از بستهٔ `Roxygen` گزینهٔ استانداردی است. کد زیر و توضیحاتی که بعد از علامت `#` آمده است، مطالعه کنید:

``` r
> #' Sum of two matrices
> #'
> #' This function takes two matrices as input and returns their sum.
> #'
> #' @param A A matrix
> #' @param B A matrix
> #' @return The sum of matrices A and B
> #' @examples
> #' A <- matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2)
> #' B <- matrix(c(5, 6, 7, 8), nrow = 2, ncol = 2)
> #' matrix.sum(A, B)
> matrix.sum <- function(A, B) {
+   stopifnot(dim(A) == dim(B))
+   C <- A + B
+   C
+ }
```
دوم، تابع باید آزمون شود تا مطمئن شوید رفتار خلاف انتظاری ندارد. در این زمینه، گزینهٔ معمول استفاده از بستهٔ `testthat` است.


<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۱-۲: شناسایی نوع ماتریس‌ها (ادامهٔ مقدمه‌ای بر برنامه‌نویسی)](matrix_book_fa_example1.2.html)
- [مثال ۱-۴: ضرب و معکوس ماتریس (معرفی برخی توابع و عملیات‌ها)](matrix_book_fa_example1.4.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)
