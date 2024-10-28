pipeline {
    agent any

    environment {
        SONARQUBE_SERVER = 'SonarQube_Server'  // Remplacez par le nom du serveur SonarQube configuré dans Jenkins
        SONARQUBE_TOKEN = credentials('sonarqube-token') // Configurez votre token d'accès SonarQube dans Jenkins
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
                withSonarQubeEnv('SonarQube_Server') { // Remplacez par le nom du serveur SonarQube configuré dans Jenkins
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

        stage('Test') {
            steps {
                echo 'Running tests...'
                //sh 'mvn test'
            }
        }
	
	stage('Building image') {
    	    steps {
                script {
                    docker.build("khiari11/achat:1.0.0", ".")
        	}
    	    }
	}

	stage('Push image to Docker Hub') {
    	    steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', variable: 'DOCKER_TOKEN')]) {
                sh '''

                     echo $DOCKER_TOKEN | docker login -u khiari11 --password-stdin
                     docker push khiari11/achat:1.0.0
            	'''
                }
    	    }
	}

        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                // Ajoutez ici votre commande de déploiement
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
