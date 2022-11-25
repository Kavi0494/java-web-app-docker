node
{
   def buildNumber = BUILD_NUMBER
   stage("Git CheckOut"){
        git url: 'https://github.com/sandeepdurai/java-web-app-docker.git',branch: 'master'
    }
    
    stage(" Maven Clean Package"){
      def mavenHome =  tool name: "Maven", type: "maven"
      def mavenCMD = "${mavenHome}/bin/mvn"
      sh "${mavenCMD} clean package"
    } 
   stage("Build Dokcer Image") {
         sh "docker build -t sandeep08aws/javawebapp:${buildNumber} ."
    }
    stage("Docker login and Push"){
        withCredentials([string(credentialsId: 'docker_hub_password', variable: 'Dockerpassword')]){
         sh "docker login -u sandeep08aws -p ${Dockerpassword} " 
           }
        sh "docker push sandeep08aws/javawebapp:${buildNumber}"
    }
    stage("Deploy to dockercontinor in docker deployer"){
        sshagent(['docker_ssh_password']) {
            sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.2.57 docker rm -f cloudcandy || true"
            sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.2.57 docker run -d -p 8080:8080 --name cloudcandy sandeep08aws/javawebapp:${buildNumber}"           
    }  
}
