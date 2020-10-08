library(dplyr)
library(tidyr)
library(stringr)
library(zoo)
library(lubridate)
library(ggplot2)
library(anytime)
library(forecast)
library(TSstudio)
library(MLmetrics)
library(DT)
library(plotly)
library(reactable)
library(highcharter)

beras_2019 <- read.csv("2019.csv") %>% 
  rename("2019-01" = Januari,
         "2019-02" = Februari,
         "2019-03" = Maret,
         "2019-04" = April,
         "2019-05" = Mei,
         "2019-06" = Juni,
         "2019-07" = Juli,
         "2019-08" = Agustus,
         "2019-09" = September,
         "2019-10" = Oktober,
         "2019-11" = November,
         "2019-12" = Desember) %>% 
  select(-Tahunan)


beras_2018 <- read.csv("2018.csv") %>% 
  rename("2018-01" = Januari,
         "2018-02" = Februari,
         "2018-03" = Maret,
         "2018-04" = April,
         "2018-05" = Mei,
         "2018-06" = Juni,
         "2018-07" = Juli,
         "2018-08" = Agustus,
         "2018-09" = September,
         "2018-10" = Oktober,
         "2018-11" = November,
         "2018-12" = Desember) %>% 
  select(-Tahunan)


beras_2017 <- read.csv("2017.csv") %>% 
  rename("2017-01" = Januari,
         "2017-02" = Februari,
         "2017-03" = Maret,
         "2017-04" = April,
         "2017-05" = Mei,
         "2017-06" = Juni,
         "2017-07" = Juli,
         "2017-08" = Agustus,
         "2017-09" = September,
         "2017-10" = Oktober,
         "2017-11" = November,
         "2017-12" = Desember) %>% 
  select(-Tahunan)


beras_2016 <- read.csv("2016.csv") %>% 
  rename("2016-01" = Januari,
         "2016-02" = Februari,
         "2016-03" = Maret,
         "2016-04" = April,
         "2016-05" = Mei,
         "2016-06" = Juni,
         "2016-07" = Juli,
         "2016-08" = Agustus,
         "2016-09" = September,
         "2016-10" = Oktober,
         "2016-11" = November,
         "2016-12" = Desember) %>% 
  select(-Tahunan)


beras_2015 <- read.csv("2015.csv") %>% 
  rename("2015-01" = Januari,
         "2015-02" = Februari,
         "2015-03" = Maret,
         "2015-04" = April,
         "2015-05" = Mei,
         "2015-06" = Juni,
         "2015-07" = Juli,
         "2015-08" = Agustus,
         "2015-09" = September,
         "2015-10" = Oktober,
         "2015-11" = November,
         "2015-12" = Desember) %>% 
  select(-Tahunan)


beras_2014 <- read.csv("2014.csv") %>% 
  rename("2014-01" = Januari,
         "2014-02" = Februari,
         "2014-03" = Maret,
         "2014-04" = April,
         "2014-05" = Mei,
         "2014-06" = Juni,
         "2014-07" = Juli,
         "2014-08" = Agustus,
         "2014-09" = September,
         "2014-10" = Oktober,
         "2014-11" = November,
         "2014-12" = Desember) %>% 
  select(-Tahunan)


beras_2013 <- read.csv("2013.csv") %>% 
  rename("2013-01" = Januari,
         "2013-02" = Februari,
         "2013-03" = Maret,
         "2013-04" = April,
         "2013-05" = Mei,
         "2013-06" = Juni,
         "2013-07" = Juli,
         "2013-08" = Agustus,
         "2013-09" = September,
         "2013-10" = Oktober,
         "2013-11" = November,
         "2013-12" = Desember) %>% 
  select(-Tahunan)


beras_2012 <- read.csv("2012.csv") %>% 
  rename("2012-01" = Januari,
         "2012-02" = Februari,
         "2012-03" = Maret,
         "2012-04" = April,
         "2012-05" = Mei,
         "2012-06" = Juni,
         "2012-07" = Juli,
         "2012-08" = Agustus,
         "2012-09" = September,
         "2012-10" = Oktober,
         "2012-11" = November,
         "2012-12" = Desember) %>% 
  select(-Tahunan)


beras_2011 <- read.csv("2011.csv") %>% 
  rename("2011-01" = Januari,
         "2011-02" = Februari,
         "2011-03" = Maret,
         "2011-04" = April,
         "2011-05" = Mei,
         "2011-06" = Juni,
         "2011-07" = Juli,
         "2011-08" = Agustus,
         "2011-09" = September,
         "2011-10" = Oktober,
         "2011-11" = November,
         "2011-12" = Desember) %>% 
  select(-Tahunan)


beras_2010 <- read.csv("2010.csv") %>% 
  rename("2010-01" = Januari,
         "2010-02" = Februari,
         "2010-03" = Maret,
         "2010-04" = April,
         "2010-05" = Mei,
         "2010-06" = Juni,
         "2010-07" = Juli,
         "2010-08" = Agustus,
         "2010-09" = September,
         "2010-10" = Oktober,
         "2010-11" = November,
         "2010-12" = Desember) %>% 
  select(-Tahunan)


beras <- beras_2010 %>% 
  left_join(beras_2011) %>% 
  left_join(beras_2012) %>% 
  left_join(beras_2013) %>% 
  left_join(beras_2014) %>% 
  left_join(beras_2015) %>% 
  left_join(beras_2016) %>% 
  left_join(beras_2017) %>% 
  left_join(beras_2018) %>% 
  left_join(beras_2019)

beras <- beras %>% 
  select(-X) %>% 
  gather(key = Monthly, value = Price)

beras$Price <- gsub(pattern = " ", replacement = "", x = beras$Price)

beras <- beras %>% 
  mutate(Monthly = anydate(Monthly),
         Monthly = ymd(Monthly),
         Price = as.numeric(Price))

beras_ts <- ts(beras$Price, frequency = 12)
beras_ts

# Validation mengabil 12 data terakhir
beras_val <- beras_ts %>% 
  tail(12)

# Train mengambil semua data kecuali data Val
beras_train <- head(beras_ts, length(beras_ts) - length(beras_val))

beras_test <- 12 # Test = 12 untuk melakukan forecast 12 bulan kedepan

beras_ets <- ets(y = beras_train, model = "ZZZ")

beras_ets_frcst <- forecast(beras_ets, h = 12)

error_ets <- MAPE(y_pred = beras_ets_frcst$mean, y_true = beras_val)*100

beras_autoarima <- auto.arima(beras_train)

beras_autoarima_frcst <- forecast(beras_autoarima, h = 12)

error_autoarima <- MAPE(y_pred = beras_autoarima_frcst$mean, y_true = beras_val)*100

beras_sarima <- Arima(y = beras_train, order = c(11, 1, 11), seasonal = list(order = c(0, 1, 1), period = 12))

beras_sarima_frcst <- forecast(beras_sarima, h = 12)

error_sarima <- MAPE(y_pred = beras_sarima_frcst$mean, beras_val)*100

beras_stlm <- stlm(y = beras_train, method = "ets")

beras_stlm_frcst <- forecast(beras_stlm, h = 12)

error_stlm <- MAPE(y_pred = beras_stlm_frcst$mean, y_true = beras_val)*100

beras_model <- ets(beras_ts, model = "ZZZ")

beras_forecast <- forecast(beras_model, h = beras_test)
