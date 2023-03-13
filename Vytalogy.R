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
options(tigris_use_cache = TRUE)


data <- read.csv("~/Desktop/Chalice/imputed_chalicedata_vytalogy.csv")



#### Vytalogy change creative Type ####
# creative = data %>% dplyr::select(c(80))
# 
# library(stringr)
# creative = data.frame(do.call(rbind , str_split(creative$Creative.Name , "_")))
# creative = creative %>% dplyr::select(c(7, 11:14))
# colnames(creative) <- c('Ad_served_on','Platform','type', 'creative', "octx")
# data = cbind(data,creative)

#data <- read.csv("~/Downloads/Chalice_lift/Chalice Precision Strategies SEIU Campaign (Raw) (2).csv")

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


df = df %>%
  separate(Response.Date, sep="-", into = c("year", "month", "day"))
df = df %>%
  separate(day, sep=" ", into = c("date","x"))
df$x = NULL
df$Date<-as.Date(with(df,paste(year,month,date,sep="-")),"%Y-%m-%d")

df$week <- as.integer(format(df$Date, "%V"))
sort(unique(df$week))
# df$week[df$week == '42'] <- '1'
# df$week[df$week == '43'] <- '2'
df$week[df$week == '44'] <- '1'
df$week[df$week == '45'] <- '2'
df$week[df$week == '46'] <- '3'
df$week[df$week == '47'] <- '4'
df$week[df$week == '48'] <- '5'
df$week[df$week == '49'] <- '6'
# 

# df$Weekname = "Week"
table(df$Date, df$week)
# 
# df$Weekname[df$week == '1'] <- '10/20'
# df$Weekname[df$week == '2'] <- '10/24'
# df$Weekname[df$week == '3'] <- '10/31'
# df$Weekname[df$week == '4'] <- '11/07'
# df$Weekname[df$week == '5'] <- '11/14'
# df$Weekname[df$week == '6'] <- '11/21'
# df$Weekname[df$week == '7'] <- '11/28'
# df$Weekname[df$week == '8'] <- '12/05'
# 



df$Weekname[df$week == '1'] <- '11/02'
df$Weekname[df$week == '2'] <- '11/07'
df$Weekname[df$week == '3'] <- '11/14'
df$Weekname[df$week == '4'] <- '11/21'
df$Weekname[df$week == '5'] <- '11/28'
df$Weekname[df$week == '6'] <- '12/05'

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

df["Age Group"] = cut(df$Demo.Age, c(0, 18, 44, 64, Inf), c("0-18", "19-44", "45-64", ">64"), include.lowest=TRUE)
df <- with(df, df[order(Demo.State, `Age Group`, week),])



# 
unique(df$Creative.Name)
df$Creative = df$Creative.Name
df$Creative <- ifelse(df$Creative %in% c("FamilyDollar - Game On - 15s", "FamilyDollar - Little Miracles - 15s (Version A)", "FamilyDollar - Little Miracles - 15s (Version C)",
                                                 "FamilyDollar - Little Miracles - 15s (Version B)"),
                         '15secs', ifelse(df$Creative %in% c("FamilyDollar - Little Miracles - 30s", "FamilyDollar - Game On - 30s"), '30secs',
                                                   ifelse(df$Creative %in% c("FamilyDollar - Game On - 6s", "FamilyDollar - Little Miracles - 6s (Version B)" ,
                                                                           "FamilyDollar - Little Miracles - 6s (Version C)", "FamilyDollar - Little Miracles - 6s (Version A)"
                                                  ), '6secs',df$Creative )))
# 
# 

unique(df$Creative)
df$creative = df$Creative

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
 brand = df[ which(df$Family.Dollar..Brand.Awareness=='2'),]
# recall = df[ which(df$Family.Dollar..Ad.Recall=='2'),]


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



brand_lift$lift[brand_lift$lift < 0] <- 0
#brand_lift = brand_lift %>% dplyr::mutate(cumsum = cumsum(lift))

brand_lift$lift[is.na(brand_lift$lift)] <- 0

brand_lift$lift = as.numeric(brand_lift$lift)


brand_lift <- with(brand_lift, brand_lift[order(Demo.Region, creative, week),])

# natrol_lift = natrol_lift  %>%
#   group_by(creative) %>%
#   mutate( ag_csum_Creative = sum(ag_csum, na.rm = T))
# 

#dem <- natol_brand_lift[ which(natol_brand_lift$Demo.Region== c("Midwest", "South")),]


# mutate(lift =( (Total/lag(Total) - 1)*100))

# 
# 
# 
# 
library(janitor)
count = tabyl(natrol_lift, Demo.State, Demo.Region)
# write.csv(count, "~/Downloads/countstate.csv")



# # a named list of rescaled icons with links to images
# favicons <- iconList(
#   "1" = makeIcon(
#     iconUrl = "https://cdn-icons-png.flaticon.com/512/412/412862.png",
#     iconWidth = 15,
#     iconHeight = 15)
#   # ),
#   # "2" = makeIcon(
#   #   iconUrl = "https://cdn-icons-png.flaticon.com/512/412/412806.png",
#   #   iconWidth = 15,
#   #   iconHeight = 15
#   # ),
#   # "3" = makeIcon(
#   #   iconUrl = "https://drasite.com/content/img/icons/gnome-documents.svg",
#   #   iconWidth = 15,
#   #   iconHeight = 15
#   # ),
#   # "4" = makeIcon(
#   #   iconUrl = "http://cdn.onlinewebfonts.com/svg/img_183001.png",
#   #   iconWidth = 15,
#   #   iconHeight = 15
#   # )
# )

## Make vector of colors for values below threshold
## Make vector of colors for values above threshold
#sort(unique(brand_lift$csum))
## Congressional District Map/
#colores <- c('red4', 'red3', 'red', 'green', 'green3' ,'darkgreen')

#risk.bins <-c(-100, -50, -25, 0, 25, 50, 100  )

risk.pal <- colorBin(palette="RdYlGn", na.color = NA, domain = brand_lift$csum, reverse = F)

# pal <- colorBin(
#   palette = "Blues"
#   #palette = "Blues"
#   #, domain = dsch_count_by_city$dsch_count
#   , domain = y$lift
#   , bins = 5
#   , reverse = TRUE, na.color = NA
# )


#factpal <- colorFactor("Blues", unique(y$lift))
htmltitle <- "Brand Lift for Family Dollar across states"


# mapping based on type


m = leaflet(brand_lift) %>% addProviderTiles("Stamen.TonerLite") %>% 
  addCircleMarkers(~longitude, ~latitude, weight = 3, radius=2, 
                   color=~risk.pal(csum), stroke = F, fillOpacity =3, group = ~brand_lift$creative)%>% 
  addLayersControl(  baseGroups = "Creative Name",
                     overlayGroups = brand_lift$creative,
                     options = layersControlOptions(collapsed = FALSE)
  )%>%
  addControl(html=htmltitle, position = "bottomright")%>% 
  addLegend("bottomright", pal = risk.pal, values = ~csum,
            title = "Lift %")
m
library(htmlwidgets)
saveWidget(m, file=paste0("~/Downloads/famdollar_brandlift_map.html"))
# library(usmap)
# library(ggplot2)
# 
# us_states <- map_data("state")
# 
# natol_brand_lift$Demo.State
# natol_x = merge(natol_brand_lift, us_states, by.x = "Demo.State", by.y="region")
# 
# 
# plot_usmap(data = natol_brand_lift, values = "pop_2015", color = "red") + 
#   scale_fill_continuous(name = "Population (2015)", label = scales::comma) + 
#   theme(legend.position = "right") 
# 
# usa_map1 <- ggplot(data = natol_brand_lift) + 
#   geom_polygon(aes(x =longitude , y = latitude, group = Demo.Region, 
#                    fill = lift)) + 
#   ggtitle("USA Map 1")
# 
# hc = dem_lift %>% 
#   hchart(., 
#          type = "column", 
#          hcaes(x = week, 
#                y = lift, group = Demo.State)) %>% 
#   hc_xAxis(title = list(text = "Weeks")) %>%  
#   hc_yAxis(opposite = F,
#            labels = list(format = "{value}%")) %>% 
#   hc_title(text = "Vote Choice") %>% 
#   # hc_plotOptions(column = list(
#   #   dataLabels = list(enabled = T),
#   #   stacking = "normal",
#   #   enableMouseTracking = TRUE)) %>%   
#   hc_caption(text = "If November 2022 elections were held today what would you vote for: Democrats?")
# 
# hc
# saveWidget(hc, file=paste0("~/Downloads/vote_choice_bar.html"))

brand_lift %>%
  hchart('line', hcaes(x = Weekname, y = Cumulative, group = creative)) %>%
hc_plotOptions(series = list(connectNulls = TRUE), line = list(marker = list(enabled = FALSE)))


csum = brand_lift %>% 
  hchart(., 
         type = "column", 
         hcaes(x = Weekname, 
               y = Cumulative, group = Demo.State)) %>% 
  # hc_add_series(dem_lift, "column", hcaes(x = week, 
  #                                         y = csum, group = Demo.State)) %>%
  #hc_plotOptions(series = list(connectNulls = TRUE), line = list(marker = list(enabled = FALSE)))%>%
  hc_xAxis(title = list(text = "States")) %>%  
  hc_yAxis(opposite = F,
           title = list(text = "Aggregate Cumulative Lift %")) %>% 
  hc_title(text = "Family Dollar Brand Awareness Aggregate Lift By Creative %") %>% 
  # hc_plotOptions(column = list(
  #   dataLabels = list(enabled = T),
  #   stacking = "normal",
  #   enableMouseTracking = TRUE)) %>%
  hc_subtitle(text = "Family Dollar Brand Awareness: Lucid Survey",
              style = list(fontWeight = "bold"),
              align = "center") 
saveWidget(csum, file=paste0("~/Downloads/famdollar_cumsum_creativewise.html"))


brand_lift$Weekname = as.factor(brand_lift$Weekname)

brand_lift = brand_lift  %>%
  group_by(`Age Group`, Demo.Gender) %>%
  arrange(week) %>%
  mutate(Cumulative = cumsum(lift),
         cumulative = scale(Cumulative),
        #  cumulative = ((Cumulative - min(Cumulative))/(max(Cumulative) - min(Cumulative))),
        # cumulative = cumulative*100,
         cumulative = round(cumulative ,digit=2)) %>%
         ungroup() 

brand_lift <- with(brand_lift, brand_lift[order(Weekname),])


rpivotTable(brand_lift, rows="Age Group", col="Weekname", aggregatorName="Average",
            vals="cumulative", rendererName="Table Bar Chart")




ggp <- ggplot(brand_lift, aes(Weekname, `Age Group`)) +    # Create default ggplot2 heatmap
  geom_tile(aes(fill = cumulative)) 
ggp +                                         # Add values & modify color
  geom_text(aes(label = round(cumulative, 1))) +
  scale_fill_gradient(low = "white", high = "#1b98e0")

hchart(brand_lift, type = "heatmap", hcaes(x = Weekname, y = `Age Group`, value = cumulative))
  

hchart(brand_lift,"heatmap",hcaes(x = Weekname, y = `Age Group`, value = cumulative),
       dataLabels = list(enabled = TRUE)) %>%
  hc_xAxis(categories = brand_lift$creative)  %>%
  hc_colorAxis(minColor = brewer.pal(12, "Set3")[1],
               maxColor = brewer.pal(12, "Set3")[12])  
library("billboarder")

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


x = (glm(lift ~ 0 + Demo.State, data= brand_lift))

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

m <- glm(lift ~ Demo.Region, data = brand_lift)
library("multcomp")
g <- glht(m)
summary(g, test = adjusted("none"))
confint(g, level = 0.99)




######################################################################



m = recall %>% 
  filter(Group == "Exposed") %>%
  group_by(week, Demo.State,Strata) %>% 
  mutate(Total_exposed = sum(Weight, na.rm = TRUE))%>%
  group_by(week, Demo.State) %>% 
  mutate(Total_exposed_strata = sum(Total_exposed, na.rm = TRUE))%>%
  ungroup()









n = m %>% 
  group_by(Demo.State) %>% 
  mutate(prop = (Total_exposed_strata / sum(Total_exposed_strata))*100)

k = recall %>% 
  filter(Group == "Control") %>%
  group_by(week, Demo.State,Strata) %>% 
  mutate(Total_control = sum(Weight, na.rm = TRUE))%>%
  group_by(week, Demo.State) %>% 
  mutate(Total_control_strata = sum(Total_control, na.rm = TRUE))%>%
  ungroup()



l = k %>% 
  group_by(Demo.State) %>% 
  mutate(prop = (Total_control_strata / sum(Total_control_strata))*100)

recall_lift = rbind(n,l)

#dem_lift <- merge(n,l, by = intersect(names(x), names(y)), all = TRUE)


recall_lift = recall_lift %>% 
  group_by(Demo.State, week) %>% 
  mutate(lift = (prop-lead(prop)))

recall_lift$lift = round(recall_lift$lift ,digit=2)


recall_lift = recall_lift  %>%
  group_by(Demo.State, week) %>%
  mutate(csum = cumsum(lift, na.rm = T))

recall_lift = recall_lift  %>%
  group_by(Demo.State) %>%
  mutate( ag_csum = mean(csum, na.rm = T))


recall_lift$ag_csum = round(recall_lift$ag_csum ,digit=2)


recall_lift <- with(recall_lift, recall_lift[order(Demo.State, Weekname),])

recall_lift$Weekname = as.factor(recall_lift$Weekname)

recall_lift <- subset(recall_lift, subset = Demo.State %in% c("MASSACHUSETTS", "MICHIGAN", "MISSISSIPPI", "MISSOURI", "NEW JERSEY", "NEW MEXICO",
                                            "SOUTH DAKOTA", "VIRGINIA"))

#dem <- natol_brand_lift[ which(natol_brand_lift$Demo.Region== c("Midwest", "South")),]


# mutate(lift =( (Total/lag(Total) - 1)*100))

# 
# 
# 
# 
library(janitor)
count = tabyl(recall_lift, Demo.State, Demo.Region)
# write.csv(count, "~/Downloads/countstate.csv")



# # a named list of rescaled icons with links to images
# favicons <- iconList(
#   "1" = makeIcon(
#     iconUrl = "https://cdn-icons-png.flaticon.com/512/412/412862.png",
#     iconWidth = 15,
#     iconHeight = 15)
#   # ),
#   # "2" = makeIcon(
#   #   iconUrl = "https://cdn-icons-png.flaticon.com/512/412/412806.png",
#   #   iconWidth = 15,
#   #   iconHeight = 15
#   # ),
#   # "3" = makeIcon(
#   #   iconUrl = "https://drasite.com/content/img/icons/gnome-documents.svg",
#   #   iconWidth = 15,
#   #   iconHeight = 15
#   # ),
#   # "4" = makeIcon(
#   #   iconUrl = "http://cdn.onlinewebfonts.com/svg/img_183001.png",
#   #   iconWidth = 15,
#   #   iconHeight = 15
#   # )
# )

## Make vector of colors for values below threshold
## Make vector of colors for values above threshold
sort(unique(recall_lift$lift))
## Congressional District Map/
#colores <- c('red4', 'red3', 'red', 'green', 'green3' ,'darkgreen')

#risk.bins <-c(-80, -25, -5, 0, 5, 10, 90  )

risk.pal <- colorBin(palette="RdYlGn", na.color = NA, domain = recall_lift$csum, reverse = F)

# pal <- colorBin(
#   palette = "Blues"
#   #palette = "Blues"
#   #, domain = dsch_count_by_city$dsch_count
#   , domain = y$lift
#   , bins = 5
#   , reverse = TRUE, na.color = NA
# )


#factpal <- colorFactor("Blues", unique(y$lift))
htmltitle <- "AdRecall Lift for Family Dollar across states"


# mapping based on type


m = leaflet(recall_lift) %>% addProviderTiles("Stamen.TonerLite") %>% 
  addCircleMarkers(~longitude, ~latitude, weight = 3, radius=2, 
                   color=~risk.pal(csum), stroke = F, fillOpacity =3, group = ~recall_lift$Weekname)%>% 
  addLayersControl(  baseGroups = "Weeks",
                     overlayGroups = recall_lift$Weekname,
                     options = layersControlOptions(collapsed = FALSE)
  )%>%
  addControl(html=htmltitle, position = "bottomright")%>% 
  addLegend("bottomright", pal = risk.pal, values = ~csum,
            title = "Lift %")
m
library(htmlwidgets)
saveWidget(m, file=paste0("~/Downloads/fam_dollar_adrecalllift.html"))
# library(usmap)
# library(ggplot2)
# 
# us_states <- map_data("state")
# 
# natol_brand_lift$Demo.State
# natol_x = merge(natol_brand_lift, us_states, by.x = "Demo.State", by.y="region")
# 
# 
# plot_usmap(data = natol_brand_lift, values = "pop_2015", color = "red") + 
#   scale_fill_continuous(name = "Population (2015)", label = scales::comma) + 
#   theme(legend.position = "right") 
# 
# usa_map1 <- ggplot(data = natol_brand_lift) + 
#   geom_polygon(aes(x =longitude , y = latitude, group = Demo.Region, 
#                    fill = lift)) + 
#   ggtitle("USA Map 1")
# 
# hc = dem_lift %>% 
#   hchart(., 
#          type = "column", 
#          hcaes(x = week, 
#                y = lift, group = Demo.State)) %>% 
#   hc_xAxis(title = list(text = "Weeks")) %>%  
#   hc_yAxis(opposite = F,
#            labels = list(format = "{value}%")) %>% 
#   hc_title(text = "Vote Choice") %>% 
#   # hc_plotOptions(column = list(
#   #   dataLabels = list(enabled = T),
#   #   stacking = "normal",
#   #   enableMouseTracking = TRUE)) %>%   
#   hc_caption(text = "If November 2022 elections were held today what would you vote for: Democrats?")
# 
# hc
# saveWidget(hc, file=paste0("~/Downloads/vote_choice_bar.html"))




csum = recall_lift %>% 
  hchart(., 
         type = "column", 
         hcaes(x = Demo.REGION, 
               y = ag_csum)) %>% 
  # hc_add_series(dem_lift, "column", hcaes(x = week, 
  #                                         y = csum, group = Demo.State)) %>%
  #hc_plotOptions(series = list(connectNulls = TRUE), line = list(marker = list(enabled = FALSE)))%>%
  hc_xAxis(title = list(text = "States")) %>%  
  hc_yAxis(opposite = F,
           title = list(text = "Aggregate Cumulative Lift %")) %>% 
  hc_title(text = "Family Dollar Ad Recall Aggregate Lift %") %>% 
  # hc_plotOptions(column = list(
  #   dataLabels = list(enabled = T),
  #   stacking = "normal",
  #   enableMouseTracking = TRUE)) %>%
  hc_subtitle(text = "Family Dollar Ad Recall: Lucid Survey",
              style = list(fontWeight = "bold"),
              align = "center") 
saveWidget(csum, file=paste0("~/Downloads/famdollar_cumsum_adrecall_statewise.html"))



csum = brand_lift %>% 
  hchart(., 
         type = "column", 
         hcaes(x = Demo.Region, 
               y = csum, group = Creative)) %>% 
  # hc_add_series(dem_lift, "column", hcaes(x = week, 
  #                                         y = csum, group = Demo.State)) %>%
  #hc_plotOptions(series = list(connectNulls = TRUE), line = list(marker = list(enabled = FALSE)))%>%
  hc_xAxis(title = list(text = "Weeks"), categories = levels(recall_lift$Weekname)) %>%  
  hc_yAxis(opposite = F,
           title = list(text = "Cumulative Lift %")) %>% 
  hc_title(text = "Family Dollar Ad Recall Cumulative Lift %") %>% 
  # hc_plotOptions(column = list(
  #   dataLabels = list(enabled = T),
  #   stacking = "normal",
  #   enableMouseTracking = TRUE)) %>%
  hc_subtitle(text = "Family Dollar Ad Recall: Lucid Survey",
              style = list(fontWeight = "bold"),
              align = "center") 

saveWidget(csum, file=paste0("~/Downloads/famdollar_cumsum_adrecall_weekwise.html"))




#######################################
library(broom)


x = (glm(lift ~ 0 + Demo.State, data= recall_lift))
summary((glm(lift ~ 0 + Demo.State, data= recall_lift)))
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

write.csv(MOE, "~/Downloads/MOE_adrecalllift.csv")

m <- glm(lift ~ Demo.State, data = recall_lift)
library("multcomp")
g <- glht(m)
summary(g, test = adjusted("none"))
confint(g, level = 0.99)


































########################### focus ###################

focus$Focus.on.Issues = as.numeric(as.character(focus$Focus.on.Issues))
focus$week = as.factor(focus$week)
focus$Demo.State = as.factor(focus$Demo.State)



m = focus %>% 
  filter(Group == "Exposed") %>%
  group_by(week, Demo.State,Strata) %>% 
  mutate(Total_exposed = sum(Weight, na.rm = TRUE))%>%
  group_by(week, Demo.State) %>% 
  mutate(Total_exposed_strata = sum(Total_exposed, na.rm = TRUE))%>%
  ungroup()









n = m %>% 
  group_by(Demo.State) %>% 
  mutate(prop = (Total_exposed_strata / sum(Total_exposed_strata))*100)

k = focus %>% 
  filter(Group == "Control") %>%
  group_by(week, Demo.State,Strata) %>% 
  mutate(Total_control = sum(Weight, na.rm = TRUE))%>%
  group_by(week, Demo.State) %>% 
  mutate(Total_control_strata = sum(Total_control, na.rm = TRUE))%>%
  ungroup()



l = k %>% 
  group_by(Demo.State) %>% 
  mutate(prop = (Total_control_strata / sum(Total_control_strata))*100)

focus_lift = rbind(n,l)


focus_lift = focus_lift %>% 
  group_by(Demo.State, week) %>% 
  mutate(lift = (prop - lag(prop)))



focus_lift$lift = round(focus_lift$lift ,digit=2)


focus_lift = focus_lift  %>%
  group_by(Demo.State,week) %>%
  mutate(csum = sum(lift, na.rm = T))


focus_lift <- with(focus_lift, focus_lift[order(Demo.State, week),])




sort(unique(focus_lift$lift))


colores <- c('red4', 'red', 'lawngreen', 'green', 'green3' ,'darkgreen')

risk.bins <-c(-4, -1, 0, 2, 4, 5, 10)
risk.pal <- colorBin(palette=colores, bins = risk.bins, na.color = NA, domain = focus_lift$lift, reverse = F)

# pal <- colorBin(
#   palette = "Blues"
#   #palette = "Blues"
#   #, domain = dsch_count_by_city$dsch_count
#   , domain = y$lift
#   , bins = 5
#   , reverse = TRUE, na.color = NA
# )

table(df$Date, df$week)
#factpal <- colorFactor("Blues", unique(y$lift))
htmltitle <- "<h5> To what extent do you agree: Democrats are focusing on issue most important to me? </h5>"


# mapping based on type
m = leaflet(focus_lift) %>% addProviderTiles("Stamen.TonerLite") %>% 
  addCircleMarkers(~longitude, ~latitude, weight = 3, radius=2, 
                   color=~risk.pal(lift), stroke = F, fillOpacity =3, group = ~focus_lift$week)%>% 
  addLayersControl( baseGroups = "Weeks", overlayGroups = focus_lift$week,
                    options = layersControlOptions(collapsed = FALSE)
  )%>%
  addControl(html=htmltitle, position = "bottomright")%>% 
  addLegend("bottomright", pal = risk.pal, values = ~lift,
            title = "Lift %")
m
saveWidget(m, file=paste0("~/Downloads/focus_lift.html"))


# 
# hc = focus_lift %>% 
#   hchart(., 
#          type = "column", 
#          hcaes(x = week, 
#                y = lift, group = Demo.State)) %>% 
#   hc_xAxis(title = list(text = "Weeks")) %>%  
#   hc_yAxis(opposite = F,
#            labels = list(format = "{value}%")) %>% 
#   hc_title(text = "Focus Issues ") %>% 
#   # hc_plotOptions(column = list(
#   #   dataLabels = list(enabled = T),
#   #   stacking = "normal",
#   #   enableMouseTracking = TRUE)) %>%   
#   hc_caption(text = "To what extent do you agree: Democrats are focusing on issue most important to me?")
# 
# saveWidget(hc, file=paste0("~/Downloads/focus_issue_bar.html"))
# 


csum = focus_lift %>% 
  hchart(., 
         type = "column", 
         hcaes(x = week, 
               y = csum, group = Demo.State)) %>% 
  hc_xAxis(title = list(text = "Weeks")) %>%  
  hc_yAxis(opposite = F,
           labels = list(format = "{value}%")) %>% 
  hc_title(text = "Focus Issues by Cumulative Lift % ") %>% 
  # hc_plotOptions(column = list(
  #   dataLabels = list(enabled = T),
  #   stacking = "normal",
  #   enableMouseTracking = TRUE)) %>%
  hc_subtitle(text = "To what extent do you agree: Democrats are focusing on issue most important to me?",
              style = list(fontWeight = "bold"),
              align = "center")
saveWidget(csum, file=paste0("~/Downloads/focus_issue_bar_cum.html"))


focus_lift %>%
  group_by(Demo.State) %>%
  summarise(res = list(tidy(t.test(lift, level = 0.90)))) %>%
  unnest()



m <- lm(lift ~ Demo.State, data = focus_lift)
g <- glht(m)
summary(g, test = adjusted("holm"))
confint(g)



########################### purchase ###################

purchase$Purchase.Intent = as.numeric((purchase$Purchase.Intent))
purchase$week = as.factor(purchase$week)
purchase$Demo.State = as.factor(purchase$Demo.State)

m = purchase %>% 
  filter(Group == "Exposed") %>%
  group_by(week, Demo.State) %>% 
  mutate(Total_exposed = sum(Purchase.Intent, na.rm = TRUE)) %>% ungroup()

n = m %>% 
  group_by(Demo.State) %>% 
  mutate(prop = (Total_exposed / sum(Total_exposed))*100)

k = purchase %>% 
  filter(Group == "Control") %>%
  group_by(week, Demo.State) %>% 
  mutate(Total_control = sum(Purchase.Intent, na.rm = TRUE))



l = k %>% 
  group_by(Demo.State) %>% 
  mutate(prop = (Total_control / sum(Total_control))*100)

purchase_lift = rbind(n,l)
purchase_lift = purchase_lift %>% 
  group_by(Demo.State) %>% 
  mutate(lift = (prop/lag(prop) - 1))



purchase_lift$lift = round(purchase_lift$lift ,digit=2)


purchase_lift = purchase_lift  %>%
  group_by(Demo.State,week) %>%
  mutate(csum = cumsum(lift*!duplicated(week)))

purchase_lift <- with(purchase_lift, purchase_lift[order(Demo.State, week),])


sort(unique(purchase_lift$lift))


colores <- c('red4', 'red', 'lawngreen', 'green', 'green3' ,'darkgreen')

risk.bins <-c(-3, -1, 0, 2, 4, 5, 12)
risk.pal <- colorBin(palette=colores, bins = risk.bins, na.color = NA, domain = purchase_lift$lift, reverse = F)

# pal <- colorBin(
#   palette = "Blues"
#   #palette = "Blues"
#   #, domain = dsch_count_by_city$dsch_count
#   , domain = y$lift
#   , bins = 5
#   , reverse = TRUE, na.color = NA
# )


#factpal <- colorFactor("Blues", unique(y$lift))
htmltitle <- "<h5> How Likely are you to vote in November 2022 election? </h5>"


# mapping based on type
m = leaflet(purchase_lift) %>% addProviderTiles("Stamen.TonerLite") %>% 
  addCircleMarkers(~longitude, ~latitude, weight = 3, radius=2, 
                   color=~risk.pal(lift), stroke = F, fillOpacity =3, group = ~purchase_lift$week)%>% 
  addLayersControl(baseGroups = "Weeks", overlayGroups = purchase_lift$week,
                   options = layersControlOptions(collapsed = FALSE)
  )%>%
  addControl(html=htmltitle, position = "bottomright")%>% 
  addLegend("bottomright", pal = risk.pal, values = ~lift,
            title = "Lift %")
m
library(htmlwidgets)
saveWidget(m, file=paste0("~/Downloads/purchase_lift.html"))




# hc = purchase_lift %>% 
#   hchart(., 
#          type = "column", 
#          hcaes(x = week, 
#                y = lift, group = Demo.State)) %>% 
#   hc_xAxis(title = list(text = "Weeks")) %>%  
#   hc_yAxis(opposite = F,
#            labels = list(format = "{value}%")) %>% 
#   hc_title(text = "Purchase Intent") %>% 
#   # hc_plotOptions(column = list(
#   #   dataLabels = list(enabled = T),
#   #   stacking = "normal",
#   #   enableMouseTracking = TRUE)) %>%   
#   hc_caption(text = "How Likely are you to vote in November 2022 election?")
# saveWidget(hc, file=paste0("~/Downloads/purchase_intent_bar.html"))



csum = purchase_lift %>% 
  hchart(., 
         type = "column", 
         hcaes(x = week, 
               y = csum, group = Demo.State)) %>% 
  hc_xAxis(title = list(text = "Weeks")) %>%  
  hc_yAxis(opposite = F,
           labels = list(format = "{value}%")) %>% 
  hc_title(text = "Purchase Intent by Cumulative Lift %") %>% 
  # hc_plotOptions(column = list(
  #   dataLabels = list(enabled = T),
  #   stacking = "normal",
  #   enableMouseTracking = TRUE)) %>%
  hc_subtitle(text = "How Likely are you to vote in November 2022 election?",
              style = list(fontWeight = "bold"),
              align = "center")
saveWidget(csum, file=paste0("~/Downloads/purchase_intent_bar_cum.html"))


purchase_lift %>%
  group_by(Demo.State) %>%
  summarise(res = list(tidy(t.test(lift, level = 0.95)))) %>%
  unnest()


m <- lm(lift ~ Demo.State, data = purchase_lift)
g <- glht(m)
summary(g, test = adjusted("holm"))
confint(g)





############## BY Demo : Age  #####################
dem_lift$csum = as.numeric(dem_lift$csum)


age = dem_lift  %>%
  group_by(Demo.State, age_group) %>%
  summarise(csum_age = sum(lift, na.rm = T))


dem_lift <- with(dem_lift, dem_lift[order(Demo.State,age_group ),])

focus_lift <- with(focus_lift, focus_lift[order(Demo.State, age_group),])
purchase_lift <- with(purchase_lift, purchase_lift[order(Demo.State, age_group),])


csum = age %>% 
  hchart(., 
         type = "column", 
         hcaes(x = age_group, 
               y = csum_age, group = Demo.State)) %>% 
  hc_xAxis(title = list(text = "Age Groups")) %>%  
  hc_yAxis(opposite = F,
           labels = list(format = "{value}%")) %>% 
  hc_title(text = "Vote Choice by Cumulative Lift % for Age Groups") %>% 
  # hc_plotOptions(column = list(
  #   dataLabels = list(enabled = T),
  #   stacking = "normal",
  #   enableMouseTracking = TRUE)) %>%
  hc_subtitle(text = "If November 2022 elections were held today what would you vote for: Democrats?",
              style = list(fontWeight = "bold"),
              align = "center")
saveWidget(csum, file=paste0("~/Downloads/vote_choice_bar_age_group.html"))

age = focus_lift  %>%
  group_by(Demo.State, age_group) %>%
  summarise(csum_age = sum(lift, na.rm = T))


csum = age %>% 
  hchart(., 
         type = "column", 
         hcaes(x = age_group, 
               y = csum_age, group = Demo.State)) %>% 
  hc_xAxis(title = list(text = "Age Groups")) %>%  
  hc_yAxis(opposite = F,
           labels = list(format = "{value}%")) %>% 
  hc_title(text = "Focus Issues by Cumulative Lift % for Age Groups") %>% 
  # hc_plotOptions(column = list(
  #   dataLabels = list(enabled = T),
  #   stacking = "normal",
  #   enableMouseTracking = TRUE)) %>%
  hc_subtitle(text = "To what extent do you agree: Democrats are focusing on issue most important to me?",
              style = list(fontWeight = "bold"),
              align = "center")
saveWidget(csum, file=paste0("~/Downloads/focus_issue_bar_age_group.html"))

age = purchase_lift  %>%
  group_by(Demo.State, age_group) %>%
  summarise(csum_age = sum(lift,na.rm = T))

csum = age %>% 
  hchart(., 
         type = "column", 
         hcaes(x = age_group, 
               y = csum_age, group = Demo.State)) %>% 
  hc_xAxis(title = list(text = "Age Groups")) %>%  
  hc_yAxis(opposite = F,
           labels = list(format = "{value}%")) %>% 
  hc_title(text = "Purchase Intent by Cumulative Lift % for Age Groups") %>% 
  # hc_plotOptions(column = list(
  #   dataLabels = list(enabled = T),
  #   stacking = "normal",
  #   enableMouseTracking = TRUE)) %>%
  hc_subtitle(text = "How Likely are you to vote in November 2022 election?",
              style = list(fontWeight = "bold"),
              align = "center")
saveWidget(csum, file=paste0("~/Downloads/purchase_intent_bar_age_group.html"))



############## BY Demo : Gender  #####################

dem_lift = dem_lift  %>%
  group_by(Demo.State, Demo.Gender) %>%
  mutate(csum_gender = sum(lift, na.rm=T))



csum = dem_lift %>% 
  hchart(., 
         type = "column", 
         hcaes(x = Demo.Gender, 
               y = csum_gender, group = Demo.State)) %>% 
  hc_xAxis(title = list(text = "Gender")) %>%  
  hc_yAxis(opposite = F,
           labels = list(format = "{value}%")) %>% 
  hc_title(text = "Vote Choice by Cumulative Lift % for Gender") %>% 
  # hc_plotOptions(column = list(
  #   dataLabels = list(enabled = T),
  #   stacking = "normal",
  #   enableMouseTracking = TRUE)) %>%
  hc_subtitle(text = "If November 2022 elections were held today what would you vote for: Democrats?",
              style = list(fontWeight = "bold"),
              align = "center")
saveWidget(csum, file=paste0("~/Downloads/vote_choice_bar_gender_group.html"))


focus_lift = focus_lift  %>%
  group_by(Demo.State, Demo.Gender) %>%
  mutate(csum_gender = sum(lift, na.rm = T))
csum = focus_lift %>% 
  hchart(., 
         type = "column", 
         hcaes(x =  Demo.Gender, 
               y = csum_gender, group = Demo.State)) %>% 
  hc_xAxis(title = list(text = "Gender")) %>%  
  hc_yAxis(opposite = F,
           labels = list(format = "{value}%")) %>% 
  hc_title(text = "Focus Issues by Cumulative Lift % for Gender") %>% 
  # hc_plotOptions(column = list(
  #   dataLabels = list(enabled = T),
  #   stacking = "normal",
  #   enableMouseTracking = TRUE)) %>%
  hc_subtitle(text = "To what extent do you agree: Democrats are focusing on issue most important to me?",
              style = list(fontWeight = "bold"),
              align = "center")
saveWidget(csum, file=paste0("~/Downloads/focus_issue_bar_gender_group.html"))


purchase_lift = purchase_lift  %>%
  group_by(Demo.State, Demo.Gender) %>%
  mutate(csum_gender = sum(lift, na.rm = T))

csum = purchase_lift %>% 
  hchart(., 
         type = "column", 
         hcaes(x =  Demo.Gender, 
               y = csum_gender, group = Demo.State)) %>% 
  hc_xAxis(title = list(text = "Gender")) %>%  
  hc_yAxis(opposite = F,
           labels = list(format = "{value}%")) %>% 
  hc_title(text = "Purchase Intent by Cumulative Lift % for Gender") %>% 
  # hc_plotOptions(column = list(
  #   dataLabels = list(enabled = T),
  #   stacking = "normal",
  #   enableMouseTracking = TRUE)) %>%
  hc_subtitle(text = "How Likely are you to vote in November 2022 election?",
              style = list(fontWeight = "bold"),
              align = "center")
saveWidget(csum, file=paste0("~/Downloads/purchase_intent_bar_gender_group.html"))



############ Specific Female ######




dem_lift = dem_lift %>% separate(Demo.Hispanic, c("Hispanic","B"), sep = ",")
focus_lift = focus_lift %>% separate(Demo.Hispanic, c("Hispanic","B"), sep = ",")
purchase_lift = purchase_lift %>% separate(Demo.Hispanic, c("Hispanic","B"), sep = ",")

dem_female = subset(dem_lift,Demo.Gender == 'Female'& Hispanic == 'Yes')
focus_female = subset(focus_lift,Demo.Gender == 'Female'& Hispanic == 'Yes')
purchase_female = subset(purchase_lift,Demo.Gender == 'Female'& Hispanic == 'Yes')


dem_female$week <- as.numeric(dem_female$week)
focus_female$week <- as.numeric(focus_female$week)
purchase_female$week <- as.numeric(purchase_female$week)

dem_female <- with(dem_female, dem_female[order(Demo.State, week),])
focus_female <- with(focus_female, focus_female[order(Demo.State, week),])
purchase_female <- with(purchase_female, purchase_female[order(Demo.State, week),])



csum = dem_female %>% 
  hchart(., 
         type = "column", 
         hcaes(x = week, 
               y = lift, group = age_group)) %>% 
  hc_xAxis(title = list(text = "Weeks")) %>%  
  hc_yAxis(opposite = F,    
           labels = list(format = "{value}%")) %>% 
  hc_title(text = "Vote Choice for Female and Ethnicity : Hispanic by Age Groups") %>% 
  # hc_plotOptions(column = list(
  #   dataLabels = list(enabled = T),
  #   stacking = "normal",
  #   enableMouseTracking = TRUE)) %>%
  hc_caption(text = "If November 2022 elections were held today what would you vote for: Democrats?")
saveWidget(csum, file=paste0("~/Downloads/vote_choice_bar_femalehispanic_group.html"))

csum = focus_female %>% 
  hchart(., 
         type = "column", 
         hcaes(x = week, 
               y = lift, group = age_group)) %>% 
  hc_xAxis(title = list(text = "Weeks")) %>%  
  hc_yAxis(opposite = F,
           labels = list(format = "{value}%")) %>% 
  hc_title(text = "Focus Issues for Female and Ethnicity : Hispanic by Age Groups") %>% 
  # hc_plotOptions(column = list(
  #   dataLabels = list(enabled = T),
  #   stacking = "normal",
  #   enableMouseTracking = TRUE)) %>%
  hc_caption(text = "To what extent do you agree: Democrats are focusing on issue most important to me?")
saveWidget(csum, file=paste0("~/Downloads/focus_issue_bar_femalehispanic_group.html"))


csum = purchase_female %>% 
  hchart(., 
         type = "column", 
         hcaes(x = week, 
               y = lift, group = age_group)) %>% 
  hc_xAxis(title = list(text = "Weeks")) %>%  
  hc_yAxis(opposite = F,
           labels = list(format = "{value}%")) %>% 
  hc_title(text = "Purchase Intent for Female and Ethnicity : Hispanic by Age Groups") %>% 
  # hc_plotOptions(column = list(
  #   dataLabels = list(enabled = T),
  #   stacking = "normal",
  #   enableMouseTracking = TRUE)) %>%
  hc_caption(text = "How Likely are you to vote in November 2022 election?")
saveWidget(csum, file=paste0("~/Downloads/purchase_intent_bar_femalehispanic_group.html"))






############ Specific Male ######


dem_male = subset(dem_lift,Demo.Gender == 'Male' & Demo.Age > 64)
focus_male = subset(focus_lift,Demo.Gender == 'Male'& Demo.Age > 64)
purchase_male = subset(purchase_lift,Demo.Gender == 'Male'& Demo.Age > 64)


csum = dem_male %>% 
  hchart(., 
         type = "column", 
         hcaes(x = week, 
               y = lift, group = Demo.State)) %>% 
  hc_xAxis(title = list(text = "Weeks")) %>%  
  hc_yAxis(opposite = F,
           labels = list(format = "{value}%")) %>% 
  hc_title(text = "Vote Choice for Male and  Age > 64") %>% 
  # hc_plotOptions(column = list(
  #   dataLabels = list(enabled = T),
  #   stacking = "normal",
  #   enableMouseTracking = TRUE)) %>%
  hc_caption(text = "If November 2022 elections were held today what would you vote for: Democrats?")
saveWidget(csum, file=paste0("~/Downloads/vote_choice_bar_male64_group.html"))

csum = focus_male %>% 
  hchart(., 
         type = "column", 
         hcaes(x = week, 
               y = lift, group = Demo.State)) %>% 
  hc_xAxis(title = list(text = "Weeks")) %>%  
  hc_yAxis(opposite = F,
           labels = list(format = "{value}%")) %>% 
  hc_title(text = "Focus Issues for Male and  Age > 64") %>% 
  # hc_plotOptions(column = list(
  #   dataLabels = list(enabled = T),
  #   stacking = "normal",
  #   enableMouseTracking = TRUE)) %>%
  hc_caption(text = "To what extent do you agree: Democrats are focusing on issue most important to me?")
saveWidget(csum, file=paste0("~/Downloads/focus_issue_bar_male64_group.html"))


csum = purchase_male %>% 
  hchart(., 
         type = "column", 
         hcaes(x = week, 
               y = lift, group = Demo.State)) %>% 
  hc_xAxis(title = list(text = "Weeks")) %>%  
  hc_yAxis(opposite = F,
           labels = list(format = "{value}%")) %>% 
  hc_title(text = "Purchase Intent for Male and  Age > 64") %>% 
  # hc_plotOptions(column = list(
  #   dataLabels = list(enabled = T),
  #   stacking = "normal",
  #   enableMouseTracking = TRUE)) %>%
  hc_caption(text = "How Likely are you to vote in November 2022 election?")
saveWidget(csum, file=paste0("~/Downloads/purchase_intent_bar_male64_group.html"))



# 
# 
# 
# 
# # 
# # 
# #   
# #   #addCircles(lng = ~longitude, lat = ~latitude) %>%
# #   addMarkers(icon = ~ favicons[Vote.Choice], # lookup based on ticker
# #              group = ~Group) %>%
# #   
# #   addLayersControl(
# #     overlayGroups = c("Exposed", "Control"),
# #     options = layersControlOptions(collapsed = FALSE)
# #   )%>%
# #   addControl(html=htmltitle, position = "bottomright")
# #   
# #   # addLegend("bottomright", 
# #   #           colors = c('darkgreen', 'green', 'yellow', 'red', 'darkred'),
# #   #           labels = c("Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"),
# #   #           title = "If November 2022 elections were held today what would you vote for? ",
# #   #           opacity = 1)
# # 
# 
# #%>%addProviderTiles("CartoDB.Positron")
# 
# #### 
# 
# df$Demo.Income = as.factor(df$Demo.Income)
# 
# 
# 
# favicons <- iconList(
#   "1" = makeIcon(
#     iconUrl = "https://cdn-icons-png.flaticon.com/512/7284/7284440.png",
#     iconWidth = 15,
#     iconHeight = 15
#   ),
#   "2" = makeIcon(
#     iconUrl = "https://cdn-icons-png.flaticon.com/512/166/166538.png",
#     iconWidth = 15,
#     iconHeight = 15)
#   # ),
#   # "3" = makeIcon(
#   #   iconUrl = "https://cdn-icons-png.flaticon.com/512/777/777077.png",
#   #   iconWidth = 15,
#   #   iconHeight = 15
#   # ),
#   # "4" = makeIcon(
#   #   iconUrl = "https://cdn-icons-png.flaticon.com/512/5953/5953169.png",
#   #   iconWidth = 15,
#   #   iconHeight = 15
#   # ),
#   # "5" = makeIcon(
#   #   iconUrl = "https://cdn-icons-png.flaticon.com/512/5953/5953468.png",
#   #   iconWidth = 15,
#   #   iconHeight = 15
#   # )
# )
# 
# 
# 
# library(leaflet)
# 
# htmltitle <- "<h5> To what extent do you agree: Democrats are focusing on issue most important to me? </h5>"
# 
# 
# leaflet(focus) %>%
#   addTiles() %>%
#   #addCircles(lng = ~longitude, lat = ~latitude) %>%
#   addMarkers(icon = ~ favicons[Focus.on.Issues], # lookup based on ticker
#              group = ~Group) %>%
#   addLayersControl(
#     overlayGroups = c("Exposed", "Control"),
#     options = layersControlOptions(collapsed = FALSE)
#   )%>%
#   addControl(html=htmltitle, position = "bottomright")
# 
# 
# 
# 
# 
# 
# leaflet(df) %>%
#   addTiles() %>%
#   #addCircles(lng = ~longitude, lat = ~latitude) %>%
#   addMarkers(icon = ~ favicons[Focus.on.Issues], # lookup based on ticker
#              label = ~ Focus.on.Issues)%>%
#   addMarkers(icon = ~ favicons[Focus.on.Issues], # lookup based on ticker
#              label = ~ Focus.on.Issues)%>%
#   addLayersControl(
#     overlayGroups=c("Magnitude between 4 and 5", "Magnitude between 5 and 6"),
#     options=layersControlOptions(collapsed=FALSE)
#   )%>%
#   addLegend("bottomright", 
#             colors = c('darkgreen', 'green', 'yellow', 'red', 'darkred'),
#             labels = c("Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"),
#             title = "To what extent do you agree: Democrats are focusing on issue most important to me? ",
#             opacity = 1)
# 
# 
# 
# 
# 
# 
# 
# #### Purchase Intent #####
# 
# df$Demo.Income = as.factor(df$Demo.Income)
# 
# 
# 
# favicons <- iconList(
#   "1" = makeIcon(
#     iconUrl = "https://cdn-icons-png.flaticon.com/512/927/927295.png",
#     iconWidth = 15,
#     iconHeight = 15
#   ),
#   "2" = makeIcon(
#     iconUrl = "https://cdn-icons-png.flaticon.com/512/1027/1027567.png",
#     iconWidth = 15,
#     iconHeight = 15
#   # ),
#   # "3" = makeIcon(
#   #   iconUrl = "https://cdn-icons-png.flaticon.com/512/4989/4989647.png",
#   #   iconWidth = 15,
#   #   iconHeight = 15
#   # ),
#   # "4" = makeIcon(
#   #   iconUrl = "https://cdn-icons-png.flaticon.com/512/594/594914.png",
#   #   iconWidth = 15,
#   #   iconHeight = 15
#   # ),
#   # "5" = makeIcon(
#   #   iconUrl = "https://cdn-icons-png.flaticon.com/512/1828/1828665.png",
#   #   iconWidth = 15,
#   #   iconHeight = 15
#   # ),
#   # "6" = makeIcon(
#   #   iconUrl = "https://cdn-icons-png.flaticon.com/512/2027/2027322.png",
#   #   iconWidth = 15,
#   #   iconHeight = 15
#   )
# )
# df$Purchase.Intent
# 
# 
# 
# 
# htmltitle <- "<h5> How Likely are you to vote in November 2022 election? </h5>"
# 
# 
# leaflet(purchase) %>%
#   addTiles() %>%
#   #addCircles(lng = ~longitude, lat = ~latitude) %>%
#   addMarkers(icon = ~ favicons[Purchase.Intent], # lookup based on ticker
#              group = ~Group) %>%
#   addLayersControl(
#     overlayGroups = c("Exposed", "Control"),
#     options = layersControlOptions(collapsed = FALSE)
#   )%>%
#   addControl(html=htmltitle, position = "bottomright")
# 
# 
# 
# 
# 
# leaflet(df) %>%
#   addTiles() %>%
#   #addCircles(lng = ~longitude, lat = ~latitude) %>%
#   addMarkers(icon = ~ favicons[Purchase.Intent], # lookup based on ticker
#              label = ~ Purchase.Intent)%>%
#   addLegend("bottomright", 
#             colors = c('green', 'green', 'black', 'red', 'darkred', 'yellow'),
#             labels = c("Very Likely", "Somewhat Likely", "Neutral", "Somewhat Unlikely", "Unlikely", "Don't Know"),
#             title = "How Likely are you to vote in November 2022 election?",
#             opacity = 1)
# 
# 
# ##### LikertScales in R ##########
# 
# 
# focus$Focus.on.Issues[focus$Focus.on.Issues == '2'] <- '1'
# 
# focus$Group = as.factor(focus$Group)
# 
# 
# 
# 
# 
# items <- as.data.frame(focus[,c(16,30, 10)])   ##Vote Choice
# choices  = c("Control", "Exposed")
# 
# 
# 
# names(items)[1] = "To what extent do you agree: Democrats are focusing on issue most important to me? "
# 
# 
# plot(likert(items[1], grouping=items$Demo.State), colors = c("darkblue", "deepskyblue"),  ordered=F, as.percent=TRUE)
# 
# 
# 
# 
# ################
# 
# 
# 
# purchase$Purchase.Intent[purchase$Purchase.Intent == '2'] <- '1'
# 
# purchase$Group = as.factor(purchase$Group)
# 
# 
# 
# 
# 
# items <- as.data.frame(purchase[,c(16,31, 10)])   ##Vote Choice
# choices  = c("Control", "Exposed")
# 
# 
# 
# names(items)[1] = "How Likely are you to vote in November 2022 election? "
# 
# 
# plot(likert(items[1], grouping=items$Demo.State), colors = c("darkblue", "deepskyblue"),  ordered=F, as.percent=TRUE)
# 
# 
# 
# 
# ################
# 
# 
# 
# 
# dem$Group = as.factor(dem$Group)
# 
# 
# 
# 
# 
# items <- as.data.frame(dem[,c(16,32, 10)])   ##Vote Choice
# choices  = c("Control", "Exposed")
# 
# 
# 
# names(items)[1] = "If November 2022 elections were held today what would you vote for: Democrats? "
# 
# 
# plot(likert(items[1], grouping=items$Demo.State), colors = c("darkblue", "deepskyblue"),  ordered=F, as.percent=TRUE)
# 
# # 
# # 
# # 
# # 
# # exposed_focus  = focus[which(focus$Group == "Exposed"),]
# # control_focus = focus[which(focus$Group == "Control"),]
# # 
# # 
# # 
# # items <- as.data.frame(exposed_focus[,30])  ##Focus on Issue
# # choices  = c("Strongly Agree", "Agree")
# # 
# # for(i in 1:ncol(items)) {
# #   items[,i] = factor(items[,i], levels=1:2, labels=choices, ordered=TRUE)
# # }
# # 
# # names(items)[1] = "EXPOSED GROUP: To what extent do you agree: Democrats are focusing on issue most important to me? "
# # plot(likert(items[1], grouping=exposed_focus$Demo.State), colors = c("darkgreen", "limegreen"),  ordered=TRUE, include.histograms = TRUE)
# # 
# # 
# # 
# # items <- as.data.frame(control_focus[,30])  ##Focus on Issue
# # choices  = c("Strongly Agree", "Agree")
# # 
# # for(i in 1:ncol(items)) {
# #   items[,i] = factor(items[,i], levels=1:2, labels=choices, ordered=TRUE)
# # }
# # 
# # names(items)[1] = "CONTROL GROUP: To what extent do you agree: Democrats are focusing on issue most important to me? "
# # plot(likert(items[1], grouping=control_focus$Demo.State), colors = c("darkgreen", "limegreen"),  ordered=TRUE, include.histograms = TRUE)
# # 
# # 
# # 
# # 
# # 
# # 
# # 
# # 
# # 
# # ##### LikertScales in R ##########
# # 
# # exposed_purchase = purchase[which(purchase$Group == "Exposed"),]
# # control_purchase = purchase[which(purchase$Group == "Control"),]
# # 
# # 
# # 
# # items <- as.data.frame(exposed_purchase[,31])  ##Purchase Intent
# # choices  = c("Very Likely", "Somewhat Likely")
# # 
# # for(i in 1:ncol(items)) {
# #   items[,i] = factor(items[,i], levels=1:2, labels=choices, ordered=TRUE)
# # }
# # 
# # names(items)[1] = "EXPOSED GROUP: How Likely are you to vote in November 2022 election?"
# # plot(likert(items[1], grouping=exposed_purchase$Demo.State), colors = c("darkgreen", "limegreen"),  ordered=TRUE, include.histograms = TRUE)
# # 
# # 
# # 
# # items <- as.data.frame(control_purchase[,31])  ##Purchase  Intent
# # choices  = c("Very Likely", "Somewhat Likely")
# # 
# # for(i in 1:ncol(items)) {
# #   items[,i] = factor(items[,i], levels=1:2, labels=choices, ordered=TRUE)
# # }
# # 
# # names(items)[1] = "CONTROL GROUP: How Likely are you to vote in November 2022 election?"
# # plot(likert(items[1], grouping=control_purchase$Demo.State), colors = c("darkgreen", "limegreen"),  ordered=TRUE, include.histograms = TRUE)
# # 
# # 
# # 
# # ##### LikertScales in R ##########
# # 
# # 
# # 
# # # exposed_vote = dem[which(dem$Group == "Exposed"),]
# # # control_vote = dem[which(dem$Group == "Control"),]
# # # 
# # # 
# # 
# # 
# # 
# # dem$Group = as.factor(dem$Group)
# # 
# # 
# # items <- as.data.frame(dem[,16])   ##Vote Choice
# # choices  = c("Control", "Exposed")
# # 
# # for(i in 1:ncol(items)) {
# #   items[,i] = factor(items[,i], levels=1:2, labels=choices, ordered=TRUE)
# # }
# # 
# # names(items)[1] = "If November 2022 elections were held today what would you vote for: Democrats?"
# # 
# # 
# # plot(likert(items[1], grouping=dem$Demo.State), colors = c("darkblue", "deepskyblue"),  ordered=F, as.percent=TRUE)
# # 
# # 


##### Stat Test ########

##### Dem Lift ########

library(rpivotTable)
data(mtcars)
## One line to create pivot table

colnames(brand_lift)[age_group] <- "Age group"


k = rpivotTable(brand_lift, rows="c4", col="Creative", aggregatorName="Average", 
            vals="csum", rendererName="Table Bar Chart")


saveWidget(k, file=paste0("~/Downloads/vytalogy.html"))

brand_lift$Weekname

write.csv(brand_lift, "~/Downloads/brandlift.csv")
