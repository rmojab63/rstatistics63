---
title: "مثال ۶-۱: درون‌یابی چندجمله‌ای (تمرین برنامه‌نویسی)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۶-۱: درون‌یابی چندجمله‌ای (تمرین برنامه‌نویسی)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۲۰۹ کتاب)**

درون‌یابی چندجمله‌ای فرایند پیچیده‌ای نیست و می‌توان کد آن را نوشت. بااین‌حال در این مثال، از بستهٔ `polynom` <span dir="ltr">(Venables, Hornik, and Maechler, 2022)</span> استفاده می‌کنیم. کد زیر را ملاحظه کنید:


``` r
> x <- c(0, 2, 3, 4)
> y <- c(7, 2, 2, -1)
> plot(polynom::poly.calc(x, y), xlim = c(-1, 6))
> points(x, y, col = "red", pch = 19)
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_polynom-1.svg" style="display: block; margin: auto;" />
کدهای فوق نکتهٔ بیان‌نشده‌ای ندارند.   نمودار با استفاده از تابع `plot()` و `points()` ترسیم شده است. فقط توجه کنید که ورودی تابع `plot()`، عدد و رقم نیست، بلکه خروجی تابع `poly.calc()` است.  در [مثال ۴-۲](matrix_book_fa_example4.2)، توضیحاتی در این زمینه ارائه شد.

به‌عنوان تمرین، کد فوق را تغییر دهید و چندجمله‌ای را بر اساس ریشه‌های آن رسم کنید؛ یعنی یک چندجمله‌ای  رسم کنید که از نقاط $(x_i,0)$ به‌ازای برخی مقادیر برای  $x_i$ می‌گذرد. اکنون، اگر بخواهید یک چندجمله‌ای که در یک نقطه ریشهٔ مضاعف دارد، مثلاً $\operatorname{f}(x)=(x-1)^2$ را رسم کنید، چه می‌توان کرد؟ به‌نظر شما، آیا روش لاگرانژ یا نیوتون این نکته را لحاظ می‌کنند؟

	


### References

[1] B. Venables, K. Hornik, and M. Maechler. _polynom: A Collection of Functions
to Implement a Class for Univariate Polynomial Manipulations_. R package version
1.4-1. 2022. <https://CRAN.R-project.org/package=polynom>.


<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۵-۴: محاسبهٔ بردارهای ویژهٔ تعمیم‌یافته (تفاوت حل عددی و حل نمادی)](matrix_book_fa_example5.4.html)
- [مثال ۶-۲: دایرهٔ واحد در صفحهٔ مختلط (تمرین برنامه‌نویسی)](matrix_book_fa_example6.2.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)
