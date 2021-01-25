#VARIABLES
BOX_1 = "gitlab"
BOX_GITLAB = "ubuntu/xenial64"
BOX_GITLAB_RAM = "4096"
BOX_GITLAB_IP = "192.168.56.56"

BOX_2 = "runner"
BOX_GITLAB_RUNNER = "geerlingguy/centos7"
BOX_GITLAB_RUNNER_RAM = "1024"
BOX_GITLAB_RUNNER_IP = "192.168.56.201"

$etchostsgitlab = <<-SCRIPT
cp /etc/hosts /root && \
sed -ie '/ubuntu-gitlab/d' /etc/hosts && \
echo '192.168.56.56 gitlab.example.com' >> /etc/hosts
SCRIPT

$etchostsgitlabrunner = <<-SCRIPT
cp /etc/hosts /root && \
sed -ie '/gitlab-runner/d' /etc/hosts && \
echo '192.168.56.56 gitlab.example.com' >> /etc/hosts
SCRIPT


Vagrant.configure("2") do |config|
 
  config.vm.define BOX_1 do |gl|
    gl.vm.box = BOX_GITLAB
    gl.vm.provider "virtualbox" do |vb|
      vb.memory = BOX_GITLAB_RAM
    end
    gl.vm.network "private_network", ip: BOX_GITLAB_IP
    gl.vm.hostname = BOX_1
    gl.vm.synced_folder "./provision", "/provision"
    gl.vm.provision "shell", inline: $etchostsgitlabrunner
    gl.vm.provision "ansible_local" do |ansible|
        ansible.become = true
        ansible.playbook = "provision/gitlab.yaml"
        ansible.galaxy_role_file = "provision/requirements.yaml"
        ansible.galaxy_roles_path = "/etc/ansible/roles"
        ansible.galaxy_command = "sudo ansible-galaxy install --role-file=%{role_file} --roles-path=%{roles_path} --force"
      end
  end

  config.vm.define BOX_2 do |runner|
    runner.vm.box = BOX_GITLAB_RUNNER
    runner.vm.provider "virtualbox" do |vb|
      vb.memory = BOX_GITLAB_RUNNER_RAM
    end
    runner.vm.network "private_network", ip: BOX_GITLAB_RUNNER_IP
    runner.vm.hostname = BOX_2
    runner.vm.provision "shell", inline: "curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh | sudo bash"
    runner.vm.provision "shell", inline: "export GITLAB_RUNNER_DISABLE_SKEL=true; sudo -E yum install gitlab-runner -y"
    runner.vm.provision "shell", path: "provision/docker.sh"
    # Workaround - insecure option to be able to execute git command with self-signed cert
    runner.vm.provision "shell", inline: "sudo runuser -l gitlab-runner -c 'git config --global http.sslVerify false'"
    runner.vm.provision "shell", inline: $etchostsgitlabrunner
    #https://stackoverflow.com/questions/44458410/gitlab-ci-runner-ignore-self-signed-certificate - Apply self-signed certification workaround
    #runner.vm.provision "shell", inline: "SERVER=gitlab.example.com; PORT=443; CERTIFICATE=/etc/gitlab-runner/certs/${SERVER}.crt; sudo mkdir -p $(dirname $CERTIFICATE); openssl s_client -connect ${SERVER}:${PORT} -showcerts </dev/null 2>/dev/null | sed -e '/-----BEGIN/,/-----END/!d' | sudo tee $CERTIFICATE >/dev/null; gitlab-runner register --tls-ca-file=$CERTIFICATE"
  end

end