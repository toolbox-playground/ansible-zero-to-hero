#  Pré-requisitos

Antes de configurar o pipeline de CI/CD, precisamos garantir que:  
- Você tenha um usuário IAM na AWS com permissões de EC2  
- Sua chave AWS (AWS_ACCESS_KEY_ID e AWS_SECRET_ACCESS_KEY) esteja armazenada no CI/CD como variáveis de ambiente  
- O Ansible esteja instalado no runner da pipeline  

# 📂 Estrutura do Projeto

O projeto seguirá a seguinte organização:

```bash
ansible-desafio-turma-p1/
├── ansible.cfg
├── inventory/
│   ├── aws_ec2.yaml  # Inventário dinâmico AWS
├── group_vars/
│   ├── all.yml       # Variáveis globais
│   ├── webservers.yml  # Variáveis para os Web Servers
│   ├── database.yml  # Variáveis para os Bancos de Dados
│   ├── vault.yml     # Variáveis secretas protegidas (Ansible Vault)
├── playbook.yml
├── roles/
│   ├── webserver/
│   │   ├── tasks/
│   │   │   ├── main.yml
│   │   │   ├── install.yml
│   │   │   ├── config.yml
│   │   ├── templates/
│   │   │   ├── nginx.conf.j2
│   │   │   ├── index.html.j2
│   │   ├── vars/
│   │   │   ├── main.yml
│   │   ├── handlers/
│   │   │   ├── main.yml
│   ├── database/
│   │   ├── tasks/
│   │   │   ├── main.yml
│   │   │   ├── install.yml
│   │   │   ├── setup.yml
│   │   ├── vars/
│   │   │   ├── main.yml
│   │   ├── handlers/
│   │   │   ├── main.yml
├── .github/
│   ├── workflows/
│   │   ├── provision-aws.yml
├── .gitlab-ci.yml     # Pipeline do GitLab CI/CD 🚀
```

# 1. Configuração do Ansible

Arquivo ansible.cfg:
```ini
[defaults]
inventory = inventory/aws_ec2.yaml
host_key_checking = False
log_path = ansible.log
retry_files_enabled = False

[ssh_connection]
pipelining = True
```

## Explicação
- inventory = inventory/aws_ec2.yaml → Define o inventário dinâmico como padrão;  
- host_key_checking = False → Evita prompts de confirmação SSH;  
- log_path = ansible.log → Habilita logs de execução;  
- pipelining = True → Otimiza a execução das tarefas.  

# 2. Criando a Instância EC2 (Playbook create-ec2.yml)
Arquivo create-ec2.yml:
```yaml
---
- name: Criar uma instância EC2 na AWS
  hosts: localhost
  gather_facts: no
  tasks:
    - name: Criar uma instância EC2
      amazon.aws.ec2_instance:
        name: "ansible-ci-instance"
        key_name: "{{ aws_key_name }}"
        instance_type: t2.micro
        security_group: "{{ security_group }}"
        region: us-east-1
        image_id: "{{ ami_id }}"
        count: 1
        vpc_subnet_id: "{{ subnet_id }}"
        wait: yes
        tags:
          Role: webserver
          Environment: ci
      register: ec2_instance

    - name: Exibir IP público da instância
      debug:
        msg: "A instância EC2 foi criada com o IP: {{ ec2_instance.instances[0].public_ip_address }}"

    - name: Criar arquivo de inventário dinâmico
      copy:
        content: |
          [webservers]
          {{ ec2_instance.instances[0].public_ip_address }} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/minha-chave.pem
        dest: inventory/aws_hosts.ini
```

## Explicação
- Criamos a instância EC2 e salvamos o IP público  
- Geramos um inventário dinâmico (aws_hosts.ini) para configurar a VM depois  

# x. Configuração do Inventário Dinâmico

Arquivo inventory/aws_ec2.yaml
```yaml
plugin: amazon.aws.aws_ec2
regions:
  - us-east-1
filters:
  instance-state-name: running
keyed_groups:
  - key: tags.Role
    prefix: tag_Role_
compose:
  ansible_host: private_ip_address
```

## Explicação
- Agrupa as instâncias automaticamente pela tag Role (tag_Role_webserver e tag_Role_database);  
- Usa o IP privado para comunicação entre instâncias.

### Testando o Inventário
```bash
ansible-inventory -i inventory/aws_ec2.yaml --graph
```

# 3. Configuração de Variáveis

Arquivo group_vars/all.yml (Variáveis globais):
```yaml
ansible_ssh_user: ubuntu
ansible_ssh_private_key_file: ~/.ssh/minha-chave.pem
```

Arquivo group_vars/webservers.yml (Web Server):
```yaml
server_name: "meu-webserver.com"
nginx_port: 80
document_root: "/var/www/html"
```

Arquivo group_vars/database.yml (Banco de Dados):
```yaml
db_user: "admin"
db_password: "{{ vault_db_password }}"
```

Arquivo group_vars/vault.yml (Protegido com Ansible Vault):
```yaml
vault_db_password: "p@rangaricuTirimirruar0"
```

Protegendo com Vault:
```bash
ansible-vault encrypt group_vars/vault.yml
```

# 4. Criando a Role do Web Server

Arquivo roles/webserver/tasks/main.yml:
```yaml
---
- include_tasks: install.yml
- include_tasks: config.yml
```

Arquivo roles/webserver/tasks/install.yml:
```yaml
---
- name: Instalar Nginx e PHP
  apt:
    name:
      - nginx
      - php-fpm
    state: present
    update_cache: yes
```

Arquivo roles/webserver/tasks/config.yml:
```yaml
---
- name: Criar diretório do site
  file:
    path: "{{ document_root }}"
    state: directory
    owner: www-data
    group: www-data
    mode: '0755'

- name: Configurar Nginx
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/sites-available/default
  notify: Restart Nginx

- name: Criar página de exemplo
  template:
    src: index.html.j2
    dest: "{{ document_root }}/index.html"
    owner: www-data
    group: www-data
    mode: '0644'
```

Arquivo roles/webserver/handlers/main.yml:
```yaml
---
- name: Restart Nginx
  service:
    name: nginx
    state: restarted
```

Arquivo roles/webserver/templates/nginx.conf.j2:
```jinja
server {
    listen {{ nginx_port }};
    server_name {{ server_name }};

    root {{ document_root }};
    index index.html index.php;
}
```

Arquivo roles/webserver/templates/index.html.j2:
```html
<html>
    <head><title>{{ server_name }}</title></head>
    <body>
        <h1>Bem-vindo ao {{ server_name }}!</h1>
    </body>
</html>
```

# 5. Criando a Role do Banco de Dados

Arquivo roles/database/tasks/main.yml:
```yaml
---
- include_tasks: install.yml
- include_tasks: setup.yml
```

Arquivo roles/database/tasks/install.yml:
```yaml
---
- name: Instalar MySQL
  apt:
    name: mysql-server
    state: present
    update_cache: yes
```

Arquivo roles/database/tasks/setup.yml:
```yaml
---
- name: Criar usuário no MySQL
  mysql_user:
    name: "{{ db_user }}"
    password: "{{ db_password }}"
    priv: '*.*:ALL'
    state: present
  no_log: true
```

# 6. Criando o Playbook Mestre

Arquivo playbook.yml:
```yaml
---
- name: Provisionar Web Server
  hosts: tag_Role_webserver
  become: yes
  roles:
    - webserver

- name: Provisionar Banco de Dados
  hosts: tag_Role_database
  become: yes
  roles:
    - database
```

# x. Criando o Pipeline CI/CD no GitHub Actions
Arquivo .github/workflows/provision-aws.yml:
```yaml
name: Provisionar AWS com Ansible

on:
  push:
    branches:
      - main

jobs:
  provision:
    runs-on: ubuntu-latest
    steps:
      - name: 📥 Clonar repositório
        uses: actions/checkout@v3

      - name: 🔧 Instalar Ansible e Dependências
        run: |
          sudo apt update
          sudo apt install -y ansible python3-boto3 python3-botocore

      - name: 🔑 Configurar credenciais AWS
        run: |
          mkdir -p ~/.aws
          echo "[default]" > ~/.aws/credentials
          echo "aws_access_key_id=${{ secrets.AWS_ACCESS_KEY_ID }}" >> ~/.aws/credentials
          echo "aws_secret_access_key=${{ secrets.AWS_SECRET_ACCESS_KEY }}" >> ~/.aws/credentials
          echo "[default]" > ~/.aws/config
          echo "region = us-east-1" >> ~/.aws/config

      - name: 🚀 Criar Instância EC2 na AWS
        run: ansible-playbook -i localhost, create-ec2.yml

      - name: 🕒 Aguardar 60 segundos para inicialização
        run: sleep 60

      - name: 🔄 Configurar Servidores Web e Banco de Dados
        run: ansible-playbook -i inventory/aws_hosts.ini playbook.yml --ask-vault-pass
```

## x.x Adicionando Credenciais no GitHub
1. Vá para Settings → Secrets and Variables → Actions  
2. Adicione:  
- AWS_ACCESS_KEY_ID  
- AWS_SECRET_ACCESS_KEY  
- VAULT_PASSWORD (caso use Ansible Vault)  

# 7. Executando o Playbook

Rodando com Vault:
```bash
ansible-playbook -i inventory/aws_ec2.yaml playbook.yml --ask-vault-pass
```

Testando apenas Web Server:
```bash
ansible-playbook -i inventory/aws_ec2.yaml playbook.yml --limit tag_Role_webserver
```

# 🎯 Conclusão

- Estruturamos um projeto completo do Ansible;  
- Criamos um inventário dinâmico para AWS;  
- Separação de roles para Web e Banco de Dados;  
- Templates dinâmicos para Nginx e HTML;  
- Uso de Ansible Vault para senhas seguras.
