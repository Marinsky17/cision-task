pipeline {
// assuming no particular agent / slave is set    
    agent any

    stages {
        stage('Build') {
            steps {
                // code checkout from source repo
                checkout scm
                // here we assume that the docker registry, as well as the credentials are set-up
                sh 'docker build -t nginx:1.19 .'
                sh 'docker push nginx:1.19'
            }
        }
        stage('Deploy') {
            steps {
                // Function providing cluster access and then applying the .yaml manifest
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                    sh 'kubectl --kubeconfig=$KUBECONFIG apply -f k8s/nginx-statefulset.yaml'
                }
            }
        }
    }
}
