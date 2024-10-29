pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/khiari-aymen/erp-bi5-opsight-station-ski.git',
                branch: 'IsmahenBENHALIMA-5bi5-opsight'
            }
        }

        stage('Build') {
            steps {
                echo 'Building the project...'
                sh 'mvn clean compile'
            }
        }

        stage('SonarQube') {
            steps {
                echo 'Running SonarQube analysis...'
                sh 'mvn sonar:sonar'
            }
        }

        stage('Deploy to Nexus') {
            steps {
                echo 'Deploying artifacts to Nexus...'
                sh 'mvn deploy -DskipTests -DaltDeploymentRepository=nexus::default::http://192.168.60.130:8081/repository/maven-releases/'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'mvn test'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
            }
        }
    }
}

