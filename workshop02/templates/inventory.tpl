all:
  vars:
    ansible_connection: ssh
    ansible_user: root
    ansible_ssh_private_key_file: /home/fred/repo/workshop02/GVT-MacBook
    to_install: 
    - name: nginx 
      version: latest
      service_name: nginx

  hosts:
    server-0:
      ansible_host: ${host_ip}