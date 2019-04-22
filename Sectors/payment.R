rm(list = ls(all=TRUE))
library(plotly)

teachers = read.csv('teachers.csv', header = TRUE)
positions = c("Mining", "Agriculture", "Construction",
              "Finance", "Government", "Education", "Health")
years = length(teachers[,1])

allStaffs = data.frame(teachers[,1],
                       teachers[,2],
                       rep(positions[1], years))
names(allStaffs) = c("years","people","position")
for(tid in seq(3,8))
{

    temp = data.frame(teachers[,1],
                      teachers[,tid],
                      rep(positions[tid-1],years))

  names(temp) = c("years","people","position")
  allStaffs = rbind(allStaffs,temp)
}

p<-plot_ly(allStaffs, x=~years, y=~people, color=~position) %>%
   add_lines() %>%
  layout(title = "Employee numbers by sectors in 1995-2015 (thousands)",
         xaxis = list(title = "Year"),
         yaxis = list(title = "Employees"))
p
htmlwidgets::saveWidget(p, "index.html")
