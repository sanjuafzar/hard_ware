pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "afzar/hard_ware:latest"
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t hard_ware .'
            }
        }

        stage('Test') {
            steps {
                echo 'Build success for hard_ware project'
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker tag hard_ware $DOCKER_IMAGE'
                sh 'docker push $DOCKER_IMAGE'
            }
        }

        stage('Deploy using Ansible') {
            steps {
                sh 'ansible-playbook -i terraform/ansible/inventory.ini terraform/ansible/deploy.yml'
            }
        }
    }
}