pipeline {
    agent any
    stages {
        // stage('Unit Tests') {
        //     steps {
        //         sh './mvnw test -Dcheckstyle.skip=true'
        //     }
        // }
        
        // stage('SonarQube Tests') {
        //     environment {
        //         scannerHome = tool 'SonarQube'
        //     }
        //     steps {
        //         withSonarQubeEnv('SonarQube') {
        //             sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=spring-petclinic -Dsonar.java.binaries=target/classes"
        //         }
        //         timeout(time: 10, unit: 'MINUTES') {
        //             waitForQualityGate abortPipeline: true
        //         }
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
        
        stage('Docker Image Build') {
            steps {
                script {
                    def jar = sh(script: "ls target/*.jar", returnStdout: true).trim()
                    sh "docker build -t sythe7/petclinic:${env.BUILD_ID} . --build-arg JAR_FILE=${jar}"
                }
            }
        }

        stage('Docker Image Push') {
            steps {
                script {
                    withCredentials([string(credentialsId: '84827f3c-43b9-4708-b767-e70f87e76e7b', variable: 'dockerHubPassword')]) {
                        sh "docker login -u sythe7 -p ${dockerHubPassword}"
                    }
                    sh "docker push sythe7/petclinic:${env.BUILD_ID}"
                }
            }
        }

        // stage('Deploy Docker Container') {
        //     steps {
        //         ansiblePlaybook credentialsId: 'dev-server', disableHostKeyChecking: true, extras: '-e TAG=${TAG} -e ENV=${DEPLOY_TO} --tags hello1', installation: 'ansible', inventory: '/home/src/ansible-scripts/inventory.inv', playbook: '/home/src/ansible-scripts/docker-deployment.yml'
        //     }
        // }
        
        // stage('Clean') {
        //     steps {
        //         sh "docker image rm -f ${REGISTRY}/hello1:${TAG}"
        //         sh "docker system prune -f"
                
        //     }
        // }
    }
}