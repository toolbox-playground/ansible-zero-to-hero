# Módulo 01 - Nivelamento

## Arquivos YAML

```yaml
---
# Nome do playbook
- name: Configuração de um Servidor Web Apache
  hosts: webservers
  become: true  # Elevar privilégios para sudo
  vars:
    apache_packages:
      - apache2  # Pacote para Debian/Ubuntu
  tasks:
    # Atualizar pacotes no servidor
    - name: Atualizar o cache de pacotes
      apt:
        update_cache: yes
        
    # Instalar o Apache
    - name: Instalar o Apache
      apt:
        name: "{{ apache_packages }}"
        state: present
        
    # Iniciar e habilitar o serviço do Apache
    - name: Garantir que o Apache está ativo e habilitado
      service:
        name: apache2
        state: started
        enabled: yes
        
    # Configurar página inicial personalizada
    - name: Criar página inicial do Apache
      copy:
        dest: /var/www/html/index.html
        content: |
          <html>
          <head><title>Bem-vindo</title></head>
          <body>
            <h1>Servidor Apache configurado pelo Ansible!</h1>
          </body>
          </html>
      notify: Reiniciar Apache

  handlers:
    - name: Reiniciar Apache
      service:
        name: apache2
        state: restarted
```
