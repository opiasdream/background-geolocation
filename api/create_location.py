import json
from geopy.distance import geodesic

try:
    
    # start_location = (latitude, longitude).
    start_location = (41.015941, 28.9784021)

    # locations list.
    locations = []

    # distance multipliers.
    distances = [1, 2, 3, 4, 5]

    # kilometers per distance.
    km_per_distance = 5

    # create points and add them to locations list.
    for distance in distances:
        for point in range(1, km_per_distance + 1):
            new_location = geodesic(kilometers=distance).destination(start_location, bearing=point * 360/km_per_distance)
            location_entry = {
                "companyID": f"rand {distance}_{point}",
                "latitude": new_location.latitude,
                "longitude": new_location.longitude
            }
            locations.append(location_entry)

    # write json file.
    with open('locations.json', 'w') as json_file:
        json.dump({"locations": locations}, json_file, indent=2)
        
    print("locations have been successfully created and saved in the file named 'locations.json'")
    
except:
    
    print("Error!")

