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


No container principal, execute os comandos:

```
ping machine1
ping machine2

ssh root@machine1
ssh root@machine2
```

## Para acessar a máquina 
docker run -it machine1 bash
docker exec -it machine1 /bin/bash 
