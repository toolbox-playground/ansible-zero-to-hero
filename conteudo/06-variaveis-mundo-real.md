# Módulo 06 - Trabalhando com Variáveis

```yaml
- name: Configurar servidor web
  hosts: webservers
  vars_files:
    - vars/main.yml
  tasks:
    - name: Configurar porta HTTP
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/nginx.conf
      vars:
        listen_port: "{{ http_port }}"
```
