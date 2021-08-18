pipeline {
    agent any
    environment{
        DOCKER_TAG = getDockerTag()
    }
    stages{
        stage('Build awg docker image'){
            steps{
                sh "docker build . -t itayvolo/awgapp:${DOCKER_TAG}"
            }
        }
        stage('Dockerhub push'){
            steps{
                withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerhubPWD')]) {
                    sh "docker login -u itayvolo -p ${dockerhubPWD}"
                    sh "docker push itayvolo/awgapp:${DOCKER_TAG}"
                }
            }
        }
    }
}

def getDockerTag(){
    def tag = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}