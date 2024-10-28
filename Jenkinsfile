pipeline {
    agent any

    environment {
        // Add SonarQube credentials
        SONARQUBE_SERVER = 'sonar' // Replace with your SonarQube server name in Jenkins
        SONARQUBE_TOKEN = credentials('jenkins.sonar') // Replace with your SonarQube token ID
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

        stage('Building Image') {
            steps {
                script {
                    echo 'Building Docker image...'
                    docker.build("elbehieya/achat:1.0.0", ".")
                }
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'docker-hub-token', variable: 'DOCKER_TOKEN')]) {
                    sh '''
                    echo $DOCKER_TOKEN | docker login -u your_docker_username --password-stdin
                    docker push your_docker_username/achat:1.0.0
                    '''
                }
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                // Uncomment the following line to enable tests
                // sh 'mvn test'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                // Add your deployment command here
                // Example: sh 'scp target/my-app.jar user@server:/path/to/deploy'
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

