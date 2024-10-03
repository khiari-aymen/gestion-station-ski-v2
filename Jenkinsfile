       pipeline {

    agent any
 
    stages {

        stage('Checkout') {

            steps {

                // Cette étape vérifie le code source du dépôt

                git url: 'https://github.com/khiari-aymen/erp-bi5-opsight-station-ski.git', branch: 'EyaELBEHI-5bi5-Opsight'

            }

        }
 
        stage('Build') {

            steps {

                // Remplacez parr vos commandes de build (par exemple, pour Maven, npm, etc.)

                echo 'Building the project...'

                // sh 'mvn clean install' (par exemple pour un projet Maven)

            }

        }
 
        stage('Test') {

            steps {

                // Remplacez par vos commandes de testt

                echo 'Running tests...'

                // sh 'mvn test' (par exemple pour les tests unitaires avec Maven)

            }

        }
 
        stage('Deploy') {

            steps {

                // Remplacez par vos commandes de déploiement

                echo 'Deploying the application...'

                // sh 'scp target/my-app.jar user@server:/path/to/deploy' (par exemple pour un déploiement via SCP)

            }

        }

    }

}

 
