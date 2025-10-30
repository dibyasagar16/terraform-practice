pipeline {
    agent any

    environment {
        TF_DIR = "Terraform"
        ANSIBLE_DIR = "Ansible"
    }

    stages {
        stage('Checkout Terraform Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/dibyasagar16/terraform-practice.git'
            }
        }

        stage('Initialize Terraform') {
            steps {
                dir("${TF_DIR}") {
                    withAWS(credentials: 'aws-access', region: 'us-east-1') {
                        sh "terraform init"
                    }
                }
            }
        }

        stage('Validate Terraform') {
            steps {
                dir("${TF_DIR}") {
                    withAWS(credentials: 'aws-access', region: 'us-east-1') {
                        sh "terraform validate"
                    }
                }  
            }
        }

        stage('Plan Infrastructure') {
            steps {
                dir("${TF_DIR}") {
                    withAWS(credentials: 'aws-access', region: 'us-east-1') {
                        sh "terraform plan"
                    }
                }
            }
        }

        stage('Apply Infrastructure') {
            steps {
                dir("${TF_DIR}") {
                    withAWS(credentials: 'aws-access', region: 'us-east-1') {
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }

        stage('Generate Inventory') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'ec2-key', keyFileVariable: 'KEY_PATH')]) {
                    sh '''
                        cd Terraform
                        mkdir -p ../Ansible

                        # Get all public IPs from Terraform output (supports multiple instances)
                        IP=$(terraform output -raw app_server_public_ip)

                        INVENTORY_FILE=../Ansible/inventory.ini

                        echo "[web]" > $INVENTORY_FILE
                        echo "${IP} ansible_user=ubuntu ansible_ssh_private_key_file=${KEY_PATH}" >> $INVENTORY_FILE
                        cat $INVENTORY_FILE
                    '''
                }
            }
        }
    }
}
