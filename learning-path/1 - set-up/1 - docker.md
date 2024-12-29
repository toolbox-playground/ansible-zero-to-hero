🐳 Instalação e Uso do Ansible com Docker
Este guia explica como usar o Ansible dentro de um container Docker para evitar problemas de dependências ou compatibilidade com o sistema operacional.

📚 Índice
⚠️ Pré-requisitos
🐳 Usando Ansible com Docker
📂 Montando Volumes para Playbooks
🚀 Executando Playbooks com Ansible Docker
✅ Testando o Ansible Docker
🛠️ Comandos Úteis
📚 Recursos Adicionais
⚠️ Pré-requisitos
Antes de iniciar, certifique-se de ter:

Docker instalado:
Guia de Instalação do Docker

Playbook Ansible preparado (opcional).

Permissões de Administrador/Root (se necessário).

Verifique se o Docker está instalado corretamente:

bash
Copiar código
docker --version
🐳 Usando Ansible com Docker
O Ansible pode ser executado diretamente em um container Docker sem precisar instalá-lo no host.

Baixe a imagem oficial do Ansible:
bash
Copiar código
docker pull ghcr.io/ansible/ansible-runner:latest
Crie um contêiner com Ansible:
bash
Copiar código
docker run -it --rm ghcr.io/ansible/ansible-runner:latest bash
📂 Montando Volumes para Playbooks
Para executar seus playbooks Ansible locais, você precisa montá-los como volume no contêiner:

bash
Copiar código
docker run -it --rm \
  -v $(pwd)/playbooks:/playbooks \
  ghcr.io/ansible/ansible-runner:latest bash
Explicação dos parâmetros:

-v $(pwd)/playbooks:/playbooks: Monta a pasta playbooks do diretório atual no contêiner.
--rm: Remove o contêiner após a execução.
-it: Executa o contêiner no modo interativo.
🚀 Executando Playbooks com Ansible Docker
Dentro do contêiner Docker, navegue até o diretório montado:
bash
Copiar código
cd /playbooks
Execute o playbook:
bash
Copiar código
ansible-playbook exemplo.yml -i inventario.ini
Exemplo Completo (executar diretamente do host):
bash
Copiar código
docker run -it --rm \
  -v $(pwd)/playbooks:/playbooks \
  ghcr.io/ansible/ansible-runner:latest \
  ansible-playbook /playbooks/exemplo.yml -i /playbooks/inventario.ini
✅ Testando o Ansible Docker
Para validar a configuração, execute o seguinte comando:

bash
Copiar código
docker run -it --rm ghcr.io/ansible/ansible-runner:latest ansible --version
Você verá uma saída semelhante a:

text
Copiar código
ansible [core 2.x.x]
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.x/site-packages/ansible
  executable location = /usr/bin/ansible
🛠️ Comandos Úteis
Listar Inventário:

bash
Copiar código
ansible -i inventario.ini --list-hosts all
Testar Conexão com Hosts:

bash
Copiar código
ansible -i inventario.ini all -m ping
Executar Comando Ad-Hoc:

bash
Copiar código
ansible -i inventario.ini all -m shell -a "uptime"
Acessar o Contêiner Interativamente:

bash
Copiar código
docker run -it --rm ghcr.io/ansible/ansible-runner:latest bash