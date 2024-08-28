#app_name = ${APP_NAME}
prid = ${PROJECT_ID}
APP_VERSION = $(shell cat ../../VERSION)
#APP_VERSION = ${script cat ../../VERSION}

plan: .terraform
	@echo "ENV APP_NAME:   '$(APP_NAME)'"
	@echo "ENV PROJECT_ID: '$(prid)'"
	@echo "ENV VERSION: '$(APP_VERSION)'"
	@echo Example: terraform plan -var="app_name=$(APP_NAME)" -var="project_id=${PROJECT_ID}" -var="APP_VERSION=$(APP_VERSION)"
#	@echo terraform apply -var="app_name=$(APP_NAME)" -var="project_id=${PROJECT_ID}"
	terraform plan -var="APP_VERSION=$(APP_VERSION)"
# terraform plan -var="instance_type=t2.large"

apply-yes-im-sure:
	terraform apply -var="APP_VERSION=$(APP_VERSION)" -auto-approve
.terraform:
	echo Initialization: init
	terraform init


watch-plan-every-5sec:
	watch -n 5 make plan
