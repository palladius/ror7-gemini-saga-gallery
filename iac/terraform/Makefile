#app_name = ${APP_NAME}
prid = ${PROJECT_ID}
plan: .terraform
	@echo "ENV APP_NAME:   '$(APP_NAME)'"
	@echo "ENV PROJECT_ID: '$(prid)'"
	@echo terraform apply -var="app_name=$(APP_NAME)" -var="project_id=${PROJECT_ID}"
	terraform plan

apply-yes-im-sure:
	terraform apply -auto-approve
.terraform:
	echo Initialization: init
	terraform init
