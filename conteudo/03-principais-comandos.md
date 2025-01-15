# Módulo 03 - Instalação e Configuração

## Principais comandos do Ansible

### Mostrar versão do Ansible e suas dependências
```bash
ansible --version
```

### Consumindo Aplicações instaladas no cliente
```bash
ansible -a "/bin/echo hi" localhost
```

### Ping no localhost
```bash
ansible -m ping localhost
```

### Checar status de um endereço externo
```bash
ansible localhost
```

### Além de checar o status, também retorna o conteúdo da página
```bash
ansible
```

### Testando com timeout de 10 segundos
```bash
ansible X
```
