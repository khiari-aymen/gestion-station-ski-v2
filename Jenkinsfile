pipeline {
   agent any
 
   environment {
       // Remplacez 'SonarQubeServer' par le nom exact de votre serveur SonarQube défini dans Jenkins
       SONARQUBE_SERVER = 'SonarQubeServer'
   }
 
   stages {
       stage('Checkout') {
           steps {
               // **Cette étape vérifie le code source du dépôt
               git url: 'https://github.com/khiari-aymen/erp-bi5-opsight-station-ski.git', branch: 'BOUABDALLAHMohamed-ERP-BI5-opsight'
           }
       }
 
       stage('MVN Clean') {
           steps {
               echo 'Executing mvn clean...'
               sh 'mvn clean'
           }
       }
 
       stage('MVN Compile') {
           steps {
               echo 'Executing mvn compile...'
               sh 'mvn compile'
           }
       }
 
       stage('MVN SonarQube') {
           steps {
               echo 'Executing SonarQube analysis...'
              withSonarQubeEnv(SONARQUBE_SERVER) {
                   sh 'mvn sonar:sonar -Dsonar.projectKey= erp-bi5-opsight-station-ski-Dsonar.host.url=http://192.168.50.4:9000 -Dsonar.login=squ_41b445af0fe2aa032f8e205670c0049764e83e07'
               }
           }
       }
     stage('Build') {
            steps {
                echo 'Building the project...'
               // sh 'mvn clean install'
            }
        }
 
        stage('Test') {
            steps {
                echo 'Running tests...'
                //sh 'mvn test'
            }
        }
 
        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                // Ajoutez ici votre commande de déploiement
                // Exemple : sh 'scp target/my-app.jar user@server:/path/to/deploy'
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

