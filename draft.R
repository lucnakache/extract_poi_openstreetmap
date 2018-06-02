# requests df
requests_df = build_requests_df (poi_list,box_list)


# religion test
results_religion = osm_religion_to_df(pathfile = pathfile)
pathfile = "results.osm"




extract_data_from_osm(my_feature = "amenity",
                      my_value = "casino",
                      my_city = "Marseille",
                      filename = "results.osm",
                      box_list)


results_other = extract_openstreet_map_informations_to_df(pathfile = pathfile)


# test sur une requete




# poi_list = list()
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

poi_df = do.call(rbind,poi_list)








# poi_list = lapply(seq(1,nrow(requests_df)),FUN = function(id_request){
#   
#   pathfile = "results.osm"
#   mycity = requests_df[id_request,"ville"]
#   myfeature = requests_df[id_request,"feature"]
#   myvalue = requests_df[id_request,"value"]
#   cat("Request n°",id_request,": ",mycity," | ",myfeature," | ",myvalue,"\n")
#   res = build_df_from_request (myfeature,myvalue,mycity,pathfile,box_list)
#   cat("      Number of point of interest : ",nrow(res),"\n")
#   Sys.sleep(15)
#   return(res)
# } )
# 
# poi_df = do.call(rbind,poi_list)





extract_data_from_osm(my_feature = "amenity",
                      my_value = "casino",
                      my_city = "Deauville",
                      filename = "results.osm",
                      box_list
)



q <- opq(bbox =  box_list[["Deauville"]]) %>%
  add_osm_feature(key = "amenity")
lots_of_data <- osmdata_sf(q)

DD=lots_of_data$osm_polygons

osmdata_xml (q, 'other.osm')
df=sf::st_read ('other.osm', layer = 'points', quiet = TRUE)
