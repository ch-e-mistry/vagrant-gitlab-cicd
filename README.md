# GitLab CI/CD With Vagrant

For Hunagrian version, please open [README_hun.md](README_hun.md)

This repository contains Vagrant code designed to set up a local GitLab CI/CD environment, comprising two virtual machines:

- A **GitLab VM** running on Ubuntu, with an IP address of **192.168.56.222**.
- A **Runner VM** running on CentOS, with an IP address of **192.168.56.223**.

The GitLab VM is configured using an Ansible playbook to install GitLab, while the Runner VM setup is facilitated through bash scripts.

# Table of Contents

- [GitLab CI/CD With Vagrant](#gitlab-cicd-with-vagrant)
- [Table of Contents](#table-of-contents)
  - [Requirements](#requirements)
  - [Usage Instructions](#usage-instructions)
    - [Configuring the GitLab Runner](#configuring-the-gitlab-runner)
  - [Known Limitations](#known-limitations)
  - [License Information](#license-information)
  - [About the Author](#about-the-author)

## Requirements

To utilize this setup, you must have the **Vagrant software installed** on your machine. Additionally, a **minimum of 8GB** of RAM is required, as the VMs collectively consume approximately **5120MB of memory**.

The setup process typically takes around **25 minutes**, varying based on internet connection speed due to the necessity to download base boxes.

Should you encounter a timeout issue, as described below, you are advised to destroy the VMs using the `vagrant destroy` command, adjust the `config.vm.boot_timeout` value as needed, and then rerun `vagrant up`. Monitoring the VMs' boot process via the Oracle VirtualBox GUI can provide useful insights.

```bash
...
...
...
problem that networking isn't setup properly in these boxes.
Verify that authentication configurations are also setup properly,
as well.

If the box appears to be booting properly, you may want to increase
the timeout ("config.vm.boot_timeout") value.
...
```

## Usage Instructions

Firstly, ensure `gitlab.devops.com` is added to your local hosts file (Windows - "c:\Windows\System32\drivers\etc\hosts"; Linux / MacOS - "/etc/hosts"), pointing to the GitLab server's IP address, as illustrated below:

```bash
192.168.56.222   gitlab.devops.com
```

Proceed by cloning this repository and navigating to the cloned directory. Initiate the setup by executing `vagrant up`.

Upon completion, GitLab can be accessed via the IP address `192.168.56.222` or through `gitlab.devops.com` in your web browser.

The default login credentials are as follows: username `admin@example.com` and password `SecRetPassworD#2023!`, as specified in the [gitlab.yaml](./provision/gitlab.yaml) configuration file.

### Configuring the GitLab Runner

To access the virtual machines, use `vagrant ssh <BOX_NAME>`, replacing `<BOX_NAME>` with either `gitlab` or `runner`. The GitLab Runner installation and registration are automated, adhering to the official GitLab documentation, thus manual installation or registration is unnecessary.

## Known Limitations

This setup is intended for local development and testing. As such, it is important to be mindful of SSL certificate validation issues, as many applications will either notify the user of self-signed certificates or block execution entirely.

## License Information

This project is licensed under the MIT License.

## About the Author

**Peter Mikaczo** - <petermikaczo@gmail.com>