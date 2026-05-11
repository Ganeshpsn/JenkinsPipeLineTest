pipeline {
    agent any 

    environment {
        PYTHONPATH = "${env.WORKSPACE}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'pip install --upgrade pip'
                sh 'pip install -r requirements.txt'
            }
        }

        stage('Static Analysis') {
            steps {
                // Optional: Check for syntax errors or styling issues before running tests
                sh 'python -m compileall Calculator_Project/'
            }
        }

        stage('Run Unit Tests') {
            steps {
                sh 'python -m pytest Calculator_Project/tests/test_calculator.py --junitxml=results/pytest_report.xml'
            }
        }

        stage('Run Specific Robot Tests') {
            steps {
                // We explicitly list the two files you want to execute. 
                // Robot Framework will combine them into a single test suite execution.
                sh '''
                   robot -d reports \
                   Calculator_Project/tests/Login_Page_Tests.robot \
                   Calculator_Project/tests/calculator_tests.robot
                '''
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'reports/*, results/*.xml', allowEmptyArchive: true
            junit testResults: 'results/*.xml', allowEmptyResults: true
        }
    }
}
