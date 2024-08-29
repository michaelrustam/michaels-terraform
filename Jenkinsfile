pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AKIA5MSUBMSROIPTDLPX')  // Jenkins credentials ID
        AWS_SECRET_ACCESS_KEY = credentials('iSNHuuIxHZ2D4oZ1MVxW1pFzhbR4GYx6eoEKT6RV')
        AWS_DEFAULT_REGION    = 'us-east-1'  // Set your AWS region
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/michaelrustam/michaels-terraform.git'
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
    
    post {
        always {
            cleanWs() // Clean workspace after the build
        }
    }
}
