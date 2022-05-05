# terraform2Instance
This is Terraform template to launch front end instance!

#### Create conda environment to install terraform locally:
(Do everything locally! nothing globally - thank me later!)

conda create --name terraform

#### Install terraform:
conda install -c conda-forge terraform

terraform version

terraform init  #works!

#### To see what will be deployed:

terraform plan

#### To deploy:
terraform apply

#### To see the state list (what has been deployed)

terraform state list #Prints: aws_vpc.front_vpc

#### terraform state show aws_vpc.front_vpc

#It shows all the info about vpc i deployed, long list of aws resources


#### To print every resource
terraform show

#[<<<<terraform state list; terraform state show aws_vpc.front_vpc>>>>]

#### To destroy every resource created:

terraform destroy -auto-approve









