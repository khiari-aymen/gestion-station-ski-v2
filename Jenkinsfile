pipeline {
    agent any

    triggers {
        // Utilisez pollSCM si vous ne configurez pas le webhook ou si vous voulez une alternative
        pollSCM('* * * * *')  // Vérifie toutes les minutes les modifications du dépôt
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'AymenKHIARI-5BI5-Opsight', 
                    url: 'https://github.com/khiari-aymen/erp-bi5-opsight-station-ski.git'
            }
        }
        stage('Build') {
            steps {
                echo 'Building...'
                // Ajoutez ici les commandes de build, comme Maven ou Gradle
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                // Ajoutez ici les commandes de test, comme des tests unitaires
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // Ajoutez ici vos commandes de déploiement
            }
        }
    }
}
