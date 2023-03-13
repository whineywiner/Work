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
#creative = data %>% dplyr::select(c(81))
# creative <- as.data.frame(data[,c(73)])
# 
# library(stringr)
# creative = data.frame(do.call(rbind, str_split(creative$`data[, c(73)]` , "_")))
# creative = creative %>% dplyr::select(c(7, 11:14))
# colnames(creative) <- c('Ad_served_on','Platform','type', 'creative', "octx")
# data = cbind(data,creative)
#data <- read.csv("~/Downloads/Chalice_lift/Chalice Precision Strategies SEIU Campaign (Raw) (2).csv")

## Download source file, unzip and extract into table
# ZipCodeSourceFile = "http://download.geonames.org/export/zip/US.zip"
# temp <- tempfile()
# download.file(ZipCodeSourceFile , temp)
# ZipCodes <- read.table(unz(temp, "US.txt"), sep="\t")
# unlink(temp)
# names(ZipCodes) = c("CountryCode", "Demo.ZIP", "PlaceName", 
#                     "state_name", "Stateabb", "County", "fipscountycode", 
#                     "AdminName3", "AdminCode3", "latitude", "longitude", "accuracy")
# 
# 
# 
# df = merge(data, ZipCodes, all.x = TRUE, by="Demo.Zip")
# 
 df = data

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


# 
# df = data %>%
#   separate(Response.Date, sep="-", into = c("year", "month", "day"))
# df = df %>%
#   separate(day, sep=" ", into = c("date","x"))
# df$x = NULL
# df$Date<-as.Date(with(df,paste(year,month,date,sep="-")),"%Y-%m-%d")

df$week <- as.integer(format(df$date, "%V"))
sort(unique(df$week))

df <- df[!df$week %in% c("1"), ]



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


df$week[df$week == '1'] <- '19'
df$week[df$week == '2'] <- '20'
df$week[df$week == '3'] <- '21'
df$week[df$week == '4'] <- '22'
df$week[df$week == '5'] <- '23'
df$week[df$week == '6'] <- '24'


df$week[df$week == '35'] <- '1'
df$week[df$week == '36'] <- '2'
df$week[df$week == '37'] <- '3'
df$week[df$week == '38'] <- '4'
df$week[df$week == '39'] <- '5'
df$week[df$week == '40'] <- '6'
df$week[df$week == '41'] <- '7'


df$week[df$week == '42'] <- '8'
df$week[df$week == '43'] <- '9'
df$week[df$week == '44'] <- '10'
df$week[df$week == '45'] <- '11'
df$week[df$week == '46'] <- '12'
df$week[df$week == '47'] <- '13'
df$week[df$week == '48'] <- '14'
df$week[df$week == '49'] <- '15'
df$week[df$week == '50'] <- '16'
df$week[df$week == '51'] <- '17'
df$week[df$week == '52'] <- '18'



# df$week[df$week == '44'] <- '1'
# df$week[df$week == '45'] <- '2'
# df$week[df$week == '46'] <- '3'
# df$week[df$week == '47'] <- '4'
# df$week[df$week == '48'] <- '5'
# df$week[df$week == '49'] <- '6'
# df$week[df$week == '50'] <- '7'
# df$week[df$week == '51'] <- '8'
# 
# # 
options(max.print=999999)

# df$Weekname = "Week"
table(df$date, df$week)
# 
df$Weekname[df$week == '1'] <- '22/09/02'
df$Weekname[df$week == '2'] <- '22/09/05'
df$Weekname[df$week == '3'] <- '22/09/12'
df$Weekname[df$week == '4'] <- '22/09/20'
df$Weekname[df$week == '5'] <- '22/09/26'
df$Weekname[df$week == '6'] <- '22/10/03'
df$Weekname[df$week == '7'] <- '22/10/10'
df$Weekname[df$week == '8'] <- '22/10/17'
df$Weekname[df$week == '9'] <- '22/10/24'
df$Weekname[df$week == '10'] <- '22/10/31'
df$Weekname[df$week == '11'] <- '22/11/07'
df$Weekname[df$week == '12'] <- '22/11/15'
df$Weekname[df$week == '13'] <- '22/11/21'
df$Weekname[df$week == '14'] <- '22/11/28'
df$Weekname[df$week == '15'] <- '22/12/05'
df$Weekname[df$week == '16'] <- '22/12/12'
df$Weekname[df$week == '17'] <- '22/12/19'
df$Weekname[df$week == '18'] <- '22/12/26'
df$Weekname[df$week == '19'] <- '23/01/02'
df$Weekname[df$week == '20'] <- '23/01/09'
df$Weekname[df$week == '21'] <- '23/01/16'
df$Weekname[df$week == '22'] <- '23/01/23'
df$Weekname[df$week == '23'] <- '23/02/01'
df$Weekname[df$week == '24'] <- '23/02/06'


# 
# df$Weekname[df$week == '1'] <- '11/02'
# df$Weekname[df$week == '2'] <- '11/07'
# df$Weekname[df$week == '3'] <- '11/14'
# df$Weekname[df$week == '4'] <- '11/21'
# df$Weekname[df$week == '5'] <- '11/28'
# df$Weekname[df$week == '6'] <- '12/05'
# df$Weekname[df$week == '7'] <- '12/12'
# df$Weekname[df$week == '8'] <- '12/19'


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
########################

df["Age Group"] = cut(df$Demo.Age, c(0, 18, 24, 34, 44, 54, 64, Inf), c("0-18", "19-24", "25-34", "35-44", "45-54", "55-64", "65+"), include.lowest=TRUE)
#df <- with(df, df[order(Demo.State, `Age Group`, week),])


# 
unique(df$Creative.Name)
# df$Creative <- ifelse(df$Creative %in% c("FamilyDollar - Game On - 15s", "FamilyDollar - Little Miracles - 15s (Version A)", "FamilyDollar - Little Miracles - 15s (Version C)",
#                                          "FamilyDollar - Little Miracles - 15s (Version B)"),
#                       '15secs', ifelse(df$Creative %in% c("FamilyDollar - Little Miracles - 30s", "FamilyDollar - Game On - 30s"), '30secs',
#                                        ifelse(df$Creative %in% c("FamilyDollar - Game On - 6s", "FamilyDollar - Little Miracles - 6s (Version B)" ,
#                                                                  "FamilyDollar - Little Miracles - 6s (Version C)", "FamilyDollar - Little Miracles - 6s (Version A)"
#                                        ), '6secs',df$Creative )))
# 
# 
# 
# unique(df$creative)
# df$creative = df$Creative

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

#natrol <- df[ which(df$Natrol..Brand.Awareness=='1'),]


# 
brandlift = df[ which(df$Slater...Gordon..Ad.Recall=='1'),]
# recall = df[ which(df$Family.Dollar..Ad.Recall=='2'),]
brandlift = df[ which(df$Slater...Gordon..Brand.Awareness=='1'),]
#brandlift = brandlift[brandlift$date >= "2022-11-28" , ]


# df <- subset(df, subset = Demo.State %in% c("INDIANA", "IOWA", "KANSAS", "MASSACHUSETTS", "MISSISSIPPI", "MONTANA", "NEW MEXICO", "OKLAHOMA",
#                                             "UTAH", "WASHINGTON", "WEST VIRGINIA"))

m = brandlift %>% 
  filter(Group == "Exposed") %>%
  group_by(week) %>% 
  mutate(Total_exposed = sum(Weight, na.rm = TRUE))%>%
  group_by(week) %>% 
  mutate(Total_exposed_strata = sum(Total_exposed, na.rm = TRUE))%>%
  ungroup()









n = m %>% 
  group_by(week) %>% 
  mutate(prop = (Total_exposed_strata / sum(Total_exposed_strata))*100)

k = brandlift %>% 
  filter(Group == "Control") %>%
  group_by(week) %>% 
  mutate(Total_control = sum(Weight, na.rm = TRUE))%>%
  group_by(week) %>% 
  mutate(Total_control_strata = sum(Total_control, na.rm = TRUE))%>%
  ungroup()



l = k %>% 
  group_by(week) %>% 
  mutate(prop = (Total_control_strata / sum(Total_control_strata))*100)

brand_lift = rbind(n,l)

#dem_lift <- merge(n,l, by = intersect(names(x), names(y)), all = TRUE)




brand_lift = brand_lift %>% 
  group_by(week) %>% 
  mutate(lift = (prop-lead(prop , na.rm = T)))



brand_lift$lift = round(brand_lift$lift ,digit=2)



#brand_lift$lift[brand_lift$lift < 0] <- 0
#brand_lift = brand_lift %>% dplyr::mutate(cumsum = cumsum(lift))

brand_lift$lift[is.na(brand_lift$lift)] <- 0

brand_lift$lift = as.numeric(brand_lift$lift)


brand_lift$Group = as.factor(brand_lift$Group)

#natrol_lift <- with(natrol_lift, natrol_lift[order(Demo.State, creative, week),])
# 
# natrol_lift["Age Group"] = cut(brand_lift$Demo.Age, c(0, 18, 24, 34, 44, 54, 64, Inf), c("0-18", "19-24", "25-34", "35-44", "45-54", "55-64", "65+"), include.lowest=TRUE)
# brand_lift <- with(brand_lift, brand_lift[order(Demo.State, `Age Group`, week),])


brand_lift["Frequencies"] = cut(brand_lift$Frequency, c(0, 1, 4, 9, 15, 18), c("0-1", "2-4", "5-9", "10-15", "16-18"), include.lowest=TRUE)






brand_lift = brand_lift  %>%
  group_by() %>%
  arrange(week) %>%
  mutate(
    #Cumulative = cumsum(lift),
    increment = c(first(lift), pmax(diff(lift), 0)),
    Cumulative = cumsum(increment),
    #ifelse(cumsum(lift)<0,0,cumsum(lift))) %>%
    #cumulative = pnorm(Cumulative)*100,
    #cumulative = ((Cumulative - min(Cumulative))/(max(Cumulative) - min(Cumulative))),
    cumulative = Cumulative/100,
    #total = cumsum(cumulative),
    
    #cumulative = Cumulative,
    #diff = cumulative - lag(cumulative, default = 0) ) %>%
  
    cumulative = round(cumulative ,digit=2)) %>%
  ungroup() 

brand_lift <- with(brand_lift, brand_lift[order(Weekname),])
library(rpivotTable)

rpivotTable(brand_lift, rows=c("") , col=c("Weekname", "week"), aggregatorName="Last",
            vals="cumulative", rendererName="Heatmap", color = "green")




old <- subset(brand_lift, date < as.Date("2022-11-28"))     
new <- subset(brand_lift, date >= as.Date("2022-11-28"))     




old_data = old %>% group_by(Weekname, date) %>% summarise(cumulative = last(cumulative))


old_data <- subset(old_data, date >= as.Date("2022-10-31"))     

new_data = new %>% group_by(Weekname, date) %>% summarise(cumulative = last(cumulative))

old_data$type <- "Before Algo Push"
new_data$type <- "11/28: After Algo Push"

d4 <- rbind(old_data, new_data)


d5 = d4 %>% group_by(type, Weekname) %>%
  summarise(Max=max(cumulative,na.rm=T))

########## Plot#########

library(hrbrthemes)
d4 = d4[rev(order(as.Date(d4$Date, format="%m/%d/%Y"))),]

  ggplot(d4, aes(x=reorder(type, cumulative), y=cumulative, fill = type)) +
   geom_bar(stat="identity", position=position_dodge())+theme_ipsum() +
   ggtitle("Slater & Gordon AdRecall Lift") + 
    scale_fill_manual(
      values = c("forestgreen", "red"), label = NULL) + 
  labs(label='') +
    xlab("") + ylab("Cumulative %") + guides(fill=FALSE)



  

d5 %>%
  ggplot( aes(x=(Weekname), y=(Max), group=type, color=type)) +
  geom_text(aes(label = Max), hjust=-0.35, vjust=0.75, size=3) +
  geom_line()+
  geom_point() +
  scale_color_viridis(discrete = TRUE) +
  ggtitle("Slater & Gordon AdRecall Lift") + 
  xlab("Weeks") + ylab("Cumulative %") +
  theme_ipsum()  + scale_color_manual(values=c("#69b3a2", "red")) + labs(color='') 
########## Plot#########



saveWidget(x, file=paste0("~/Downloads/pivottable.html"))


edit(rpivotTable::rpivotTable)
write.csv(natrol_lift, "~/Downloads/natrol_lift.csv")

############ Map Plots##############
risk.pal <- colorBin(palette="YlGn", na.color = NA, domain = natrol_lift$cumulative, reverse = F)

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


m = leaflet(natrol_lift) %>% addProviderTiles("Stamen.TonerLite") %>% 
  addCircleMarkers(~longitude, ~latitude, weight = 3, radius=2, 
                   color=~risk.pal(cumulative), stroke = F, fillOpacity =3, group = ~natrol_lift$Weekname)%>% 
  addLayersControl(  baseGroups = "Weeks",
                     overlayGroups = natrol_lift$Weekname,
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


table( brand_lift$cumulative, brand_lift$Group)


