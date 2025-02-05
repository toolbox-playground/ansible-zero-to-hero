# Módulo 09 - Ansible Templates

## Exemplo completo

```yaml
Exemplo
---
- name: Configurar Servidores Web
  hosts: all
  become: yes

  tasks:
    - name: Atualizar pacotes
      apt:
        update_cache: yes
      tags: 
        - always

    - name: Instalar Nginx
      apt:
        name: nginx
        state: present
      tags:
        - nginx
        - install

    - name: Configurar Nginx
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/nginx.conf
      tags:
        - nginx
        - config

    - name: Instalar PHP
      apt:
        name: php-fpm
        state: present
      tags:
        - php
        - install

    - name: Configurar PHP
      template:
        src: php.ini.j2
        dest: /etc/php/7.4/fpm/php.ini
      tags:
        - php
        - config
```
