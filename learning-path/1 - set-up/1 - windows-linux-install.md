Instalação do Ansible no Windows e Linux
Este documento descreve como instalar o Ansible em sistemas Windows e Linux.

⚠️ Pré-requisitos
Acesso root ou permissões de administrador.
Python 3.8+ (para Linux).
WSL2 (Windows Subsystem for Linux) para Windows.
🐧 Instalação no Linux
Distribuições Baseadas em Debian/Ubuntu
Atualize os pacotes:

bash
Copiar código
sudo apt update
sudo apt upgrade -y
Instale dependências:

bash
Copiar código
sudo apt install -y software-properties-common python3 python3-pip
Adicione o repositório do Ansible:

bash
Copiar código
sudo add-apt-repository --yes --update ppa:ansible/ansible
Instale o Ansible:

bash
Copiar código
sudo apt install -y ansible
Verifique a instalação:

bash
Copiar código
ansible --version
Distribuições Baseadas em RHEL/CentOS
Atualize os pacotes:

bash
Copiar código
sudo yum update -y
Instale dependências:

bash
Copiar código
sudo yum install -y epel-release
sudo yum install -y python3 python3-pip
Instale o Ansible:

bash
Copiar código
sudo yum install -y ansible
Verifique a instalação:

bash
Copiar código
ansible --version
🪟 Instalação no Windows
O Ansible não é nativamente suportado no Windows, mas pode ser usado através do WSL2 ou em uma máquina virtual Linux.

Método 1: WSL2 (Windows Subsystem for Linux)
Habilite o WSL2 no Windows (caso ainda não esteja habilitado):

powershell
Copiar código
wsl --install
Reinicie o computador.

Instale uma distribuição Linux (ex: Ubuntu) na Microsoft Store.

Abra o terminal WSL e siga os passos da instalação no Linux (acima).

Verifique a instalação:

bash
Copiar código
ansible --version
Método 2: Máquina Virtual Linux (VirtualBox ou Hyper-V)
Instale uma máquina virtual com uma distribuição Linux.
Siga os passos para Instalação no Linux mencionados acima.
📁 Configuração Inicial
Crie um inventário Ansible:

bash
Copiar código
sudo nano /etc/ansible/hosts
Adicione hosts de exemplo:

text
Copiar código
[servidores]
servidor1 ansible_host=192.168.1.10 ansible_user=usuario ansible_ssh_private_key_file=/caminho/chave.pem
Teste a configuração:

bash
Copiar código
ansible all -m ping
✅ Verificação da Instalação
Execute o comando abaixo para garantir que tudo está funcionando corretamente:

bash
Copiar código
ansible --version
🛠️ Desinstalação
Linux (Ubuntu/Debian)
bash
Copiar código
sudo apt remove --purge ansible -y
Linux (RHEL/CentOS)
bash
Copiar código
sudo yum remove ansible -y
Windows (WSL2)
powershell
Copiar código
wsl --unregister <nome_da_distro>
📖 Documentação Oficial
Ansible Documentation
WSL Documentation