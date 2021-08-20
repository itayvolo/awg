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
        stage('Deploy to K8s'){
            steps{
                sh "chmod +x changeTag.sh"
                sh "./changeTag.sh ${DOCKER_TAG}"
                sshagent(['k8s']) {
                    sh "scp -o StrictHostKeyChecking=no awgapp-depl.yaml root@volomaster1:/root/k8s/application/"
                    sh "ssh root@volomaster1 kubectl apply -f /root/k8s/application/"
                }
            }
        }
    }
}

def getDockerTag(){
    def tag = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}