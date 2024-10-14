pipeline {
    agent any

    environment {
        // Ajoutez les informations d'identification SonarQube
        SONARQUBE_SERVER = 'sq1'  // Remplacez par le nom du serveur SonarQube configuré dans Jenkins
        SONARQUBE_TOKEN = credentials('jenkins-sonar') // Configurez votre token d'accès SonarQube dans Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning the repository...'
                git url: 'https://github.com/khiari-aymen/erp-bi5-opsight-station-ski.git', branch: 'LindaBOUKHIT-5bi5-opsight'
            }
        }

        stage('Clean') {
            steps {
                echo 'Cleaning the project...'
                sh 'mvn clean'
            }
        }

        stage('Compile') {
            steps {
                echo 'Compiling the project...'
                sh 'mvn compile'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo 'Analyzing the project with SonarQube...'
                withSonarQubeEnv('sq1') { // Remplacez par le nom du serveur SonarQube configuré dans Jenkins
                    sh 'mvn sonar:sonar -Dsonar.login=$SONARQUBE_TOKEN -Dsonar.projectKey=erp-bi5-opsight-station-ski -Dsonar.host.url=http://<votre-sonarqube-url>'
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
        success {
            echo 'SonarQube analysis completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}

