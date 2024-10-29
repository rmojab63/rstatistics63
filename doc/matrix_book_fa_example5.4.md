---
title: "مثال ۵-۴: محاسبهٔ بردارهای ویژهٔ تعمیم‌یافته (تفاوت حل عددی و حل نمادی)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۵-۴: محاسبهٔ بردارهای ویژهٔ تعمیم‌یافته (تفاوت حل عددی و حل نمادی)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۱۹۱ کتاب)**

یک راه برای محاسبهٔ بردارهای ویژهٔ تعمیم‌یافته در **R**، استفاده از تابع `geigen()` در بستهٔ `geigen` <span dir="ltr">(Hasselman and Lapack authors, 2019)</span> است. این بسته را نصب کنید و کد زیر را به‌عنوان ادامهٔ کد [مثال ۵-۲](matrix_book_fa_example5.2) در نظر بگیرید:


``` r
> A <- matrix(c(1, -1, 2, -3, 1, 4, -2, -1, 5), nrow = 3)
> R <- geigen::geigen(A, diag(nrow(A)))
> R$values
```

```
# [1] 2 2 3
```

``` r
> R$vectors
```

```
#      [,1] [,2]         [,3]
# [1,]  0.5  0.5 -1.00000e+00
# [2,]  0.5  0.5 -1.43987e-15
# [3,] -1.0 -1.0  1.00000e+00
```

``` r
> qr(R$vectors)$rank
```

```
# [1] 2
```

برخلاف تابع `eigen()`، در اینجا محاسبات اعداد مختلط گزارش نمی‌کنند، اما حل تحلیلی و این نتایج گزارش‌شده متفاوت است و رتبهٔ ماتریس بردارهای ویژهٔ تعمیم‌یافته نیز کامل نیست. از دید نظریه، بردارهای ویژهٔ تعمیم‌یافتهٔ این ماتریس عبارتند از $(-1,-1,2)'$، $(1,0,0)'$، و $(-1,0,1)'$. این موضوع اهمیت محاسبات نمادی یا symbolic را در این‌گونه مسائل  نشان می‌دهد.

توجه کنید که مسئلهٔ مقدار ویژهٔ تعمیم‌یافته‌ای که  تابع `geigen()` حل می‌کند به‌صورت $\mathbf{Ax}=\lambda\mathbf{Bx}$ است و ماتریس‌های $\mathbf{A}$ و $\mathbf{B}$ ورودی‌های اول و دوم تابع‌اند. به همین دلیل، ماتریس دوم را به‌صورت ماتریس یکه تعریف کرده‌ایم.  


### References

[1] B. Hasselman and Lapack authors. _geigen: Calculate Generalized Eigenvalues,
the Generalized Schur Decomposition and the Generalized Singular Value
Decomposition of a Matrix Pair with Lapack_. R package version 2.3. 2019.
<https://CRAN.R-project.org/package=geigen>.


<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۵-۳: ادامهٔ تجزیهٔ ویژه (انباشت خطای گردشدن اعداد و مشکلات ناشی از آن‌ها)](matrix_book_fa_example5.3.html)
- [مثال ۶-۱: درون‌یابی چندجمله‌ای (تمرین برنامه‌نویسی)](matrix_book_fa_example6.1.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)
