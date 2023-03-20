# ical testing.R
# demonstrating use of the ical package to determine hidden attributes of calendar events
# e.g. find out when a google calendar event was created or modified

# Note: ical package misses the Created tag

require(dplyr)
require(ical)
require(calendar)

# supply the path to the file 
ical_file <- "~/Desktop/swaynetheresa@gmail.com.ical/Confocal Use_cu.anes.confocal@gmail.com.ics"

# parse the file into columns
mycal <- ical_parse_df(ical_file)

# gives error
# myothercal <- ic_read(ical_file)

# dates are already parsed as POSIXct so you can compare them
recent <- mycal %>%
  filter(start > '2023-01-01')

