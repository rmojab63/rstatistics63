---
title: "مثال ۱۵-۳: حل عددی معادلهٔ دیفرانسیل تصادفی (شبیه‌سازی)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۱۵-۳: حل عددی معادلهٔ دیفرانسیل تصادفی (شبیه‌سازی)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۴۴۴ کتاب)**

در این مثال، تحقق‌های مختلفی از یک متغیر تصادفی که دارای یک حرکت براونی هندسی  است و متوسط این تحقق‌ها را ترسیم می‌کنیم. همچنین، حل تحلیلی را با و بدون فرض تصادفی‌بودن  رسم می‌کنیم. بنابراین در گام اول، تابعی می‌خواهیم که با دریافت پارامترها، تحقق‌ها و دیگر اطلاعات را محاسبه کند. کد زیر را ملاحظه کنید:


``` r
> #' Gets Realizations of Geometric Brownian Motion
> #'
> #' @param r drift
> #' @param sigma volatility
> #' @param n number of time steps
> #' @param m number of realizations
> #' @param t time period
> gbm.realizations <- function(r = 0.1, sigma = 0.5, mu = 5,
+                              n = 10, m = 1, t = 1) {
+   S0 <- 1
+   dt <- t / n
+   time <- seq(0, (t - dt), by = dt)
+   paths <- matrix(ncol = m, nrow = n)
+ 
+   for (i in 1:m) {
+     S <- numeric(n)
+     S[1] <- S0
+     for (j in 2:n) {
+       dW <- rnorm(1, mean = 0, sd = sqrt(dt))
+       S[j] <- S[j - 1] + r * S[j - 1] * dt + sigma * S[j - 1] * dW
+     }
+     paths[, i] <- S
+   }
+   analytical_ito <- S0 * exp(r * time)
+   analytical_stra <- S0 * exp((r + 0.5 * sigma^2) * time)
+ 
+   return(list(
+     time = time,
+     paths = paths,
+     analytical_ito = analytical_ito,
+     analytical_stra = analytical_stra
+   ))
+ }
```

ورودی‌های تابع در کد معرفی شده‌اند. در این تابع، تحقق‌ها با توجه به معادلهٔ دیفرانسیل و به‌صورت برگشتی محاسبه شده است. متوسط این تحقق‌ها و حل تحلیلی در دو تفسیر ایتو و معادلهٔ دیفرانسیل معمولی نیز ترسیم شده است.  در تمام این محاسبات، ارزش  `dt` بی‌نهایت کوچک نیست و این قطعاً خطایی را در نتایج ایجاد می‌کند. اینکه یک ارزش گسسته را برای نمایش یک پدیده پیوسته انتخاب کرده‌ایم، با نام گسسته‌سازی (یا discretization) مشهور است. اکنون، مسیرها و دیگر ارزش‌های متوسط‌گیری شده را در شکل زیر ترسیم می‌کنیم:


``` r
> library(ggplot2)
> theme_set(theme_bw())
> 
> 
> set.seed(123)
> m <- 30
> r <- 1
> sigma <- 0.5
> n <- 100
> 
> 
> res <- gbm.realizations(r = r, sigma = sigma, n = n, m = m)
> avg_path <- rowMeans(res$paths)
> 
> # Select one path to be black
> df_paths <- data.frame(
+   Time = rep(res$time, ncol(res$paths)),
+   Value = as.vector(res$paths),
+   Group = rep(1:ncol(res$paths), each = length(res$time))
+ )
> 
> df_one <- data.frame(Time = res$time, Value = res$paths[, 1], Group = "One")
> df_avg <- data.frame(Time = res$time, Value = avg_path, Group = "Average")
> df_analytical_ito <- data.frame(Time = res$time, Value = res$analytical_ito, Group = "Analytical (Ito)")
> df_analytical_stra <- data.frame(Time = res$time, Value = res$analytical_stra, Group = "Analytical (Stra.)")
> 
> p <- ggplot() +
+   geom_line(data = df_paths, aes(x = Time, y = Value, group = Group, color = "Path")) +
+   labs(x = "زمان", y = "ارزش", color = "")
> 
> p <- p +
+   geom_line(data = df_one, aes(x = Time, y = Value, color = "One"), linewidth = 0.7) +
+   geom_line(data = df_avg, aes(x = Time, y = Value, color = "Average"), linewidth = 1.2, linetype = "dashed") +
+   geom_line(data = df_analytical_ito, aes(x = Time, y = Value, color = "AnalyticalIto"), linewidth = 0.7) +
+   geom_line(data = df_analytical_stra, aes(x = Time, y = Value, color = "AnalyticalStra"), linewidth = 0.7, linetype = "dotted")
> 
> # Add the legend
> p <- p +
+   scale_color_manual(
+     values = c(
+       "Path" = "lightgray", "Average" = "red", "AnalyticalIto" = "blue",
+       "AnalyticalStra" = "orange", One = "black"
+     ),
+     labels = c(
+       "Path" = "دیگر تحقق‌ها",
+       "One" = "یک تحقق",
+       "Average" = "متوسط",
+       "AnalyticalIto" = "مقدار موردانتظار، ایتو",
+       "AnalyticalStra" = "مقدار موردانتظار، استر."
+     )
+   ) +
+   theme(legend.position = "right")
> 
> print(p)
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_differential_stochastic-1.svg" style="display: block; margin: auto;" />

نمودار مربوط به حل تحلیلی بر اساس تفسیر ایتو و متوسط مقادیر شبیه‌سازی‌شده بر یکدیگر می‌افتند (این به‌دلیل نوع گسسته‌سازی انتخاب‌شده است). نمودار حاصل از تفسیر معمولی مسیر متفاوتی دارد. به‌عنوان تمرین، بررسی کنید که با افزایش ارزش ورودی `sigma`، فاصلهٔ مسیرها بیشتر خواهد شد.


<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۱۵-۲: دستگاه معادلات دیفرانسیل با دو متغیر (رسم نمودارهای میدان برداری)](matrix_book_fa_example15.2.html)
- [مثال ۱۶-۱: کالمن فیلتر و هموارسازی (تمرین برنامه‌نویسی)](matrix_book_fa_example16.1.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)
