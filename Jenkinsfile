pipeline {
    agent any

    environment {
        // Reference Jenkins credentials
        AWS_ACCESS_KEY_ID = credentials("aws_access_key_id")
        AWS_SECRET_ACCESS_KEY = credentials("aws_secret_access_key")
    }

    stages {
        stage('Checkout') {
            steps {
                // Correct syntax for the 'git' step
                git(branch: "main", credentialsId: "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", url: "https://github.com/michaelrustam/michaels-terraform.git")
            }
        }
        
        stage('Init') {
            steps {
                sh 'terraform init'
            }
        }
        
        stage('Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }
        
        stage('Apply') {
            steps {
                sh 'terraform apply -input=false tfplan'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
