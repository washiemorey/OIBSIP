#...........CLEANING DATA ...............#
#...........DONE BY WASHINGTONE MOREY OBURU................#
#.........ON 14,DECEMBER,2023...............................#
#.........DATA ANALYSIS AT OASIS INFOBYTE........#
#Importing data into R
data <- read.csv("C:\\Users\\hp\\OneDrive\\Desktop\\OASIS INTERN\\AB_NYC_2019.csv",
                 header = TRUE)
#Checking for missing values in the data
sum(is.na(data))        #NA values in whole data
colSums(is.na(data))     #NA values in each column

library(tidyverse)

#Checking for entries with white spaces or empty strings
sum(trimws(data$name) == "", na.rm = TRUE) #White spaces in name column
sapply(data, function(col) sum(trimws(col) == "", na.rm = TRUE)) #White spaces in each column

#Replacing NA values in review per month column by Average of values given
data <- data %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .)))

#Replacing white spaces in the data with NA values
#Convert White Spaces to NA Across All Columns
data <- data.frame(lapply(data, function(column) {
  ifelse(trimws(column) == "", NA, column)
}), stringsAsFactors = FALSE)
colSums(is.na(data))
#Removing NA values in the data
data1 <- data %>% na.omit()

#Checking for duplicated rows in the data
sum(duplicated(data1))

#Standadization
#Excluding id,name, host id,neighbourhood from the data
data1 <- data1 %>% select(-id,-name,-host_id,-host_name,-neighbourhood) %>%
  mutate(neighbourhood_group = as.factor(neighbourhood_group),   #Converting neighbourhood_group &
         room_type  = as.factor(room_type)) %>%                 #room_type into groups
  mutate(last_review = as.Date(last_review,format("%Y-%m-%d"))) %>%  #Converting last review into date format
  rename(Neighbourhood_Group = neighbourhood_group,        #Renaming columns
         Longitude= longitude,
         Price = price,
         Reviews = number_of_reviews,
         Monthly_Reviews = reviews_per_month,
         Availability = availability_365,
         Latitude = latitude,
         Room_Type = room_type,
         Minimun_Nights = minimum_nights,
         Last_Review = last_review,
         Host_Listings_Count = calculated_host_listings_count)


#Plotting numeric columns to see distribution then addressing outliers
#Price
plot(data1$Price)
abline(h = seq(0,2000,200))
boxplot(data1$Price,horizontal = TRUE,main = "PRICE DISTRIBUTION")
quantiles <- quantile(data1$Price, probs = c(0.25, 0.75))
iqr <- quantiles[2] - quantiles[1]  # Interquartile Range
lower_bound <- quantiles[1] - 1.5  * iqr
upper_bound <- quantiles[2] + 1.5 * iqr
#Replacing outliers by average values
data1$Price[data1$Price > upper_bound] <- mean(data1$Price[data1$Price <= upper_bound])
data1$Price[data1$Price < lower_bound] <- mean(data1$Price[data1$Price >= lower_bound])
boxplot(data1$Price,horizontal = TRUE,main = "PRICE DISTRIBUTION")

#Minimun Nights
boxplot(data1$Minimun_Nights,main = "MINIMUM NIGHTS DISTRIBUTION",horizontal = TRUE)
quantiles <- quantile(data1$Minimun_Nights,probs = c(0.25,0.75))
iqr <- quantiles[2] - quantiles[1]
lowerbound <- quantiles[1] - 1.5 * iqr
upperbound <- quantiles[2] + 1.5 * iqr
#Replacing outliers by average values
data1$Minimun_Nights[data1$Minimun_Nights > upperbound] <- mean(data1$Minimun_Nights[data1$Minimun_Nights <= upperbound])
data1$Minimun_Nights[data1$Minimun_Nights < lowerbound] <- mean(data1$Minimun_Nights[data1$Minimun_Nights >= lowerbound])                                                             
boxplot(data1$Minimun_Nights,main = "MINIMUM NIGHTS DISTRIBUTION",horizontal = TRUE)

#Reviews
boxplot(data1$Reviews,horizontal = TRUE,main = "REVIEWS DISTRIBUTION")
quantiles <- quantile(data1$Reviews,probs = c(0.25,0.75))
iqr <- quantiles[2] - quantiles[1]
lower_bound <- quantiles[1] - 1.5 * iqr
upper_bound <- quantiles[2] + 1.5 * iqr
data1$Reviews[data1$Reviews > upper_bound] <- mean(data1$Reviews[data1$Reviews <= upper_bound])
data1$Reviews[data1$Reviews < lower_bound] <- mean(data1$Reviews[data1$Reviews >= lower_bound])
boxplot(data1$Reviews,horizontal = TRUE,main = "REVIEWS DISTRIBUTION")

#Monthly Reviews
boxplot(data1$Monthly_Reviews,main = "MONTHLY REVIEWS DISTRIBUTION",horizontal = TRUE)
quantiles <- quantile(data1$Monthly_Reviews,probs = c(0.25,0.75))
iqr <- quantiles[2] -quantiles[1]
lower_bound <- quantiles[1] - 1.5 * iqr
upper_bound <- quantiles[2] + 1.5 * iqr
data1$Monthly_Reviews[data1$Monthly_Reviews > upper_bound] <- mean(data1$Monthly_Reviews[data1$Monthly_Reviews <= upper_bound])
data1$Monthly_Reviews[data1$Monthly_Reviews < lower_bound] <- mean(data1$Monthly_Reviews[data1$Monthly_Reviews >= lower_bound])
boxplot(data1$Monthly_Reviews,main = "MONTHLY REVIEWS DISTRIBUTION",horizontal = TRUE)

#Host_Listings_Count
boxplot(data1$Host_Listings_Count,main ="HOST LISTINGS COUNT DISTRIBUTION",horizontal = TRUE)
quantiles <- quantile(data1$Host_Listings_Count,probs = c(0.25,0.75))
iqr <- quantiles[2] - quantiles[1]
lower_bound <- quantiles[1] - 1.5 * iqr
upper_bound <- quantiles[2] + 1.5 * iqr
data1$Host_Listings_Count[data1$Host_Listings_Count > upper_bound] <- mean(data1$Host_Listings_Count[data1$Host_Listings_Count <= upper_bound])
boxplot(data1$Host_Listings_Count,main ="HOST LISTINGS COUNT DISTRIBUTION",horizontal = TRUE)

