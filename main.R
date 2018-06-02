#☺ Erase the working folder
rm(list=ls())

# working folder
foldername = "C:/Users/Bar Yokhai/Desktop/projets/Blog/openstreet_poi_df/"

# Load les autres scripts
list_of_relevant_files = paste0(foldername,c("config.R","packages.R","fun.R"))
source(list_of_relevant_files[1],encoding = "UTF-8")
source(list_of_relevant_files[2],encoding = "UTF-8")
source(list_of_relevant_files[3],encoding = "UTF-8")

# Requests df
requests_df = build_requests_df (poi_list,box_list)

# Récupère tout les poi dans une liste qu'on sauvegarde à chaque itération
poi_list = list()
for (id_request in seq(length(poi_list)+1,nrow(requests_df))){
  pathfile = "results.osm"
  mycity = requests_df[id_request,"ville"]
  myfeature = requests_df[id_request,"feature"]
  myvalue = requests_df[id_request,"value"]
  cat("Request n°",id_request,": ",mycity," | ",myfeature," | ",myvalue,"\n")
  res = build_df_from_request (myfeature,myvalue,mycity,pathfile,box_list)
  cat("      Number of point of interest : ",nrow(res),"\n")
  Sys.sleep(20)
  poi_list[[id_request]] = res
  saveRDS(object = poi_list,file = "poi_list.rds")
}

# Load data and filter three cities
df = readRDS(file = "poi_list.rds")
df = do.call(rbind,df)
df = df[df$ville %in% c("Paris","Lyon","Marseille"),]

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