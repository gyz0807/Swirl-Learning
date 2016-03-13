# Unfortunately, due to different date and time representations, this lesson is only guaranteed to work
# with an "en_US.UTF-8" locale. To view your locale, type Sys.getlocale("LC_TIME").

library(lubridate)

# Type help(package = lubridate) to bring up an overview of the package, including the package DESCRIPTION, 
# a list of available functions, and a link to the official package vignette.

# The today() function returns today's date.
this_day <- today()

year(this_day)  # Get year
month(this_day)  # Get month
day(this_day)  # Get day
wday(this_day)  # Get the day of week (1 = Sunday, 2 = Monday, 3 = Tuesday ...)
wday(this_day, label = TRUE)  # Display the name of the weekday (factor output)


# In addition to handling dates, lubridate is great for working with date and time combinations, referred
# to as date-times. The now() function returns the date-time representing this exact moment in time. 

this_moment <- now()
hour(this_moment)  # Get hour
minute(this_moment)  # Get minute
second(this_moment)  # Get second

# Fortunately, lubridate offers a variety of functions for parsing date-times. These functions take the
# form of ymd(), dmy(), hms(), ymd_hms(), etc., where each letter in the name of the function stands for
# the location of years (y), months (m), days (d), hours (h), minutes (m), and/or seconds (s) in the
# date-time being read in.

my_date <- ymd("1989-05-17")  # "1989-05-17 UTC"
class(my_date)  # [1] "POSIXct" "POSIXt"
ymd("1989 May 17")
mdy("March 12, 1975")
dmy(25081985)  # 25081985 represents "the 25th day of August 1985", so use dmy(). Output: "1985-08-25 UTC"

# In addition to dates, we can parse date-times.
dt1   # [1] "2014-08-23 17:23:02"
ymd_hms(dt1)  # "2014-08-23 17:23:02 UTC"
hms("03:22:14")  # [1] "3H 22M 14S"


# The update() function allows us to update one or more components of a date-time. For example, let's say
# the current time is 08:34:55 (hh:mm:ss). Update this_moment to the new time using the following
# command:

this_moment <- update(this_moment, hours = 8, minutes = 34, seconds = 55)

# Now, pretend you are in New York City and you are planning to visit a friend in Hong Kong. You seem to
# have misplaced your itinerary, but you know that your flight departs New York at 17:34 (5:34pm) the day
# after tomorrow. You also know that your flight is scheduled to arrive in Hong Kong exactly 15 hours and
# 50 minutes after departure.

# Let's reconstruct your itinerary from what you can remember, starting with the full date and time of
# your departure. We will approach this by finding the current date in New York, adding 2 full days, then
# setting the time to 17:34.

# To find the current date in New York, we'll use the now() function again. This time, however, we'll
# specify the time zone that we want: "America/New_York". Store the result in a variable called nyc.

nyc <- now("America/New_York")

# For a complete list of valid time zones for use with lubridate, check out the following Wikipedia page:
# http://en.wikipedia.org/wiki/List_of_tz_database_time_zones

depart <- nyc + days(2)  ## Adding two days

depart <- update(depart, hours = 17, minutes = 34)  ## depart time nyc

arrive <- depart + hours(15) + minutes(50)  ## arrive time nyc

arrive <- with_tz(arrive, tzone = "Asia/Hong_Kong")   ## arrive time HK

# Fast forward to your arrival in Hong Kong. You and your friend have just met at the airport and you
# realize that the last time you were together was in Singapore on June 17, 2008. Naturally, you'd like
# to know exactly how long it has been.

last_time <- mdy("June 17, 2008", tz = "Singapore")

how_long <- interval(last_time, arrive)  ## Find out how long has it been since the last meet

as.period(how_long)  ## See how long it has been

# This is where things get a little tricky. Because of things like leap years, leap seconds, and daylight
# savings time, the length of any given minute, day, month, week, or year is relative to when it occurs.
# In contrast, the length of a second is always the same, regardless of when it occurs.

# To address these complexities, the authors of lubridate introduce four classes of time related objects:
# instants, intervals, durations, and periods. These topics are beyond the scope of this lesson, but you
# can find a complete discussion in the 2011 Journal of Statistical Software paper titled 'Dates and
# Times Made Easy with lubridate'.

