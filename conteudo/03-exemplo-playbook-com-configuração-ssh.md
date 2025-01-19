Exemplo de Playbook com Configuração SSH

```yaml
- hosts: webservers
  vars:
    ansible_ssh_private_key_file: "~/.ssh/id_rsa"
    ansible_user: admin
  tasks:
    - name: Testar conexão
      ping:
```

