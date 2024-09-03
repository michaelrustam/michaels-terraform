pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws_access_key_id')  // Jenkins credentials ID
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key') 
        AWS_DEFAULT_REGION    = 'us-east-1'  // Set your AWS region
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId:"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" url: 'https://github.com/michaelrustam/michaels-terraform.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }
    
stage('Wait Before Destroy') { 
            steps { 
                script {
                    input message: 'Do you want to proceed with applying the Terraform destroy?', ok: 'Apply'
                }
            } 
        }
    
        stage('Terraform Destroy') { 
            steps {
                sh 'terraform destroy -auto-approve -input=false'
            }  
        }
    }

    post {
        always {
            cleanWs() // Clean workspace after the build
        }
    }
}
