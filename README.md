
# gitlab CICD vagrant

It is a **vagrant code** which:

- Brings up **Two Virtual Machine**:
- 1 - **gitlab VM** (ubuntu). IP-Address: **192.168.56.56**
- 2 - **runner VM** (centos). IP-Address: **192.168.56.201**

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

## Usage

**You must add `gitlab.example.com` on you local hosts** (Windows - "c:\Windows\System32\drivers\etc\hosts") file to point to gitlab server's ip-address. Example:

```bash
# Copyright (c) 1993-2009 Microsoft Corp.

#...

# localhost name resolution is handled within DNS itself.
# 127.0.0.1       localhost
# ::1             localhost
192.168.56.56   gitlab.example.com
```

**Clone** this repository and **change directory to it**.

After that please **execute `vagrant up`**.

After vagrant was finished with creation of VMs and provisioning, you will be able to **reach gitlab with `192.168.56.56` ip-address** or via `gitlab.example.com` in your browser.

**Default username is `root`**, password will be asked on first run to set.

### gitlab-runner

You can SSH on the instances with `vagrant ssh <BOX_NAME>`, so `vagrant ssh gitlab` or `vagrant ssh runner`.

The automated installation of runner is based on following official documentations:

- <https://docs.gitlab.com/13.6/runner/register/index.html#requirements>
- <https://docs.gitlab.com/13.6/runner/register/index.html#linux>

Please read them. The tasks, should be done on **gitlab-runner was automatized**, so you **do not need to install gitlab-runner**!

As a last step, please execute this command on `runner` VM as `root`:

```bash
SERVER=gitlab.example.com; PORT=443; CERTIFICATE=/etc/gitlab-runner/certs/${SERVER}.crt; sudo mkdir -p $(dirname $CERTIFICATE); openssl s_client -connect ${SERVER}:${PORT} -showcerts </dev/null 2>/dev/null | sed -e '/-----BEGIN/,/-----END/!d' | sudo tee $CERTIFICATE >/dev/null; gitlab-runner register --tls-ca-file=$CERTIFICATE
```

- If **you changed the domain** of gitlab server, please **update this command** as well.

## Limitations

Keep in mind, it is a local implementation. It means you should take care of **SSL certification issues in every term** (plugins, clone, git, ... most of the applications are notify you or block the execution in case of self-signed cert - as in our case)

## License

MIT

## Author Information

**Peter Mikaczo**  - <petermikaczo@gmail.com>
