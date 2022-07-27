node {
    def MavenbyAdemola = tool name: "maven3.8.6"
    def buildNumber = "BUILD_NUMBER"
    stage ("Clone"){
        checkout([$class: 'GitSCM', branches: [[name: '**']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/TechDom-Ca/web-appl']]])
    }
    stage ("MavenBuild"){
        sh "${MavenbyAdemola}/bin/mvn clean package"
    }
    stage ("ImageBuildfromDocker"){
        sh "docker build -t techdomdevelopers/dockerbuild:${buildNumber} ."
    }
    stage ("LogintoDocker"){
        withCredentials([string(credentialsId: 'DockerPassword', variable: 'DockerPass')]) {
            sh "docker login -u techdomdevelopers -p ${DockerPass}"
        }
    }
    stage ("ImagePushtoDockerHub"){
        sh "docker push techdomdevelopers/dockerbuild:${buildNumber}"
    }
    stage ("LogintoDeploymentServer"){
        sshagent(['deploymentServer']) {
            sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.86.135" 
        }
    }
    stage ("RunImageinDeploymentServer"){
        sh "docker rm -f pipelinecontainer || true"
        sh "docker run --name pipelinecontainer -d -p 5180:8080 techdomdevelopers/dockerbuild:${buildNumber}"
    }
}
