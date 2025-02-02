## Ansible ad hoc/ansible-console

### Comandos Ad Hoc

Comandos ad hoc são tarefas únicas executadas rapidamente sem a necessidade de criar um playbook completo. São ideais para operações simples e rápidas.

### Características:
Executados diretamente na linha de comando
Úteis para tarefas simples e não repetitivas
Servem como uma introdução prática ao Ansible

Sintaxe básica:

bash
ansible [padrão_de_hosts] -m [módulo] -a "[argumentos_do_módulo]"

Exemplos:
Verificar conectividade:

bash
ansible all -m ping
Coletar informações do sistema:

bash
ansible webservers -m setup
Instalar um pacote:

bash
ansible webservers -m apt -a "name=nginx state=present" --become
Reiniciar serviços:

bash
ansible webservers -m service -a "name=nginx state=restarted" --become
