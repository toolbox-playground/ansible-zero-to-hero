# Instalação do Ansible no Ubuntu

Siga este guia passo a passo para instalar o Ansible no seu sistema Ubuntu.

---

## Pré-requisitos

1. **Certifique-se de que seu sistema está atualizado:**
   - Abra um terminal e execute:
     ```bash
     sudo apt update && sudo apt upgrade -y
     ```

2. **Verifique a instalação do Python:**
   - Verifique se o Python está instalado:
     ```bash
     python3 --version
     ```
   - Caso o Python não esteja instalado, instale com:
     ```bash
     sudo apt install python3 -y
     ```

3. **Instale o `pip` (gerenciador de pacotes do Python):**
   ```bash
   sudo apt install python3-pip -y
   ```

---

## Instalando o Ansible

1. **Adicione o repositório PPA do Ansible:**
   ```bash
   sudo apt-add-repository --yes --update ppa:ansible/ansible
   ```

2. **Instale o Ansible:**
   ```bash
   sudo apt install ansible -y
   ```

3. **Verifique a instalação:**
   - Confira a versão do Ansible para garantir que foi instalado corretamente:
     ```bash
     ansible --version
     ```

---

## Configurando o Ansible

1. **Edite o arquivo de configuração do Ansible:**
   - Abra o arquivo de configuração para edição:
     ```bash
     sudo nano /etc/ansible/ansible.cfg
     ```
   - Modifique as configurações conforme necessário (por exemplo, caminho do arquivo de inventário, configurações de SSH).

2. **Configure seu arquivo de inventário:**
   - O arquivo de inventário padrão está localizado em `/etc/ansible/hosts`.
   - Adicione seus nós gerenciados (por exemplo, servidores) neste arquivo:
     ```
     [webservers]
     192.168.1.10
     192.168.1.11

     [databases]
     192.168.1.20
     ```

3. **Teste a conexão do Ansible:**
   - Use o módulo `ping` para testar a conectividade com seus nós:
     ```bash
     ansible all -m ping -i /etc/ansible/hosts
     ```

---

## Notas Adicionais

- **Documentação:** Consulte a [documentação oficial do Ansible](https://docs.ansible.com/) para mais detalhes e configurações avançadas.
- **Atualizando o Ansible:** Para manter o Ansible atualizado, execute regularmente:
  ```bash
  sudo apt update && sudo apt upgrade -y
  ```
- **Desinstalando o Ansible:** Caso precise remover o Ansible:
  ```bash
  sudo apt remove ansible -y
  ```

---