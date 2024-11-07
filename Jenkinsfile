pipeline {
    agent any

    environment {
        SR = 'SR'  // Name of the SonarQube server configured in Jenkins
        SONARQUBE_TOKEN = credentials('SonarToken') // SonarQube access token configured in Jenkins
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
        IMAGE_NAME = 'bouabdallahmohamed/station-ski'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            agent { label 'test-agent' }
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
            agent { label 'analysis-agent' }
            steps {
                echo 'Analyzing the project with SonarQube...'
                withSonarQubeEnv('SR') {
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
            agent { label 'test-agent' }
            steps {
                echo 'Running tests...'
                // sh 'mvn test' // Uncomment to run tests
            }
        }

        stage('Build Docker Image') {
            agent { label 'build-agent' }
            steps {
                echo 'Building Docker Image...'
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Push Docker Image') {
            agent { label 'deploy-agent' }
            steps {
                echo 'Pushing Docker Image to Docker Hub...'
                script {
                    sh "echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin"
                    sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker logout"
                }
            }
        }

        stage('Deploy with Docker Compose') {
            agent { label 'deploy-agent' }
            steps {
                echo 'Deploying the application with Docker Compose...'
                script {
                    sh "echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin"
                    sh 'docker compose down'
                    sh 'docker compose up -d'
                    sh "docker logout"
                }
            }
        }

        stage('Deploy') {
            agent { label 'deploy-agent' }
            steps {
                echo 'Deploying the application...'
                // Add your deployment command here, for example:
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
