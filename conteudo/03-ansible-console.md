Ansible Console
O ansible-console é uma ferramenta interativa que permite executar múltiplos comandos ad hoc em uma sessão persistente.
Características:
Fornece um shell interativo para executar comandos Ansible
Mantém o contexto entre comandos (inventário, conexões)
Útil para testes e depuração
Uso básico:
Iniciar o console:

bash
ansible-console
Executar comandos dentro do console:
text
webservers.example.com | BECOME» apt name=nginx state=present
webservers.example.com | BECOME» service name=nginx state=started

Vantagens:
Reduz a sobrecarga de estabelecer conexões repetidamente
Permite exploração interativa do ambiente Ansible
Facilita a execução de sequências de comandos relacionados
Tanto os comandos ad hoc quanto o ansible-console são ferramentas poderosas para administradores de sistemas e desenvolvedores, permitindo rápida execução de tarefas e exploração de ambientes gerenciados pelo Ansible.
