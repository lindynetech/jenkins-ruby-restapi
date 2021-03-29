pipeline{
    agent{
        label 'spot'
    }
   environment {
        imageName = 'lindynetech/book-library'
        containerName = 'booklibrary'
    }
    stages{
        stage("Prapare Runtime"){
            steps{
                echo "====++++executing Prapare Runtime++++===="
                sh "sudo yum install ruby ruby-dev rubygem-cucumber -y"
                sh "sudo gem install json rest-client"
            }
        }
        stage("Docker Build"){
            steps{
                echo "========executing Docker Build========"
                sh "docker build -t $imageName ."
            }
        }
        stage("Docker login"){
            steps{
                echo "====++++executing Docker login++++===="
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub',
                         usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
                     sh "docker login --username $USERNAME --password $PASSWORD"
                }
            }
        }
        stage("Docker push"){
            steps{
                echo "====++++executing Docker push++++===="
                sh "docker push $imageName"
            }
        }
        stage("Deploy to Staging"){
            steps{
                echo "====++++executing Deploy to Staging++++===="
                sh "docker run -d --name $containerName -p 8080:8080 $imageName"
            }            
        }
        stage("Acceptance Test"){
            steps{
                echo "====++++executing Acceptance Test++++===="
                sleep 10
                sh "cucumber"
            }
        }
    }

    post{
        always{
            echo "========Cleanup (always) ========"
            sh "docker rm -f $containerName"
            sh "docker rmi $imageName"
            //sh "sudo yum remove rubygem-cucumber -y"
            //sh "sudo yum clean all -y"
        }
    }
}