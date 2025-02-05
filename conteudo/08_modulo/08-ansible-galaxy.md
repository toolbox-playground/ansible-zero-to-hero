# Módulo 08 - Ansible Galaxy

## Comandos Essenciais do Ansible Galaxy

# Instalar uma role
```bash
ansible-galaxy install nome_da_role
```

# Inicializar uma nova role
```bash
ansible-galaxy init nome_da_nova_role
```

# Listar roles instaladas
```bash
ansible-galaxy list
```

# Instalar múltiplas roles de um arquivo requirements.yml
```bash
ansible-galaxy install -r requirements.yml
```

# Buscar roles no Galaxy
```bash
ansible-galaxy search <palavra_chave>
```

# Exibir informações sobre uma role específica
```bash
ansible-galaxy info nome_da_role
```

# Remover uma role instalada
```bash
ansible-galaxy remove nome_da_role
```

# Instalar uma coleção
```bash
ansible-galaxy collection install nome_da_colecao
```

# Listar coleções instaladas
```bash
ansible-galaxy collection list
```

# Atualizar uma coleção
```bash
ansible-galaxy collection install nome_da_colecao --upgrade
```
