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
        
        stage('Docker Build') {
            steps {
                sh 'docker build -t sythe7/spring-petclinic:latest .'
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                sh 'docker push shanem/spring-petclinic:latest'
                }
            }
        }

        // stage('Create Dockerfile') {
        //     steps {
        //         script {
        //             // Define and write the Dockerfile to the workspace
        //             writeFile file: 'Dockerfile', text: '''
        //             FROM openjdk:11-jre-slim
        //             WORKDIR /app
        //             ARG JAR_FILE
        //             COPY ${JAR_FILE} app.jar
        //             EXPOSE 8000
        //             ENTRYPOINT ["java", "-jar", "/app/app.jar", "--server.port=8000"]
        //             '''
        //         }
        //     }
        // }
        
        // stage('Docker Image Build and Push') {
        //     steps {
        //         script {
        //             def jar = sh(script: "ls target/*.jar", returnStdout: true).trim()
        //             sh "docker build -t sythe7/petclinic:${env.BUILD_ID} . --build-arg JAR_FILE=${jar}"
        //             sh "docker login -u sythe7 -p abcdefghi"
        //             sh "docker push sythe7/petclinic:${env.BUILD_ID}"
        //         }
        //     }
        // }
    }
}
