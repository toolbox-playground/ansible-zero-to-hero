# 📖 Configuração do Nginx com MySQL 

## 🚀 Como Executar o Playbook

1. **Certifique-se de ter o Ansible instalado:**
   ```sh
   sudo apt update && sudo apt install ansible -y
   ```

2. **Verifique se o arquivo de inventário está correto (`inventory.ini`):**
   ```ini
   [servers]
   machine1 ansible_host=machine1 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
   machine2 ansible_host=machine2 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
   ```

3. **Execute o playbook:**

Excute para checkar a syntax
```
ansible-playbook --syntax-check playbook.yml
```

Encripitando senha e verificando
```
ansible-vault encrypt mysql/vars/main.yml
cat mysql/vars/main.yml
```

Rodando o ansible
```
chmod 600 vault-password.txt
ansible-playbook -i inventory.ini playbook.yml --vault-password-file vault-password.txt
```

Testando nossa conexão com banco
```
ansible -i hosts.ini my_vm -m mysql_db -a "name=test_db state=present login_user=root login_password={{ mysql_root_password }}"
```

3. **Executando Troubleshooting**

Pare e remova os contêineres:

```
docker stop machine1
docker rm machine1
```

Inicie o contêiner para simular a maquina:

```
docker run -d --name machine1 --network ansible-net -p 2222:22 -p 3306:3306 ansible-node
```

Atualize o container do ansible control

```
apk add busybox-extras
telnet machine1 3306
```

Caso necessite, para acessar o nó é só usar:

```
docker exec -it machine1 sh
```