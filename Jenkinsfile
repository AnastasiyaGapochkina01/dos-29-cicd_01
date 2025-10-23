pipeline {
  agent { label 'docker' }
  parameters {
    booleanParam(name: 'RUN_TESTS', defaultValue: true)
    string(name: 'TAG', defaultValue: 'latest')
    gitParameter(type: 'PT_BRANCH', name: 'REVISION', defaultValue: 'main', selectedValue: 'DEFAULT', branchFilter: 'origin/(.*)')
  }

  environment {
    REPO="anestesia01"
    PRJ_NAME="goapp"
    GIT_URL="https://github.com/AnastasiyaGapochkina01/dos-29-cicd_01.git"
    TOKEN=credentials('docker_token')
  }

  stages {
    stage('Clone repo') {
      steps {
        script {
          sh """
            if [ -d ${env.PRJ_NAME}/.git ]; then
              echo "Repo exists. Updating..."
              cd ${env.PRJ_NAME}
              git checkout ${params.REVISION}
              git fetch
              git pull ${env.GIT_URL} ${params.REVISION}
            else
              echo "Clone repo"
              git clone ${env.GIT_URL} ${env.PRJ_NAME}
            fi
          """
        }
      }
    }

    stage('Build image') {
      steps {
        script {
          sh """
            cd ${env.PRJ_NAME}
            docker build -t ${env.REPO}/${env.PRJ_NAME}:${params.TAG} ./
            docker login -u ${env.REPO} -p ${env.TOKEN}
            docker push ${env.REPO}/${env.PRJ_NAME}:${params.TAG}
            docker logout
          """
        }
      }
    }

    stage('Run tests') {
      when {
        expression { params.RUN_TESTS }
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
  }
}
