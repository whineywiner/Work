gc()

library(sp)
library(maps)
library(maptools)
library(stringr)
library(gdata)
library(likert)
#library(HH)
library(readxl)
library(dplyr)
library(MASS) 
library(reshape2) 
library(reshape) 
library(highcharter)
library(mapview)
library(leaflet)
library(raster)
library(rgdal)
library(RColorBrewer)
library(lubridate)
library(htmlwidgets)
library(viridis)
library(stringr)
library(tidycensus)
library(tidyverse)
library(tigris)
library(scales)
library(dplyr)
options(tigris_use_cache = TRUE)


data = final

#data <- read.csv("~/Downloads/imputed_chalicedata_vytalogy.csv")


#### Vytalogy change creative Type ####
# creative = data %>% dplyr::select(c(93))
# #creative <- as.data.frame(data[,c(73)])
# 
# library(stringr)
# creative = data.frame(do.call(rbind, str_split(creative$Creative.Name , "_")))
# creative = creative %>% dplyr::select(c(7, 11:14))
# colnames(creative) <- c('Ad_served_on','Platform','type', 'creative', "octx")
# data = cbind(data,creative)
#data <- read.csv("~/Downloads/Chalice_lift/Chalice Precision Strategies SEIU Campaign (Raw) (2).csv")

#### Family Dollar change creative Type ####

# 
creative = data %>% dplyr::select(c(73))
# #creative <- as.data.frame(data[,c(73)])
#
library(stringr)
creative = data.frame(do.call(rbind, str_split(creative$Creative.Name , "-")))
creative = creative %>% dplyr::select(c(2:3))
## creative = data.frame(do.call(rbind, str_split(creative$X3 , " ")))
## creative = creative %>% dplyr::select(c(2))
colnames(creative) <- c("creativename",'creativeduration')
creative$creativeduration[grepl("15",creative$creativeduration)]<-"15s"
creative$creativeduration[grepl("6",creative$creativeduration)]<-"6s"
creative$creativeduration[grepl("30",creative$creativeduration)]<-"30s"

data = cbind(data,creative)
# #data <- read.csv("~/Downloads/Chalice_lift/Chalice Precision Strategies SEIU Campaign (Raw) (2).csv")


## Download source file, unzip and extract into table
ZipCodeSourceFile = "http://download.geonames.org/export/zip/US.zip"
temp <- tempfile()
download.file(ZipCodeSourceFile , temp)
ZipCodes <- read.table(unz(temp, "US.txt"), sep="\t")
unlink(temp)
names(ZipCodes) = c("CountryCode", "Demo.ZIP", "PlaceName", 
                    "state_name", "Stateabb", "County", "fipscountycode", 
                    "AdminName3", "AdminCode3", "latitude", "longitude", "accuracy")



df = merge(data, ZipCodes, all.x = TRUE, by="Demo.ZIP")



####### Geog Plots ##########

# necessaryPackages <- c("foreign","reshape","rvest","tidyverse","dplyr","stringr","ggplot2", "stargazer","readr", "haven", "readxl")
# new.packages <- necessaryPackages[
#   !(necessaryPackages %in% installed.packages()[,"Package"])]
# if(length(new.packages)) install.packages(new.packages)
# lapply(necessaryPackages, require, character.only = TRUE)
# library(dplyr)
# library(maps)
# #install.packages(c('gapminder','ggplot2','gganimate','gifski'))
# library(gganimate)
# library(gifski)

# write.csv(df, '~/Downloads/df.csv')

###########################################################

# 
# [1] "Demo.ZIP"                                                                         
# [2] "Session.ID"                                                                       
# [3] "Response.Date"                                                                    
# [4] "Demo.Age"                                                                         
# [5] "Demo.Gender"                                                                      
# [6] "Demo.Income"                                                                      
# [7] "Demo.Industry"                                                                    
# [8] "Demo.Ethnicity"                                                                   
# [9] "Demo.Hispanic"                                                                    
# [10] "Demo.State"                                                                       
# [11] "Demo.Region"                                                                      
# [12] "Demo.Education"                                                                   
# [13] "Demo.Occupation"                                                                  
# [14] "Custom.Variables"                                                                 
# [15] "Impression.Date"                                                                  
# [16] "Group"                                                                            
# [17] "Site.ID"                                                                          
# [18] "Site.Name"                                                                        
# [19] "Site.Group.Name"                                                                  
# [20] "Placement.ID"                                                                     
# [21] "Placement.Name"                                                                   
# [22] "Placement.Group.Name"                                                             
# [23] "Creative.ID"                                                                      
# [24] "Creative.Name"                                                                    
# [25] "Creative.Group.Name"                                                              
# [26] "Device"                                                                           
# [27] "Media.Channel"                                                                    
# [28] "Tracked.Media"                                                                    
# [29] "Frequency"                                                                        
# [30] "Focus.on.Issues"                                                                  
# [31] "Purchase.Intent"                                                                  
# [32] "Vote.Choice"                                                                      
# [33] "baseline_Category.Recency"                                                        
# [34] "TV..baseline_Past.Media.Exposure"                                                 
# [35] "Social.Media..baseline_Past.Media.Exposure"                                       
# [36] "Website.Mobile.App..baseline_Past.Media.Exposure"                                 
# [37] "Radio..baseline_Past.Media.Exposure"                                              
# [38] "Billboard..baseline_Past.Media.Exposure"                                          
# [39] "Newspaper.Magazine..baseline_Past.Media.Exposure"                                 
# [40] "Other..baseline_Past.Media.Exposure"                                              
# [41] "I.have.not.seen.heard.an.ad.for.this.brand.recently..baseline_Past.Media.Exposure"
# [42] "PC..Laptop.or.Desktop...baseline_Device.Usage"                                    
# [43] "Connected.TV..Smart.TV..Roku..Apple.TV..Chromecast..etc....baseline_Device.Usage" 
# [44] "Mobile.Tablet.device..baseline_Device.Usage"                                      
# [45] "Other..baseline_Device.Usage"                                                     
# [46] "I.have.not.watched.TV.shows.or.movies.in.the.past.30.days..baseline_Device.Usage" 
# [47] "baseline_Voter.Registration"                                                      
# [48] "baseline_Voter.Turnout"                                                           
# [49] "baseline_Party.ID..democratic.republican.etc."                                    
# [50] "baseline_Ideology..liberal.conservation.etc."                                     
# [51] "baseline_Political.interest..political.engagement."                               
# [52] "Weight"                                                                           
# [53] "Strata"                                                                           
# [54] "CountryCode"                                                                      
# [55] "PlaceName"                                                                        
# [56] "state_name"                                                                       
# [57] "Stateabb"                                                                         
# [58] "County"                                                                           
# [59] "fipscountycode"                                                                   
# [60] "AdminName3"                                                                       
# [61] "AdminCode3"                                                                       
# [62] "latitude"                                                                         
# [63] "longitude"                                                                        
# [64] "accuracy" 

df$date <- as.POSIXct( df$Response.Date, format="%Y-%m-%d" )

df = df %>%
  separate(date, sep=" ", into = c("date", "timezone"))


#df = df[df$date >= "2023-01-05" , ]

df$date = as.Date(df$date)



## df = df %>%
##   separate(day, sep=" ", into = c("date","x"))
## df$x = NULL
## df$Date<-as.Date(with(df,paste(year,month,date,sep="-")),"%Y-%m-%d")

df$week <- as.integer(format(df$date, "%V"))
sort(unique(df$week))

# 
# df$week[df$week == '42'] <- '1'
# df$week[df$week == '43'] <- '2'
# df$week[df$week == '44'] <- '3'
# df$week[df$week == '45'] <- '4'
# df$week[df$week == '46'] <- '5'
# df$week[df$week == '47'] <- '6'
# df$week[df$week == '48'] <- '7'
# df$week[df$week == '49'] <- '8'
# df$week[df$week == '50'] <- '9'
# df$week[df$week == '51'] <- '10'
# df$week[df$week == '52'] <- '11'

# 
df$week[df$week == '1'] <- '9'
df$week[df$week == '2'] <- '10'
df$week[df$week == '3'] <- '11'
df$week[df$week == '4'] <- '12'
df$week[df$week == '5'] <- '13'

df$week[df$week == '44'] <- '1'
df$week[df$week == '45'] <- '2'
df$week[df$week == '46'] <- '3'
df$week[df$week == '47'] <- '4'
df$week[df$week == '48'] <- '5'
df$week[df$week == '49'] <- '6'
df$week[df$week == '50'] <- '7'
df$week[df$week == '51'] <- '8'

#

df$week <- as.numeric(as.character(df$week))
df = df[order(df$week),]

# df$Weekname = "Week"
table(df$date, df$week)
# 
# df$Weekname[df$week == '1'] <- '10/20'
# df$Weekname[df$week == '2'] <- '10/24'
# df$Weekname[df$week == '3'] <- '10/31'
# df$Weekname[df$week == '4'] <- '11/07'
# df$Weekname[df$week == '5'] <- '11/14'
# df$Weekname[df$week == '6'] <- '11/21'
# df$Weekname[df$week == '7'] <- '11/28'
# df$Weekname[df$week == '8'] <- '12/05'
# df$Weekname[df$week == '9'] <- '12/12'
# df$Weekname[df$week == '10'] <- '12/19'
# df$Weekname[df$week == '11'] <- '12/26'

# 


df$Weekname[df$week == '1'] <- '11/02/22'
df$Weekname[df$week == '2'] <- '11/07/22'
df$Weekname[df$week == '3'] <- '11/14/22'
df$Weekname[df$week == '4'] <- '11/21/22'
df$Weekname[df$week == '5'] <- '11/28/22'
df$Weekname[df$week == '6'] <- '12/05/22'
df$Weekname[df$week == '7'] <- '12/12/22'
df$Weekname[df$week == '8'] <- '12/19/22'
df$Weekname[df$week == '9'] <- '01/05/23'
df$Weekname[df$week == '10'] <- '01/09/23'
df$Weekname[df$week == '11'] <- '01/16/23'
df$Weekname[df$week == '12'] <- '01/23/23'
df$Weekname[df$week == '13'] <- '01/28/23'

# df$Weekname[df$week == '1'] <- '01/05/23'
# df$Weekname[df$week == '2'] <- '01/09/23'
# df$Weekname[df$week == '3'] <- '01/16/23'


# df$weekgiven <- paste(df$Weekname,df$week)
# 
# 
# 
# df$Focus.on.Issues[df$Focus.on.Issues == '2'] <- '1'
# df$Purchase.Intent[df$Purchase.Intent == '2'] <- '1'
# 
# # NY, AZ, PA, GA, TX, and NV 

# 
# df <- with(df, df[order(Demo.State, week),])
######### Wrong zip codes ############

# 
# df<-df[!(df$Demo.ZIP=="83438"),] #Idaho
# df<-df[!(df$Demo.ZIP=="98101"),] # Wa
# 
#df<-df[!(df$Demo.State==""),] # Wa

df = df[df$date >= "2023-01-05" , ]

########################
df$Demo.Age = as.numeric(df$Demo.Age)
df["Age Group"] = cut(df$Demo.Age, c(0, 18, 24, 34, 44, 54, 64, Inf), c("0-18", "19-24", "25-34", "35-44", "45-54", "55-64", "65+"), include.lowest=TRUE)
df <- with(df, df[order(Demo.State, `Age Group`, week),])


# # 
# unique(df$Creative.Name)
# df$Creative = df$Creative.Name
# df$Creative <- ifelse(df$Creative %in% c("FamilyDollar - Game On - 15s", "FamilyDollar - Little Miracles - 15s (Version A)", "FamilyDollar - Little Miracles - 15s (Version C)",
#                                          "FamilyDollar - Little Miracles - 15s (Version B)"),
#                       '15secs', ifelse(df$Creative %in% c("FamilyDollar - Little Miracles - 30s", "FamilyDollar - Game On - 30s"), '30secs',
#                                        ifelse(df$Creative %in% c("FamilyDollar - Game On - 6s", "FamilyDollar - Little Miracles - 6s (Version B)" ,
#                                                                  "FamilyDollar - Little Miracles - 6s (Version C)", "FamilyDollar - Little Miracles - 6s (Version A)"
#                                        ), '6secs',df$Creative )))
# 
# 

unique(df$creativeduration)
#df$creative = df$Creative

#Creative plot
#Purchase intent 
#brand preference


#Vytalogy - focus on brandawareness 

# 
# 
# #wrong = df[df$Stateabb == 'WA',]
# dem <- df[ which(df$Vote.Choice=='1'),]
# focus <- df[ which(df$Focus.on.Issues=='1' ),]
# purchase <- df[ which(df$Purchase.Intent=='1' ),]
# 
# 

#brand <- df[ which(df$Natrol..Brand.Awareness=='1'),]
# 
# 
brand = df[ which(df$Family.Dollar..Brand.Awareness=='2'),]
# brand = df[ which(df$Family.Dollar..Ad.Recall=='2'),]


# brand_overall = df[ which(df$Family.Dollar..Brand.Awareness=='2'  |  df$Dollar.General..Brand.Awareness == '1' |
#                     df$Five.Below..Brand.Awareness == '3' | df$Big.Lots..Brand.Awareness == '4' |
#                     df$None.of.the.above..Brand.Awareness == '5'),]

table(brand$week)
# df <- subset(df, subset = Demo.State %in% c("INDIANA", "IOWA", "KANSAS", "MASSACHUSETTS", "MISSISSIPPI", "MONTANA", "NEW MEXICO", "OKLAHOMA",
#                                             "UTAH", "WASHINGTON", "WEST VIRGINIA"))
######### Dem Lift ################


m = brand %>% 
  filter(Group == "Exposed") %>%
  group_by(week,Demo.State,Strata) %>% 
  mutate(Total_exposed = sum(Weight, na.rm = TRUE))%>%
  group_by(week, Demo.State) %>% 
  mutate(Total_exposed_strata = sum(Total_exposed, na.rm = TRUE))%>%
  ungroup()









n = m %>% 
  group_by(Demo.State) %>% 
  mutate(prop = (Total_exposed_strata / sum(Total_exposed_strata))*100)

k = brand %>% 
  filter(Group == "Control") %>%
  group_by(week, Demo.State,Strata) %>% 
  mutate(Total_control = sum(Weight, na.rm = TRUE))%>%
  group_by(week, Demo.State) %>% 
  mutate(Total_control_strata = sum(Total_control, na.rm = TRUE))%>%
  ungroup()



l = k %>% 
  group_by(Demo.State) %>% 
  mutate(prop = (Total_control_strata / sum(Total_control_strata))*100)

brand_lift = rbind(n,l)

#dem_lift <- merge(n,l, by = intersect(names(x), names(y)), all = TRUE)




brand_lift = brand_lift %>% 
  group_by(Demo.State, week) %>% 
  mutate(lift = (prop-lead(prop , na.rm = T)))



brand_lift$lift = round(brand_lift$lift ,digit=2)



#brand_lift$lift[brand_lift$lift < 0] <- 0
#brand_lift = brand_lift %>% dplyr::mutate(cumsum = cumsum(lift))

brand_lift$lift[is.na(brand_lift$lift)] <- 0

brand_lift$lift = as.numeric(brand_lift$lift)

#brand_lift = brand_lift[brand_lift$date >= "2023-01-05" , ]


#natrol_lift <- with(natrol_lift, natrol_lift[order(Demo.State, creative, week),])
# 
# natrol_lift["Age Group"] = cut(brand_lift$Demo.Age, c(0, 18, 24, 34, 44, 54, 64, Inf), c("0-18", "19-24", "25-34", "35-44", "45-54", "55-64", "65+"), include.lowest=TRUE)
# brand_lift <- with(brand_lift, brand_lift[order(Demo.State, `Age Group`, week),])



brand_lift = brand_lift  %>%
  group_by(c5) %>%
  arrange(week) %>%
  mutate(
    #Cumulative = cumsum(lift),
    increment = c(first(lift), pmax(diff(lift), 0)),
    Cumulative = cumsum(increment),
           #ifelse(cumsum(lift)<0,0,cumsum(lift))) %>%
         #cumulative = pnorm(Cumulative)*100,
          #cumulative = ((Cumulative - min(Cumulative))/(max(Cumulative) - min(Cumulative))),
    cumulative = ((Cumulative - mean(Cumulative))/(sd(Cumulative))),
    
         #cumulative = Cumulative/100
    #diff = cumulative - lag(cumulative, default = 0) 
    ) %>%
  
#cumulative = round(cumulative ,digit=2)) %>%
  ungroup() 


#brand_lift_m = brand_lift[brand_lift$date >= "2023-01-05" , ]
#brand_lift_all = df[df$date >= "2023-01-05" , ]

#table(brand_lift_m$Group)

library(rpivotTable)
#df = df[order(as.Date(df$Weekname, format="%m/%d/%y")),]
#df$Weekname <- df$Weekname[order(as.Date(df$Weekname, format="%m/%d/%Y"))]

#df$Weekname = sort(df$Weekname)


brand_lift <- with(brand_lift, brand_lift[order(week),])

rpivotTable(brand_lift, rows=c("c5"), col=c("Weekname", "week"), aggregatorName="Last",
            vals="cumulative", rendererName="Heatmap", color = "green")

table(brand_lift_m$creativename, brand_lift_m$date)
d4 = brand_lift %>% group_by(Weekname, date) %>% summarise(cumulative = last(cumulative))

d5 = d4 %>% group_by(Weekname) %>%
  summarise(Max=max(cumulative,na.rm=T))

d5 <- d5[-1,]

d5 = d5[order(as.Date(d5$Weekname, format="%m/%d/%y")),]
d5$Weekname<-as.Date(d5$Weekname, format = "%m/%d/%y")
d5$Max = round(d5$Max, digits = 2)



library(ggrepel)
library(hrbrthemes)


d5 %>%
  ggplot( aes(x=(Weekname), y=sort(Max), group=1)) +
  geom_text(aes(label = Max), hjust=-0.35, vjust=0.75, size=3) +
  geom_line(color = "forestgreen")+
  geom_point(color = "darkgreen") +
  scale_color_viridis(discrete = TRUE) +
  ggtitle("Family Dollar Brand Lift") + 
  xlab("Weeks") + ylab("Cumulative %") + scale_x_date(date_labels = "%m/%d/%y", date_breaks  ="1 week") +
  theme_ipsum() 



d5 %>%
  ggplot( aes(x=(Weekname), y=(Max), group=`Age Group`, color=`Age Group`)) +
  geom_line()+
  geom_point() +
  scale_color_viridis(discrete = TRUE) +
  ggtitle("Slater & Gordon Brand Lift") + 
  xlab("Weeks") + ylab("Cumulative %") +
  theme_ipsum()   + labs(color='') 






##### End Code #####



old <- subset(brand_lift, date < as.Date("2022-11-28"))     
new <- subset(brand_lift, date >= as.Date("2022-11-28"))     




old_data = old %>% group_by(Weekname, date) %>% summarise(cumulative = last(cumulative))


old_data <- subset(old_data, date >= as.Date("2022-10-31"))     

new_data = new %>% group_by(Weekname, date) %>% summarise(cumulative = last(cumulative))

old_data$type <- "Before Algo Push"
new_data$type <- "11/28: After Algo Push"

d4 <- rbind(old_data, new_data)



ggplot(d4, aes(x=reorder(type, cumulative), y=cumulative, fill = type)) +
  geom_bar(stat="identity", position=position_dodge())+theme_ipsum() +
  ggtitle("Family Dollar Brand Lift") + 
  scale_fill_manual(
    values = c("forestgreen", "red"), label = NULL) + 
  labs(label='') +
  xlab("") + ylab("Cumulative %") + guides(fill=FALSE)









#scale_x_date(date_labels = "%m/%y", date_breaks  ="1 week")

ggplot(data=d5, aes(x=Weekname, y=Max, group=1)) +
  geom_line(color="forestgreen")+
  geom_point()





#####

library(ggplot2)
library(hrbrthemes)

# create data
xValue <- 1:10
yValue <- cumsum(rnorm(10))
data <- data.frame(xValue,yValue)

# Plot

brand_lift %>%
  ggplot( aes(x=Weekname, y=cumulative, group=, color=)) +
  geom_line() +
  scale_color_viridis(discrete = TRUE) +
  ggtitle("Popularity of American names in the previous 30 years") +
  theme_ipsum() +
  ylab("Number of babies born")


ggplot(brand_lift, aes(x=cumulative, y=Weekname)) +
  geom_line( color="#69b3a2", size=2, alpha=0.9, linetype=2) +
  theme_ipsum() +
  ggtitle("Evolution of something")
library(rpivotTable)


saveWidget(x, file=paste0("~/Downloads/pivottable.html"))


edit(rpivotTable::rpivotTable)
 write.csv(natrol_lift, "~/Downloads/natrol_lift.csv")

############ Map Plots##############
risk.pal <- colorBin(palette="YlGn", na.color = NA, domain = brand_lift$cumulative, reverse = F)

# pal <- colorBin(
#   palette = "Blues"
#   #palette = "Blues"
#   #, domain = dsch_count_by_city$dsch_count
#   , domain = y$lift
#   , bins = 5
#   , reverse = TRUE, na.color = NA
# )


#factpal <- colorFactor("Blues", unique(y$lift))
htmltitle <- "Brand Lift for Vytalogy across states"


# mapping based on type


m = leaflet(brand_lift) %>% addProviderTiles("Stamen.TonerLite") %>% 
  addCircleMarkers(~longitude, ~latitude, weight = 3, radius=2, 
                   color=~risk.pal(cumulative), stroke = F, fillOpacity =3, group = ~brand_lift$creative)%>% 
  addLayersControl(  baseGroups = "Creative",
                     overlayGroups = brand_lift$creative,
                     options = layersControlOptions(collapsed = FALSE)
  )%>%
  addControl(html=htmltitle, position = "bottomright")%>% 
  addLegend("bottomleft", pal = risk.pal, values = ~cumulative,
            title = " Cumulative Lift %")
m

 library(htmlwidgets)
saveWidget(m, file=paste0("~/Downloads/vytalogy_brandlift_map.html"))




csum = brand_lift %>% 
  hchart(., 
         type = "column", 
         hcaes(x = Weekname, 
               y = Cumulative, group =`Age Group` )) %>% 
  # hc_add_series(dem_lift, "column", hcaes(x = week, 
  #                                         y = csum, group = Demo.State)) %>%
  #hc_plotOptions(series = list(connectNulls = TRUE), line = list(marker = list(enabled = FALSE)))%>%
  hc_xAxis(title = list(text = "Weeks")) %>%  
  hc_yAxis(opposite = F,
           title = list(text = "Cumulative Lift %")) %>% 
  hc_title(text = "Family Dollar Brand Awareness Aggregate Lift %") %>% 
  # hc_plotOptions(column = list(
  #   dataLabels = list(enabled = T),
  #   stacking = "normal",
  #   enableMouseTracking = TRUE)) %>%
  hc_subtitle(text = "Family Dollar Brand Awareness: Lucid Survey",
              style = list(fontWeight = "bold"),
              align = "center") 

saveWidget(csum, file=paste0("~/Downloads/famdollar_cumsum_weekwise.html"))



#######################################
library(broom)


x = (glm(lift ~Weekname, data= brand_lift))
summary(x)
margin = as.data.frame((summary(x)$coefficients[,3]  * summary(x)$coefficients[,2] ))
nmaes = as.data.frame(summary(x)[["coefficients"]])



MOE = cbind(margin, nmaes)

# 
# brand_lift %>%
#   group_by(Demo.State) %>%
#   summarise(res = list(tidy(t.test(lift)))) %>%
#   unnest()

id <- rownames(MOE)
MOE<- cbind(id=id, MOE)

write.csv(MOE, "~/Downloads/MOE_brandlift.csv")

m <- glm(lift ~ Weekname, data = brand_lift)
library("multcomp")
g <- glht(m)
summary(g, test = adjusted("none"))
confint(g, level = 0.99)


edit(rpivotTable::rpivotTable)


library(Rserve)
Rserve()
