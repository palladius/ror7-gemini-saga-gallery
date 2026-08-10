
test-riccardo-only:
	gcloud config set project ricc-genai
	python3 scuba-gcs-detect.py

auth:
	gcloud auth application-default login
	gcloud auth login

init:
	pip install -r requirements.txt
	echo "Enable videointelligence API: videointelligence.googleapis.com"
