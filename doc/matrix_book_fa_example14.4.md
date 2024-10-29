---
title: "مثال ۱۴-۴: شبیه‌سازی با مدل تصحیح خطای برداری (تمرین برنامه‌نویسی و رسم نمودار)"
author: "رامین مجاب"
output: md_document
---
##  مثال ۱۴-۴: شبیه‌سازی با مدل تصحیح خطای برداری (تمرین برنامه‌نویسی و رسم نمودار)
<p style='font-size: 0.8em;'><b>نویسنده:</b> <span>رامین مجاب</span></p>

**(صفحهٔ ۴۰۷ کتاب)**
  
یکی از مفیدترین ابزارها برای  درک ماهیت یک مدل تصحیح خطا،  مشاهدهٔ تغییرات مشاهدات شبیه‌سازی‌شده است. شبیه‌سازی در اینجا به این معناست که جامعه (فرایند تولید داده) را می‌دانیم و می‌توانیم بر اساس آن، رفتار مشاهدات را بررسی کنیم. در ابتدا، به یک تابع نیاز داریم که با گرفتن پارامترهای جامعه (و دیگر اطلاعات)، نمونه را تولید کند. کد زیر را مطالعه کنید:


``` r
> dyn.sim <- function(alpha, beta,
+                     c1 = diag(0, nrow(alpha)),
+                     sigma = diag(0.01, nrow(alpha)),
+                     n = 100, nburn = 1000) {
+   n <- n + nburn
+   e <- MASS::mvrnorm(n, mu = rep(0, nrow(alpha)), Sigma = sigma)
+   dY <- Y <- matrix(0, n, nrow(alpha))
+   Pi <- alpha %*% t(beta)
+   for (t in 2:n) {
+     dY[t, ] <- Pi %*% Y[t - 1, ] - c1 %*% dY[t - 1, ] + e[t, ]
+     Y[t, ] <- Y[t - 1, ] + dY[t, ]
+   }
+   return(list(Y = tail(Y, n - nburn), Pi = Pi))
+ }
```
اگر مثال‌هایی که تا کنون نوشته‌ایم دنبال کرده باشید،  به توضیحات چندانی برای درک خطوط مختلف این کد نیاز نخواهید داشت. درون حلقهٔ `for` و در یک فرایند دومرحله‌ای، در ابتدا $\Delta \mathbf{y}_t$ و سپس سطح متغیرها را می‌سازیم. مشخص است که برای ساخت $\Delta \mathbf{y}_t$، از پارامترهای $\mathbf{C}_1$ و $\boldsymbol{\Pi}$ استفاده می‌کنیم.

توابع زیر نیز نیاز است:

``` r
> var2vecm <- function(B) {
+   p <- length(B)
+   C <- vector("list", p - 1)
+   if (p > 1) {
+     C[[1]] <- B[[1]]
+     if (p > 2) {
+       for (i in 2:(p - 1)) {
+         C[[i]] <- -Reduce("+", B[(i + 1):p])
+       }
+     }
+   }
+   Pi <- -Reduce("+", B)
+   list(C = C, Pi = Pi)
+ }
> 
> 
> vecm2var <- function(C, Pi) {
+   p <- length(C) + 1
+   B <- vector("list", p)
+   if (p == 1) {
+     B[[1]] <- -Pi
+   } else {
+     B[[1]] <- C[[1]]
+     if (p <= 2) {
+       B[[2]] <- -C[[1]] - Pi
+     } else {
+       B[[2]] <- C[[2]] - C[[1]] - Pi
+       if (p > 2) {
+         if (p > 3) {
+           for (i in 3:(p - 1)) {
+             B[[i]] <- C[[i]] - C[[i - 1]]
+           }
+         }
+         B[[p]] <- -C[[p - 1]]
+       }
+     }
+   }
+   B
+ }
> 
> 
> test_conversion <- function() {
+   # Create a sample B for testing
+   B <- list(
+     matrix(c(1, 2, 3, 4), nrow = 2),
+     matrix(c(5, 6, 7, 8), nrow = 2),
+     matrix(c(10, 11, 12, 13), nrow = 2),
+     matrix(c(14, 15, 16, 17), nrow = 2),
+     matrix(c(18, 19, 20, 21), nrow = 2)
+   )
+ 
+   # Convert B to C
+   result1 <- var2vecm(B)
+   C <- result1$C
+   Pi <- result1$Pi
+ 
+   # Convert C back to B
+   B2 <- vecm2var(C, Pi)
+ 
+   # Check if the original B and the converted B2 are the same
+   if (length(B2) != length(B)) {
+     stop("Unequal length")
+   }
+   for (i in 1:length(B)) {
+     if (!all(B[[i]] == B2[[i]])) {
+       stop("Not equal")
+     }
+   }
+   return(TRUE)
+ }
> 
> dyn.sim.plot <- function(res, beta, legpos = "topleft") {
+   Y <- res$Y
+ 
+   num_vars <- ncol(Y)
+   num_eqs <- 0 # ncol(beta)
+ 
+   colors <- c("black", "red", "blue", "green", "brown", "orange", "pink", "violet")
+ 
+ 
+   #  Y_eq <- matrix(NA, nrow(Y), num_eqs)
+   #  if (num_eqs > 0){
+   #    beta_norm <- beta %*% solve(beta[1:num_eqs, 1:num_eqs])
+   #    if (num_eqs==nrow(beta))
+   #      Y_eq[,]<-0
+   #    else{
+   #      b1 <- -beta_norm[(num_eqs+1):num_vars,, drop = FALSE]
+   #      Y_eq[2:(nrow(Y)),] <-  Y[1:(nrow(Y) - 1), ((num_eqs+1):num_vars), drop=FALSE] %*% b1
+   #    }
+   #  }
+ 
+ 
+   all_series <- Y # cbind(Y, Y_eq)
+ 
+   plot(Y[, 1],
+     type = "l", col = colors[1], ylim = range(all_series, na.rm = TRUE),
+     ylab = latex2exp::TeX("$y_t$"), xlab = "t", main = ""
+   )
+ 
+   if (num_vars > 1) {
+     for (i in 2:num_vars) {
+       lines(Y[, i], col = colors[i], lty = 1, lwd = 2)
+     }
+   }
+ 
+   if (num_eqs > 0) {
+     for (i in 1:num_eqs) {
+       lines(Y_eq[, i], col = colors[num_vars + i], lty = 2, lwd = 1)
+     }
+   }
+ 
+   legends <- c(paste("متغیر", 1:num_vars))
+   if (num_eqs > 0) {
+     legends <- c(legends, paste("تعادل بلندمدت", 1:num_eqs))
+   }
+ 
+   legend(legpos,
+     legend = legends,
+     col = colors, lty = c(rep(1, num_vars), rep(2, num_eqs)), lwd = c(rep(2, num_vars), rep(1, num_eqs)), cex = 0.6
+   )
+ }
> set.seed(123)
```

 در ادامه، چند حالت مختلف را بررسی می‌کنیم:

 
### حالت یک‌متغیره
ضرایبی که در کد زیر تعریف شده است و نمودار حاصل از آن را ببینید:

``` r
> alpha <- matrix(-0.2, ncol = 1)
> beta <- matrix(1, ncol = 1)
> res <- dyn.sim(alpha, beta, n = 100)
```


``` r
> par <- par(mar = c(4, 4, 2, 2) + 0.1)
> dyn.sim.plot(res, beta, "topright")
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_cointegration1-1.svg" style="display: block; margin: auto;" />
جامعه در این حالت به‌صورت زیر است:

$$\dot{y}_{t} = (\alpha\beta+1-c_{1})\dot{y}_{t-1}+c_{1}\dot{y}_{t-2}+\dot{\epsilon}_{t}$$

 البته در این مثال، برای سادگی فرض کرده‌ایم که $c\_{1}=0$ باشد. بنابراین، تعیین‌کنندهٔ پویایی‌های مدل، ضریب $\alpha\beta+1$ است. اگر این جمع درون دایرهٔ واحد باشد، مدل همگرا و پایدار است و به تعادل بازمی‌گردد (به‌عنوان تمرین، با تغییر پارامتر `alpha`، این موضوع را بررسی کنید).  توجه کنید که مطابق با تعریف، برای این مدل‌های تک‌متغیره، بحث «هم‌انباشتگی» مطرح نیست.

### مدل با دو متغیر، بدون رابطهٔ بلندمدت
همانند قبل، ضرایبی که در کد زیر تعریف شده است و نمودار حاصل از آن را ببینید:


``` r
> alpha <- matrix(0, nrow = 2, ncol = 0)
> beta <- matrix(0, nrow = 2, ncol = 0)
> res <- dyn.sim(alpha, beta, n = 100)
```
(نسبت به کد در کتاب و با هدف نمایش بهتر، پارامتر `n` تغییر کرده است).


``` r
> par <- par(mar = c(4, 4, 2, 2) + 0.1)
> dyn.sim.plot(res, beta)
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_cointegration2-1.svg" style="display: block; margin: auto;" />
در این نمودار، عملاً تحقق‌هایی از دو فرایند گام تصادفی را مشاهده می‌کنیم که هیچ حرکت آن‌ها در طول زمان ارتباط مشخصی با یکدیگر ندارد. البته، اگر بحث مدل رگرسیون‌های به‌ظاهر نامرتبط را به یاد  بیاورید، می‌توان توسط پارامتر `sigma` ارتباط هم‌زمانی برقرار کرد؛ یا می‌توان توسط پارامتر `c1`، متغیرها را به یکدیگر مرتبط کرد؛ اما ارتباط بلندمدت، با آن تعریفی که ارائه شد، وجود نخواهد داشت. 

- **مدل با دو متغیر و با دو رابطهٔ بلندمدت:** همانند قبل، ضرایبی که در کد زیر تعریف شده است و نمودار حاصل از آن را ببینید:


``` r
> alpha <- diag(-0.2, nrow = 2, ncol = 2)
> beta <- diag(1, nrow = 2, ncol = 2)
> res <- dyn.sim(alpha, beta, n = 100)
```


``` r
> par <- par(mar = c(4, 4, 2, 2) + 0.1)
> dyn.sim.plot(res, beta)
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_cointegration22-1.svg" style="display: block; margin: auto;" />
دو فرایندی که تحقق‌های آن‌ها در این نمودار ترسیم شده است، از منظر ارتباط بلندمدت، تفاوت چندانی با حالت یک متغیره ندارند. توجه کنید که در حالت کلی، اگر  $r=M$ باشد، آنگاه $|\boldsymbol{\Pi}|\ne 0$ است؛ این یعنی مقادیر ویژهٔ ضرایب درون دایرهٔ واحد قرار دارند، پس فرایند $\dot{\mathbf{y}}_t$ در سطح  ماناست.   برای متغیرهای این بردار، تعادل بلندمدت در صفر وجود دارد.  البته، این بدان معنا نیست که متغیرها در بلندمدت با یکدیگر ارتباط دارند. برای چنین مدل‌هایی، بحث هم‌انباشتگی مطرح نمی‌شود؛ یعنی در تعریف هم‌انباشتگی در ۱۴-۶ (صفحهٔ ۴۰۶ در کتاب)، تعداد روابط بلندمدت را کمتر از تعداد متغیرها فرض کرده‌ایم.

### مدل با دو متغیر و با یک رابطهٔ بلندمدت
همانند قبل، ضرایبی که در کد زیر تعریف شده است و نمودار حاصل از آن را ببینید:


``` r
> alpha <- matrix(c(-0.1, -0.01), nrow = 2, ncol = 1)
> beta <- matrix(c(0.3, -0.2), nrow = 2, ncol = 1)
> res <- dyn.sim(alpha, beta, n = 1000, nburn = 10000)
```


``` r
> par <- par(mar = c(4, 4, 2, 2) + 0.1)
> dyn.sim.plot(res, beta, "topright")
```

<img src="/rstatistics63/assets/images/matrix_book_fa/fig_cointegration21-1.svg" style="display: block; margin: auto;" />
در این مثال، یک  تعادل بلندمدت وجود دارد و سرعت بازگشت به تعادل، در دو معادله نیز متفاوت  است.





<p style='margin-bottom:3cm;'></p><hr/>

- [مثال ۱۴-۳: تبدیل z و نمودارهای بزرگی و فاز (تمرین برنامه‌نویسی)](matrix_book_fa_example14.3.html)
- [مثال ۱۵-۱: حل یک مسئلهٔ مقدار اولیه (معرفی برخی توابع و فرایندها)](matrix_book_fa_example15.1.html)
- [<b>لیست مثال‌ها</b>](matrix_book_fa.html)
