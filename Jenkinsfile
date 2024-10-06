pipeline {
    agent any
 
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/khiari-aymen/erp-bi5-opsight-station-ski.git', branch: 'EyaELBEHI-5bi5-opsight'
            }
        }
 
        stage('Build') {
            steps {
                echo 'Building the project...'
            }
        }
 
        stage('Test') {
            steps {
                echo 'Running tests...'
            }
        }
 
        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
            }
        }
    }
}
//hi 

 
