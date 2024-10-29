---
title: "مثال ۱۵-۱: حل یک مسئلهٔ مقدار اولیه (معرفی برخی توابع و فرایندها)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۱۵-۱: حل یک مسئلهٔ مقدار اولیه (معرفی برخی توابع و فرایندها)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۴۲۰ کتاب)**

برای حل معادلات دیفرانسیل در **R**، می‌توان از بستهٔ نرم‌افزاری `deSolve` <span dir="ltr">(Soetaert, Petzoldt, and Setzer, 2023)</span> و تابع `ode()` استفاده کرد.  تابع `ode()`،  به جواب عمومی معادله نیاز ندارد. یکی از ورودی‌های آن با نام `func`، معادلهٔ دیفرانسیل را تعریف می‌کند. برای یک معادلهٔ دیفرانسیل خطی مرتبهٔ اول، تابع زیر را تعریف می‌کنیم:

``` r
> f_ode <- function(t, y, parms) {
+   f_t <- parms[["f_t"]]
+   g_t <- parms[["g_t"]]
+   list(-f_t(t) * y + g_t(t))
+ }
```
ساختار این تابع باید ورودی‌های `t` (به‌عنوان زمان) و `y` (به‌عنوان بردار متغیرها) را داشته باشد. در اینجا `f_t` و `g_t` پارامترهای اختیاری هستند که با توجه به فرمول ۱۵-۱ (صفحهٔ ۴۱۹ در کتاب) وجود دارند. خروجی تابع نیز باید یک `list` باشد. اولین عضو آن باید بردار مشتق‌های اول `y` نسبت به زمان باشد. در کد زیر، معادله را برای مجموعه‌ای از فروض و یک شرط اولیهٔ مشخص حل و ترسیم می‌کنیم:


``` r
> y0 <- 0.5
> tspan <- seq(0, 10, by = 0.01)
> sol <- deSolve::ode(
+   y = y0, times = tspan, func = f_ode,
+   parms = list(
+     f_t = function(t) {
+       t^2
+     },
+     g_t = function(t) {
+       1
+     }
+   )
+ )
> plot(sol, main = "", xlab = "t", ylab = "y(t)")
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_differential-1.svg" style="display: block; margin: auto;" />

به‌عنوان تمرین، جواب را وقتی $f(t)=0$ و $g(t)=\cos(t)$ است، ترسیم کنید. آیا می‌توانید جواب عمومی را با مشاهدهٔ مسیر حرکت زمانی متغیر حدس بزنید؟



### References

[1] K. Soetaert, T. Petzoldt, and R. W. Setzer. _deSolve: Solvers for Initial
Value Problems of Differential Equations (ODE, DAE, DDE)_. R package version
1.40. 2023. <http://desolve.r-forge.r-project.org/>.


<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۱۴-۴: شبیه‌سازی با مدل تصحیح خطای برداری (تمرین برنامه‌نویسی و رسم نمودار)](matrix_book_fa_example14.4.html)
- [مثال ۱۵-۲: دستگاه معادلات دیفرانسیل با دو متغیر (رسم نمودارهای میدان برداری)](matrix_book_fa_example15.2.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)
