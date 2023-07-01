#!/bin/bash
echo '***** ***** update ***** *****' >>user-logs\.log
sudo apt-get update -y >>user-logs\.log 2>&1
echo '***** ***** update completed ***** *****' >>user-logs\.log
# sudo apt-get install openjdk-8-jdk maven -y
echo '***** ***** install maven ***** *****' >>user-logs\.log
sudo apt-get install maven -y >>user-logs\.log 2>&1
echo '***** ***** install maven completed ***** *****' >>user-logs\.log
echo '***** ***** clone ***** *****' >>user-logs\.log
git clone https://github.com/melsaied930/demo.git >>user-logs\.log 2>&1
echo '***** ***** clone completed ***** *****' >>user-logs\.log

# cat <<EOF >/home/ubuntu/user-data.sh
# #!/bin/bash
# # Create a folder
# mkdir actions-runner && cd actions-runner
# echo '.' >> user-data\.log
# # Download the latest runner package
# curl -o actions-runner-linux-x64-2.305.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.305.0/actions-runner-linux-x64-2.305.0.tar.gz >> user-data\.log 2>&1
# echo '..' >> user-data\.log
# # Optional: Validate the hash
# echo "737bdcef6287a11672d6a5a752d70a7c96b4934de512b7eb283be6f51a563f2f  actions-runner-linux-x64-2.305.0.tar.gz" | shasum -a 256 -c >> user-data\.log 2>&1
# echo '...' >> user-data\.log
# # Extract the installer
# tar xzf ./actions-runner-linux-x64-2.305.0.tar.gz
# echo '....' >> user-data\.log
# # Create the runner and start the configuration experience
# ./config.sh --url https://github.com/melsaied930/demo --token AGXSOTECYJ2U5ICDF6RVSOLETUCLO --unattended >> user-data\.log 2>&1
# echo '.....' >> user-data\.log
# # Install svc.sh
# sudo ./svc.sh install >> user-data\.log 2>&1
# echo '......' >> user-data\.log
# EOF
# cd /home/ubuntu
# chmod +x user-data.sh
# /bin/su -c "./user-data.sh" - ubuntu | tee user-data\.log

# #!/bin/bash
# cat <<EOF >/home/ubuntu/user-data.sh
# #!/bin/bash
# wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
# chmod +x ./jq
# sudo cp jq /usr/bin
# curl --request POST 'https://api.github.com/repos/your_user/your_repository_name/actions/runners/registration-token' --header "Authorization: token ${personal_access_token}" > output.txt
# runner_token=\$(jq -r '.token' output.txt)
# mkdir ~/actions-runner
# cd ~/actions-runner
# curl -O -L https://github.com/actions/runner/releases/download/v2.263.0/actions-runner-linux-x64-2.263.0.tar.gz
# tar xzf ~/actions-runner/actions-runner-linux-x64-2.263.0.tar.gz
# rm ~/actions-runner/actions-runner-linux-x64-2.263.0.tar.gz
# ~/actions-runner/config.sh --url https://github.com/your_user/your_repository_name/ --token \$runner_token --name "Github EC2 Runner" --unattended
# ~/actions-runner/run.sh
# EOF
# cd /home/ubuntu
# chmod +x user-data.sh
# /bin/su -c "./user-data.sh" - ubuntu | tee user-data\.log
