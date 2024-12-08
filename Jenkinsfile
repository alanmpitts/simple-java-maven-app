pipeline {
    agent any

    // environment {
    //     AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
    //     AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    //     AWS_DEFAULT_REGION = "us-east-1"
    // }

    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Build') {

            steps {
                sh 'set +x ; echo "[INFO] Endtime: `date -Iseconds`" '
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
                // sh 'stress-ng -t 5m --cpu 0'
            }
        }
        stage("Deploy to Kube") {
            steps {
                script {
                    sh 'echo "[EoP] Endtime: `date -Iseconds`" '
                    // dir('kubernetes') {
                    //     sh "aws eks update-kubeconfig --name myapp-eks-cluster"
                    //     sh "kubectl apply -f nginx-deployment.yaml"
                    //     sh "kubectl apply -f nginx-service.yaml"
                    // }
                }
            }
        }

    }
}
