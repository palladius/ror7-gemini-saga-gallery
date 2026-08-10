'''
Ricc: i dont think this works. It uses videosurveillance API, not Gemini.
'''
from google.cloud import storage
from google.cloud import videointelligence

def analyze_video(event, context):
    """Triggered by a change to a Cloud Storage bucket."""
    print(f"🌱 INFO: event: {event}")
    print(f"🌱 INFO: context: {context}")
    file_name = event['name']
    bucket_name = event['bucket']

    if not file_name.lower().endswith(('.mp4', '.mov', '.avi')): # Add more if you need
        print(f"File {file_name} is not a supported video format.")
        return

    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(file_name)

    # Check MIME type (more robust)
    blob.reload()
    if not blob.content_type.startswith('video/'):
        print(f"File {file_name} does not have a video MIME type.")
        return

    video_client = videointelligence.VideoIntelligenceServiceClient()
    gcs_uri = f"gs://{bucket_name}/{file_name}"
    operation = video_client.annotate_video(
        request={
            "features": [videointelligence.Feature.OBJECT_TRACKING],
            "input_uri": gcs_uri,
        }
    )

    print("Waiting for operation to complete...")
    result = operation.result(timeout=600) # Adjust timeout as needed
    print("🌱 INFO: result: ", result)
    annotations = []
    for track in result.annotation_results[0].object_annotations:
        print("🌱 INFO: track: ", track)
        if track.entity.description in ["Fish", "Shark", "Dolphin", "Turtle"]: # Example: Fish
            for segment in track.segments:
                start_time = segment.segment.start_time_offset.seconds + segment.segment.start_time_offset.microseconds/1000000
                end_time = segment.segment.end_time_offset.seconds + segment.segment.end_time_offset.microseconds/1000000
                annotations.append({
                    "timeStart": str(start_time),
                    "timeEnd": str(end_time),
                    "fishName": track.entity.description, # Needs further processing to get correct name
                    "fishLatinName": "", # Needs further processing to get correct name
                    "number": "1",
                    "description": f"A {track.entity.description} was spotted"
                })
    print(annotations)
    print("🌱 INFO: Saving annotations to JSON file: TODO(ricc): ", annotations)
    # ... (Further processing to get accurate fish name and Latin name using a database or external API)
    # ... (Screenshot extraction - separate process recommended)


if __name__ == "__main__":
    print("🌱 INFO: Testing scuba-gcs-detect.py with Riccardo's project")
    event = {
        "name": "video/GX014497.MP4",
#        "name": "test.mp4",
        "bucket": "ricc-genai-prove",
       # "projectId": "ricc-genai",
    }
    context = {}
    analyze_video(event, context)
