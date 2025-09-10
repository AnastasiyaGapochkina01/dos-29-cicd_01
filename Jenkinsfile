pipeline {
	agent any

	parameters {
		booleanParam(name: 'RUN_TEST', defaultValue: true, description: 'Run tests?')
		booleanParam(name: 'RUN_BUILD', defaultValue: true, description: 'Run go build?')
		booleanParam(name: 'BUILD_DOCKER', defaultValue: true, description: 'Run build image?')
		string(name: 'TAG', defaultValue: 'latest', description: '')
	}

	environment {
		PRJ_NAME="simple-go"
		GIT_URL="https://github.com/AnastasiyaGapochkina01/dos-29-cicd_01.git"
	}

	stages {
		stage('Clone repo') {
			steps {
				script {
					sh """
						if [ -d ${env.PRJ_NAME}/.git ]; then
					  		echo "Repository exists. Updating..."
					  		cd ${env.PRJ_NAME}
					  		git pull
						else
					   		echo "Clone repo..."
					   		git clone ${env.GIT_URL} ${env.PRJ_NAME}
					   	fi
				"""
				}
			}
		}
		stage('Go build') {
			when {
				expression { params.RUN_BUILD }
			}
			steps {
				script {
					sh """
						set -x;
						cd ${env.PRJ_NAME}
						if [ ! -f "go.mod" ]; then
							go mod init ${env.PRJ_NAME}
						fi
						go build -o ${env.PRJ_NAME}_linux
					"""
				}
			}
		}
		stage('Run test') {
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
		stage('Docker build') {
			when {
				expression { params.BUILD_DOCKER }
			}
			steps {
				script {
					sh """
						cd ${env.PRJ_NAME}
						sudo docker build -t ${env.PRJ_NAME}:${params.TAG} .
					"""
				}
			}
		}
	}
}
