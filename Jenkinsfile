pipeline {
    agent any

    environment {
        // Add SonarQube and Docker Hub credentials
        SONARQUBE_SERVER = 'sonar' // Replace with your SonarQube server name in Jenkins
        SONARQUBE_TOKEN = credentials('jenkins.sonar') // Replace with your SonarQube token ID
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials') // Replace with your Docker Hub credentials ID
        IMAGE_NAME = 'stationski'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning the repository...'
                git url: 'https://github.com/khiari-aymen/erp-bi5-opsight-station-ski.git', branch: 'ELBEHIEya-ERP-BI5-opsight'
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
                withSonarQubeEnv('sonar') { 
                    sh '''
                    mvn sonar:sonar \
                        -Dsonar.login=$SONARQUBE_TOKEN \
                        -Dsonar.projectKey=erp-bi5-opsight-station-ski \
                        -Dsonar.host.url=http://192.168.50.4:9000/
                    '''
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
                // Uncomment the following line to enable tests
                // sh 'mvn test'
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
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_HUB_CREDENTIALS_PSW', usernameVariable: 'DOCKER_HUB_CREDENTIALS_USR')]) {
                        sh "echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin"
                        sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                        sh "docker logout"
                    }
                }
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                echo 'Deploying the application with Docker Compose...'
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_HUB_CREDENTIALS_PSW', usernameVariable: 'DOCKER_HUB_CREDENTIALS_USR')]) {
                        sh "echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin"
                        sh 'docker compose down'
                        sh 'docker compose up -d'
                        sh "docker logout"
                    }
                }
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

