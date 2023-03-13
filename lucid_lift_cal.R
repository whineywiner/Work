
m = df %>% 
  filter(Family.Dollar..Brand.Awareness == "2") %>%
  group_by(Family.Dollar..Brand.Awareness,Group,Strata) %>% 
  mutate(weights = sum(Weight, na.rm = TRUE))



m = df %>% 
  group_by(Group,Strata) %>% 
  mutate(weightsall = sum(Weight, na.rm = TRUE))



z = m %>%
  group_by(Group) %>%
  mutate(proportions = (weights/weightsall)*100)

z = z %>%
  group_by(Strata) %>%
  mutate(lift = (proportions-lag(proportions , na.rm = T)))

z = z %>%
  group_by(Strata) %>% 
  mutate(weight_total = sum(weightsall)) 


z = z %>%
  group_by(Group) %>% 
  mutate(weight_totalt = sum(weight_total))


z = z %>%
  group_by(Weekname.x,week.x) %>% 
  mutate(weight_value = weight_total/weight_totalt)
z = z %>%
  mutate(cum_lift = sum(weight_value * lift))



rpivotTable(z, rows="", col=c("Weekname", "week.x"), aggregatorName="Last",
            vals="cum_lift", rendererName="Heatmap", color = "green")

