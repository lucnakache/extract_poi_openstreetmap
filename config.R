# Config.R

# liste de box , d'abord latitude, puis longitude
box_list = list()
box_list [[1]] = c(2.1871558,48.9979687,2.6863471,48.6516909)
box_list [[2]] = c(5.3587714,43.3314951,5.448207,43.2299569)
box_list [[3]] = c(4.9206916,45.8041042,4.9907294,45.6659567)
box_list [[4]] = c(0.0539199,49.3544647,0.09087, 49.3467068)
box_list [[5]] = c(-2.7207288,47.6418376,-2.7172955,47.6691549)
names(box_list) = c("Paris","Marseille","Lyon","Deauville","Vannes")

# Liste de poi, d'abord la catégorie puis le tag
# Voir https://wiki.openstreetmap.org/wiki/Map_Features
poi_list = list()
poi_list[["amenity"]] = c("bar","cafe","fast_food","food_court","pub","restaurant",
                          "college","kindergarten","library","school","university",
                          "parking",
                          "bureau_de_change","bank",
                          "clinic","dentist","doctors","hospital",
                          "brothel","casino","cinema","gambling","nightclub","stripclub",
                          "swingerclub",
                          "internet_cafe",
                          "place_of_worship",
                          "prison")

poi_list[["building"]] = c("apartments","hotel","house","detached","residential",
                           "bungalow")

poi_list[["leisure"]] = c("fitness_centre","fitness_station","garden","park","pitch",
                          "playground","sports_centre",
                        "swimming_pool","track")

poi_list[["office"]] =  c("company","employment_agency")

poi_list[["shop"]] =c("department_store","general","mall","supermarket")




