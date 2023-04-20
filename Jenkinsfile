pipeline {
    agent any

    tools {
        maven 'maven-3.9.1'
    }

    environment {
        NEXUS_RELEASES=credentials('nexus-mvn-central')
        NEXUS_SNAPSHOTS=credentials('nexus-mvn-snapshots')
        NEXUS_CENTRAL=credentials('nexus-mvn-central')
        // NEXUS_ADMIN_USR NEXUS_ADMIN_PSW
        NEXUS_ADMIN=credentials('nexus-admin')
    }

    stages {
        
        stage('Build') {
            steps {
                echo "Building..."
                sh "mvn -Dmaven.test.failure.ignore=true -s mvn-settings.xml --batch-mode clean deploy"
            }
        }

        stage('Build container') {
            steps {
                script{
                    docker.withRegistry('http://ubuntu-vm1:18090/', 'nexus-usr') {
                        def myImage = docker.build("simple-app:${env.BUILD_ID}")
                        myImage.push()
                    }
                }
            }
        }
    }
}
