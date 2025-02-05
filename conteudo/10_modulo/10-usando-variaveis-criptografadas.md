Usando variáveis criptografadas
# Criptografar uma string:
ansible-vault encrypt_string 'senha_secreta' --name 'db_password'

# Usar a variável criptografada em um playbook:
- name: Configurar banco de dados
  mysql_user:
    name: admin
    password: "{{ db_password }}"

# Executar um playbook com variáveis criptografadas:
ansible-playbook playbook.yml --ask-vault-pass


