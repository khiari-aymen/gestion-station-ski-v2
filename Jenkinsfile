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
        stage('📥 Checkout') {
            steps {
                echo 'Cloning the repository...'
                git url: 'https://github.com/khiari-aymen/erp-bi5-opsight-station-ski.git', branch: 'LindaBOUKHIT-5bi5-opsight'
            }
        }

        stage('🧹 Clean') {
            steps {
                echo 'Cleaning the project...'
                sh 'mvn clean'
            }
        }

        stage('⚙️ Compile') {
            steps {
                echo 'Compiling the project...'
                sh 'mvn compile'
            }
        }

        stage('📊 JaCoCo Report') {
            steps {
                jacoco(
                    execPattern: '**/jacoco.exec',
                    classPattern: '**/classes',
                    sourcePattern: '**/src/main/java'
                )
            }
        }

        stage('🔍 SonarQube Analysis') {
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

        stage('🏗️ Build') {
            steps {
                echo 'Building the project...'
                sh 'mvn clean deploy -DskipTests'
            }
        }

        stage('🧪 Test') {
            steps {
                echo 'Running tests...'
                // Uncomment the following line to enable tests
                // sh 'mvn test'
            }
        }

        stage('🐳 Build Docker Image') {
            steps {
                echo 'Building Docker Image...'
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('📤 Push Docker Image') {
            steps {
                echo 'Pushing Docker Image to Docker Hub...'
                script {
                    sh "echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin"
                    sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker logout"
                }
            }
        }

        stage('🚀 Deploy with Docker Compose') {
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
    }

    post {
        success {
            echo 'Build and analysis completed successfully!'
            emailext(
                to: "linda.boukhit@esprit.tn",
                subject: "🎉 Build SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                mimeType: 'text/html',
                body: """
                    <html>
                        <body style="background: url('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS90sm-yM3GhbgHIE-mTLUBrYYMsoZDiCj50yw&usqp=CAU');">
                            <div style="background-color: rgba(255, 255, 255, 0.85); padding: 20px; border-radius: 10px;">
                                <h2 style="color: #4CAF50;">🎉 Jenkins Build Succeeded!</h2>
                                <p>Bonjour Linda Boukhit,</p>
                                <p>Le build de votre projet s'est terminé avec succès. Voici les détails :</p>
                                <ul style="list-style: none; padding: 0;">
                                    <li><strong>Project:</strong> ${env.JOB_NAME}</li>
                                    <li><strong>Build Number:</strong> ${env.BUILD_NUMBER}</li>
                                    <li><strong>Status:</strong> <span style="color:green;"><strong>SUCCESS</strong></span></li>
                                    <li><strong>Branch:</strong> ${env.GIT_BRANCH}</li>
                                    <li><strong>Commit:</strong> ${env.GIT_COMMIT}</li>
                                    <li><strong>Build Duration:</strong> ${currentBuild.durationString}</li>
                                </ul>
                                <p>Plus d'informations :</p>
                                <ul style="list-style: none; padding: 0;">
                                    <li><a href="${env.BUILD_URL}console" style="color: #1E90FF;">Console Output</a></li>
                                    <li><a href="${env.BUILD_URL}changes" style="color: #1E90FF;">Changes</a></li>
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
                to: "linda.boukhit@esprit.tn",
                subject: "🚨 Build FAILURE: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                mimeType: 'text/html',
                body: """
                    <html>
                        <body style="background: url('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS90sm-yM3GhbgHIE-mTLUBrYYMsoZDiCj50yw&usqp=CAU');">
                            <div style="background-color: rgba(255, 255, 255, 0.85); padding: 20px; border-radius: 10px;">
                                <h2 style="color: #FF0000;">🚨 Jenkins Build Failed!</h2>
                                <p>Bonjour Linda Boukhit,</p>
                                <p>Le build de votre projet a échoué. Voici les détails :</p>
                                <ul style="list-style: none; padding: 0;">
                                    <li><strong>Project:</strong> ${env.JOB_NAME}</li>
                                    <li><strong>Build Number:</strong> ${env.BUILD_NUMBER}</li>
                                    <li><strong>Status:</strong> <span style="color:red;"><strong>FAILURE</strong></span></li>
                                    <li><strong>Branch:</strong> ${env.GIT_BRANCH}</li>
                                    <li><strong>Commit:</strong> ${env.GIT_COMMIT}</li>
                                    <li><strong>Build Duration:</strong> ${currentBuild.durationString}</li>
                                </ul>
                                <p>Plus d'informations :</p>
                                <ul style="list-style: none; padding: 0;">
                                    <li><a href="${env.BUILD_URL}console" style="color: #1E90FF;">Console Output</a></li>
                                    <li><a href="${env.BUILD_URL}changes" style="color: #1E90FF;">Changes</a></li>
                                    <li><a href="${env.BUILD_URL}testReport" style="color: #1E90FF;">Test Results</a></li>
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

