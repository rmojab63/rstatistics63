---
title: "مثال ۴-۲: جمع دو چندجمله‌ای (معرفی مفاهیم `type`، `attribute`، و `class`)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۴-۲: جمع دو چندجمله‌ای (معرفی مفاهیم `type`، `attribute`، و `class`)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۱۶۸ کتاب)**

در **R**، ساختار پایه‌ای داده‌ها (به‌عبارت دیگر، نوع ذخیرهٔ اطلاعات)، به چند مورد محدود است:

- اعداد حقیقی (ذخیره `double` و نام `numeric`)،
- اعداد صحیح (ذخیره `int` و نام `integer`)،
- اعداد مختلط (ذخیره دو `double` و  نام `complex`)،
- بولی (نام `logical`)،
- کاراکتر (نام `character`)،
- لیست (نام `list`) یا بردار  (نام `named vector`)،
- جفت‌لیست (نام `pairlist`)،
- سه‌نقطه (`...`)،
- `NULL`،
- نام/نماد (نام `name/symbol`)،
- تابع (نام `function or function closure`)،
- محیط (نام `environment`).

به‌عبارت دیگر، شیءهایی که در **R** ایجاد می‌کنید، یکی از  انواع  فوق را دارد. در کنار نوع درونی ذخیرهٔ اطلاعات و معمولاً شیءهایی که ایجاد می‌شوند، اطلاعات دیگری با نام ویژگی یا `attributes` نیز دارند. از مهم‌ترین ویژگی‌های اشیاء در **R** می‌توان به `class`، `dim`، و `dimnames` اشاره کرد (جهت اطلاعات بیشتر، نگاه کنید به: <span dir="ltr">@writingRextensions2023</span>).

در **R**، بسیاری از توابع با توجه به ویژگی `class` ورودی‌ها تعریف می‌شوند. این‌ها با نام توابع عمومی (<span dir="ltr">generic function</span>) شناخته می‌شوند. چند مثال زیر را برای توضیح بیشتر مطرح می‌کنیم:

- در مثال‌های چندی نظیر [مثال ۱-۱](matrix_book_fa_example1.1)، از تابع `as.numeric()` استفاده شد. درواقع، `as()` یک تابع عمومی  است که وقتی با `.numeric` می‌آید، برخی از شی‌ءهای ورودی را به کلاس `numeric` تبدیل می‌کند (اگر کلاس شیء ورودی مناسب نباشد، خطا گزارش می‌شود).
- ‏`is()` نیز یک تابع عمومی است و مثلاً می‌توان از `is.numeric()` برای بررسی اینکه آیا کلاس شیء  از نوع `numeric` است، استفاده کرد.
- توابع `as.matrix()` و `is.matrix()` وجود دارند و می‌توان از آن‌ها برای بررسی ماتریس‌بودن شیء یا تبدیل برخی کلاس‌های دیگر، مثلاً `data.frame`، به ماتریس استفاده کرد. 
- در مثال [مثال ۶-۱](matrix_book_fa_example6.1)، خروجی یک تابع را به‌طور مستقیم به تابع `plot()`  می‌دهیم و نمودار رسم می‌شود. علت آن است که در بستهٔ نرم‌افزاری مورداستفاده، تابع عمومی `plot()` برای کلاس خروجی آن تابع تعریف شده است.
 
در ادامه، بحث را با تکیه بر موضوع ماتریس چندجمله‌ای بیشتر توضیح می‌دهیم. در **R**، یک شیء به‌عنوان ماتریس به رسمیت شناخته می‌شود، اما ماتریس چندجمله‌ای وجود ندارد (البته ممکن است این شیء در یک بستهٔ نرم‌افزاری تعریف شده باشد. درهرحال، اگر فراخوانی نکنیم، یعنی تعریف نشده است). در ادامه، می‌خواهیم این شیء را متناسب با نیاز خود تعریف کنیم. کد زیر را ملاحظه کنید:


``` r
> mpoly <- function(...) {
+   matrices <- list(...)
+   if (is.list(matrices[[1]])) {
+     matrices <- matrices[[1]]
+   }
+ 
+   attr(matrices, "degree") <- length(matrices)
+   attr(matrices, "size") <- nrow(matrices[[1]])
+   class(matrices) <- "mpoly"
+ 
+   matrices
+ }
```

در اینجا، تابعی با نام `mpoly` را تعریف می‌کنیم. منطق کد بسیار ساده است و توضیح نیاز ندارد. به‌عنوان تمرین، این تابع را کامل کنید؛ مطمئن شوید که همهٔ ماتریس‌های درون لیست، مربع و هم‌اندازه هستند. همچنین، اگر ماتریسی در انتهای لیست صفر است، آن را حذف کنید (در غیر این‌صورت، عملکرد تابع منطبق  با تعریف یک چندجمله‌ای در ۴-۲ در صفحهٔ ۱۲۵ در کتاب نیست). 

نوع ذخیرهٔ اطلاعات در آنچه توسط تابع فوق ارسال می‌شود، `list` است و عناصر آن `matrix` هستند. بااین‌حال، کلاس این تابع را `mpoly` نام‌گذاری کرده‌ایم. همچنین، دو ویژگی دیگر که در تعریف وجود داشت، یعنی درجه و اندازه را هم اضافه کرده‌ایم. این ویژگی‌ها را می‌توانیم به‌صورت اعضای لیست نیز وارد کنیم. رفتار `attribute` در کپی‌کردن بخشی از شیء متفاوت است. 

با در اختیار داشتن شیء فوق، می‌توانیم توابع مختلفی برای ماتریس چندجمله‌ای بنویسیم. مثال زیر را ملاحظه کنید:


``` r
> `+.mpoly` <- function(P, Q) {
+   stopifnot(class(P) == "mpoly" && class(Q) == "mpoly")
+   stopifnot(attr(P, "size") == attr(Q, "size"))
+ 
+   max_degree <- max(attr(P, "degree"), attr(Q, "degree"))
+   result <- vector("list", max_degree)
+   for (i in 1:max_degree) {
+     if (i <= length(P) && i <= length(Q)) {
+       result[[i]] <- P[[i]] + Q[[i]]
+     } else if (i <= length(P)) {
+       result[[i]] <- P[[i]]
+     } else {
+       result[[i]] <- Q[[i]]
+     }
+   }
+ 
+   mpoly(result)
+ }
```

در ابتدای تابع و با بررسی کلاس ورودی‌ها، عملاً مربع‌بودن و دیگر ویژگی‌هایی که در تابع `poly()` بررسی می‌شوند، بررسی کرده‌ایم (البته، بهتر آن است که از تابع `inherits` استفاده کنیم). همچنین، ویژگی‌های `size` و `degree` را از ورودی‌ها دریافت کرده‌ایم و این باعث می‌شود که بتوانیم ارتباط بهتری در کدنویسی و مباحث نظری برقرار کنیم. در نهایت، ازآنجاکه جمع دو ماتریس چندجمله‌ای، یک ماتریس چندجمله‌ای است، با فراخواندن  تابع `poly()`، کلاس و دیگر ویژگی‌های خروجی را ثبت کرده‌ایم.

اکنون، می‌توانیم از عملگر `+` برای دو ماتریس چندجمله‌ای استفاده کنیم. کد زیر را ملاحظه کنید:

``` r
> A <- matrix(c(1, 2, 3, 4), nrow = 2)
> B <- matrix(c(5, 6, 7, 8), nrow = 2)
> P <- mpoly(A, B)
> 
> P + P
```

```
# [[1]]
#      [,1] [,2]
# [1,]    2    6
# [2,]    4    8
# 
# [[2]]
#      [,1] [,2]
# [1,]   10   14
# [2,]   12   16
# 
# attr(,"degree")
# [1] 2
# attr(,"size")
# [1] 2
# attr(,"class")
# [1] "mpoly"
```

به‌عنوان تمرین، سعی کنید تابع عمومی `print` را برای این کلاس بنویسید، به‌طوری‌که نمایش مناسب‌تری از آن گزارش شود.



<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۴-۱: محاسبهٔ ریشه‌های چندجمله‌ای (محاسبات با اعداد مختلط)](matrix_book_fa_example4.1.html)
- [مثال ۵-۱: محاسبهٔ مقادیر ویژه (معرفی برخی توابع و عملیات‌ها و رسم نمودار)](matrix_book_fa_example5.1.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)