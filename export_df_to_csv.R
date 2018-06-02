# Load data and filter three cities
df = readRDS(file = "poi_list.rds")
df = do.call(rbind,df)
df = df[df$ville %in% c("Paris","Lyon","Marseille"),]
unique(df$ville)

# Saving Parameters
foldername = "C:/Users/Bar Yokhai/Desktop/projets/Blog/openstreet_poi_df/data/"
filename = "df_poi.csv"
pathfile = paste0(foldername,filename)

# Save df
write.table(x = df,
            file = pathfile,
            sep = "\t",
            row.names = FALSE,
            fileEncoding = "UTF-8")
