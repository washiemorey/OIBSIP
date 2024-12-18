# OIBSIP
Here have added all the projects i worked on during my one month internship at OASIS INFOBYTE
### : Project1 :Exploratory Data Analysis (EDA) on Retail Sales Data
Here is the[Dataset](https://drive.google.com/file/d/1HsxLZSshRD2o63EJ-DTze6TsFlGDsXO5/view?usp=drive_link) used 
In this project, have worked with a dataset containing information about retail sales. The goal is
to perform exploratory data analysis (EDA) to uncover patterns, trends, and insights that can
help the retail business make informed decisions.
## Key Concepts and Challenges:
## 1.Data Loading and Cleaning: Load the retail sales dataset.
I loaded the data in R then did various cleaning,which included removing sales Id and Customer Id columns 
that aint important in the analysis.
Converted gender and product category into factors
Converted Date column also into date format as it should be.
## 2.Descriptive Statistics: Calculate basic statistics (mean, median, mode, standard deviation).
Here i grouped sales data by product category then did Basic Statistics on Age,
Price Per Unit,Quantity and Total Amount

## 3.Time Series Analysis: Analyze sales trends over time using time series techniques.
Here i grouped my data by Product Category,then converted into daily time series first using zoo library in R 
since days were inconsistent.
Afterwards I filtered 2023 data then grouped further by Month .
Then converted this to quarterly time series ,
Decomposed to other time series components,
Calculated three months moving Average,linear model,Seasonality anaalysis ,then predicted possible future sales using ARIMA model

##  4.Customer and Product Analysis: Analyze customer demographics and purchasing behavior.
On Customer demographics is grouped data by gender first then calculated quantity and Total Sales by gender.

On age I grouped the data into three age categories 18-29,30-50,51and above then analysed total sales and quantity by each age group.

On product category i grouped the data by Product Category then analysed Total Quantity,Total Sales and average Price Per Unit of each category.

On product perfomance by price i categorised price into three bands:<50,50-200,201 and above then grouped the data by there categories.
Analysed total sales,quantity on each band.Did this further on each Product category individually.

On temporal Analysis I added new column on the data named Day of the week,grouped the data by day of the week.
Then Analysed sales and quantity by day of the week.Did this further on each product category.

On monthly sales trend I grouped the data by Months and Years .Then Analysed total sales and Quantity sold monthly.

Did this further on individual prroduct category for more detailed understanding.

Also did correlation Analysis on continous variables Quantity Price Per Unit and Total Amount
## 5.Visualization: Present insights through bar charts, line plots, and heatmaps.
Here i provided visualisation on my findings at every stage
## 6.Recommendations: Provide actionable recommendations based on the EDA.
Based on my analysis and findings i provided various recommendations
click [here](https://drive.google.com/file/d/1IfB28_chCjVYUXWB4lowjTeukhtZjX-H/view?usp=sharing) to acces the recommendations.

### Project 2 Data Cleaning
Data cleaning is the process of fixing or removing incorrect, corrupted, duplicate, or incomplete
data within a dataset. Messy data leads to unreliable outcomes. Cleaning data is an essential
part of data analysis.
Here is the [Dataset](https://drive.google.com/file/d/1-tHKRVvu9mEvSQ0E8FtoC6a8eC-dHl5u/view?usp=sharing) used in this project

Also available on kaggle as New York City Airbnb Open Data

## Missing Data Handling
First I checked for Null values in the dataset which happen to appear in only one column Reviews per month.
Handled these by substituting them by average of values given .

Checked on columns with white spaces then which happen to appear in three columns: name,host name and last review
converted them to Null values aftterwards omitted them from the data 

## Duplicate Removal
Checked if there was any duplicated rows.This is done to ensure data uniqueness

## Did standadization which involved the following:
Removing columns like id,name,host_id,host name and neighbourhood that are not important in analysis process

Converted neighbourhood group and room type into factors since they are categorical data

Converted last review into date format

Renamed the columns approriately.

## Outlier Detection
Peformed this on Continous variables in the data
Plotting numeric columns to see distribution then addressing outliers.Used box plot.

Then calculated quantiles,intequantile range,lower bound and upperbound of the variables

Then standadized values that were far much higher than upper bound by replacing them by average values.



