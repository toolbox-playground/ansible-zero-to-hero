## Ansible Console
O ansible-console é uma ferramenta interativa que permite executar múltiplos comandos ad hoc em uma sessão persistente.


### Características:
- Fornece um shell interativo para executar comandos Ansible  
- Mantém o contexto entre comandos (inventário, conexões)  
- Útil para testes e depuração 

### Uso básico

Iniciar o console:

```bash
ansible-console
```

Obs.: Executando o comando dessa forma, ele irá carregar apenas o localhost como máquina alvo. Caso queira que mais máquinas estejam disponíveis, é necessário informar o arquivo de inventário com os grupos e servidores.

Alguns comandos úteis:

#### Listar servidores disponíveis
```bash
list
```

#### Listar grupos de servidores disponíveis
```bash
list group
```

#### Rodar comandos com privilégios elevados
```bash
become true
```

#### Instalando pacote Python3-pip no servidor
```bash
ansible.builtin.apt name=python3-pip
```

### Vantagens

- Reduz a sobrecarga de estabelecer conexões repetidamente  
- Permite exploração interativa do ambiente Ansible  
- Facilita a execução de sequências de comandos relacionados  
- Tanto os comandos ad hoc quanto o ansible-console são ferramentas poderosas para administradores de sistemas e desenvolvedores, permitindo rápida execução de tarefas e exploração de ambientes gerenciados pelo Ansible.  
