pipeline {

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    } 
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  any
    stages {
        stage('STAGE-CHECKOUT') {
            steps {
                 script{
                        dir("Jenkins-Terraform")
                        {
                            git "https://github.com/sksuraj17/Jenkins-Terraform.git"
                        }
                    }
                }
            }

        stage('STAGE-PLAN') {
            steps {
                sh 'pwd;cd Jenkins-Terraform/ ; terraform init'
                sh "pwd;cd Jenkins-Terraform/ ; terraform plan -out myplan"
                sh 'pwd;cd Jenkins-Terraform/ ; terraform show -no-color myplan > myplan.txt'
            }
        }
        stage('STAGE-APPROVAL') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
           }

           steps {
               script {
                    def plan = readFile 'Jenkins-Terraform/myplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: "plan")]
               }
           }
       }

        stage('Apply') {
            steps {
                sh "pwd;cd Jenkins-Terraform/ ; terraform apply -input=false myplan"
            }
        }
    }

  }