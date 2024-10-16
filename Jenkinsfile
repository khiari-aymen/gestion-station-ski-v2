pipeline {
    agent any
 
    environment {
        // Ajoutez les informations d'identification SonarQube
        SONARQUBE_SERVER = 'SonarQubeServer'  // Remplacez par le nom du serveur SonarQube configuré dans Jenkins
        SONARQUBE_TOKEN = credentials('SonarToken') // Configurez votre token d'accès SonarQube dans Jenkins
    }
 
    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning the repository...'
                git url: 'https://github.com/khiari-aymen/erp-bi5-opsight-station-ski.git', branch: 'BOUABDALLAHMohamed-ERP-BI5-opsight'
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
                withSonarQubeEnv('SonarQubeServer') { // Remplacez par le nom du serveur SonarQube configuré dans Jenkins
                    sh 'mvn sonar:sonar -Dsonar.login=$SONARQUBE_TOKEN -Dsonar.projectKey=erp-bi5-opsight-station-ski -Dsonar.host.url=http://192.168.51.4:9000/'
                }
            }
        }
	stage('Build') {
            steps {
                echo 'Building the project...'
                sh 'mvn clean deploy -DskipTests'
            }
        } 
        stage('Test') {
            steps {
                echo 'Running tests...'
                //sh 'mvn test'
            }
        }
 
        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                //** Ajoutez ici votre commande de déploiement
                // Exemple : sh 'scp target/my-app.jar user@server:/path/to/deploy'
            }
        }
    }
 
    post {
        success {
            echo 'Build and analysis completed successfully!'
        }
        failure {
            echo 'Build or analysis failed.'
        }
    }
}


