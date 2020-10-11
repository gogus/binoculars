#!/usr/bin/env python3
import falcon
import pymongo

class PlaceResource:
    def on_get(self, req, resp):
        myclient = pymongo.MongoClient("mongodb://localhost:27017/")
        mydb = myclient["binoculars"]

        places = []
        places_obj = mydb["places"]

        for object in places_obj.find():
            object.pop('_id', None)
            places.append(object)

        maxnum = 0

        for place in places:
            if (place['currentpopular'] > maxnum):
                maxnum = place['currentpopular']

        for place in places:
            place['currentpopular'] = round(place['currentpopular'] * 100 / maxnum, 0)

        resp.media = places

api = falcon.API()
api.add_route('/places', PlaceResource())