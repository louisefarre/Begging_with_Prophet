
library(readr)

daily_total_female_births_CA <- read_csv("C:/Users/louise.farre/Desktop/daily-total-female-births-CA.csv")

View(daily_total_female_births_CA)


#Installing prophet

install.packages("prophet")
library(prophet)


#Plot of our data

library(ggplot2)

ggplot(data=daily_total_female_births_CA, aes(date, births,group = 1)) 
         + geom_line() 
         + ggtitle("Daily female births in 1959") 
         + xlab("Date") + ylab("Births")






#Change of the columns names
  
names(daily_total_female_births_CA) <- c('ds', 'y')



#Creation of our model 

m <- prophet(daily_total_female_births_CA, 
             daily.seasonality = TRUE,
             seasonality.mode = "additive",
             )





#Creation of our future dataframe with a period of 60 days

future <- make_future_dataframe(m, periods = 60)



#Forecast with predict, and plot of the result

forecast <- predict(m, future)

  
plot(m, forecast) 
  + labs(y = "Births", x ="Date", title = "Actual values against forecast values")
  + guides(colour = guide_legend(title = "Prophet"))




#Looking at a piece of our forecast values
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])


prophet_plot_components(m, forecast)



 
 
 
 
 
 
