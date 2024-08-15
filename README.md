# Cloud Native Boardgame Java App on Amazon EKS with Terraform, Github action

## Description

**Board Game Database Full-Stack Web Application.**
Deploy boardgame - the web application displays lists of board games and their reviews. While anyone can view the board game lists and reviews, they are required to log in to add/ edit the board games and their reviews. The 'users' have the authority to add board games to the list and add reviews, and the 'managers' have the authority to edit/ delete the reviews on top of the authorities of users.  

## Technologies

- Java
- Spring Boot
- Amazon Web Services(AWS) EC2, EKS
- Terraform
- JavaScript
- Spring MVC
- Maven

## Features

- Full-Stack Application
- UI components created with Thymeleaf and styled with Twitter Bootstrap
- Authentication and authorization using Spring Security
  - Authentication by allowing the users to authenticate with a username and password
  - Authorization by granting different permissions based on the roles (non-members, users, and managers)
- Different roles (non-members, users, and managers) with varying levels of permissions
  - Non-members only can see the boardgame lists and reviews
  - Users can add board games and write reviews
  - Managers can edit and delete the reviews
- Deployed the application on AWS EC2
- JUnit test framework for unit testing
- Spring MVC best practices to segregate views, controllers, and database packages
- JDBC for database connectivity and interaction
- CRUD (Create, Read, Update, Delete) operations for managing data in the database
- Schema.sql file to customize the schema and input initial data
- Thymeleaf Fragments to reduce redundancy of repeating HTML elements (head, footer, navigation)'

## Prerequisites
- AWS account with the IAM permissions to create EKS clusters
- AWS CLI installed and configured
- AWS IAM Authenticator installed on your machine
- kubectl installed on your machine
- Docker installed and configured on your machine
- Terraform installed on your machine
- Java 11+ installed on your machine

## Create an EKS cluster using Terraform
To deploy the stack to AWS EKS, we need to create a cluster. So let's begin by creating a cluster using Terraform.

### Create a cluster
Ensure you have configured your AWS CLI and IAM Authenticator to use the correct AWS account. If not, run and following:
```
# Visit https://console.aws.amazon.com/iam/home?#/security_credentials for creating access keys
aws configure
```
Initialize, plan and apply the following Terraform configuration:

```
cd terraform
# download modules and providers. Initialize state.
terraform init
# see a preview of what will be done
terraform plan
# apply the changes
terraform apply
```
Confirm by typing yes when prompted. This will take a while (15-20 minutes), so sit back and have a coffee or contemplate
Once the EKS cluster is ready, you will see the output variables printed on the console.

## Deploy the microservice stack to EKS
Config kubeconfig file
```
aws eks update-kubeconfig --region ap-southeast-1 --name $(terraform ouput cluster_name)
```
Deploy to AWS EKS
```
kubectl apply -f deployment-service.yaml
```
<img width="660" alt="image" src="https://github.com/user-attachments/assets/4785cd67-237a-44bf-8942-ecc1ad7ccc44">

## Run application

1. Access application through browser from your cluster external IP and port 30060
2. To use initial user data, use the following credentials.
  - username: bugs    |     password: bunny (user role)
  - username: daffy   |     password: duck  (manager role)
3. You can also sign-up as a new user and customize your role to play with the application! 😊
