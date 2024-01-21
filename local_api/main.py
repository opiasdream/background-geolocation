import json
from datetime import datetime
from geopy.distance import geodesic
from fastapi.responses import StreamingResponse
from fastapi import FastAPI, Header, HTTPException
from apscheduler.schedulers.background import BackgroundScheduler
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# origins = [
#     "http://localhost",
#     "http://localhost:8080",
#     "http://127.0.0.1:8000",
#     "http://10.0.2.2:8000",
# ]

# app.add_middleware(
#     CORSMiddleware,
#     allow_origins = origins,
#     allow_credentials = True,
#     allow_methods = ["*"],
#     allow_headers = ["*"],
# )

# company locations list.
company_locations = []

# ------------------------------------ API ----------------------------------- #

@app.post("/addLocation")
def add_location(location: dict, token: str = Header()):
    
    time = f"{datetime.fromisoformat(str(location['location']['timestamp']).replace("Z", "+00:00"))}"
    
    f = open("location_logs.txt", "a+")
    f.write(f"\n\n******* {token} {time} \n\n " + str(location))
    f.close()
    
    data = {
        "token": token,
        "time": time,
        "location" : location["location"]
    }

    json_object = json.dumps(data, indent=4)
    with open(f"{token}.json", "w") as outfile:
        outfile.write(json_object)
    
    check_and_send_notifications({"token" : token, "latitude" : location["location"]["coords"]["latitude"], "longitude" : location["location"]["coords"]["longitude"]})
    
    return {"message": "Location added"}

@app.get("/location-logs")
async def get_locations():
    def generate():
        with open("location_logs.txt", "r") as f:
            while chunk := f.read(8192):
                yield chunk
                
    return StreamingResponse(generate(), media_type="text/plain")

@app.get("/client-last-location")
async def get_last_location(token:str = Header(default="")):   
 
    async def last_location():
        try:
            with open(f"{token}.json", 'r') as openfile:
                json_object = json.load(openfile)
                json_bytes = json.dumps(json_object).encode('utf-8')
                yield json_bytes
        except FileNotFoundError:
            raise HTTPException(status_code=404, detail="File not found")

    return StreamingResponse(last_location(), media_type="application/event-stream")


@app.get("/company-locations")
def getCompanyLocations():
    with open('locations.json', 'r') as json_file:
        decoded_data = json.load(json_file)
        
    global company_locations
    company_locations = decoded_data["locations"]

    return company_locations

@app.get("/notification-logs")
def get_notification_logs():
    def notifications():
        with open("notifications.txt", "r") as f:
            while chunk := f.read(8192):
                yield chunk
                
    return StreamingResponse(notifications(), media_type="text/plain")

# ------------------------------- notifications ------------------------------ #

# send notification service
def send_notification(token: str):
    f = open("notifications.txt", "a+")
    f.write(f"Time:{datetime.now()}\nNotification sent to Token: {token}\n\n")
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




