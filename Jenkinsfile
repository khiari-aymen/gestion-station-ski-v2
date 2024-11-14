pipeline {
    agent any

    environment {
        SONARQUBE_SERVER = 'SonarQube_Server'
        SONARQUBE_TOKEN = credentials('sonarqube-token')
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
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
        
	stage('JaCoCo Report') {   
            steps {   
                jacoco(
                    execPattern: '**/jacoco.exec',   
                    classPattern: '**/classes',   
                    sourcePattern: '**/src/main/java'
                )   
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
                    sh "echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin"
                    sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker logout"
                }
            }
        }

        stage('Deploy with Docker Compose') {
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
    }

    post {
        success {
            echo 'Build and analysis completed successfully!'
            emailext(
                to: "khiari.aymen.1@esprit.tn",
                subject: "Jenkins Build SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                mimeType: 'text/html',
                body: """
                    <html>
                        <body>
                            <h2>The Jenkins build completed successfully!</h2>
                            <p><strong>Build Details:</strong></p>
                            <ul>
                                <li>Project: ${env.JOB_NAME}</li>
                                <li>Build Number: ${env.BUILD_NUMBER}</li>
                                <li>Status: <span style="color:green;"><strong>SUCCESS</strong></span></li>
                                <li>Branch: ${env.GIT_BRANCH}</li>
                                <li>Commit: ${env.GIT_COMMIT}</li>
                                <li>Build Duration: ${currentBuild.durationString}</li>
                            </ul>
                            <p><strong>Additional Information:</strong></p>
                            <ul>
                                <li><a href="${env.BUILD_URL}console">Console Output</a></li>
                                <li><a href="${env.BUILD_URL}changes">Changes</a></li>
                                <li><a href="${env.BUILD_URL}testReport">Test Results</a> (if applicable)</li>
                            </ul>
                        </body>
                    </html>
                """
            )
        }
        failure {
            echo 'Build or analysis failed.'
            emailext(
                to: "mohamed.bouabdallah@esprit.tn",
                subject: "Jenkins Build FAILURE: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                mimeType: 'text/html',
                body: """
                    <html>
                        <body>
                            <h2>The Jenkins build failed.</h2>
                            <p><strong>Build Details:</strong></p>
                            <ul>
                                <li>Project: ${env.JOB_NAME}</li>
                                <li>Build Number: ${env.BUILD_NUMBER}</li>
                                <li>Status: <span style="color:red;"><strong>FAILURE</strong></span></li>
                                <li>Branch: ${env.GIT_BRANCH}</li>
                                <li>Commit: ${env.GIT_COMMIT}</li>
                                <li>Build Duration: ${currentBuild.durationString}</li>
                            </ul>
                            <p><strong>Additional Information:</strong></p>
                            <ul>
                                <li><a href="${env.BUILD_URL}console">Console Output</a></li>
                                <li><a href="${env.BUILD_URL}changes">Changes</a></li>
                                <li><a href="${env.BUILD_URL}testReport">Test Results</a> (if applicable)</li>
                            </ul>
                            <p>Please review the build logs for more details.</p>
                        </body>
                    </html>
                """
            )
        }
        always {
            echo 'Cleaning up...'
        }
    }
}
