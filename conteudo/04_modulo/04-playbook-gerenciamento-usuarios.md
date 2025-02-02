# Módulo 04 - Ansible Playbooks

```yaml
---
- name: Gerenciar usuários
  hosts: all
  become: yes
  vars:
    novos_usuarios:
      - nome: alice
        grupo: desenvolvedores
      - nome: bob
        grupo: operacoes
  tasks:
    - name: Criar grupos
      group:
        name: "{{ item }}"
        state: present
      loop:
        - desenvolvedores
        - operacoes

    - name: Criar usuários
      user:
        name: "{{ item.nome }}"
        groups: "{{ item.grupo }}"
        state: present
      loop: "{{ novos_usuarios }}"
```
