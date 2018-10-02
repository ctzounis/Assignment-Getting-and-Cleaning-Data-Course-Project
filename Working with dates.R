# make this an external chunk that can be included in any file
options(width = 100)
opts_chunk$set(message = F, error = F, warning = F, comment = NA, fig.align = 'center', dpi = 100, tidy = F, cache.path = '.cache/', fig.path = 'fig/', cache=TRUE)

options(xtable.type = 'html')
knit_hooks$set(inline = function(x) {
  if(is.numeric(x)) {
    round(x, getOption('digits'))
  } else {
    paste(as.character(x), collapse = ', ')
  }
})
knit_hooks$set(plot = knitr:::hook_plot_html)

#Starting simple

d1 = date()
d1
class(d1)

#Date class
#Sys.Date(): gives the date without the time
d2 = Sys.Date()
d2
class(d2)

#Formatting dates

#%d = day as number (0-31), 
#%a = abbreviated weekday,
#%A = unabbreviated weekday, 
#%m = month (00-12), 
#%b = abbreviated month, 
#%B = unabbrevidated month, 
#%y = 2 digit year, 
#%Y = four digit year

format(d2,"%a %b %d")

#Creating dates

x = c("1jan1960", "2jan1960", "31mar1960", "30jul1960"); z = as.Date(x, "%d%b%Y")
z
z[1] - z[2]
as.numeric(z[1]-z[2])

#Converting to Julian

weekdays(d2)
months(d2)
#julian(): This command gives the number of days 
#that occured since the origin where origin is "1970-01-01"
julian(d2)

#Lubridate

library(lubridate); ymd("20140108")
mdy("08/04/2013")
dmy("03-04-2013")

#http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/
  
#  Dealing with times

ymd_hms("2011-08-03 10:15:03")
ymd_hms("2011-08-03 10:15:03",tz="Pacific/Auckland")
?Sys.timezone

#http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/
  
#  Some functions have slightly different syntax

x = dmy(c("1jan2013", "2jan2013", "31mar2013", "30jul2013"))
wday(x[1])
wday(x[1],label=TRUE)

#Notes and further resources

#More information in this nice lubridate tutorial http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/
 # The lubridate vignette is the same content http://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html
#Ultimately you want your dates and times as class "Date" or the classes "POSIXct", "POSIXlt". For more information type ?POSIXlt