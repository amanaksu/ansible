## ansible in centos8

### Setup Environment

* Host OS : Windows 10 Pro
* Virtual Program : VMware Workstation 15 Pro
* Virtual OS : CentOS 8 ( [Download VM][0] )

### Install ansible
* Reference : [Install ansible centos8][1]

	```
	$ sudo dnf makecache
	$ sudo dnf install python3
	$ sudo dnf install epel-release
	$ sudo dnf makecache
	$ sudo dnf install ansible
	```
	
### Install AWX
* Reference : [How to install the awx ansible web gui on centos8][2]
* Dependency
	```
	$ sudo dnf install git gcc gcc-c++ ansible nodejs gettext device-mapper-persistent-data lvm2 bzip2 python3-pip -y
	$ sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
	$ sudo dnf install docker-ce-3:18.09.1-3.el7 -y

	$ sudo systemctl start docker
	$ sudo systemctl enable docker
	$ sudo usermod -aG docker $USER

    # Log out & Log back in.

    $ sudo pip3 install docker-compose
	# sudo alternatives --set python /usr/bin/python3
	```
	
* Install AWX
	```
	$ git clone https://github.com/ansible/awx.git
	$ cd awx/installer
	$ openssl rand -base64 30
	$ vi inventory
		# 파일 내 다음 항목들을 수정한다. 
		> postgres_data_dir = < postgres persistent storage 경로 >
		> docker-compose_dir = < docker 저장 경로 >
		> secret_key = < 사전에 만들어 둔 랜덤값 >
		> admin_password = < 신규 비밀번호 >
	$ sudo ansible-playbook -i inventory install.yaml
	```
	
	* Docker 가 실행되기까지 10분 이상 소요됨	
	
[0]:https://www.linuxvmimages.com/images/centos-8/
[1]:https://linuxhint.com/install_ansible_centos8/
[2]:https://www.techrepublic.com/article/how-to-install-the-awx-ansible-web-gui-on-centos-8/