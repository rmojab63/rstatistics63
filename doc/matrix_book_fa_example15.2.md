---
title: "مثال ۱۵-۲: دستگاه معادلات دیفرانسیل با دو متغیر (رسم نمودارهای میدان برداری)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۱۵-۲: دستگاه معادلات دیفرانسیل با دو متغیر (رسم نمودارهای میدان برداری)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۴۲۸ کتاب)**
 
در این مثال، پویایی متغیرهای معادلات دیفرانسیل (با دو متغیر) را در نمودارهای میدان برداری (یا <span dir="ltr">field diagram</span>) ترسیم می‌کنیم. این بخش از کد شبیه به [مثال ۱۵-۱](matrix_book_fa_example15.1) البته با دو متغیر است. 


``` r
> plot.field <- function(
+     u = function(x, y) {
+       y
+     },
+     v = function(x, y) {
+       -x - 3 * y
+     },
+     count = 10,
+     length = 0.15,
+     num_arrows = 10,
+     initial_points =
+       list(
+         c(-6, 6), c(-6, -6), c(6, -6), c(6, 6),
+         c(-6, 3), c(-6, -3), c(6, 3), c(6, -3),
+         c(3, 6), c(3, -6), c(-3, 6), c(-3, -6)
+       ),
+     arrowPos = c(2, 20),
+     timeMax = 100,
+     ...) {
+   x <- seq(-6, 6, length.out = count)
+   y <- seq(-6, 6, length.out = count)
+   grid <- expand.grid(x = x, y = y)
+ 
+   grid$u <- u(grid$x, grid$y)
+   grid$v <- v(grid$x, grid$y)
+ 
+   plot(0, 0,
+     xlim = c(-6, 6), ylim = c(-6, 6), type = "n", asp = 1,
+     xlab = "x", ylab = "y", xaxt = "n", yaxt = "n"
+   )
+   abline(h = 0, v = 0, col = "lightblue", lty = 2)
+ 
+   arrows(grid$x, grid$y,
+     grid$x + length * grid$u,
+     grid$y + length * grid$v,
+     length = 0.1, angle = 30,
+     col = "gray"
+   )
+ 
+   derivs <- function(t, y, params) {
+     list(c(u(y[1], y[2]), v(y[1], y[2])))
+   }
+ 
+   times <- seq(0, timeMax, by = 0.1)
+   arrowPos <- arrowPos * 10 # note the 0.1
+ 
+   for (y0 in initial_points) {
+     out <- deSolve::ode(y = y0, times = times, func = derivs, parms = NULL)
+     lines(out[, 2], out[, 3], col = "red", lwd = 2)
+ 
+ 
+     for (i in 1:(length(arrowPos))) {
+       suppressWarnings(arrows(out[arrowPos[i], 2], out[arrowPos[i], 3],
+         out[arrowPos[i] + 1, 2], out[arrowPos[i] + 1, 3],
+         length = 0.1, angle = 30, col = "red", lwd = 2
+       ))
+     }
+   }
+ }
```

### مقادیر ویژهٔ متمایز و منفی
 در این مورد، پویایی‌های دستگاه زیر ترسیم می‌شود:
 
$$
\begin{cases}
\frac{\mathrm{d}x(t)}{\mathrm{d}t}=y\\
\frac{\mathrm{d}y(t)}{\mathrm{d}t}=-x-3y\\
\end{cases}
$$


``` r
> par <- par(mar = c(2, 2, 2, 2) + 0.1)
> plot.field(
+   u = function(x, y) {
+     y
+   },
+   v = function(x, y) {
+     -x - 3 * y
+   },
+   initial_points =
+     list(
+       c(-6, 6), c(-6, -6), c(6, -6), c(6, 6),
+       c(-6, 3), c(-6, -3), c(6, 3), c(6, -3),
+       c(3, 6), c(3, -6), c(-3, 6), c(-3, -6)
+     ),
+   arrowPos = c(0.1, 1),
+   timeMax = 100
+ )
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_differential2_neg_diff-1.svg" style="display: block; margin: auto;" />
ماتریس ضرایب برای این دستگاه به‌صورت زیر است:

$$\begin{bmatrix} 0&1\\\\-1&-3 \end{bmatrix}$$

 مقادیر ویژهٔ این ماتریس برابر با $-2.61$ و $-0.38$ است. اگر هر دو مشتق جزئی را برابر با صفر قرار دهیم، $x=y=0$ به‌عنوان تعادل به‌دست می‌آید. همچنین، روی خط $y=-\frac{1}{4}x$، سرعت تغییرات هر دو متغیر مساوی است.


### مقادیر ویژهٔ متمایز و مثبت
 در این مورد، پویایی‌های دستگاهی که ضرایب آن برابر با قرینهٔ ضرایب حالت قبل است، ترسیم می‌شود:
 

``` r
> par <- par(mar = c(2, 2, 2, 2) + 0.1)
> plot.field(
+   u = function(x, y) {
+     -y
+   },
+   v = function(x, y) {
+     x + 3 * y
+   }, initial_points =
+     lapply(seq(-6, 6, by = 0.8), function(a) c(a, -0.25 * a)),
+   timeMax = 20,
+   arrowPos = c(0.6, 1)
+ )
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_differential2_pos_diff-1.svg" style="display: block; margin: auto;" />
مقادیر ویژه، قرینهٔ مقادیر ویژهٔ حالت قبل است. همانند حالت قبل، تعادل در نقطهٔ $x=y=0$ وجود دارد. البته برخلاف قبل، این تعادل پایدار نیست.  دو متغیر روی خط $y=-\frac{1}{4}x$ با سرعت یکسانی از تعادل دور می‌شوند.

### مقادیر ویژه با علامت متفاوت
 در این مورد، پویایی‌های دستگاه زیر ترسیم می‌شود:
 
$$
\begin{cases}
\frac{\mathrm{d}x(t)}{\mathrm{d}t}=x+2y\\
\frac{\mathrm{d}y(t)}{\mathrm{d}t}=2x+y\\
\end{cases}
$$


``` r
> par <- par(mar = c(2, 2, 2, 2) + 0.1)
> d <- plot.field(
+   u = function(x, y) {
+     x + 2 * y
+   },
+   v = function(x, y) {
+     2 * x + y
+   },
+   initial_points = list(
+     c(-6, 6), c(6, -6),
+     c(-6, 5.9), c(-5.9, 6),
+     c(-0.1, -0.1), c(0.1, 0.1),
+     c(6, -5.9), c(5.9, -6)
+   ),
+   arrowPos = c(1, 1.5),
+   timeMax = 20
+ )
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_differential2_neg_pos-1.svg" style="display: block; margin: auto;" />
ماتریس ضرایب برای این دستگاه به‌صورت زیر است:

 $$\begin{bmatrix} 1&2\\2&1 \end{bmatrix}$$

مقادیر ویژه $3$ و $-1$ است. به‌عنوان تمرین، نقطهٔ تعادل و خطوطی  که بر آن‌ها، قدرمطالق سرعت تغییرات دو متغیر برابر (هم‌جهت و خلاف جهت) است،  محاسبه کنید.

### مقادیر ویژهٔ مساوی با علامت منفی
 در این مورد، پویایی‌های دستگاه زیر ترسیم می‌شود:
 
$$
\begin{cases}
\frac{\mathrm{d}x(t)}{\mathrm{d}t}=-x\\
\frac{\mathrm{d}y(t)}{\mathrm{d}t}=-y\\
\end{cases}
$$


``` r
> par <- par(mar = c(2, 2, 2, 2) + 0.1)
> plot.field(
+   u = function(x, y) {
+     -x
+   },
+   v = function(x, y) {
+     -y
+   },
+   initial_points =
+     list(
+       c(-6, 6), c(-6, -6), c(6, -6), c(6, 6),
+       c(-6, 3), c(-6, -3), c(6, 3), c(6, -3),
+       c(3, 6), c(3, -6), c(-3, 6), c(-3, -6),
+       c(0, -6), c(0, 6), c(6, 0), c(-6, 0)
+     ),
+   arrowPos = c(0.1, 1, 2),
+   timeMax = 10
+ )
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_differential2_neg_eq-1.svg" style="display: block; margin: auto;" />
ماتریس ضرایب برای این دستگاه به‌صورت زیر است:

$$\begin{bmatrix} -1&0\\0&-1 \end{bmatrix}$$

مقدار ویژه برابر با $-1$ با تعدد جبری ۲ است. 

### مقادیر ویژهٔ مساوی با علامت مثبت
در این مورد، پویایی‌های دستگاهی که ماتریس ضرایب آن قرینهٔ حالت قبل است، ترسیم می‌شود:


``` r
> par <- par(mar = c(2, 2, 2, 2) + 0.1)
> plot.field(
+   u = function(x, y) {
+     x
+   },
+   v = function(x, y) {
+     y
+   },
+   initial_points =
+     list(
+       c(-0.1, 0.1), c(-0.1, -0.1), c(0.1, -0.1), c(0.1, 0.1),
+       c(0, 0.1), c(0, -0.1), c(0.1, 0), c(-0.1, 0)
+     ),
+   timeMax = 10,
+   arrowPos = c(2, 3, 4)
+ )
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_differential2_pos_eq-1.svg" style="display: block; margin: auto;" />

### مقادیر ویژهٔ مختلط با بخش حقیقی منفی
در این مورد، پویایی‌های دستگاه زیر ترسیم می‌شود:

$$
\begin{cases}
\frac{\mathrm{d}x(t)}{\mathrm{d}t}=-x-2y\\
\frac{\mathrm{d}y(t)}{\mathrm{d}t}=2x-y\\
\end{cases}
$$


``` r
> par <- par(mar = c(2, 2, 2, 2) + 0.1)
> plot.field(
+   u = function(x, y) {
+     -x - 2 * y
+   },
+   v = function(x, y) {
+     2 * x - y
+   },
+   initial_points =
+     list(
+       c(-6, 6), c(-6, -6), c(6, -6), c(6, 6),
+       c(-4, 6), c(-6, -4), c(4, -6), c(6, 4)
+     ),
+   timeMax = 10,
+   arrowPos = c(0.1, 1)
+ )
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_differential2_neg_real-1.svg" style="display: block; margin: auto;" />
ماتریس ضرایب برای این دستگاه به‌صورت زیر است:
$$\begin{bmatrix} -1&-2\\2&-1 \end{bmatrix}$$
 مقادیر ویژه برابر با $-1+2\operatorname{i}$ و $-1-2\operatorname{i}$ است.

### مقادیر ویژهٔ مختلط با بخش حقیقی مثبت
در این مورد، پویایی‌های دستگاهی که ماتریس ضرایب آن قرینهٔ حالت قبل است، ترسیم می‌شود.


``` r
> par <- par(mar = c(2, 2, 2, 2) + 0.1)
> plot.field(
+   u = function(x, y) {
+     x + 2 * y
+   },
+   v = function(x, y) {
+     -2 * x + y
+   },
+   initial_points =
+     list(
+       c(-0.1, 0.1), c(-0.1, -0.1), c(0.1, -0.1), c(0.1, 0.1),
+       c(0, 0.3), c(0, -0.3), c(0.3, 0), c(-0.3, 0)
+     ),
+   timeMax = 10,
+   arrowPos = c(2, 3, 4)
+ )
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_differential2_pos_real-1.svg" style="display: block; margin: auto;" />

### مقادیر ویژهٔ مختلط با بخش حقیقی صفر
در این مورد، پویایی‌های دستگاه زیر ترسیم می‌شود:

$$
\begin{cases}
\frac{\mathrm{d}x(t)}{\mathrm{d}t}=y\\
\frac{\mathrm{d}y(t)}{\mathrm{d}t}=-x\\
\end{cases}
$$


``` r
> par <- par(mar = c(2, 2, 2, 2) + 0.1)
> plot.field(
+   u = function(x, y) {
+     y
+   },
+   v = function(x, y) {
+     -x
+   },
+   initial_points =
+     list(c(0.1, 0.1), c(1, 1), c(2, 2), c(3, 3), c(4, 4)),
+   timeMax = 10,
+   arrowPos = c(2, 3, 4, 5, 6, 7)
+ )
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_differential2_zero_real-1.svg" style="display: block; margin: auto;" />
ماتریس ضرایب برای این دستگاه به‌صورت زیر است:

$$\begin{bmatrix} 0&1\\-1&0 \end{bmatrix}$$

مقدار ویژه برابر با $\operatorname{i}$ و $-\operatorname{i}$ است.



<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۱۵-۱: حل یک مسئلهٔ مقدار اولیه (معرفی برخی توابع و فرایندها)](matrix_book_fa_example15.1.html)
- [مثال ۱۵-۳: حل عددی معادلهٔ دیفرانسیل تصادفی (شبیه‌سازی)](matrix_book_fa_example15.3.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)
