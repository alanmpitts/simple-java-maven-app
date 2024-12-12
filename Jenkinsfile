pipeline {
    agent any
    environment {
        AWS_DEFAULT_REGION = "us-east-1"
    }

    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Build') {
            steps {
                sh './jenkins/scripts/prn-time.sh START'
                sh './jenkins/scripts/kube-env.sh'
                sh 'mvn -q -B -DskipTests -Denforcer.skip=true clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn -q test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Deliver') {
            steps {
                sh './jenkins/scripts/deliver.sh'
                sh 'stress-ng  -t 5m --cpu 0'
            }
        }
        stage("Deploy to Kube") {
            steps {
                script {
                    // sh "aws eks update-kubeconfig --name demo"
                    sh "kubectl version ; kubectl get nodes"
                    sh "kubectl version ; kubectl get nodes"
                    dir("kubernetes") {
                        // sh "kubectl apply -f nginx-deployment.yaml"
                        // sh "kubectl apply -f nginx-deployment.yaml"
                        // sh "kubectl apply -f nginx-service.yaml"
                    }
                    sh './jenkins/scripts/prn-time.sh END'
                }
            }
        }

    }
}
