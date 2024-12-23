---
title: "مثال ۱۷-۲: نمونه‌گیری گیبس (تمرین کدنویسی)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۱۷-۲: نمونه‌گیری گیبس (تمرین کدنویسی)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۵۰۲ کتاب)**
 
با  پیشین نرمال-ویشارت، به توزیع پسین با نوع شناخته‌شده‌ای رسیدیم. در دو حالت پیشین پراکنده و پیشین نرمال-ویشارت مستقل، توزیع‌های پسین شرطی محاسبه شد.  توزیع شناخته‌شده این مزیت را دارد که اطلاعاتی از مقدار موردانتظار، واریانس، و دیگر ویژگی‌های آن‌ها داریم و بنابراین، تفسیر یا خلاصه‌کردن  آن نسبتاً ساده است. پرسش مهم آن است که توزیع‌های شرطی را چگونه  به اطلاعات قابل‌تفسیر تبدیل کنیم. الگوریتم نمونه‌گیری گیبس (<span dir="ltr">Gibbs sampling</span>) که در این مثال معرفی می‌شود، یکی از راه‌های یافتن چنین اطلاعاتی به‌صورت نمونه‌هایی از توزیع‌های غیرشرطی است. برای این منظور، از فرمول‌های۱۷-۲۶ (صفحهٔ ۵۰۱ در کتاب)، که برای پیشین نرمال-ویشارت مستقل به‌دست آمد، استفاده می‌کنیم. تابع زیر را ملاحظه کنید: 


``` r
> mvn.gibbs <- function(Y, psi0, mu0, nu0, s0, n_iter = 1000) {
+   N <- nrow(Y)
+   M <- ncol(Y)
+   samples <- array(NA, dim = c(n_iter, M, M + 1))
+ 
+   y_bar <- matrix(colMeans(Y), nrow = M)
+   lambda <- matrix(0, nrow = M, ncol = M)
+ 
+   for (i in 1:n_iter) {
+     psi1 <- psi0 + N * lambda
+     mu1 <- solve(psi1) %*% (psi0 %*% mu0 + N * lambda %*% y_bar)
+     mu <- MASS::mvrnorm(1, mu1, solve(psi1))
+ 
+     nu1 <- nu0 + N
+     s1 <- solve(solve(s0) + crossprod(Y - matrix(mu,
+       nrow = N,
+       ncol = M, byrow = TRUE
+     )))
+     lambda <- rWishart(1, nu1, s1)[, , 1]
+ 
+     samples[i, , ] <- cbind(mu, lambda)
+   }
+   return(samples)
+ }
```

ورودی‌های تابع (غیر از ماتریس داده‌ها و تعداد نمونه‌گیری `n_iter`)، ابرپارامترهای توزیع‌های پیشین هستند. در اینجا، مقابل نام این متغیرها صفر گذاشته‌ایم تا نمایانگر این موضوع باشند. در بخش اول تابع، فضایی برای ذخیره‌سازی اطلاعات در نظر می‌گیریم. حلقهٔ `for`، شامل به‌روزرسانی پارامترهای توزیع پسین و نمونه‌گیری از توزیع پسین شرطی، حرکت به‌سمت پارامتر دیگر و به‌روزرسانی و نمونه‌گیری، ذخیرهٔ نمونه‌ها، و سپس تکرار این مراحل است. اگر دقت کنید، از نمونهٔ `mu` در توزیع به‌روزرسانی‌شده، در به‌روزرسانی پارامترهای توزیع دوم و سپس در  تکرار بعد، از نمونهٔ `lambda` در به‌روزرسانی توزیع اول استفاده می‌کنیم. نکات دیگری به شرح زیر مطرح است:

- ازآنجاکه نمونه‌گیری را با `mu` آغاز می‌کنیم، پارامترهای توزیع پسین شرطی این متغیر نیازمند مقداری برای شرط یعنی `lambda` است. اگر به دو معادلهٔ اول در ۱۷-۲۶ (صفحهٔ ۵۰۱ در کتاب) دقت کنید، ماتریس صفر یعنی در اولین تکرار از توزیع پیشین نمونه گرفته می‌شود.
- محاسبهٔ معکوس ماتریس‌ها در مسائل کاربردی بزرگ‌تر می‌تواند مسئله‌ساز باشد. در این زمینه، الگوریتم‌های پایدارتر مثلاً، برای تضمین آنکه  خاصیت مثبت‌معین بودن ماتریس‌های دقت، به‌دلیل خطاهای محاسباتی از بین نمی‌رود، لازم است.
- عملیات‌های تکراری را می‌توان از حلقهٔ `for` خارج  و کد را کاراتر کرد. همچنین، به یاد  داشته باشید که نمونه‌گیری ظرافت‌های بسیار دیگری نیز دارد که خارج از این بحث  است. واضح‌ترین آن‌ها اینکه بهتر است نمونه‌های اولیه را کنار بگذاریم و همچنین از هر چند نمونه، یکی را برای کاهش همبستگی بین آن‌ها ذخیره کنیم.

برای این مثال، از داده‌هایی که پیش‌تر در [مثال ۱۲-۳](matrix_book_fa_example12.3)  بحث شد، استفاده می‌کنیم. کد زیر میانگین و واریانس این داده‌ها را نشان می‌دهد:

``` r
> Y <- as.matrix(datasets::mtcars[, c("mpg", "cyl")])
> colMeans(Y)
```

```
#      mpg      cyl 
# 20.09062  6.18750
```

``` r
> cov(Y)
```

```
#           mpg       cyl
# mpg 36.324103 -9.172379
# cyl -9.172379  3.189516
```
هدف در اینجا صرفاً یک بررسی عددی است و بنابراین توضیحات نظری را کنار می‌گذاریم. فرض کنید پیشین از حدس و گمان ایجاد شده و اطمینان زیادی نسبت به آن داریم. درواقع، می‌خواهیم میانگین و واریانس توزیع پسین زیاد تحت‌تأثیر داده‌ها قرار نگیرد. مقادیر زیر را ملاحظه کنید:

``` r
> psi0 <- diag(2) * 10^6
> mu0 <- c(2, 2)
> nu0 <- 1
> s0 <- diag(2)
> 
> samples <- mvn.gibbs(Y, psi0, mu0, nu0, s0)
> print(apply(samples, c(2, 3), mean))
```

```
#          [,1]         [,2]        [,3]
# [1,] 2.000025  0.007035541 -0.02273349
# [2,] 1.999971 -0.022733486  0.12401883
```
ارزش `psi0` ماتریس دقت پیشین است و آن را بزرگ انتخاب کرده‌ایم. این وزن زیادی به میانگین پیشین در محاسبهٔ میانگین پسین می‌دهد. در نتایج،  ستون اول نزدیک به ارزش‌های پیشین است. در مثال فوق، ارزش 1 برای ابرپارامتر `nu0` انتخاب کرده‌ایم؛ این یعنی میانگین توزیع شرطی پسین برابر با `s1` است. بااین‌حال، `s1` از `s0` فاصله خواهد داشت، زیرا پیشینی که به آن اطمینان داریم، به نمونه‌هایی برای `mu` می‌انجامد که از مشاهدات فاصله دارند. بنابراین، `s1` کوچک‌تر می‌شود تا به‌گونه‌ای این «فاصله» و «نااطمینانی»  منعکس شود. پس، در نتیجهٔ نهایی، دقت کم گزارش می‌شود. 

فرض کنید هدف آن است تا در محاسبات نهایی دقت نسبتاً زیادی گزارش شود. انتخاب ارزش زیاد برای `s0` گزینهٔ خوبی نیست، زیرا این ماتریس در ابتدا  (معادلهٔ ۴ در ۱۷-۲۶، صفحهٔ ۵۰۱ در کتاب) معکوس می‌شود و به یک ماتریس واریانس تبدیل می‌شود. از این جهت، ارزش زیاد برای این ماتریس بیشتر «نبود نااطمینانی» است تا «وجود دقت زیاد». برای درک بیشتر، حالتی که معکوس این ماتریس صفر است، بررسی کنید. گزینهٔ دیگر، افزایش ارزش `nu0` است. این مقدار موردانتظار توزیع پسین شرطی و هم‌زمان، واریانس درایه‌‌های ماتریس را زیاد می‌کند. بنابراین، ارزش‌های بالاتری برای `lambda` به‌دست می‌آید. البته، این ارزش‌ها می‌تواند به فاصله‌گرفتن بیشتر میانگین  از پیشین  بینجامد. برای بررسی کمّ‌وکیف این تغییرات، کد زیر و نتیجهٔ آن را ملاحظه کنید:

``` r
> nu0 <- 10^4
> 
> samples <- mvn.gibbs(Y, psi0, mu0, nu0, s0)
> print(apply(samples, c(2, 3), mean))
```

```
#          [,1]      [,2]      [,3]
# [1,] 2.000277  2.145410 -6.945337
# [2,] 2.001026 -6.945337 37.661259
```

	


<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۱۷-۱: توزیع معکوس یک متغیر تصادفی (درک مفهوم با استفاده از کدنویسی)](matrix_book_fa_example17.1.html)
- [مثال ۲-۱: محاسبهٔ ترانهاده، دترمینان، و اثر (معرفی برخی توابع و عملیات‌ها)](matrix_book_fa_example2.1.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)
