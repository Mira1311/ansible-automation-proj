Infrastructure & Deployment - AWS FinOps Bot
This repository contains the Infrastructure as Code (IaC) and Configuration Management required to automate server provisioning and deploy a cost-optimization (FinOps) Bot on AWS.
🛠 Tech Stack
Terraform: AWS resource provisioning (EC2, Security Groups, IAM Roles).
Ansible: Configuration management (Docker installation, Image pulling, and Container deployment).
Docker: Isolated runtime environment for the Python bot.
📂 Directory Structure
main.tf: AWS infrastructure definitions.
inventories/hosts: Target server IPs for Ansible execution.
ansible.cfg: Default Ansible configuration (host key checking disabled, custom inventory path).
playbooks/:
setup-docker.yml: Playbook to install Docker on Ubuntu instances.
deploy-bot.yml: Playbook to pull the image from ECR and run the container.
main.yml: Master playbook to orchestrate the entire deployment workflow.
🚀 Quick Start
Step 1: Provision Infrastructure (Terraform)
Provision the virtual server on AWS:
terraform init
terraform plan
terraform apply -auto-approve
Note: After successful provisioning, copy the generated EC2 Public IP and paste it into the inventories/hosts file.
Step 2: Configure & Deploy (Ansible)
Execute a single command to set up the runtime environment and start the bot:
ansible-playbook playbooks/main.yml
🔒 Security Notes
State Files: *.tfstate files contain sensitive infrastructure data and are strictly ignored via .gitignore. NEVER force commit these files to the repository.
Credentials: AWS Access Keys are strictly prohibited in the codebase. Use local AWS Profiles or pass them securely via a .env file