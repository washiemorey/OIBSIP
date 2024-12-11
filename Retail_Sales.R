#...........EDA ON RETAIL SALES DATA...............#
#...........DONE BY WASHINGTONE MOREY OBURU................#
#.........ON 10,DECEMBER,2023...............................#
#.........DATA ANALYSIS AT OASIS INFOBYTE........#

#IMPORTING DATA INTO R
data <- read.csv("C:\\Users\\hp\\OneDrive\\Desktop\\OASIS INTERN\\Retail_Sales.csv",
                 header = T)

#Selecting required columns to do analysis on
library(tidyverse)
data <- data %>% select(-Customer_ID,-Transaction.ID)

#Converting Date into date format ,Gender,Product_Category into factor
data <- data %>% mutate(Date = as.Date(Date,format = "%m/%d/%Y"),Gender = as.factor(Gender),
                        Product_Category = as.factor(Product_Category)) %>% arrange(Date)  #arranging date in ascending order

#Performing basic statistics on continuous variables in the data grouped by Product Category
variables <- data %>% select(Product_Category,Age,Quantity,Price_per_Unit,Total_Amount)
#...function for calculating mode
calculate_mode <- function(x) {
  unique_x <- unique(x)
  freq <- tabulate(match(x, unique_x))
  unique_x[which.max(freq)]
}

#Basic statistics on Age
Age = variables %>% select(Age,Product_Category) %>% group_by(Product_Category) %>%
  summarise(MEAN = mean(Age),MEDIAN = median(Age),MODE = calculate_mode(Age),STANDARD_DEV = sd(Age))

#Basic statistics on Quantity
quantity <- variables %>% select(Product_Category,Quantity) %>% group_by(Product_Category) %>% 
  summarise(MEAN = mean(Quantity),MEDIAN = median(Quantity),MODE = calculate_mode(Quantity),STANDARD_DEV = sd(Quantity))

#Basic statistics in Price per unit
price <- variables %>% select(Product_Category,Price_per_Unit) %>% group_by(Product_Category) %>% 
  summarise(MEAN  = mean(Price_per_Unit),MEDIAN = median(Price_per_Unit),
            MODE = calculate_mode(Price_per_Unit),STANDARD_DEV = sd(Price_per_Unit))

#Basic statistics on Total Amount
total <- variables %>% select(Product_Category,Total_Amount) %>% group_by(Product_Category) %>% 
  summarise(MEAN = mean(Total_Amount),MEDIAN = median(Total_Amount),MODE = calculate_mode(Total_Amount),
            STANDARD_DEV = sd(Total_Amount))


#Time series Analysis
#Sales trend over time of each product category
#Adding day month and year columns in the data
date <- data$Date
Day = as.numeric(format(date,"%d"))
Month <- as.numeric(format(date,"%m"))
Year <- as.numeric(format(date,"%Y"))

data1 <- cbind(data,Day,Month,Year)


#Extracting each product sales data
#Beauty Products
beauty <- data1 %>% filter(Product_Category == "Beauty")  #filtering beauty products
library(zoo)
beauty_tseries <- zoo(beauty %>% select(Total_Amount,Date))  #Converting beauty products sales to time series
timeseries <- ts(beauty_tseries$Total_Amount,start =c(2023,1,1),frequency = 365)
#Understanding Sales trends over time using visualization
plot(beauty_tseries,ylab = "Sales Amount",main = "SALES TREND OVER TIME")

#Total monthly sales 
total <- beauty %>% select(Month,Year,Total_Amount) %>% filter(Year == 2023) %>% 
  group_by(Month) %>% 
  summarise(Total_Sales = sum(Total_Amount))
#Total quarterly sales 
quarterly_sales <- total %>%
  mutate(Quarter = ceiling(Month / 3)) %>%  # Divide months into quarters
  group_by(Quarter) %>%
  summarise(Quarterly_Sales = sum(Total_Sales))
#Converting monthly sales into quarterly  time series
time_series <- ts(total$Total_Sales,frequency = 3)
decomposed <- decompose(time_series,type = c("additive","multiplicative"),filter = NULL)
plot(decomposed)

#Trend Analysis
#Three months moving average
m_average <- rollmean(total$Total_Sales,k = 3,fill = NA)
plot(m_average,type = "l",ylab = "Moving Average",main = "THREE MONTHS MOVING AVERAGE")
#lInear regression model
model <- lm(total$Total_Sales ~ as.numeric(total$Month),data = total)

#Seasonality Analysis
library(forecast)
ggseasonplot(time_series,month.label = TRUE)

#Forcasting sales 
fit <- auto.arima(time_series)
forcasted <- forecast(fit,h = 12)
plot(forcasted)


# Clothing products
clothing <- data1 %>% filter(Product_Category == "Clothing")
library(zoo)
clothing_tseries <- zoo(clothing %>% select(Total_Amount,Date))  #Converting clothing products sales to time series
timeseries <- ts(clothing_tseries$Total_Amount,start =c(2023,1,1),frequency = 365)
#Understanding Sales trends over time using visualization
plot(clothing_tseries,ylab = "Sales Amount",main = "SALES TREND OVER TIME")

#Total monthly sales 
total <- clothing %>% select(Month,Year,Total_Amount) %>% filter(Year == 2023) %>% 
  group_by(Month) %>% 
  summarise(Total.Sales = sum(Total_Amount))
#Total quarterly sales 
quarterly_sales <- total %>%
  mutate(Quarter = ceiling(Month / 3)) %>%  # Divide months into quarters
  group_by(Quarter) %>%
  summarise(Quarterly_Sales = sum(Total.Sales))
#Converting monthly sales into quarterly  time series
time_series <- ts(total$Total.Sales,frequency = 3)
decomposed <- decompose(time_series,type = c("additive","multiplicative"),filter = NULL)
plot(decomposed)

#Trend Analysis
#Three months moving average
m_average <- rollmean(total$Total.Sales,k = 3,fill = NA)
plot(m_average,type = "l",ylab = "Moving Average",main = "THREE MONTHS MOVING AVERAGE")
#lInear regression model
model <- lm(total$Total.Sales ~ as.numeric(total$Month),data = total)

#Seasonality Analysis
library(forecast)
ggseasonplot(time_series,month.label = TRUE)

#Forcasting sales 
fit <- auto.arima(time_series)
forcasted <- forecast(fit,h = 12)
plot(forcasted)



#Electronics products 
electronics <- data1 %>% filter(Product_Category == "Electronics")
library(zoo)
electronic_tseries <- zoo(electronics %>% select(Total_Amount,Date))  #Converting electronics products sales to time series
timeseries <- ts(electronic_tseries$Total_Amount,start =c(2023,1,1),frequency = 365)
#Understanding Sales trends over time using visualization
plot(electronic_tseries,ylab = "Sales Amount",main = "SALES TREND OVER TIME")

#Total monthly sales 
total <- electronics %>% select(Month,Year,Total_Amount) %>% filter(Year == 2023) %>% 
  group_by(Month) %>% 
  summarise(Total.Sales = sum(Total_Amount))
#Total quarterly sales 
quarterly_sales <- total %>%
  mutate(Quarter = ceiling(Month / 3)) %>%  # Divide months into quarters
  group_by(Quarter) %>%
  summarise(Quarterly_Sales = sum(Total.Sales))
#Converting monthly sales into quarterly  time series
time_series <- ts(total$Total.Sales,frequency = 3)
decomposed <- decompose(time_series,type = c("additive","multiplicative"),filter = NULL)
plot(decomposed)

#Trend Analysis
#Three months moving average
m_average <- rollmean(total$Total.Sales,k = 3,fill = NA)
plot(m_average,type = "l",ylab = "Moving Average",main = "THREE MONTHS MOVING AVERAGE")
#linear regression model
model <- lm(total$Total.Sales ~ as.numeric(total$Month),data = total)

#Seasonality Analysis
library(forecast)
ggseasonplot(time_series,month.label = TRUE)

#Forecasting sales 
fit <- auto.arima(time_series)
forcasted <- forecast(fit,h = 12)
plot(forcasted)



#Customer and Product Analysis:
# Customer Demographic analysis 
#Gender Analysis ...Understand purchasing pattern by gender.........................................................
sales_bygender <- data1 %>% group_by(Gender) %>% summarise(Total_Amount = sum(Total_Amount),
                                                           Quantity = sum(Quantity))
#visualizing
library(ggplot2)
ggplot(sales_bygender,aes(Gender,Total_Amount,fill = Gender))+
  geom_bar(stat = "identity")+
  labs(title = "TOTAL SALES BY GENDER",y = "Total Sales")
ggplot(sales_bygender,aes(Gender,Quantity,fill = Gender))+
  geom_bar(stat = "identity")+
  labs(title = "TOTAL QUANTITY PURCHASE BY GENDER")


#Age Analysis ...Primary Age group contributing to Sales..................................
sales_by_age <- data1 %>%
  mutate(Age_Group = case_when(
    Age < 30 ~ "18-29",
    Age >= 30 & Age <= 50 ~ "30-50",
    Age > 50 ~ "51+"
  )) %>%
  group_by(Age_Group) %>%
  summarise(Total_Amount = sum(Total_Amount),Quantity = sum(Quantity))
#Visualizing
ggplot(sales_by_age,aes(Age_Group,Total_Amount,fill = Age_Group))+
  geom_bar(stat = "identity")+
  labs(title = "TOTAL SALES BY AGE GROUP",y = "Total Amount", x = "Age Group")
#Product preference for each gender
table(data$Gender,data1$Product_Category)


#Product Category Analysis............................................................
#Popularity of product Categories ...Most popular and profitable products
sales_by_category <- data1 %>%
  group_by(Product_Category) %>%
  summarise(Total_Sales = sum(Total_Amount),
            Average_Price = mean(Price_per_Unit),
            Total_Quantity = sum(Quantity))
#Visualizing
ggplot(sales_by_category, aes(Product_Category,Total_Sales, fill = Product_Category)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Sales by Product Category", y = "Total Sales",x = "Product Category")


#Product Performance by Price...........................................................................................................................
#price ranges that perform well for each product category.
sales_by_price <- data1 %>%
  mutate(Price_Band = case_when(Price_per_Unit < 50 ~ "<50",
                                Price_per_Unit >= 50 & Price_per_Unit <= 200 ~ "50 - 200",
                                Price_per_Unit > 200 ~ "201+")) %>% group_by(Price_Band) %>% 
  summarise(Total_Sales = sum(Total_Amount),Quantity = sum(Quantity))
# Visualizing
ggplot(sales_by_price,aes(Price_Band,Total_Sales,fill = Price_Band))+
  geom_bar(stat = "identity")+
  labs(title = "TOTAL SALES BY PRICE BANDS",y = "Total Amount",x = "Price Band")
#Beauty products sales by  price range
beauty_sales_by_price <- data1 %>%filter(Product_Category == "Beauty") %>% 
  mutate(Price_Band = case_when(Price_per_Unit < 50 ~ "<50",
                                Price_per_Unit >= 50 & Price_per_Unit <= 200 ~ "50 - 200",
                                Price_per_Unit > 200 ~ "201+")) %>% group_by(Price_Band) %>% 
  summarise(Total_Sales = sum(Total_Amount),Quantity = sum(Quantity))

#Clothing products sales by price range
clothing_sales_by_price <- data1 %>%filter(Product_Category == "Clothing") %>% 
  mutate(Price_Band = case_when(Price_per_Unit < 50 ~ "<50",
                                Price_per_Unit >= 50 & Price_per_Unit <= 200 ~ "50 - 200",
                                Price_per_Unit > 200 ~ "201+")) %>% group_by(Price_Band) %>% 
  summarise(Total_Sales = sum(Total_Amount),Quantity = sum(Quantity))

#Electronics products sales by price range
electronics_sales_by_price <- data1 %>%filter(Product_Category == "Electronics") %>% 
  mutate(Price_Band = case_when(Price_per_Unit < 50 ~ "<50",
                                Price_per_Unit >= 50 & Price_per_Unit <= 200 ~ "50 - 200",
                                Price_per_Unit > 200 ~ "201+")) %>% group_by(Price_Band) %>% 
  summarise(Total_Sales = sum(Total_Amount),Quantity = sum(Quantity))


#Temporal trends............................................................................................................................................................................... 
#Sales by day of the week
sales_data <- data1 %>%
  mutate(Day_of_Week = weekdays(as.Date(Date)))
sales_by_day <- sales_data %>%
  group_by(Day_of_Week) %>%
  summarise(Total_Sales = sum(Total_Amount),Quantity = sum(Quantity)) %>% 
  mutate(Day_of_Week = factor(Day_of_Week,levels = c("Monday","Tuesday","Wednesday",
                                                     "Thursday","Friday","Saturday","Sunday"))) %>% 
  arrange(Day_of_Week)
#Visualizing
ggplot(sales_by_day,aes(Day_of_Week,Total_Sales,fill = Day_of_Week))+
  geom_bar(stat = "identity")+
  labs(title = "SALES BY DAY OF WEEK",y = "Total Sales",x = "Day of week")

#Week day sales trend by product category
#Beauty products
beauty_sales_by_day <- sales_data %>%filter(Product_Category == "Beauty") %>% 
  group_by(Day_of_Week) %>%
  summarise(Total_Sales = sum(Total_Amount),Quantity = sum(Quantity)) %>% 
  mutate(Day_of_Week = factor(Day_of_Week,levels = c("Monday","Tuesday","Wednesday",
                                                     "Thursday","Friday","Saturday","Sunday"))) %>% 
  arrange(Day_of_Week)
#Visualizing
ggplot(beauty_sales_by_day,aes(Day_of_Week,Total_Sales,fill = Day_of_Week))+
  geom_bar(stat = "identity")+
  labs(title = "SALES BY DAY OF WEEK",y = "Total Sales",x = "Day of week")
#Clothing products
clothing_sales_by_day <- sales_data %>%filter(Product_Category == "Clothing") %>% 
  group_by(Day_of_Week) %>%
  summarise(Total_Sales = sum(Total_Amount),Quantity = sum(Quantity)) %>% 
  mutate(Day_of_Week = factor(Day_of_Week,levels = c("Monday","Tuesday","Wednesday",
                                                     "Thursday","Friday","Saturday","Sunday"))) %>% 
  arrange(Day_of_Week)
#Visualizing
ggplot(clothing_sales_by_day,aes(Day_of_Week,Total_Sales,fill = Day_of_Week))+
  geom_bar(stat = "identity")+
  labs(title = "SALES BY DAY OF WEEK",y = "Total Sales",x = "Day of week")
#Electronics products
electronic_sales_by_day <- sales_data %>%filter(Product_Category == "Electronics") %>% 
  group_by(Day_of_Week) %>%
  summarise(Total_Sales = sum(Total_Amount),Quantity = sum(Quantity)) %>% 
  mutate(Day_of_Week = factor(Day_of_Week,levels = c("Monday","Tuesday","Wednesday",
                                                     "Thursday","Friday","Saturday","Sunday"))) %>% 
  arrange(Day_of_Week)
#Visualizing
ggplot(electronic_sales_by_day,aes(Day_of_Week,Total_Sales,fill = Day_of_Week))+
  geom_bar(stat = "identity")+
  labs(title = "SALES BY DAY OF WEEK",y = "Total Sales",x = "Day of week")



#Monthly/Quarterly Trends.............................................................................................................................
monthly_sales <- data1 %>% group_by(Month,Year) %>% summarise(Total_Sales = sum(Total_Amount),
                                                              Quantity = sum(Quantity)) %>% 
  mutate(Year = factor(Year,levels = c(2023,2024))) %>% arrange(Year)
ggplot(monthly_sales,aes(Month,Total_Sales,fill = Year))+
  geom_bar(stat = "identity")+
  labs(title = "TOTAL MONTHLY SALES",y = "Total Sales")

#Monthly sales trend by product category
#Beauty products
beauty_monthly_sales <- data1 %>% filter(Product_Category == "Beauty") %>% 
  group_by(Month,Year) %>% summarise(Total_Sales = sum(Total_Amount),
                                                              Quantity = sum(Quantity)) %>% 
  mutate(Year = factor(Year,levels = c(2023,2024))) %>% arrange(Year)
ggplot(beauty_monthly_sales,aes(Month,Total_Sales,fill = Year))+
  geom_bar(stat = "identity")+
  labs(title = "TOTAL MONTHLY SALES",y = "Total Sales")
#Clothing products
clothing_monthly_sales <- data1 %>% filter(Product_Category == "Clothing") %>% 
  group_by(Month,Year) %>% summarise(Total_Sales = sum(Total_Amount),
                                     Quantity = sum(Quantity)) %>% 
  mutate(Year = factor(Year,levels = c(2023,2024))) %>% arrange(Year)
ggplot(clothing_monthly_sales,aes(Month,Total_Sales,fill = Year))+
  geom_bar(stat = "identity")+
  labs(title = "TOTAL MONTHLY SALES",y = "Total Saels")
#Electronics products
electronics_monthly_sales <- data1 %>% filter(Product_Category == "Electronics") %>% 
  group_by(Month,Year) %>% summarise(Total_Sales = sum(Total_Amount),
                                     Quantity = sum(Quantity)) %>% 
  mutate(Year = factor(Year,levels = c(2023,2024))) %>% arrange(Year)
ggplot(electronics_monthly_sales,aes(Month,Total_Sales,fill = Year))+
  geom_bar(stat = "identity")+
  labs(title = "TOTAL MONTHLY SALES",y = "Total Saels")


#Correlation Analysis 
#Correlation between Price quantity and Total Amount
corelation <- cor(data1 %>% select(Quantity,Price_per_Unit,Total_Amount))

