---
title: "مثال ۱۳-۲: مدل رگرسیون خطی چندگانه (معرفی تابع عمومی `summary()`)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۱۳-۲: مدل رگرسیون خطی چندگانه (معرفی تابع عمومی `summary()`)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۳۵۷ کتاب)**

در این مثال، با استفاده از مجموعه دادهٔ `mtcars` که در [مثال ۱۲-۳](matrix_book_fa_example12.3) از آن صحبت شد، به تخمین یک رگرسیون چندگانه تحت فروض کلاسیک مطرح‌شده می‌پردازیم. تابع موردنیاز، `lm()` نام دارد. برای استفاده از این تابع، از یک «عبارت» که در [مثال ۸-۱](matrix_book_fa_example8.1) معرفی شد، استفاده می‌کنیم. دستور زیر را ملاحظه کنید:

``` r
> model <- lm(mpg ~ hp + cyl, data = datasets::mtcars)
```
عبارت `mpg ~ hp + cyl` به‌معنی آن است که مقدار میانگین شرطی `mpg`، تابع خطی از `hp` و `cyl` است. این‌ها، نام ستون‌هایی در ورودی `data` هستند. به‌عبارت ساده‌تر، با دستور فوق، بر پایهٔ نمونهٔ `mtcars`، اصطلاحاً `mpg` را بر `hp` و `cyl` رگرس کرده‌ایم. 

اکنون، می‌خواهیم نتیجهٔ تخمین را گزارش کنیم.  کد زیر و نتیجهٔ آن را ملاحظه کنید:

``` r
> summary(model)
```

```
# 
# Call:
# lm(formula = mpg ~ hp + cyl, data = datasets::mtcars)
# 
# Residuals:
#     Min      1Q  Median      3Q     Max 
# -4.4948 -2.4901 -0.1828  1.9777  7.2934 
# 
# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 36.90833    2.19080  16.847  < 2e-16 ***
# hp          -0.01912    0.01500  -1.275  0.21253    
# cyl         -2.26469    0.57589  -3.933  0.00048 ***
# ---
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 3.173 on 29 degrees of freedom
# Multiple R-squared:  0.7407,	Adjusted R-squared:  0.7228 
# F-statistic: 41.42 on 2 and 29 DF,  p-value: 3.162e-09
```

همان‌طور که در [مثال ۴-۲](matrix_book_fa_example4.2) توضیح داده شد، منطق تابع عمومی به  کلاس ورودی آن وابسته است. کلاس `model` در اینجا `lm` است. تابع `summary()` از پرکاربردترین توابع عمومی است و معمولاً، به‌معنی یک رویکرد دومرحله‌ای در به‌دست‌آوردن نتایج یک تحلیل است؛ مثلاً در اینجا، این تابع نتایج خروجی تابع `lm()` را بسط می‌دهد و آماره‌های دیگری را محاسبه می‌کند. توجه کنید که در اینجا، به‌طور ضمنی، تابع عمومی `print()` برای نتیجهٔ این تابع فراخوانی می‌شود.

به‌عنوان تمرین، تفاوت نتایج دو خط کد زیر را با یکدیگر مقایسه  و علت را پیدا کنید.

``` r
> lm(mpg ~ cyl + hp + I(hp^2), data = mtcars)
> lm(mpg ~ cyl + hp + hp^2, data = mtcars)
```

به یاد  داشته باشید که هدف اصلی در اینجا توضیح فرایند مدل‌سازی آماری نیست، زیرا  آن پیچیدگی‌ها و ظرافت‌های بسیاری دارد و البته، ابزارهای لازم را  هنوز به‌طور کامل معرفی نکرده‌ایم.



<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۱۳-۱: ماتریس افکنش در حداقل مربعات معمولی (اضافه‌کردن شرح در نمودار)](matrix_book_fa_example13.1.html)
- [مثال ۱۳-۳: تخمین مدل معادلات هم‌زمان (مفهوم صادرشدن اشیاء از یک بستهٔ نرم‌افزاری)](matrix_book_fa_example13.3.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)
