#...........LINEAR REGRESSION MODEL ...............#
#...........DONE BY WASHINGTONE MOREY OBURU................#
#.........ON 17,DECEMBER,2023...............................#
#.........DATA ANALYSIS AT OASIS INFOBYTE........#

#Im[porting data into R
data <- read.csv("C:\\Users\\hp\\OneDrive\\Desktop\\OASIS INTERN\\Housing.csv",header = TRUE)
#Selecting required columns needed to build model
library(tidyverse)
data <- data %>% select(area,bedrooms,bathrooms,stories,parking,price) %>% 
  rename(Area = area,               #Renaming columns
         Bedrooms = bedrooms,
         Bathrooms = bathrooms,
         Stories = stories,
         Parking = parking,
         Price = price)
#Exploring the data
summary(data)
#Checking for NA values
colSums(is.na(data))

#Checking for out liers in Area and Price column and replacing by mean value
#Area
boxplot(data$Area,main = "AREA DISTRIBUTION",horizontal = TRUE)
quantiles <- quantile(data$Area,probs = c(0.25,0.75))
iqr <- quantiles[2] - quantiles[1]    #Interquatile range
lower_bound <- quantiles[1] - 1.5 * iqr
upper_bound <- quantiles[2] + 1.5 * iqr
data$Area[data$Area > upper_bound] <- mean(data$Area[data$Area <= upper_bound])
boxplot(data$Area,main = "AREA DISTRIBUTION",horizontal = TRUE)
#Price
boxplot(data$Price,main = "PRICE DISTRIBUTION",horizontal = TRUE)
quantiles <- quantile(data$Price,probs = c(0.25,0.75))
iqr <- quantiles[2] - quantiles[1]    #Interquatile range
lower_bound <- quantiles[1] - 1.5 * iqr
upper_bound <- quantiles[2] + 1.5 * iqr
data$Price[data$Price > upper_bound] <- mean(data$Price[data$Price <= upper_bound])
boxplot(data$Area,main = "PRICE DISTRIBUTION",horizontal = TRUE)

#Visualizing variables distribution 
plot(data)

#Pre Resample test before building the model

#Testing for Multicollinearity among independent variables
corelation_matrix <- cor(data %>% select(Area,Bedrooms,Stories,Parking))
#Ploting the matrix
library(corrplot)
corrplot(corelation_matrix)

library(car)
model <- lm(Price ~.,data = data)
vif(model)

#Testing for Normality on continous indipendent variables
#Normality test on Area
hist(data$Area,probability = TRUE,main = "HISTOGRAM WITH DENSITY PLOT FOR AREA",
     col = "skyblue",xlab = "Area")
lines(density(data$Area),col = "red",lwd = 2)
shapiro.test(data$Area)

#Transforming area to be normaly distributed
#Taking log of Area
data$Arealog <- log(data$Area)
hist(data$Arealog,probability = TRUE,main = "HISTOGRAM WITH DENSITY PLOT FOR AREA LOG",
     xlab = "Area Log",col = "skyblue")
lines(density(data$Arealog),col = "red",lwd =2)
shapiro.test(data$Arealog)

#Taking Square root of Area
data$AreaRoot <- sqrt(data$Area)
hist(data$AreaRoot,probability = TRUE,main = "HISTOGRAM WITH DENSITY PLOT FOR AREA SQUARE ROOT",
     xlab = "Area Square Root",col = "skyblue")
lines(density(data$AreaRoot),col = "red",lwd =2)
shapiro.test(data$AreaRoot)

#Building the model
#Selecting Area Log to use in building model 
data1 <- data %>% select(Arealog,Bedrooms,Bathrooms,Parking,Stories,Price)

#Splitting data into train and test data
set.seed(123)
library(caTools)
split <- sample.split(data1$Price,SplitRatio = 0.7)
training_data <-subset(data1,split == TRUE)
testing_data <- subset(data1,split == FALSE)

#Building model
model <- lm(Price ~.,data = training_data)
summary(model)

#Removing Bedrooms from the model since it is insignificant
model <- lm(Price~.-Bedrooms,data = training_data)
summary(model)

#Predicting price using the model
predicted_price <- predict(model,testing_data)

#Creating data frame on predicted and actual price
data_frame <- data.frame(PREDICTED_PRICE = predicted_price,ACTUAL_PRICE = testing_data$Price)

#Model Evaluation
#Checking on Error and RSquared
error <- sqrt(mean(data_frame$PREDICTED_PRICE - data_frame$ACTUAL_PRICE)^2)
library(caret)
postResample(data_frame$PREDICTED_PRICE,data_frame$ACTUAL_PRICE)


#Plotting actual vs predicted price
plot(data_frame$ACTUAL_PRICE,type = "l",main = "ACTUAL AND PREDICTED PRICE VISUALIZATION",
     ylab = "Price",col ="blue",lwd =2)
lines(data_frame$PREDICTED_PRICE,col = "red",type = "l",lwd =2) #Adding pr4edicted price
legend("topright",                                # Position of the legend
       legend = c("Actual Price", "Predicted Price"), # Labels for the legend
       col = c("blue", "red"),                    # Colors matching the lines
       lty = 1,                                   # Line type
       lwd = 2,                                   # Line width
       bty = "n")   

