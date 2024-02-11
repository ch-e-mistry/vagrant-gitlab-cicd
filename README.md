
# gitlab CICD vagrant

It is a **vagrant code** which:

- Brings up **Two Virtual Machine**:
- 1 - **gitlab VM** (ubuntu). IP-Address: **192.168.56.222**
- 2 - **runner VM** (centos). IP-Address: **192.168.56.223**

For gitlab VM, ansible playbook was used to install the server itself, while for runner mainly bash scripts are responsible for the installation.

# Table of contents

- [gitlab CICD vagrant](#gitlab-cicd-vagrant)
- [Table of contents](#table-of-contents)
  - [Requirements](#requirements)
  - [Usage](#usage)
    - [gitlab-runner](#gitlab-runner)
  - [Limitations](#limitations)
  - [License](#license)
  - [Author Information](#author-information)

## Requirements

**Vagrant binary** must to be installed on your machine.

Also at least 8GB memory is required, as VMs will use ~ **5120MB of memory**.

It is **about ~ 25 mins to bring it up**, but it depends on your internet connection speed as well (download base-boxes).

If you face timeout problem like:

``` bash
...
    gitlab: SSH username: vagrant
    gitlab: SSH auth method: private key
Timed out while waiting for the machine to boot. This means that
Vagrant was unable to communicate with the guest machine within
the configured ("config.vm.boot_timeout" value) time period.

If you look above, you should be able to see the error(s) that
Vagrant had when attempting to connect to the machine. These errors
are usually good hints as to what may be wrong.

If you're using a custom box, make sure that networking is properly
working and you're able to connect to the machine. It is a common
problem that networking isn't setup properly in these boxes.
Verify that authentication configurations are also setup properly,
as well.

If the box appears to be booting properly, you may want to increase
the timeout ("config.vm.boot_timeout") value.
```

 * Destroy the created resources with `vagrant destroy` command and Increase the `config.vm.boot_timeout` value as recommended && exeecute `vagrant up` again. Also you can check Oracle VirtualBox GUI to see the progress.

## Usage

**You must to add `gitlab.devops.com` on you local hosts** (Windows - "c:\Windows\System32\drivers\etc\hosts") file to point to gitlab server's ip-address. Example:

```bash
# Copyright (c) 1993-2009 Microsoft Corp.

#...

# localhost name resolution is handled within DNS itself.
# 127.0.0.1       localhost
# ::1             localhost
192.168.56.222   gitlab.devops.com
```

**Clone** this repository and **change directory to it**.

After that please **execute `vagrant up`**.

After vagrant was finished with creation of VMs and provisioning, you will be able to **reach gitlab with `192.168.56.222` ip-address** or via `gitlab.devops.com` in your browser.

**Default username is `admin@example.com`**, password will be `SecRetPassworD#2023!`, as defined in [gitlab.yaml](./provision/gitlab.yaml).

### gitlab-runner

You can SSH on the instances with `vagrant ssh <BOX_NAME>`, so `vagrant ssh gitlab` or `vagrant ssh runner`.

The automated installation of runner is based on following official documentations:

- <https://docs.gitlab.com/15.11/runner/register/index.html#requirements>
- <https://docs.gitlab.com/15.11/runner/register/index.html#linux>

Please read them. The tasks, should be done on **gitlab-runner was automatized**, so you **do not need to install gitlab-runner or register it manually**!

## Limitations

Keep in mind, it is a local implementation. It means you should take care of **SSL certification issues in every term** (plugins, clone, git, ... most of the applications are notify you or block the execution in case of self-signed cert - as in our case)

## License

MIT

## Author Information

**Peter Mikaczo**  - <petermikaczo@gmail.com>
