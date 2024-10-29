---
title: "مثال ۳-۵: افکنش متعامد و اریب یک بردار (رسم شکل)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۳-۵: افکنش متعامد و اریب یک بردار (رسم شکل)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۱۰۴ کتاب)**

با استفاده از تابع `plot.vector()` که در [مثال ۳-۲](matrix_book_fa_example3.2) نوشته شد، تبدیل خطی متن را پیاده‌سازی می‌کنیم. کد زیر ماتریس‌های تبدیل را معرفی می‌کند:

``` r
> vec <- c(1, 3)
> P1 <- matrix(c(1, 0, 1, 0), nrow = 2)
> P2 <- matrix(c(1, 0, 0, 0), nrow = 2)
```
اعمال تبدیل خطی موردنظر و رسم نمودارها شامل کد زیر است:


``` r
> plot.vector(newPlot = TRUE, xlim = c(0, 4), ylim = c(0, 3))
> plot.vector(vec, col = "black", label = "A")
> plot.vector(P1 %*% vec, col = "red", lwd = 2, label = "B")
> plot.vector(P2 %*% vec, col = "blue", lwd = 2, label = "C")
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_projection_ortho-1.svg" style="display: block; margin: auto;" />

با توجه به برچسب‌های انتخاب‌شده برای بردارها، بردارهای $B$ و $C$ افکنش بردار $A$ بر محور افقی هستند، افکنش $C$ متعامد، و افکنش $B$ اریب است.



<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۳-۴: محاسبهٔ رتبه (یک راهکار برای مقایسهٔ کارایی دو تابع یا الگوریتم رقیب)](matrix_book_fa_example3.4.html)
- [مثال ۳-۶: تجزیهٔ QR (اهمیت توجه به مجوز و حق تکثیر)](matrix_book_fa_example3.6.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)
