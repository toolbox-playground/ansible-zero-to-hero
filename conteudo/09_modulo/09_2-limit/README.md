# 📖 Configuração do Nginx com Ansible Roles

Este projeto contém uma **role do Ansible** chamada `nginx_setup`, responsável por instalar, configurar e garantir que o serviço Nginx esteja rodando corretamente nos servidores gerenciados.

---

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

```
ansible-playbook -i inventory.ini playbook.yml
```

Pulando tarefas com tags especificas
```bash
ansible-playbook playbook.yml --skip-tags "database"
ansible-playbook -i hosts.ini playbook.yml --tags webserver
ansible-playbook -i hosts.ini playbook.yml --limit web
ansible-playbook -i hosts.ini playbook.yml --limit machine1
```

Listando todas as tags em um playbook
```bash
ansible-playbook playbook.yml --list-tags
```

4. **Verifique se o Nginx está rodando nos servidores:**
   ```
   systemctl status nginx
   ```
