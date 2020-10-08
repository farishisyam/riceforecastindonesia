library(shiny)
library(shinydashboard)


ui <- dashboardPage(
    header =  dashboardHeader(title = "Rice Price Forecast"),
    
    sidebar = dashboardSidebar(sidebarMenu(menuItem(text = "About", 
                                                    tabName = "About",
                                                    icon = icon("question-circle")),
                                           menuItem(text = "Data",
                                                    tabName = "Data",
                                                    icon = icon("table")),
                                           menuItem(text = "Model",
                                                    tabName = "Model",
                                                    icon = icon("brain")),
                                           menuItem(text = "Forecast",
                                                    tabName = "Forecast",
                                                    icon = icon("code-branch")))),
    
    body = dashboardBody(tabItems(
        tabItem(tabName = "About",
                fluidPage(
                    h1("Rice in Indonesia"),
                    h3("Rice is Asia's most popular staple food, especially in Indonesia. Almost every family in Indonesia buy and eat rice everyday. 
                      Price of rice is always being monitored by BPS or Indonesian Central Bureau of Statistics. This price data is based on the first transaction
                      between first big seller with another seller/consumer in big quantity. First big seller here is the first seller after the commodity was produced."),
                    br(),
                    br(),
                    fluidRow(column(width = 12,
                                    plotlyOutput("plot1"))),
                    br(),
                    br(),
                    h3("Based on the data from BPS, the price of rice in Indonesia from 2010 - 2019 keep going up every year.")
                    
                )),
        
        tabItem(tabName = "Data",
                tabsetPanel(type = "tabs",
                            tabPanel("All Data",
                                     fluidPage(
                                         br(),
                                         h3("The data below is taken from BPS website for Rice Price from year 2010 to 2019. Price is the average price from 
                                            January to December that year."),
                                         br(),
                                         br(),
                                         reactableOutput("beras"))),
                            tabPanel("Change",
                                     fluidPage(
                                         br(),
                                         h3("While this data shows yearly average price and the change in price in percentage per year"),
                                         br(),
                                         br(),
                                         reactableOutput("yearly")
                                     )),
                            tabPanel("Decompose",
                                     fluidRow(column(width = 6,
                                                     plotOutput("decompose")),
                                              box(width = 6,
                                                     h3("Trend and Seasonality from the data can be detected. Triple Exponential Smoothing and SARIMA can be used to
                                                        be forecasting model."))))
                    
                )),
        tabItem(tabName = "Model",
                tabsetPanel(type = "tabs",
                            tabPanel("ETS",
                                     fluidRow(column(width = 12,
                                                     plotlyOutput("plot_ets")
                                                     )
                                              ),
                                     br(),
                                     br(),
                                     ),
                            tabPanel("auto.arima",
                                     fluidRow(column(width = 12,
                                                     plotlyOutput("plot_autoarima")
                                                     )
                                              ),
                                     br(),
                                     br(),
                                     
                                     ),
                            tabPanel("SARIMA",
                                     fluidRow(column(width = 12,
                                                     plotlyOutput("plot_sarima")
                                                     )
                                              ),
                                     br(),
                                     br(),
                                     
                                     ),
                            tabPanel("STLM",
                                     fluidRow(column(width = 12,
                                                    plotlyOutput("plot_stlm")
                                                    )
                                              ),
                                     br(),
                                     br(),
                                     
                                     )
                            ),

                infoBox(title = "MAPE ETS",
                        value = 0.53,
                        fill = TRUE,
                        width = 3),
                infoBox(title = "MAPE AutoArima",
                        value = 2.18,
                        fill = TRUE,
                        width = 3),
                infoBox(title = "MAPE SARIMA",
                        value = 0.98,
                        fill = TRUE,
                        width = 3),
                infoBox(title = "MAPE STLM(ETS)",
                        value = 0.67,
                        fill = TRUE,
                        width = 3),
                br(),
                br(),
                box(width = 12, h3("Based on the result above, we can conclude that ETS model have the best error for forecasting the data. In this case, we will use ETS
                   model as our forecasting model for year 2020."))
                ),
        
        tabItem(tabName = "Forecast",
                fluidRow(column(width = 6,
                                plotlyOutput("plot_forecast")
                                ),
                         column(width = 6,
                                plotOutput("plotbanding"))
                         ),
                br(),
                br(),
                box(width = 6, reactableOutput("table3")),
                box(width = 6, h3("Using ETS model to forecast rice price in Indonesia in 2020 based on historical data from 2010 - 2019, we receive
                                  result as seen in the table. This result can be used to predict how rice price going to move in 2020 and because rice
                                  is Indonesian's main staple food, seller or consumer can make plans financially for rice in 2020.")))
    ))
)