### Simulação de Máquinas com Docker e Uso do Ansible

Este tutorial explica como simular duas máquinas utilizando contêineres Docker e acessar esses contêineres com o Ansible para executar um playbook.

1. Configurar Contêineres Docker como Máquinas

Dockerfile (opcional)

Crie um arquivo Dockerfile para instalar o SSH e o Python (requisitos do Ansible):
```
FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y openssh-server python3 && \
    mkdir /var/run/sshd && \
    echo 'root:password' | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
```

Crie a rede para as imagens
```
docker network create ansible-net
```

Construa a imagem:
```
docker build -t ansible-node .
```

Executar os Contêineres

Inicie dois contêineres para simular as duas máquinas:

docker run -d --name machine1 --network ansible-net -p 2222:22 ansible-node
docker run -d --name machine2 --network ansible-net -p 3333:22 ansible-node

2. Configurar o Inventário do Ansible

Crie um arquivo de inventário chamado inventory.ini com as informações dos contêineres:

[machines]
machine1 ansible_host=127.0.0.1 ansible_port=2222 ansible_user=root ansible_password=password
machine2 ansible_host=127.0.0.1 ansible_port=3333 ansible_user=root ansible_password=password

3. Testar Conectividade

Antes de executar um playbook, teste a conectividade com as máquinas usando o módulo ping do Ansible:

ansible -i inventory.ini machines -m ping

Se estiver tudo configurado corretamente, você verá uma resposta do tipo pong.

4. Criar e Executar um Playbook

Crie um playbook de teste chamado playbook.yml:

- name: Test playbook
  hosts: machines
  tasks:
    - name: Atualizar e fazer upgrade dos pacotes
      apt:
        update_cache: yes
        upgrade: dist

Execute o playbook com o comando:

ansible-playbook -i inventory.ini playbook.yml

5. Limpeza (Opcional)

Pare e remova os contêineres quando não forem mais necessários:

```
docker stop machine1 machine2
docker rm machine1 machine2
```