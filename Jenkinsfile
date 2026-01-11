pipeline {
    agent any
    parameters {
        booleanParam(name: 'RUN_TESTS', defaultValue: true)
        string(name: 'IMAGE_TAG', defaultValue: 'latest')
    }
    
    environment {
        PRJ_NAME="go-server"
        GIT_URL="https://github.com/AnastasiyaGapochkina01/dos-29-cicd_01.git"
    }
    
    stages {
        stage('Clone repo') {
            steps {
                script {
                    sh """
                        if [ -d ${env.PRJ_NAME}/.git ]; then
                          echo "Repo exists"
                          cd ${env.PRJ_NAME} && git pull
                        else
                          echo "Clone repo"
                          git clone ${env.GIT_URL} ${env.PRJ_NAME}
                        fi
                    """
                }
            }
        }
        stage('Run tests') {
            when {
                expression { params.RUN_TEST }
            }
            steps {
                script {
                    sh """
                        cd ${env.PRJ_NAME}
                        go test ./
                    """
                }
            }
        }
        
        stage('Build image') {
            steps {
                script {
                    sh """
                        cd ${env.PRJ_NAME}
                        docker build -t ${env.PRJ_NAME}:${params.IMAGE_TAG} .
                    """
                }
            }
        }
    }
}
