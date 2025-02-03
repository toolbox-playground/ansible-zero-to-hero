### Simulação de Máquinas com Docker e Uso do Ansible

1. Configurar o Inventário do Ansible

Crie um arquivo de inventário chamado inventory.ini com as informações dos contêineres:

[machines]
machine1 ansible_host=machine1 ansible_port=2222 ansible_user=root ansible_password=password
machine2 ansible_host=machine2 ansible_port=3333 ansible_user=root ansible_password=password

3. Testar Conectividade

Antes de executar um playbook, teste a conectividade com as máquinas usando o módulo ping do Ansible:

ansible -i inventory.ini machines -m ping

Se estiver tudo configurado corretamente, você verá uma resposta do tipo pong.

4. Criar e Executar um Playbook

Crie um playbook de teste chamado playbook.yml:

- name: Test playbook
  hosts: machines
  tasks:
    - name: Atualizar e fazer upgrade dos pacotes
      apt:
        update_cache: yes
        upgrade: dist

Execute o playbook com o comando:

```
 ansible all -m ping -i inventory.yml
 ansible-playbook -i inventory.ini playbook.yml
```

5. Limpeza (Opcional)

Pare e remova os contêineres quando não forem mais necessários:

```
docker stop machine1 machine2
docker rm machine1 machine2
```
