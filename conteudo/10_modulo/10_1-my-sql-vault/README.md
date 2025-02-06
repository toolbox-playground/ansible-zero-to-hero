# 📖 Configuração do Nginx com MySQL 

## 🚀 Como Executar o Playbook

1. **Certifique-se de ter o Ansible instalado:**
   ```sh
   sudo apt update && sudo apt install ansible -y
   ```

2. **Verifique se o arquivo de inventário está correto (`inventory.ini`):**
   ```ini
   [servers]
   machine1 ansible_host=192.168.1.10 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
   machine2 ansible_host=192.168.1.11 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
   ```

3. **Execute o playbook:**

Excute para checkar a syntax
```
ansible-playbook --syntax-check playbook.yml
```

Encripitando senha
```
ansible-vault encrypt_string 'mysql_root_password' --name 'db_password'
```

Rodando o ansible
```
ansible-playbook -i inventory.ini playbook.yml
```

Testando nossa conexão com banco
```
ansible -i hosts.ini my_vm -m mysql_db -a "name=test_db state=present login_user=root login_password={{ mysql_root_password }}"
```
