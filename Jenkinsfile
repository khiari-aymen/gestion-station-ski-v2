pipeline {
    agent any

    environment {
        // Ajoutez les informations d'identification SonarQube
        SONARQUBE_SERVER = 'sq1'  // Remplacez par le nom du serveur SonarQube configuré dans Jenkins
        SONARQUBE_TOKEN = credentials('jenkins-sonaaar') // Configurez votre token d'accès SonarQube dans Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning the repository...'
                git url: 'https://github.com/khiari-aymen/erp-bi5-opsight-station-ski.git', branch: 'LindaBOUKHIT-5bi5-'
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
                    sh 'mvn sonar:sonar -Dsonar.login=$SONARQUBE_TOKEN -Dsonar.projectKey=erp-bi5-opsight-station-ski'
                }
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                //sh 'mvn test'
            }
        }

        stage('Building image') {
            steps {
                script {
                    docker.build("lindaboukhit/achat:1.0.0", ".")
                }
            }
        }

        stage('Push image to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push lindaboukhit/achat:1.0.0
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                //** Ajoutez ici votre commande de déploiement
                // Exemple : sh 'scp target/my-app.jar user@server:/path/to/deploy'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}

