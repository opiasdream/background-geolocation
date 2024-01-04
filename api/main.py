from datetime import datetime
from fastapi import FastAPI
from fastapi.responses import StreamingResponse
import json

app = FastAPI()

@app.post("/addLocation")
def add_location(location: dict):
    f = open("locations.txt", "a+")
    f.write(f"\n\n*******  {datetime.fromisoformat(str(location['location']['timestamp']).replace("Z", "+00:00"))} \n\n " + str(location))
    f.close()
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

    return decoded_data["locations"]


# @app.get("/items/{item_id}")
# def read_item(item_id: int, q: Union[str, None] = None):
#     return {"item_id": item_id, "q": q}

