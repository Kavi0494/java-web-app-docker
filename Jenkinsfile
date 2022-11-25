node {
    def buildnumber= BUILD_NUMBER
    stage("Git Clone"){
        git url:'https://github.com/Kavi0494/java-web-app-docker.git',branch:'master'
    }
    stage("Maven Build"){
        def mavenHome= tool name:"Maven",type:"maven"
        sh "${mavenHome}/bin/mvn clean package" 
    }
    stage("build docker image"){
        sh "docker build -t kavi0494/java-web-docker:${buildnumber} ."
    }
    stage("docker login and push"){
        withCredentials([string(credentialsId: 'docker_hub_pwd', variable: 'docker_hub_pwd')]) {
            sh "docker login -u kavi0494 -p ${docker_hub_pwd}"
}
        sh "docker push kavi0494/java-web-docker:${buildnumber}"
    }
    stage("deploy image to deployment server as a container"){
        sshagent(['docker_server']) {
        sh "ssh -o StrictHostKeyChecking=no ubuntu@18.60.57.214 docker rm -f javawebappcon || true"
        sh "ssh -o StrictHostKeyChecking=no ubuntu@18.60.57.214 docker run -d -p 8080:8080 --name javawebappcon1 kavi0494/java-web-docker:${buildnumber}"
}
    }
}
