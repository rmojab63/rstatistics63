---
title: "مثال ۳-۱: بررسی استقلال و وابستگی خطی (تفاوت صفر در ریاضیات و صفر در محاسبات)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۳-۱: بررسی استقلال و وابستگی خطی (تفاوت صفر در ریاضیات و صفر در محاسبات)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۷۵ کتاب)**

برای بررسی استقلال یا وابستگی خطی چند بردار در **R**، تابع پیش‌فرضی وجود ندارد. راهکار مناسب استفاده از تابع `qr()` است. بااین‌حال، ازآنجاکه هنوز به مبانی نظری این تابع نپرداخته‌ایم، در یک راهکار دیگر از تابع `gaussian.elimination()` که در [مثال ۲-۳](matrix_book_fa_example2.3) مطرح شد استفاده می‌کنیم. در مثال زیر ابتدا بردارها را با تابع `rbind()` به یک ماتریس تبدیل و فرم ردهٔ سطری آن را محاسبه می‌کنیم:

``` r
> v1 <- c(1, 2, 3, 5)
> v2 <- c(5, 6, 7, 8)
> v3 <- 2 * v1 + 4
> A <- rbind(v1, v2, v3)
> gaussian.elimination(A)
```

```
#    [,1]     [,2]          [,3]      [,4]
# v1    1 1.333333  1.666667e+00  2.333333
# v2    0 1.000000  2.000000e+00  4.000000
# v3    0 0.000000 -1.998401e-15 -1.000000
```
اگر همهٔ ستون‌ها محوری باشند، آنگاه بردارها مستقل خطی و در غیر این‌صورت، وابستهٔ خطی هستند. ستون سوم در اینجا محوری نیست. توجه کنید همان‌طور که در [مثال ۲-۳](matrix_book_fa_example2.3) نیز توضیح داده شد، مقایسهٔ اعداد در کامپیوتر متفاوت با ریاضیات است و باید سطح حداکثر خطایی در نظر گرفت.
	


<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۲-۵: ادامهٔ تجزیهٔ LU (استفاده از یک بستهٔ نرم‌افزاری در سیستم `S4`)](matrix_book_fa_example2.5.html)
- [مثال ۳-۲: فضای برداری \\(\mathbb{R}^2\\) (رسم شکل)](matrix_book_fa_example3.2.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)