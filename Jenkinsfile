pipeline {
    agent any
    stages {
        // stage('Workspace Cleanup') {
        //     steps {
        //         cleanWs()
        //     }
        // }
        

        stage('Build') {
            steps {
                // Run the Maven package command
                sh './mvnw package -DskipTests -Dcheckstyle.skip=true'
                // Stash the JAR file(s) for use in later stages
                stash includes: 'target/*.jar', name: 'built-jars'
            }
        }
        
        stage('Docker Image Build and Push') {
            steps {
                script {
                    def jar = sh(script: "ls target/*.jar", returnStdout: true).trim()
                    sh "docker build -t sythe7/petclinic:${env.BUILD_ID} . --build-arg JAR_FILE=${jar}"
                    sh "docker login -u sythe7 -p abcdefghi"
                    sh "docker push sythe7/petclinic:${env.BUILD_ID}"
                }
            }
        }
    }
}