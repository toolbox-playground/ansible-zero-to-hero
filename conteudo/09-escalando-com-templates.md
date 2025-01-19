- name: Configurar servidores web
  hosts: webservers
  vars:
    nginx_port: 80
    document_root: /var/www/html
  tasks:
    - name: Aplicar configuração Nginx
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/nginx.conf
      notify: Restart Nginx

  handlers:
    - name: Restart Nginx
      service:
        name: nginx
        state: restarted

