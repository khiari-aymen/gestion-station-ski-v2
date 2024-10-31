pipeline {
    agent any

    environment {
        SONARQUBE_SERVER = 'SonarQube_Server'
        SONARQUBE_TOKEN = credentials('sonarqube-token')
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')  // Assurez-vous de créer cet identifiant dans Jenkins
        IMAGE_NAME = 'khiari11/station-ski'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning the repository...'
                git url: 'https://github.com/khiari-aymen/erp-bi5-opsight-station-ski.git', branch: 'AymenKHIARI-5BI5-Opsight'
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
                withSonarQubeEnv('SonarQube_Server') {
                    sh 'mvn sonar:sonar -Dsonar.login=$SONARQUBE_TOKEN -Dsonar.projectKey=erp-bi5-opsight-station-ski -Dsonar.host.url=http://192.168.50.4:9000/'
                }
            }
        }

        stage('Build') {
            steps {
                echo 'Building the project...'
                sh 'mvn clean deploy -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker Image...'
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Push Docker Image') {
            steps {
                echo 'Pushing Docker Image to Docker Hub...'
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                    }
                }
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                echo 'Deploying the application with Docker Compose...'
                sh 'docker-compose down'  // Arrête l’ancienne version, si nécessaire
                sh 'docker-compose up -d'  // Démarre la nouvelle version en arrière-plan
            }
        }
    }

    post {
        success {
            echo 'Build, Docker image creation, push, and deployment completed successfully!'
        }
        failure {
            echo 'An error occurred during the build or deployment process.'
        }
    }
}
