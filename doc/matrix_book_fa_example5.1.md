---
title: "مثال ۵-۱: محاسبهٔ مقادیر ویژه (معرفی برخی توابع و عملیات‌ها و رسم نمودار)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۵-۱: محاسبهٔ مقادیر ویژه (معرفی برخی توابع و عملیات‌ها و رسم نمودار)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۱۷۵ کتاب)**

محاسبهٔ مقادیر و بردارهای ویژهٔ یک ماتریس در **R**، با استفاده از تابع `eigen()` انجام می‌شود. کد زیر را ملاحظه کنید:

``` r
> A <- matrix(c(2, 1, 2, 3), nrow = 2)
> eigen(A)$value
```

```
# [1] 4 1
```
دقت کنید که مقادیر ویژه از بزرگ به کوچک منظم شده‌اند. اکنون، با استفاده از تابع `plot.vector()` که در [مثال ۳-۲](matrix_book_fa_example3.2) نوشته شد، ماتریس را در سه بردار ($(1,1)'$، $(-2,1)'$، و $(1,-2)'$) ضرب می‌کنیم، این بردارها و بردارهای حاصل را ترسیم می‌کنیم:


``` r
> plot.vector(newPlot = TRUE, xlim = c(-5, 5), ylim = c(-5, 5))
> plot.vector(c(1, 1), col = "black", label = "A", lwd = 3)
> plot.vector(A %*% c(1, 1), col = "black", label = "A*")
> plot.vector(c(-2, 1), col = "red", label = "B", lwd = 3)
> plot.vector(A %*% c(-2, 1), col = "red", label = "B*")
> plot.vector(c(1, -2), col = "blue", label = "C", lwd = 3)
> plot.vector(A %*% c(1, -2), col = "blue", label = "C*")
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_eigen-1.svg" style="display: block; margin: auto;" />

بردارهایی که از ضرب حاصل می‌شوند، با علامت «*» در کنار نام آن‌ها مشخص کرده‌ایم.  مقادیر ویژه   ماتریس $4$ و $1$ است. همان‌طور که در شکل نیز مشخص است، ضرب ماتریس در  یکی از آن بردارها همانند آن است که بردار در $4$ ضرب می‌کنیم، در یکی دیگر بردار تغییر نمی‌کند (در $1$ ضرب می‌شود) و در نهایت، در یکی راستای بردار   تغییر می‌کند.


<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۴-۲: جمع دو چندجمله‌ای (معرفی مفاهیم `type`، `attribute`، و `class`)](matrix_book_fa_example4.2.html)
- [مثال ۵-۲: تجزیهٔ ویژه (مسئولیت اشتباهات)](matrix_book_fa_example5.2.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)
