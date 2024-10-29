---
title: "مثال ۳-۲: انجام فرایند حذف گاوسی (توضیح حلقهٔ `for`)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۳-۲: انجام فرایند حذف گاوسی (توضیح حلقهٔ `for`)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۵۹ کتاب)**

در **R**، به‌طور پیش‌فرض تابعی برای حذف گاوسی و به‌دست‌آوردن فرم ردهٔ سطری وجود ندارد. با توجه به سادگی، نوشتن کد آن تمرین مناسبی است. کد زیر را ملاحظه کنید:

``` r
> #' Perform Gaussian elimination on a matrix
> #'
> #' @param A matrix to perform Gaussian elimination on
> #' @return matrix obtained by Gaussian elimination
> gaussian.elimination <- function(A) {
+   n <- nrow(A)
+   m <- ncol(A)
+ 
+   # Perform Gaussian elimination to obtain
+   #    an upper triangular matrix:
+   for (k in 1:min(n, m)) {
+     # Find the row with the largest absolute value
+     #    in column k below the current row:
+     mr <- which.max(abs(A[k:n, k])) + k - 1
+     if (k != mr) {
+       # Swap the current row with the row
+       #    with the largest absolute value:
+       A[c(k, mr), ] <- A[c(mr, k), ]
+     }
+     # Check if the pivot element is nonzero:
+     if (abs(A[k, k]) > 1e-14) {
+       # Divide the current row by the pivot element; make it 1:
+       A[k, ] <- A[k, ] / A[k, k]
+       if (k < n) {
+         for (i in (k + 1):n) {
+           # Subtract a multiple of row k from row i
+           #    to eliminate the entry in column k:
+           A[i, ] <- A[i, ] - A[k, ] * A[i, k]
+         }
+       }
+     }
+   }
+   A
+ }
```
کد فوق حاوی مثالی از حلقهٔ `for` در **R** است. در آن، `k` عدد صحیح است که ارزش‌های `1` تا `min(n, m)` را به خود می‌گیرد. در هر تکرار حلقه، مجموعهٔ دستورات درون حلقه اجرا می‌شود. همچنین، استفاده از تابع `abs()` برای محاسبهٔ ارزش قدرمطلق و مقایسهٔ آن با عدد `1e-14` است. این، به‌جای فرمول `if (A[k, k] != 1e-14)` استفاده شده است و به‌دلیل وجود خطاهای گردشدن اعداد در کامپیوتر، رویکرد معمول و البته ضروری در مقایسهٔ اعداد محاسباتی با یکدیگر است. این شرط تضمین می‌کند که تقسیم در خط بعد بر عددی نزدیک به صفر صورت نگیرد. مثال زیر نتیجهٔ استفاده از این تابع است:

``` r
> A <- matrix(c(0, runif(11, -9, 9)), nrow = 3)
> gaussian.elimination(A)
```

```
#      [,1]      [,2]       [,3]       [,4]
# [1,]    1 0.4184135  0.5354895 -0.4259793
# [2,]    0 1.0000000 -0.0882767 -0.6137780
# [3,]    0 0.0000000  1.0000000 -0.2189696
```
می‌توانید بررسی کنید که نتیجه در فرم ردهٔ سطری قرار دارد. به‌عنوان تمرین، کدی بنویسید که فرم ردهٔ سطری کاهش‌یافته ایجاد می‌کند. در نهایت، توجه کنید که در بسته‌های نرم‌افزاری دیگر راهکارهای جایگزین و کامل‌تری وجود دارد.
	


<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۲-۲: محاسبهٔ یک ماتریس مقدماتی تصادفی (توضیح بلوک `if-else`)](matrix_book_fa_example2.2.html)
- [مثال ۲-۴: تجزیهٔ LU (نیاز به بسته‌های بیرونی و معرفی CRAN)](matrix_book_fa_example2.4.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)
