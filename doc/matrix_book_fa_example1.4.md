---
title: "مثال ۱-۴: ضرب و معکوس ماتریس (معرفی برخی توابع و عملیات‌ها)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۱-۴: ضرب و معکوس ماتریس (معرفی برخی توابع و عملیات‌ها)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۲۹ کتاب)**

اگر `a` یک اسکالر و `A` و `B` دو ماتریس باشند که در **R** تعریف شده‌اند، ضرب اسکالر با دستور `a * A` و ضرب دو ماتریس با دستور `A %*% B` انجام می‌شود. مثال زیر را ملاحظه کنید:

``` r
> A <- matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2)
> B <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2, ncol = 3)
> a <- 3
> a * A
```

```
#      [,1] [,2]
# [1,]    3    9
# [2,]    6   12
```

``` r
> A %*% B
```

```
#      [,1] [,2] [,3]
# [1,]    7   15   23
# [2,]   10   22   34
```
اندازهٔ ماتریس‌ها باید مطابق با تعریف ضرب ماتریس‌ها سازگار باشند (که البته در این مثال هستند). به‌عنوان تمرین، با استفاده از ضرب ماتریس‌ها در **R** نشان دهید که «توان سوم یک ماتریس بالامثلثی یک ماتریس بالامثلثی است». مراقب باشید که در حل این تمرین از علامت `^` استفاده نکنید. در **R**، عملیات‌های بسیاری تعریف می‌شود که الزاماً تعریفی برای آن‌ها در نظریهٔ ماتریس وجود ندارد؛ مثلاً، شما می‌توانید همان‌گونه که دو ماتریس را با `+` جمع کردید، درایه‌های نظیر به نظیر دو ماتریس را با `*` یا `/` به‌ترتیب در یکدیگر ضرب و بر یکدیگر تقسیم کنید. درایه‌های یک ماتریس  با استفاده از نماد `^` به توان می‌رسند.

برای محاسبهٔ معکوس یک ماتریس، از تابع `solve()` استفاده می‌کنیم. مثال زیر را ملاحظه کنید:

``` r
> A <- matrix(c(3.5, 1, 1, 3.2), nrow = 2, ncol = 2)
> B <- solve(A)
> all.equal(diag(2), A %*% B)
```

```
# [1] TRUE
```
در خط سوم مطابق با تعریف معکوس، صحت انجام عملیات را بررسی کرده‌ایم. به‌عنوان تمرین، نشان دهید که `A^(-1)` معکوس ماتریس نیست، بلکه ماتریسی است که درایه‌های آن معکوس شده است. همچنین، تابع `solve()` برای حل دستگاه معادلات استفاده می‌شود. در فصل ۹ (صفحهٔ ۲۷۷ در کتاب)، به این موضوع خواهیم پرداخت.

به یاد داشته باشید که انجام دستوراتی که شامل اعداد حقیقی می‌شوند، به‌دلیل تجمیع‌شدن خطاهای گردشدن اعداد، در نهایت با آنچه از ریاضیات برداشت می‌شود متفاوت‌اند؛ مثلاً، به کد زیر و پیغامی که ایجاد می‌شود، دقت کنید:

``` r
> all.equal(diag(2), A %*% solve(A), tolerance = 0)
```

```
# [1] "Mean relative difference: 1.665335e-16"
```
به‌عنوان تمرین، بررسی کنید که هرچه اندازهٔ ماتریس بزرگ‌تر می‌شود، فاصلهٔ نتیجهٔ محاسبات از نتیجهٔ نظری بیشتر می‌شود. همچنین، توجه کنید که [مثال ۹-۲](matrix_book_fa_example9.2) به بحث مرتبطی می‌پردازد و جزئیات بیشتری از الگوریتم‌های مورداستفاده ارائه می‌کند.


<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۱-۳: جمع دو ماتریس (نوشتن یک تابع)](matrix_book_fa_example1.3.html)
- [مثال ۱-۵: افراز ماتریس‌ها (ارزش‌گذاری و ارزش‌گیری از زیرمجموعه‌ای از درایه‌های یک ماتریس)](matrix_book_fa_example1.5.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)
