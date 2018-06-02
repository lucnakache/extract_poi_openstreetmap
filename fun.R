# functions

get_religion = function(a_tag){
  machaine = as.character(a_tag)
  machaine = gsub(pattern = "\\\"",replacement = "",x = machaine)
  pattern = "religion=>.+?(,|$)"
  machaine = str_extract(string = machaine,pattern = pattern)
  religion = strsplit(x = machaine,split = "=>",fixed = TRUE)[[1]][2]
  return(religion)
}

# get_religion(df$other_tags[2])






osm_religion_to_df = function(pathfile){
  df = sf::st_read (pathfile, layer = 'points', quiet = TRUE)
  if (nrow(df) != 0) {
  df$religion = unlist(lapply(seq_along(df$other_tags),function(x) {
    # cat("tag n°",x,"\n")
    return(get_religion(df$other_tags[x]))
  }
  )
  )
  
  coordinates=do.call(rbind, sf::st_geometry(df$geometry))
  coordinates = as.data.frame(coordinates)
  names(coordinates) =c("long","lat")
  df$geometry = NULL
  df = data.frame("id" = df$osm_id,
                  "name" = df$name,
                  "religion" = df$religion,
                  "long" = coordinates$long,
                  "lat" = coordinates$lat)
  } else {df = data.frame("id" = character(),
                          "name" = character(),
                          "religion" = character(),
                          "long" = numeric(),
                          "lat" = numeric())
  }

  
  return(df)
}





# other df
extract_openstreet_map_informations_to_df = function(pathfile){
  df = sf::st_read (pathfile, layer = 'points', quiet = TRUE)
  if (nrow(df)>0){
    coordinates=do.call(rbind, sf::st_geometry(df$geometry))
    coordinates = as.data.frame(coordinates)
    names(coordinates) =c("long","lat")
    df$geometry = NULL
    df = data.frame("id" = df$osm_id,
                    "name" = df$name,
                    "long" = coordinates$long,
                    "lat" = coordinates$lat,
                    stringsAsFactors = FALSE)
    
  } else {df = data.frame("id" = character(),
                          "name" = character(),
                          "long" = numeric(),
                          "lat" = numeric(),
                          stringsAsFactors = FALSE)
  }
  return(df)
}
# results = extract_openstreet_map_informations_to_df(pathfile = pathfile)





extract_data_from_osm = function(my_feature = "amenity",
                                 my_value = "casino",
                                 my_city = "Paris",
                                 filename = "results.osm",
                                 box_list
){
  my_request = opq(bbox = box_list[[my_city]]) %>%
    add_osm_feature(key = my_feature,value =my_value)
  osmdata_xml (my_request, filename)
}


# extract_data_from_osm(my_feature = "amenity",
#                       my_value = "casino",
#                       my_city = "Marseille",
#                       filename = "results.osm",
#                       box_list
# )





build_requests_df = function (poi_list,box_list){
  coefficients = unlist(lapply(poi_list,length))
  values = unlist(poi_list)
  names(values) = NULL
  features = names(poi_list)
  features = rep(features,coefficients)
  
  cities_names = names(box_list)
  cities_names = rep(cities_names,each = length(features))
  
  features = rep(features, times = length(names(box_list)))
  values = rep(values,times = length(names(box_list)))
  
  requests_df = data.frame("ville" = cities_names,
                           "feature" = features,
                           "value" = values,
                           stringsAsFactors = FALSE)
  requests_df = requests_df[requests_df$value!="place_of_worship",]
  return (requests_df)
}

# tt = build_requests_df (poi_list,box_list)







build_df_from_request = function(myfeature,myvalue,mycity,pathfile,box_list){
  extract_data_from_osm(my_feature = myfeature,
                        my_value = myvalue,
                        my_city = mycity,
                        filename = pathfile,
                        box_list)
  
  temp_results = extract_openstreet_map_informations_to_df(pathfile = pathfile)
  if (nrow(temp_results)>0){
    temp_results$ville = mycity
    temp_results$feature = myfeature
    temp_results$value = myvalue
  }
  return(temp_results)
}

# tt = build_df_from_request (myfeature,myvalue,mycity,pathfile,box_list)
