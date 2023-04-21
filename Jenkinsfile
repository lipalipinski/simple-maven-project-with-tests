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
        NEXUS_DOCKER_URL=credentials('docker-reg-url')
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
                    def pom = readMavenPom()
                    env.APP_ID = pom.getArtifactId()
                    env.GROUP_ID = pom.getGroupId()
                    env.VERSION = pom.getVersion()

                    docker.withRegistry("${env.NEXUS_DOCKER_URL}", 'nexus-usr') {
                        def myImage = docker.build("${env.APP_ID}:${env.VERSION}-${env.BUILD_ID}")
                        myImage.push()
                    }
                }
            }
        }
    }
}
