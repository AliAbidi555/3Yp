library(dplyr)
data <- read.csv("lockdowns/interventions.csv")

for (i in 5:ncol(data)) {
  data[, i] <- format(as.Date(data[, i]), "%d/%m/%Y")
}
names(data)

library(dplyr)
library(tidyverse)
library(lubridate)
data <- as.tibble(data)

# Split the dataset into the different interventions.

stay_home <- data %>% select(1:4, starts_with("stay.at.home"))
stay_home <- stay_home[stay_home$stay.at.home != "01/01/0001", ]


# Replace the max rollback dates with the rollback by state.


for (i in unique(stay_home$STATE)) {
  stay_home$stay.at.home.rollback[stay_home$stay.at.home.rollback == "01/01/0001" &
    stay_home$STATE == i] <-
    max(stay_home$stay.at.home.rollback[stay_home$STATE == i])
}
stay_home$stay.at.home.rollback[stay_home$stay.at.home.rollback == "01/01/0001"] <-
  max(stay_home$stay.at.home.rollback)


fifty <- data %>% select(1:4, starts_with("X.50.gatherings"))
fifty <- fifty[fifty$X.50.gatherings != "01/01/0001", ]



for (i in unique(fifty$STATE)) {
  fifty$X.50.gatherings.rollback[fifty$X.50.gatherings.rollback == "01/01/0001" &
    fifty$STATE == i] <-
    max(fifty$X.50.gatherings.rollback[fifty$STATE == i])
}

fifty$X.50.gatherings.rollback[fifty$X.50.gatherings.rollback == "01/01/0001"] <-
  max(fifty$X.50.gatherings.rollback)


five_hundred <- data %>% select(1:4, starts_with("X.500.gatherings"))
five_hundred <-
  five_hundred[five_hundred$X.500.gatherings != "01/01/0001", ]

for (i in unique(five_hundred$STATE)) {
  five_hundred$X.500.gatherings.rollback[five_hundred$X.500.gatherings.rollback ==
    "01/01/0001" &
    five_hundred$STATE == i] <-
    max(five_hundred$X.500.gatherings.rollback[five_hundred$STATE == i])
}

five_hundred$X.500.gatherings.rollback[five_hundred$X.500.gatherings.rollback ==
  "01/01/0001"] <- max(five_hundred$X.500.gatherings.rollback)

travel_ban <- data %>% select(1:4, starts_with("foreign"))

travel_ban <- travel_ban[travel_ban$foreign.travel.ban != "01/01/0001", ]
data1 <- stay_home %>% select(2, starts_with("stay.at"))


mid <-
  data1 %>% mutate(across(c(stay.at.home, stay.at.home.rollback), lubridate::dmy), date = list(seq(
    min(stay.at.home, stay.at.home.rollback),
    max(stay.at.home, stay.at.home.rollback),
    "day"
  )))

mid <- mid %>%
  tidyr::unnest(date) %>%
  mutate(across(c(stay.at.home, stay.at.home.rollback), ~ +(. == date)))


write.csv(stay_home, "outputs/stay_home.csv")


# Convert the end and start dates to  a string of 1s


d1 <-
  mid %>%
  group_by(FIPS) %>%
  mutate(ld = as.integer(between(
    row_number(),
    match(1, stay.at.home),
    match(1, stay.at.home.rollback)
  ))) %>%
  select(FIPS, date, ld)

write_csv(d1, "outputs/lockdown_status.csv")
