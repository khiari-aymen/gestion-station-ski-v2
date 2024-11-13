pipeline {
    agent any
    environment {
        SR = 'SR'  // Nom du serveur SonarQube configuré dans Jenkins
        SONARQUBE_TOKEN = credentials('SonarToken') // Jeton d'accès SonarQube configuré dans Jenkins
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
        IMAGE_NAME = 'bouabdallahmohamed/station-ski'
        IMAGE_TAG = 'latest'
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
                withSonarQubeEnv('SR') {
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
                // sh 'mvn test' // Décommentez pour exécuter les tests
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
                to: "mohamed.bouabdallah@esprit.tn",
                subject: "🎉 Build SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                mimeType: 'text/html',
                body: """
                    <html>
                        <body style="background: url('https://example.com/background.jpg') no-repeat center center fixed; background-size: cover; font-family: Arial, sans-serif; color: #333;">
                            <div style="background-color: rgba(255, 255, 255, 0.85); padding: 20px; border-radius: 10px; max-width: 600px; margin: auto;">
                                <h2 style="color: #4CAF50;">🎉 Jenkins Build Succeeded!</h2>
                                <p>Bonjour Mohamed,</p>
                                <p style="font-size: 16px;">Le build de votre projet s'est terminé avec succès. Voici les détails :</p>
                                <ul style="list-style: none; padding: 0;">
                                    <li><strong>Project:</strong> ${env.JOB_NAME}</li>
                                    <li><strong>Build Number:</strong> ${env.BUILD_NUMBER}</li>
                                    <li><strong>Status:</strong> <span style="color:green;"><strong>SUCCESS</strong></span></li>
                                    <li><strong>Branch:</strong> ${env.GIT_BRANCH}</li>
                                    <li><strong>Commit:</strong> ${env.GIT_COMMIT}</li>
                                    <li><strong>Build Duration:</strong> ${currentBuild.durationString}</li>
                                </ul>
                                <p><strong>Plus d'informations :</strong></p>
                                <ul style="list-style: none; padding: 0;">
                                    <li><a href="${env.BUILD_URL}console" style="color: #1E90FF;">Console Output</a></li>
                                    <li><a href="${env.BUILD_URL}changes" style="color: #1E90FF;">Changes</a></li>
                                    <li><a href="${env.BUILD_URL}testReport" style="color: #1E90FF;">Test Results</a> (si applicable)</li>
                                </ul>
                            </div>
                        </body>
                    </html>
                """
            )
        }
        failure {
            echo 'Build or analysis failed.'
            emailext(
                to: "mohamed.bouabdallah@esprit.tn",
                subject: "🚨 Build FAILURE: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                mimeType: 'text/html',
                body: """
                    <html>
                        <body style="background: url('https://example.com/background.jpg') no-repeat center center fixed; background-size: cover; font-family: Arial, sans-serif; color: #333;">
                            <div style="background-color: rgba(255, 255, 255, 0.85); padding: 20px; border-radius: 10px; max-width: 600px; margin: auto;">
                                <h2 style="color: #FF0000;">🚨 Jenkins Build Failed!</h2>
                                <p>Bonjour Mohamed,</p>
                                <p style="font-size: 16px;">Le build de votre projet a échoué. Voici les détails :</p>
                                <ul style="list-style: none; padding: 0;">
                                    <li><strong>Project:</strong> ${env.JOB_NAME}</li>
                                    <li><strong>Build Number:</strong> ${env.BUILD_NUMBER}</li>
                                    <li><strong>Status:</strong> <span style="color:red;"><strong>FAILURE</strong></span></li>
                                    <li><strong>Branch:</strong> ${env.GIT_BRANCH}</li>
                                    <li><strong>Commit:</strong> ${env.GIT_COMMIT}</li>
                                    <li><strong>Build Duration:</strong> ${currentBuild.durationString}</li>
                                </ul>
                                <p><strong>Plus d'informations :</strong></p>
                                <ul style="list-style: none; padding: 0;">
                                    <li><a href="${env.BUILD_URL}console" style="color: #1E90FF;">Console Output</a></li>
                                    <li><a href="${env.BUILD_URL}changes" style="color: #1E90FF;">Changes</a></li>
                                    <li><a href="${env.BUILD_URL}testReport" style="color: #1E90FF;">Test Results</a> (si applicable)</li>
                                </ul>
                                <p>Merci de vérifier les journaux de build pour plus de détails.</p>
                            </div>
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
