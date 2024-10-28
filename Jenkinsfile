pipeline {
    // On spécifie un agent principal pour le pipeline
    agent any

    environment {
        SONARQUBE_SERVER = 'SonarQube_Server'  // Nom du serveur SonarQube configuré dans Jenkins
        SONARQUBE_TOKEN = credentials('sonarqube-token') // Token d'accès SonarQube
    }

    stages {
        stage('Checkout') {
            agent { label 'build-agent' } // Utilise un agent spécifique pour cette étape
            steps {
                echo 'Cloning the repository...'
                git url: 'https://github.com/khiari-aymen/erp-bi5-opsight-station-ski.git', branch: 'AymenKHIARI-5BI5-Opsight'
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
            agent { label 'analysis-agent' } // Spécifie un autre agent pour l’analyse SonarQube si nécessaire
            steps {
                echo 'Analyzing the project with SonarQube...'
                withSonarQubeEnv('SonarQube_Server') {
                    sh 'mvn sonar:sonar -Dsonar.login=$SONARQUBE_TOKEN -Dsonar.projectKey=erp-bi5-opsight-station-ski -Dsonar.host.url=http://192.168.50.4:9000/'
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
            agent { label 'test-agent' } // Utiliser un agent dédié aux tests si configuré
            steps {
                echo 'Running tests...'
                //sh 'mvn test'
            }
        }

        stage('Deploy') {
            agent { label 'deploy-agent' } // Utiliser un agent de déploiement
            steps {
                echo 'Deploying the application...'
                // Commande de déploiement
                // sh 'scp target/my-app.jar user@server:/path/to/deploy'
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
