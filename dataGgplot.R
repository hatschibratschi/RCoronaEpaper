library(data.table)
library(ggplot2)
library(lubridate)

# working dir
if(Sys.info()['sysname'] == 'Linux'){
  wd = file.path('~/git/github/RCoronaEpaper')
} else {
  wd = file.path('~/git/github/RCoronaEpaper')
}

zipFile = file.path(wd, 'covid19_dashboard_ages_data.zip')
url = 'https://covid19-dashboard.ages.at/data/data.zip'

download.file(url, zipFile)

rawData <- read.table(unz(zipFile, "CovidFaelle_Timeline_GKZ.csv"), header=TRUE, quote="\"", sep=";", dec = ',')
setDT(rawData)
rawData[,time := as.Date(Time, format = '%d.%m.%Y')]
rawData$Time=NULL

data = rawData[time >= Sys.Date() - 366
             , .(Inz7Tage = round((sum(AnzahlFaelle7Tage) / sum(AnzEinwohner)) * 100000,0)
                 , AnzCov = sum(AnzahlFaelle))
             , by = .(time)]

d0 = data[time == max(data$time)]$AnzCov
d7 = data[time == max(data$time)]$Inz7Tage

print(paste('heute', d0, '7t', d7))

p = ggplot(data = data) +
  geom_col(mapping = aes(x = time, y = Inz7Tage), width = 1, fill = 'black') +
  labs(title = paste('heute', d0, '7t', d7)) +
  theme(plot.title = element_text(size = 120),
        panel.grid.major = element_line(size = 1, linetype = 'solid',
                                        colour = "darkgray"),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())

# save plot
f = file.path(wd, 'plot_corona_01.png')
ggsave(filename = f, p, width = 30, height = 13, dpi = 10, units = "in", device='png')

print(Sys.time())
