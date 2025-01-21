# Módulo 08 - Ansible Galaxy

## Comandos Essenciais do Ansible Galaxy

# Instalar uma role
$ ansible-galaxy install nome_da_role

# Inicializar uma nova role
$ ansible-galaxy init nome_da_nova_role

# Listar roles instaladas
$ ansible-galaxy list

# Instalar múltiplas roles de um arquivo requirements.yml
$ ansible-galaxy install -r requirements.yml

# Buscar roles no Galaxy
$ ansible-galaxy search <palavra_chave>

# Exibir informações sobre uma role específica
$ ansible-galaxy info nome_da_role

# Remover uma role instalada
$ ansible-galaxy remove nome_da_role

# Instalar uma coleção
$ ansible-galaxy collection install nome_da_colecao

# Listar coleções instaladas
$ ansible-galaxy collection list

# Atualizar uma coleção
$ ansible-galaxy collection install nome_da_colecao --upgrade
