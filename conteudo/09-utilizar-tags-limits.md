Tags permitem executar ou pular partes específicas de um playbook.

# Definindo tags:
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
