---
title: "مثال ۳-۳: نُرم یک بردار (معرفی برخی توابع و عملیات‌ها)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۳-۳: نُرم یک بردار (معرفی برخی توابع و عملیات‌ها)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۹۵ کتاب)**

محاسبهٔ ضرب داخلی با استفاده از نماد ضرب ماتریس‌ها یعنی `%*%` امکان‌پذیر است. همچنین، از این طریق می‌توان نُرم بردارها را محاسبه کرد. مثال زیر را ملاحظه کنید: 

``` r
> a <- c(2, 5, 6)
> b <- c(4, 3, 2)
> 
> a %*% b
```

```
#      [,1]
# [1,]   35
```

``` r
> sqrt(a %*% a) # norm of 'a'
```

```
#          [,1]
# [1,] 8.062258
```
نکتهٔ اول آنکه در اینجا، باز هم گرامر برنامه‌نویسی الزاماً با فرمول‌های نظریهٔ ماتریس سازگار نیست و انعطاف بیشتری وجود دارد، زیرا  به محاسبهٔ ترانهادهٔ بردار اول نیازی نیست. نکتهٔ دوم آنکه می‌توان در محاسبهٔ نُرم، از تابع `norm()` نیز استفاده کرد. کد زیر را ملاحظه کنید:

``` r
> norm(a, type = "2")
```

```
# [1] 8.062258
```



<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۳-۲: فضای برداری \\(\mathbb{R}^2\\) (رسم شکل)](matrix_book_fa_example3.2.html)
- [مثال ۳-۴: محاسبهٔ رتبه (یک راهکار برای مقایسهٔ کارایی دو تابع یا الگوریتم رقیب)](matrix_book_fa_example3.4.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)