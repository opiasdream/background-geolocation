import json
from datetime import datetime
from geopy.distance import geodesic
from fastapi import FastAPI, BackgroundTasks, Header
from fastapi.responses import StreamingResponse
from apscheduler.schedulers.background import BackgroundScheduler

app = FastAPI()

# company locations list.
company_locations = []

# ------------------------------------ API ----------------------------------- #
@app.post("/addLocation")
def add_location(location: dict, token: str = Header()):
    
    f = open("location_logs.txt", "a+")
    f.write(f"\n\n******* {token} {datetime.fromisoformat(str(location['location']['timestamp']).replace("Z", "+00:00"))} \n\n " + str(location))
    f.close()
    
    check_and_send_notifications({"token" : token, "latitude" : location["location"]["coords"]["latitude"], "longitude" : location["location"]["coords"]["longitude"]})
    
    return {"message": "Location added"}

@app.get("/location-logs")
async def get_locations():
    def generate():
        with open("location_logs.txt", "r") as f:
            while chunk := f.read(8192):
                yield chunk
                
    return StreamingResponse(generate(), media_type="text/plain")


@app.get("/company-locations")
def getCompanyLocations():
    with open('locations.json', 'r') as json_file:
        decoded_data = json.load(json_file)
        
    global company_locations
    company_locations = decoded_data["locations"]

    return company_locations

# ------------------------------- notifications ------------------------------ #


# send notification
def send_notification(token: str):
    f = open("notifications.txt", "a+")
    f.write(f"\n***Sending notification to TOKEN: {token}")
    f.close()
    
# check and send.
def check_and_send_notifications(data):
    
    for company_location in company_locations:
        
        user_location = (data["latitude"], data["longitude"])
        target_location = (company_location['latitude'], company_location['longitude'])
        
        distance = geodesic(user_location, target_location).km
        
        if distance < 1.0:  # 1 km
            send_notification(data["token"])


# ------------------------------ BackgroundTasks ----------------------------- #

scheduler = BackgroundScheduler()
scheduler.add_job(getCompanyLocations)
scheduler.start()




