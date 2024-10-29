pipeline {
    agent none // On spécifie 'none' au niveau du pipeline pour permettre des agents spécifiques par étape
 
    environment {
        SONARQUBE_SERVER = 'SonarQubeServer'  // Nom du serveur SonarQube configuré dans Jenkins
        SONARQUBE_TOKEN = credentials('SonarToken') // Token d'accès SonarQube
    }
 
    stages {
        stage('Checkout') {
            agent { label 'build-agent' } // Utilise un agent spécifique pour cette étape
            steps {
                echo 'Cloning the repository...'
                git url: 'https://github.com/khiari-aymen/erp-bi5-opsight-station-ski.git', branch: 'BOUABDALLAHMohamed-ERP-BI5-opsight'
            }
        }
 
        stage('Clean') {
            agent { label 'build-agent' }
            steps {
                echo 'Cleaning the project...'
                sh 'mvn clean'
            }
        }
 
        stage('Compile') {
            agent { label 'build-agent' }
            steps {
                echo 'Compiling the project...'
                sh 'mvn compile'
            }
        }
 
        stage('SonarQube Analysis') {
            agent { label 'analysis-agent' } // Spécifie un autre agent pour l’analyse SonarQube
            steps {
                echo 'Analyzing the project with SonarQube...'
                withSonarQubeEnv('SonarQubeServer') {
                    sh 'mvn sonar:sonar -Dsonar.login=$SONARQUBE_TOKEN -Dsonar.projectKey=erp-bi5-opsight-station-ski -Dsonar.host.url=http://192.168.51.4:9000/'
                }
            }
        }
 
        stage('Build') {
            agent { label 'build-agent' }
            steps {
                echo 'Building the project...'
                sh 'mvn clean deploy -DskipTests'
            }
        }
 
        stage('Test') {
            agent { label 'test-agent' } // Utilise un agent dédié aux tests si configuré
            steps {
                echo 'Running tests...'
                //sh 'mvn test'
            }
        }
 
        stage('Deploy') {
            agent { label 'deploy-agent' } // Utilise un agent de déploiement
            steps {
                echo 'Deploying the application...'
                // Commande de déploiement
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
