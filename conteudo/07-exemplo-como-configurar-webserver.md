# Módulo 07 - Handlers, Roles e Collections

## Configurando servidores web

```yaml
---
- name: Configurar servidores web
 hosts: webservers
 become: yes
 tasks:
   - name: Instalar Nginx
     apt:
       name: nginx
       state: present

   - name: Copiar configuração do Nginx
     template:
       src: nginx.conf.j2
       dest: /etc/nginx/nginx.conf
     notify: Reiniciar Nginx

 handlers:
   - name: Reiniciar Nginx
     service:
       name: nginx
       state: restarted
```
