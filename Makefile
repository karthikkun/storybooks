PROJECT_ID=storybooks-devops
AWS_REGION=us-east-1
AWS_AVAILABILITY_ZONE=us-east-1a
AWS_EC2_USER=ec2-user
ENV=staging

run-local:
	docker-compose up -d

stop-local:
	docker-compose stop

create-tf-backend-bucket:
	aws s3api create-bucket \
    --bucket ${PROJECT_ID}-tf \
    --region ${AWS_REGION}

tf-create-workspace:
	cd terraform && \
	terraform workspace new ${ENV}

tf-init:
	cd terraform && \
	terraform workspace select ${ENV} && \
	terraform init

# plan, apply, destroy
TF_ACTION?=plan

tf-action:
	cd terraform && \
	terraform workspace select ${ENV} && \
	terraform ${TF_ACTION} \
	-var-file="./environments/common.tfvars" \
	-var-file="./environments/${ENV}/config.tfvars"

# deploy manually

ssh-setup:
	aws ec2-instance-connect send-ssh-public-key \
	--instance-id i-02b5a4fd22238fa48 \
	--instance-os-user ${AWS_EC2_USER} \
	--availability-zone ${AWS_AVAILABILITY_ZONE} \
	--ssh-public-key file://./.ssh/id_rsa.pub

CMD?=ip

ssh-cmd:
	ssh -o "IdentitiesOnly=yes" -i ./ssh/id_rsa ec2-user@54.174.85.61
	ssh \
	--instance-id ${INSTANCE_ID} \
	--private-key-file ./ssh/id_rsa