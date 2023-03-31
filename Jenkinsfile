pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "Maven-3.9.1-local"
    }

    stages {
        
        stage('Build') {
            steps {
                echo "Building..."
                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }
        
        stage('Deploy') {
            steps {
                echo "Deploying..."
                sh "mvn -Dmaven.test.failure.ignore=true deploy"
            }
        }
    }
}
