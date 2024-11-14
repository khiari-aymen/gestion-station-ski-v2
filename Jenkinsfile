 pipeline {
    agent any

    environment {
        // Add SonarQube and Docker Hub credentials
        SONARQUBE_SERVER = 'sq1' // Replace with your SonarQube server name in Jenkins
        SONARQUBE_TOKEN = credentials('jenkins-sonaaar') // Replace with your SonarQube token ID
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub') // Replace with your Docker Hub credentials ID
        IMAGE_NAME = 'lindaboukhit/station-ski'
        IMAGE_TAG = 'latest'
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
                withSonarQubeEnv('sq1') { 
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
                    sh "echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin"
                    sh 'docker-compose down'
                    sh 'docker-compose up -d'
                    sh "docker logout"
                }
            }
        }

    post {
        success {
            echo 'Build and analysis completed successfully!'
            emailext(
                to: "linda.boukhit@esprit.tn",
                subject: "Jenkins Build SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
                    The Jenkins build completed successfully!

                    Build Details:
                    - Project: ${env.JOB_NAME}
                    - Build Number: ${env.BUILD_NUMBER}
                    - Status: SUCCESS
                    - Branch: ${env.GIT_BRANCH}
                    - Commit: ${env.GIT_COMMIT}
                    - Build Duration: ${currentBuild.durationString}

                    Additional Information:
                    - Console Output: ${env.BUILD_URL}console
                    - Changes: ${env.BUILD_URL}changes
                    - Test Results: ${env.BUILD_URL}testReport (if applicable)
                """
            )
        }
        failure {
            echo 'Build or analysis failed.'
            emailext(
                to: "linda.boukhit@esprit.tn",
                subject: "Jenkins Build FAILURE: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
                    The Jenkins build failed.

                    Build Details:
                    - Project: ${env.JOB_NAME}
                    - Build Number: ${env.BUILD_NUMBER}
                    - Status: FAILURE
                    - Branch: ${env.GIT_BRANCH}
                    - Commit: ${env.GIT_COMMIT}
                    - Build Duration: ${currentBuild.durationString}

                    Additional Information:
                    - Console Output: ${env.BUILD_URL}console
                    - Changes: ${env.BUILD_URL}changes
                    - Test Results: ${env.BUILD_URL}testReport (if applicable)

                    Please review the build logs for more details.
                """
            )
        }
        always {
            echo 'Cleaning up...'
        }
    }
}

