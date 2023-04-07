pipeline {
    agent {label 'macos'}

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven 'maven-3.9.1'
    }

    environment {
        NEXUS_RELEASES=credentials('nexus-mvn-central')
        NEXUS_SNAPSHOTS=credentials('nexus-mvn-snapshots')
        NEXUS_CENTRAL=credentials('nexus-maven-central')
    }

    stages {
        
        stage('Build') {
            steps {
                echo "Building..."
                withCredentials([usernamePassword(credentialsId: 'nexus-admin', passwordVariable: 'NEXUS_PWD', usernameVariable: 'NEXUS_USERNAME')]) {
                    // Run Maven on a Unix agent.
                    sh "mvn -Dmaven.test.failure.ignore=true -s mvn-settings.xml clean deploy"
                }
            }
        }
    }
}
