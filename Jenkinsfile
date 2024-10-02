pipeline {
    agent any

    // Déclencheur basé sur un changement dans le dépôt Git
    triggers {
        pollSCM('* * * * *') // Vérifie chaque minute les modifications dans le dépôt
    }

    stages {
        stage('Checkout') {
            steps {
                // Récupère le code source du dépôt Git
                git branch: 'BOUABDALLAHMohamed-ERP-BI5-opsight', url: 'https://github.com/username/repository.githttps://github.com/khiari-aymen/erp-bi5-opsight-station-ski.git'
            }
        }

        stage('Build') {
            steps {
                 echo 'Building the project with Maven...'
                 // Compilation avec Maven
                 sh 'mvn clean install'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                // Ajouter ici les étapes de déploiement (par exemple, copie des fichiers, docker, etc.)
            }
        }
    }

    post {
        always {
            echo 'Pipeline terminé'
        }
        success {
            echo 'Le build a réussi !'
        }
        failure {
            echo 'Le build a échoué.'
        }
    }
}
