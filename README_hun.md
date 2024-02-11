# GitLab CI/CD Vagranttal

Ez a repository Vagrant kódot tartalmaz, amelynek célja egy helyi GitLab CI/CD környezet beállítása, amely két virtuális gépből áll:

- Egy **GitLab VM**, ami Ubuntu rendszeren fut, **192.168.56.222** IP-címmel.
- Egy **Runner VM**, ami CentOS rendszeren fut, **192.168.56.223** IP-címmel.

A GitLab VM konfigurálása egy Ansible playbook segítségével történik, a GitLab telepítéséhez, míg a Runner VM beállítása bash szkriptekkel van megkönnyítve.

## Tartalomjegyzék

- [GitLab CI/CD Vagranttal](#gitlab-cicd-vagranttal)
  - [Tartalomjegyzék](#tartalomjegyzék)
  - [Követelmények](#követelmények)
  - [Használati Utasítások](#használati-utasítások)
    - [A GitLab Runner Konfigurálása](#a-gitlab-runner-konfigurálása)
  - [Ismert Korlátozások](#ismert-korlátozások)
  - [Licenc Információ](#licenc-információ)
  - [A Szerzőről](#a-szerzőről)

## Követelmények

Ennek a beállításnak a használatához **telepítened kell a Vagrant szoftvert és az oracle VM Virtualbox-ot** a gépedre. Ezenkívül szükséges **minimum 8GB** RAM, mivel a VM-ek együttesen körülbelül **5120MB memóriát** fogyasztanak.

A beállítási folyamat általában körülbelül **25 percet** vesz igénybe, változóan az internetkapcsolat sebességétől függően a base boxok letöltése miatt.

Amennyiben időtúllépési problémába ütközöl, ahogy alább le van írva, tanácsos megsemmisíteni a VM-eket a `vagrant destroy` parancs használatával, szükség szerint módosítani a `config.vm.boot_timeout` értéket, majd újra futtatni a `vagrant up` parancsot. Az Oracle VirtualBox GUI-n keresztüli VM-ek boot folyamatának megfigyelése hasznos betekintést nyújthat.

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

## Használati Utasítások

Először is, győződj meg róla, hogy a `gitlab.devops.com` hozzá van adva a helyi hosts fájlodhoz (Windows - "c:\Windows\System32\drivers\etc\hosts"; Linux / MacOS - "/etc/hosts"), mutatva a GitLab szerver IP-címére, ahogy az alább látható:

```bash
192.168.56.222   gitlab.devops.com
```

Folytasd azzal, hogy klónozd ezt a repositoryt és navigálj a klónozott könyvtárba. Kezd meg a beállítást a `vagrant up` végrehajtásával.

A befejezés után, a GitLab elérhető az `192.168.56.222` IP-címen keresztül vagy a `gitlab.devops.com`-on keresztül a webböngésződben.

Az alapértelmezett bejelentkezési adatok a következők:
felhasználónév `admin@example.com` és jelszó `SecRetPassworD#2023!`, ahogy az a [gitlab.yaml](./provision/gitlab.yaml) konfigurációs fájlban van megadva.

### A GitLab Runner Konfigurálása

A virtuális gépekhez való hozzáféréshez használd a `vagrant ssh <BOX_NAME>`, cserélve a `<BOX_NAME>`-t `gitlab`-ra vagy a `runner`-re. A GitLab Runner telepítése és regisztrációja automatizált, a hivatalos GitLab dokumentációhoz igazodva, így manuális telepítés vagy regisztráció nem szükséges.

## Ismert Korlátozások

Ez a beállítás helyi fejlesztésre és tesztelésre szánt. Mint ilyen, fontos figyelembe venni az SSL tanúsítvány érvényesítési problémáit, mivel sok alkalmazás vagy figyelmezteti a felhasználót az önaláírt tanúsítványokról vagy teljesen blokkolja a végrehajtást.

## Licenc Információ

Ez a projekt az MIT Licenc alatt van.

## A Szerzőről

**Peter Mikaczo** - <petermikaczo@gmail.com>
