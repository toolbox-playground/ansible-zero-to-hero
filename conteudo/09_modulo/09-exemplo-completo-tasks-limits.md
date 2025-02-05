# Módulo 09 - Ansible Tags

```yaml
---
tasks:
  - name: Instalar Nginx
    apt:
      name: nginx
      state: present
    tags: 
      - nginx
      - webserver

  - name: Configurar Nginx
    template:
      src: nginx.conf.j2
      dest: /etc/nginx/nginx.conf
    tags:
      - nginx
      - config
```

Executando as tarefas:
```bash
ansible-playbook playbook.yml --tags "nginx,config"
```

Pulando tarefas com tags especificas
```bash
ansible-playbook playbook.yml --skip-tags "database"
```

Listando todas as tags em um playbook
```bash
ansible-playbook playbook.yml --list-tags
```
