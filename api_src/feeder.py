import pymongo
import populartimes
import requests

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["binoculars"]
mycol = mydb["places"]


r = requests.get('https://api.tfl.lu/v1/Occupancy/CarPark')
parks = r.json()

for park in parks['features']:

    if (park["properties"]["free"]):     
        newplace = {
            "gmapid": '0',
            "name": park['properties']["name"] + " Parking",
            "lat": round(park["geometry"]["coordinates"][1], 6),
            "lng": round(park["geometry"]["coordinates"][0], 6),
            "currentpopular": 100 - int(park["properties"]["free"]) * 100 / int(park["properties"]["total"])
        }

        mycol.insert_one(newplace)


places = populartimes.get("AIzaSyDPAw8Ry_libv-n-dYZpyczu5F73pXsS34", [], (49.596801, 6.105913), (49.639198, 6.163469), 10, 200, False)

for place in places:
    newplace = {
        "gmapid": place["id"],
        "name": place["name"],
        "lat": round(place["coordinates"]["lat"], 6),
        "lng": round(place["coordinates"]["lng"], 6),
        "currentpopular": place["populartimes"][6]["data"][19]
    }

    mycol.insert_one(newplace)

places = populartimes.get("AIzaSyDPAw8Ry_libv-n-dYZpyczu5F73pXsS34", ["park"], (49.596801, 6.105913), (49.639198, 6.163469), 10, 2000, False)

for place in places:
    newplace = {
        "gmapid": place["id"],
        "name": place["name"],
        "lat": round(place["coordinates"]["lat"], 6),
        "lng": round(place["coordinates"]["lng"], 6),
        "currentpopular": place["populartimes"][6]["data"][19]
    }

    mycol.insert_one(newplace)
