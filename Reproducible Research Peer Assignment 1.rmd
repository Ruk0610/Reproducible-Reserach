# Loading and preprocessing the data

1. Load the data (i.e. read.csv())

Activity <- read.csv("activity.csv")

2. Process/transform the data (if necessary) into a format suitable for your analysis

Answer: Process/Transform of data was not needed

# What is mean total number of steps taken per day?

Calculate the total number of steps taken per day

Total_steps_per_day <- sum(Activity$steps, na.rm = TRUE)

Total_steps_per_day
[1] 570608

2. If you do not understand the difference between a histogram and a barplot, research the difference between them. Make a histogram of the total number of steps taken each day

Total_steps_each_day <- aggregate(steps~date, data = Activity, FUN = sum, na.rm = TRUE)

Total_steps_each_day

date steps
1.  2012-10-02   126
2.  2012-10-03 11352
3.  2012-10-04 12116
4.  2012-10-05 13294
5.  2012-10-06 15420
6.  2012-10-07 11015
7.  2012-10-09 12811
8.  2012-10-10  9900
9.  2012-10-11 10304
10. 2012-10-12 17382
11. 2012-10-13 12426
12. 2012-10-14 15098
13. 2012-10-15 10139
14. 2012-10-16 15084
15. 2012-10-17 13452
16. 2012-10-18 10056
17. 2012-10-19 11829
18. 2012-10-20 10395
19. 2012-10-21  8821
20. 2012-10-22 13460
21. 2012-10-23  8918
22. 2012-10-24  8355
23. 2012-10-25  2492
24. 2012-10-26  6778
25. 2012-10-27 10119
26. 2012-10-28 11458
27. 2012-10-29  5018
28. 2012-10-30  9819
29. 2012-10-31 15414
30. 2012-11-02 10600
31. 2012-11-03 10571
32. 2012-11-05 10439
33. 2012-11-06  8334
34. 2012-11-07 12883
35. 2012-11-08  3219
36. 2012-11-11 12608
37. 2012-11-12 10765
38. 2012-11-13  7336
39. 2012-11-15    41
40. 2012-11-16  5441
41. 2012-11-17 14339
42. 2012-11-18 15110
43. 2012-11-19  8841
44. 2012-11-20  4472
45. 2012-11-21 12787
46. 2012-11-22 20427
47. 2012-11-23 21194
48. 2012-11-24 14478
49. 2012-11-25 11834
50. 2012-11-26 11162
51. 2012-11-27 13646
52. 2012-11-28 10183
53. 2012-11-29  7047

2. Make a histogram of the total number of steps taken each day
hist(Total_steps_each_day$steps)

For histogram see Plot1.png

3. Calculate and report the mean and median of the total number of steps taken per day

Total_steps_each_day_mean <- mean(Total_steps_each_day$steps)

## [1] 10766.19

Total_steps_each_day_median <- median(Total_steps_each_day$steps)

## [1] 10765

#  What is the average daily activity pattern?

1. Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)

Five_minutes_average <- aggregate(steps~interval, data = Activity,FUN = mean, na.rm = TRUE)
plot(x = Five_miuntes_average$interval, y = Five_miuntes_average$steps, type = "1")

For plot see Plot2.png

2. Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?

max_steps <- max(Five_minutes_average$steps)
for (i in 1:228)
{
  if (Five_minutes_average$steps[i] == max_steps)
    five_minutes_interval_at_max_steps <- Five_minutes_average$interval[i]
}
five_minutes_interval_at_max_steps

## [1] 835

# Imputting missing values

1. Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)

total_na <- 0
for (i in 1:17568) 
{
  if(is.na(Activity$steps[i]))
    total_na <- total_na+1
}
total_na

# [1] 2304

2. Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.
 
Ans: Strategy will be to fill in the dataset with the mean of 5 minute interval  

3. Create a new dataset that is equal to the original dataset but with the missing data filled in.

Activity_filled_in <- Activity
for (i in 1:17568) 
{
  if (is.na(Activity_filled_in$steps[i]))
  {
    Five_minutes_pointer <- Activity_filled_in$interval[i]
    for (j in 1:288) 
      {
        if (Five_minutes_average$interval[j] == Five_minutes_pointer)      
          Activity_filled_in$steps[i] <- Five_minutes_average$steps[j]
    }
  }
}


4a. Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?

Total_steps_each_day_filled_in <- aggregate(steps~date, data = Activity_filled_in, FUN = sum, na.rm = TRUE)

hist(Total_steps_each_day_filled_in$steps)

For Histogram see plot3.png

4b. Calculate the mean and median and explain the imoact of imputing missing data on the estimates of the total daily number of steps

# Mean
Total_steps_each_day_mean_filled_in <- mean(Total_steps_each_day_filled_in$steps)

# [1] 10766.19

# Median

Total_steps_each_day_median_filled_in <- median(Total_steps_each_day_filled_in$steps)
# [1] 10766.19

# Are there difference in activity pattern between weekdays and weekends?

1. Creating a new factor variable in the dataset with two levels - "weekely" and "weekend" indicating wheather a given date is a weekday or weekend day.

I have used the wday() function

Week <- wday(Activity_filled_in$date)
week_day <- week
for (i in 1:17568) 
  {
    if(week[i]== 1)
      week_day[i] <- 'weekend'
    if(week[i]== 2)
      week_day[i] <- 'weekday'
    if(week[i]== 3)
      week_day[i] <- 'weekday'
    if(week[i]== 4)
      week_day[i] <- 'weekday'
    if(week[i]== 5)
      week_day[i] <- 'weekday'
    if(week[i]== 6)
      week_day[i] <- 'weekday'
    if(week[i]== 7)
      week_day[i] <- 'weekend'
}

Activity_filled_in$weekday <- week_day

2. Make a panel plot containing a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). See the README file in the GitHub repository to see an example of what this plot should look like using simulated data.

weekday <- grep("weekday", Activity_filled_in$weekday)
weekday_frame <- Activity_filled_in[weekday,]
weekend_frame <- Activity_filled_in[-weekday,]

Five_minutes_average_weekday <- aggregate(steps~interval, data = weekday_frame, FUN = mean, na.rm = TRUE)
Five_minutes_average_weekend <- aggregate(steps~interval, data = weekend_frame, FUN = mean, na.rm = TRUE)

plot(x = Five_minutes_average_weekday$interval, y = Five_minutes_average_weekday$steps, type = "1")

For plot see plot4.png

plot(x = Five_minutes_average_weekend$interval, y = Five_minutes_average_weekend$steps, type = "1")

For Plot see plot5.png
