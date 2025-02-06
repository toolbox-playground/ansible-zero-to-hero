# 📖 Configuração do Nginx com Ansible Roles

Este projeto contém uma **role do Ansible** chamada `nginx_setup`, responsável por instalar, configurar e garantir que o serviço Nginx esteja rodando corretamente nos servidores gerenciados.

---

## 📌 Estrutura do Projeto

O comando `ansible-galaxy init nginx_setup` gerou a seguinte estrutura de diretórios:

```
nginx_setup/
│── defaults/
│   ├── main.yml  # Variáveis padrão
│── handlers/
│   ├── main.yml  # Handlers para reiniciar o Nginx
│── tasks/
│   ├── main.yml  # Lista de tarefas da role
│── templates/
│   ├── nginx.conf.j2  # Template Jinja2 do arquivo de configuração do Nginx
│── vars/
│   ├── main.yml  # Variáveis específicas (opcional)
│── meta/
│   ├── main.yml  # Metadados da role
│── README.md  # Documentação
```

---

## 📝 Definição de Variáveis (`defaults/main.yml`)

Este arquivo contém as variáveis padrão da role:

```yaml
document_root: "/var/www/html"
server_name: "example.com"
```

Caso necessário, esses valores podem ser sobrescritos no playbook principal.

---

## 🔧 Tarefas (`tasks/main.yml`)

O arquivo **tasks/main.yml** define as seguintes tarefas:

```yaml
---
- name: Instalar Nginx
  apt:
    name: nginx
    state: present
  become: yes

- name: Copiar configuração personalizada do Nginx
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
  notify: Reiniciar Nginx

- name: Garantir que o Nginx está rodando
  service:
    name: nginx
    state: started
    enabled: yes
```

---

## 🔥 Handlers (`handlers/main.yml`)

Handlers são usados para reiniciar o serviço **apenas quando necessário**:

```yaml
---
- name: Reiniciar Nginx
  service:
    name: nginx
    state: restarted
```

---

## 🎨 Template do Nginx (`templates/nginx.conf.j2`)

Este é o template Jinja2 para a configuração do Nginx:

```jinja
user www-data;
worker_processes auto;
pid /run/nginx.pid;

http {
    sendfile on;
    keepalive_timeout 65;
    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    server {
        listen 80;
        server_name {{ server_name }};
        root {{ document_root }};
        index index.html index.htm;

        location / {
            try_files $uri $uri/ =404;
        }
    }
}
```

Isso permite que o Ansible substitua os valores dinâmicos, como `server_name` e `document_root`.

---

## 🎯 Playbook Principal (`site.yml`)

O arquivo `site.yml` chama a role `nginx_setup` para configurar o Nginx nos servidores do inventário:

```yaml
---
- name: Configurar Nginx com Role Ansible
  hosts: all
  become: yes
  roles:
    - nginx_setup
```

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
  ansible-playbook --syntax-check site.yml
   ```

   ```
   ansible-playbook -i inventory.ini site.yml
   ```

4. **Verifique se o Nginx está rodando nos servidores:**
   ```
   systemctl status nginx
   ```
