function(input, output) {
    output$plot1 <- renderPlotly({
        p1 <- beras %>% 
            ggplot(aes(x = Monthly, y = Price)) +
            geom_line() +
            labs(title = "Price of Rice in Indonesia 2010 - 2019",
                 x = "Year",
                 y = "Price") +
            theme_minimal() +
            theme(plot.title = element_text(hjust = 0.5))
        
        ggplotly(p1)
      
    })
    
    table1 <- beras %>% 
      mutate(Year = year(Monthly)) %>% 
      group_by(Year) %>% 
      summarise(Price_Mean = round(mean(Price), digits = 0)) %>% 
      ungroup() %>%
      mutate(Change = (Price_Mean - lag(Price_Mean))/lag(Price_Mean)*100)
    
    output$table1 <- renderReactable({
      reactable(table1)
    })
    
    error_ets <- MAPE(y_pred = beras_ets_frcst$mean, y_true = beras_val)*100
    error_autoarima <- MAPE(y_pred = beras_autoarima_frcst$mean, y_true = beras_val)*100
    error_sarima <- MAPE(y_pred = beras_sarima_frcst$mean, beras_val)*100
    error_stlm <- MAPE(y_pred = beras_stlm_frcst$mean, y_true = beras_val)*100
    
    error <- error <- data.frame("Model" = c("ETS", "AutoArima", "SARIMA", "STLM"), "MAPE" = c(error_ets, error_autoarima, error_sarima, error_stlm))
    
    output$table2 <- renderReactable({
      reactable(data = error,
                columns = list(
                  Model = colDef(align = "center"),
                  MAPE = colDef(align = "center")
                ))
    })
    
    forecastresult <- data.frame("Month" = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"),
                                 "ForecastedPrice" = c(12317, 12316, 12225, 12019, 11952, 11971, 12029, 12062, 12069, 12083, 12124, 12230))
    
    output$table3 <- renderReactable({
      reactable(data = forecastresult)
    })
    
    output$plot_ets <- renderPlotly({
      plot_forecast(forecast_obj = beras_ets_frcst)
    })
    output$plot2_ets <- renderPlot({
      beras_ts %>% 
        autoplot() +
        autolayer(beras_ets_frcst$fitted) +
        autolayer(beras_ets_frcst$mean)
    })
    
    output$plot_autoarima <- renderPlotly({
      plot_forecast(beras_autoarima_frcst)
    })
    
    output$plot2_autoarima <- renderPlot({
      beras_ts %>% 
        autoplot() +
        autolayer(beras_autoarima_frcst$fitted) +
        autolayer(beras_autoarima_frcst$mean)
    })
    
    output$plot_sarima <- renderPlotly({
      plot_forecast(beras_sarima_frcst)
    })
    
    output$plot2_sarima <- renderPlot({
      beras_ts %>% 
        autoplot() +
        autolayer(beras_sarima_frcst$fitted) +
        autolayer(beras_sarima_frcst$mean)
    })
    
    output$plot_stlm <- renderPlotly({
      plot_forecast(beras_stlm_frcst)
    })
    
    output$plot2_stlm <- renderPlot({
      beras_ts %>% 
        autoplot() +
        autolayer(beras_stlm_frcst$fitted) +
        autolayer(beras_stlm_frcst$mean)
    })
    
    output$plot_forecast <- renderPlotly({
      plot_forecast(beras_forecast)
    })
    
    output$plot2_forecast <- renderPlot({
      beras_ts %>% 
        autoplot() +
        autolayer(beras_forecast$fitted) +
        autolayer(beras_forecast$mean)
    })
    
    output$plotbanding <- renderPlot({
      beras_ts %>% 
        autoplot() +
        autolayer(beras_forecast$fitted) +
        autolayer(beras_forecast$mean) +
        theme_minimal() 
    })
    
    output$beras <- renderReactable({
      reactable(data = beras, columns = list(
        Monthly = colDef(align = "center"),
        Price = colDef(align = "center")
      ))
    })
    
    yearly <- beras %>% 
      mutate(Year = year(Monthly)) %>% 
      group_by(Year) %>% 
      summarise(Price_Mean = round(mean(Price), digits = 0)) %>% 
      ungroup() %>%
      mutate(Change = (Price_Mean - lag(Price_Mean))/lag(Price_Mean)*100)
    
    
    
    output$yearly <- renderReactable({
      reactable(yearly, columns = list(
        Year = colDef(align = "center"),
        Price_Mean = colDef(align = "center"),
        Change = colDef(align = "center")
      ))
    })
    
    output$decompose <- renderPlot({
      beras_ts %>% 
        decompose() %>% 
        autoplot()
    })
}
