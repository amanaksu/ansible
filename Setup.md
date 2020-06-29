## Initialize Ansible Environment
* OS : Ubuntu 18.04 LTS ( on Windows WSL )

### 1. Pre-Install
* We must be docker, docker-compose because Ansable works as a docker. 
    ```
    $ sudo apt update
    $ sudo apt install software-properties-common -y
    $ sudo add-apt-repository --yes --update ppa:ansible/ansible
    $ sudo apt install docker-ce docker-ce-cli containerd.io -y
    $ sudo apt install python3 python3-pip -y
    $ pip3 install docker-compose
    $ sudo apt install ansible -y
    ```

### 2. Install Ansible AWX

* "Ansible AWX" is Ansible's OSS (Open Source Software) Version
    ```
    $ git clone https://github.com/ansible/awx.git
    ```
* Modify your id, password, postgredb path, docker path, etc.. for awx 
    ```
    $ cd ~/awx/install
    $ vi ./inventory
    ```
* Install

    * if postgredb path or docker path is /root/.awx ~~, change from user to root by command "sudo -i"
    ```
    $ cd ~/awx/installer
    $ sudo ansible-playbook -i inventory install.yml
    ```
* Check Deploy in docker
    ```
    $ docker ps -a
    ```
* Check Status Ansible in docker by Log
    ```
    $ docker logs -f awx_task
    ```



### 99. References
* [Ansible AWX 를 활용한 서버 자동화 1](1)
* [오픈소스로 구성하는 데브옵스 시스템 - Ansible 과 AWX 를 이용한 예제 3](2)


[1]:https://judo0179.tistory.com/52
[2]:https://urban1980.tistory.com/52