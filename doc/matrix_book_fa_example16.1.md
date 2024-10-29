---
title: "مثال ۱۶-۱: کالمن فیلتر و هموارسازی (تمرین برنامه‌نویسی)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۱۶-۱: کالمن فیلتر و هموارسازی (تمرین برنامه‌نویسی)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۴۵۹ کتاب)**

در این مثال برای توضیح  مفهوم فیلتر کالمن و هموارسازی، از یک پدیدهٔ فیزیکی استفاده می‌کنیم: حرکت یک ماشین بر یک سطح. انتظار آن است که این  نسبت به پدیده‌های اقتصادی، کمک بیشتری به درک مفاهیم کند. در این مثال، توضیح می‌دهیم که چگونه ویژگی‌هایی نظیر موقعیت، سرعت، و شتاب را می‌توان در  یک مدل فضای وضعیت گنجاند.  در ابتدا، یک کد می‌نویسیم تا عملیات‌های ماتریسی موردنیاز برای محاسبهٔ فیلتر کالمن و هموارسازی را انجام دهد. برای ساده‌سازی مسئله، فرض می‌کنیم که $\mathbf{G}\mathbf{H}'=\mathbf{O}$ است. کد زیر را ملاحظه کنید:


``` r
> kalman6 <- function(Z, T, G, H, a, P, n = 100) {
+   a_est <- matrix(0, nrow = 6, ncol = n)
+   v_est <- matrix(0, nrow = 2, ncol = n)
+   P_est <- array(0, dim = c(6, 6, n))
+   F_est <- array(0, dim = c(2, 2, n))
+   K_est <- array(0, dim = c(6, 2, n))
+   pos_pred_smooth <- matrix(0, nrow = n, ncol = 6)
+   for (i in 2:n) {
+     ap <- T %*% a
+     P <- T %*% P %*% t(T) + H %*% t(H)
+     y <- Z %*% a + MASS::mvrnorm(1,
+       mu = c(0, 0),
+       Sigma = G %*% t(G)
+     )
+     F <- Z %*% P %*% t(Z) + G %*% t(G)
+     K <- P %*% t(Z) %*% solve(F)
+     v <- y - Z %*% ap
+     a <- ap + K %*% v
+     P <- (diag(6) - K %*% Z) %*% P
+     a_est[, i] <- a
+     v_est[, i] <- v
+     P_est[, , i] <- P
+     F_est[, , i] <- F
+     K_est[, , i] <- T %*% K
+     pos_pred_smooth[i, ] <- c(a[1], a[4], ap[1], ap[4], NA, NA)
+   }
+ 
+   r <- matrix(rep(0, 6), nrow = 6)
+   N <- matrix(rep(0, 36), nrow = 6)
+   for (i in n:1) {
+     L <- T - K_est[, , i] %*% Z
+     r <- t(Z) %*% solve(F) %*% v_est[, i] + t(L) %*% r
+     a_smooth <- a_est[, i] + P_est[, , i] %*% r
+     N <- t(Z) %*% solve(F) %*% Z + t(L) %*% N %*% L
+     P_smooth <- P_est[, , i] - P_est[, , i] %*% N %*%
+       P_est[, , i]
+     pos_pred_smooth[i, 5:6] <- a_smooth[c(1, 4)]
+   }
+   pos_pred_smooth
+ }
```
کد  به توضیح چندانی نیاز ندارد، زیرا نام متغیرها و فرمول‌ها تقریباً بر اساس متن فصل «مدل فضای حالت» (صفحهٔ ۴۴۷ در کتاب)  انتخاب شده است. همچنین، خط‌های نسبتاً زیادی از کد مربوط به ذخیرهٔ اطلاعات برای استفاده در حلقهٔ `for` دوم مربوط می‌شود. ورودی‌های `a`  و `P`، پارامترهای توزیع وضعیت در زمان ۱ هستند. حلقهٔ `for` اول برای الگوریتم فیلتر کالمن و حلقهٔ `for` دوم برای الگوریتم هموارسازی است. 

توجه کنید که این یک تابع عمومی برای محاسبهٔ فیلتر کالمن و هموارسازی نیست، زیرا بردار وضعیت را دارای ۶ پارامتر و بردار مشاهدات را دارای ۲ متغیر  فرض می‌کنیم. همچنین، تنها بخشی از اطلاعات را که برای ترسیم  موقعیت ماشین موردنیاز است، از تابع خارج می‌کنیم.  البته، تعمیم تابع به حالت عمومی ساده است؛ هرچند بسته‌های نرم‌افزاری بسیاری در این زمینه وجود دارد و به‌جز برای تمرین، نیازی به این تلاش نیست.

در این کد، توضیح تفاوت بین `y`، `a`،  و `ap` مفید است. ارزش‌هایی که در `a` ذخیره می‌شود، موقعیت، سرعت، و شتاب واقعی ماشین است. ارزش‌هایی که در `y` ذخیره می‌شود، موقعیت مشاهده‌شدهٔ ماشین است؛ این یعنی ارزش‌های این بردار دارای خطای مشاهده و اندازه‌گیری هستند و موقعیت واقعی را نشان نمی‌دهند.  برای خروجی، ارزش `a` استخراج و ترسیم خواهد شد؛ هرچند می‌توان کد را تغییر داد و موقعیت مشاهده‌شده را ترسیم کرد. ارزش `ap` نیز پیش‌بینی موقعیت در هر دوره به‌شرط اطلاعات است. این ارزش نیز به‌عنوان خروجی گزارش می‌شود. پس، هدف آن است که موقعیت واقعی و موقعیت پیش‌بینی‌شده را در یک نمودار رسم کنیم. بااین‌حال،  پارامترهای این مثال  به توضیح نیاز دارند. بهتر است با صبر و حوصله آن‌ها را معرفی کنیم:

 
### وضعیت اولیه
بردار وضعیت در این مثال دارای ۶ متغیر است: موقعیت، سرعت، و شتاب در جهت محور افقی یعنی $x$؛ و موقعیت، سرعت، و شتاب در جهت محور عمودی یعنی $y$. انتظار داریم این متغیرها کل اطلاعات مربوط به وضعیت سیستم در هر نقطه از زمان باشند. به‌عبارت دیگر، اگر اطلاعات دیگری نیز وجود دارد که وضعیت سیستم را نشان می‌دهد، باید آن را در بردار وضعیت بگنجانیم. وضعیت اولیه را با پارامترهای زیر مشخص می‌کنیم:

``` r
> a <- matrix(c(0, 0, 0.1, 0, 0, 0.1), nrow = 6, ncol = 1)
> P <- 0.01 * diag(6)
```
این یعنی انتظار می‌رود ماشین در مبدأ مختصات باشد، حرکت نکند (سرعت صفر است)؛ هرچند راننده‌ای در آن هست و می‌خواهد ماشین را به حرکت درآورد (شتابی با اندازهٔ $0.1$ در هر دو جهت افقی و عمودی وجود دارد). ماتریس `P` قطری است. پس، ارتباطی بین مؤلفه‌های موقعیت، سرعت، و شتاب در زمان صفر وجود ندارد. اگر انتظار برود که راننده با توجه به موقعیت اولیه شتاب اولیهٔ متفاوتی  انتخاب می‌کند، فرض قطری‌بودن مناسب نیست. ارزش‌های قطر نیز نسبتاً کوچک‌اند؛ به این معنی که با اطمینان زیادی ماشین در نزدیکی‌های   مبدأ و در حال راه افتادن است. اگر نسبت به این نقطهٔ اولیه شک‌وتردید وجود دارد، باید آن را با ارزش‌های بزرگ‌تر منعکس کنیم.


### ماتریس انتقال وضعیت
 این همان ماتریس $\mathbf{T}_t$ است که البته در این مثال ثابت فرض می‌شود. این را به‌صورت زیر می‌نویسیم:

``` r
> dt <- 1
> T <- matrix(c(
+   1, dt, 0.5 * dt^2, 0, 0, 0,
+   0, 1, dt, 0, 0, 0,
+   0, 0, 1, 0, 0, 0,
+   0, 0, 0, 1, dt, 0.5 * dt^2,
+   0, 0, 0, 0, 1, dt,
+   0, 0, 0, 0, 0, 1
+ ), nrow = 6, ncol = 6, byrow = TRUE)
```
ساختار ماتریس فوق با استفاده از ارتباط نظری موقعیت، سرعت، و شتاب یک ماشین نوشته شده است. درایه‌های قطر ۱ است؛ به این معنی که هر متغیر وضعیت اثر مستقیمی بر خود در دورهٔ بعد دارد. ارزش درایه‌های $\mathbf{T}\_{1,2}=dt$ و $\mathbf{T}\_{4,5}=dt$ است. این درایه‌ها سهم سرعت در موقعیت دورهٔ بعد را نشان می‌دهد. پس اگر سرعت در جهت افقی 10 واحد باشد، در دورهٔ بعد موقعیت در جهت افقی $10\times dt$  واحد جابه‌جا می‌شود. از طرف دیگر، شتاب می‌تواند سرعت را تحت‌تأثیر قرار دهد. پس درایه‌های $\mathbf{T}\_{2,3}$ و $\mathbf{T}\_{5,6}$ نیز برابر با $dt$ هستند. همچنین، شتاب،  موقعیت را تغییر می‌دهد. با توجه به قواعد فیزیکی، ارزش‌های $\mathbf{T}\_{1,3}=0.5(dt)^2$ و $\mathbf{T}\_{4,6}=0.5(dt)^2$ انتخاب شده است. دیگر صفرهای ماتریس نشان می‌دهد که عوامل دیگر بر یکدیگر تأثیرگذار نیستند؛ مثلاً، موقعیت در این دوره در هیچ زمانی باعث تغییر سرعت یا شتاب نمی‌شود. ممکن است شرایطی را متصور باشید و بخواهید این فرض را کنار بگذارید؛ در این حالت، باید ساختار ماتریس را تغییر دهید.

### ماتریس اندازه‌گیری
 این همان ماتریس $\mathbf{Z}_t$ است. فرض می‌کنیم که تنها توانایی اندازه‌گیری موقعیت ماشین (و نه شتاب یا سرعت) آن را داریم. این یعنی دو متغیر مشاهده داریم و ساختار زیر را تعریف می‌کنیم:

``` r
> Z <- matrix(c(
+   1, 0, 0, 0, 0, 0,
+   0, 0, 0, 1, 0, 0
+ ), nrow = 2, byrow = TRUE)
```

### واریانس خطا
 اندازه و جهت خطا توسط جزء $\dot{\boldsymbol{\epsilon}}$ تعیین می‌شود. مقدار موردانتظار این متغیر صفر است؛ یعنی خطای  سیستماتیک وجود ندارد. ساختار ماتریس اندازه‌گیری `Z` به این معنی است که موقعیت افقی و عمودی ماشین را مشاهده می‌کنیم. بااین‌حال در دنیای واقع، مشاهدات  بدون خطا نیستند و بنابراین، می‌توانیم دو خطای مشاهده تعریف کنیم. از طرف دیگر، می‌توانیم شوک‌های سرعت و شتاب را تعریف کنیم. توجه کنید که منطقی نیست شوک به موقعیت ماشین (در محور افقی یا عمودی) داده شود. بنابراین، 6 شوک وجود دارد و ازآنجاکه شوک‌ها را نامرتبط با یکدیگر فرض می‌کنیم، دو ماتریس زیر را تعریف می‌کنیم:

``` r
> G <- cbind(diag(1, nrow = 2), matrix(0, nrow = 2, ncol = 4))
> H <- matrix(0, nrow = 6, ncol = 6)
> H[2, 3] <- 0.1
> H[3, 4] <- 0.1
> H[5, 5] <- 0.2
> H[6, 6] <- 0.2
```

در شکل زیر، نتایج برای ۱۰ مشاهده ترسیم می‌شود. به‌عنوان تمرین، توضیح دهید که چرا بیشتر حرکت در جهت عمودی است؟ کدام‌یک از دو ارزش فیلترشده یا هموارشده به مقادیر واقعی نزدیک‌تر هستند؟ همچنین، کد را برای تعداد مشاهدات بیشتر ترسیم کنید. از طرف دیگر، سعی کنید واریانس‌های تخمین‌زده‌شده را با رسم  یک بیضی در اطراف نقاط ترسیم کنید.


``` r
> par <- par(mar = c(4, 4, 2, 2) + 0.1)
> set.seed(123)
> res <- kalman6(T = T, Z = Z, G = G, H = H, a = a, P = P, n = 10)
> 
> # Plot
> dx <- c(res[, c(1, 3, 5)]) * 1.01
> dy <- c(res[, c(2, 4, 6)]) * 1.01
> plot(1, 1,
+   type = "n", asp = 1,
+   xlim = c(min(dx), max(dx)),
+   ylim = c(min(dy), max(dy)),
+   xlab = "X", ylab = "Y"
+ )
> points(res[, 1], res[, 2], , pch = 19, col = "red")
> points(res[, 3], res[, 4], , pch = 17, col = "blue")
> points(res[, 5], res[, 6], , pch = 15, col = "green")
> lines(res[, 1], res[, 2], , col = "red", lwd = 1, lty = 2)
> lines(res[, 3], res[, 4], , col = "blue", lwd = 1, lty = 2)
> lines(res[, 5], res[, 6], , col = "green", lwd = 1, lty = 2)
> 
> legend("topleft", legend = c("واقعی", "فیلترشده", "هموارشده"), pch = c(19, 17, 15), col = c("red", "blue", "green"))
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_kalman-1.svg" style="display: block; margin: auto;" />


<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۱۵-۳: حل عددی معادلهٔ دیفرانسیل تصادفی (شبیه‌سازی)](matrix_book_fa_example15.3.html)
- [مثال ۱۶-۲: مدل روند خطی محلی (مدل‌سازی)](matrix_book_fa_example16.2.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)