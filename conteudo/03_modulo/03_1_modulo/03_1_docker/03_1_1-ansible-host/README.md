# Usando o Ansible via Imagem Docker

Este guia fornece instruções sobre como usar o Ansible via uma imagem Docker para tarefas de gerenciamento de configuração e automação.

## Pré-requisitos

- Docker instalado na sua máquina ([Instalar Docker](https://docs.docker.com/get-docker/))
- Conhecimento básico de Ansible
- Uma conexão de internet funcional

## Baixando a Imagem Docker

Baixe a imagem oficial do Ansible Docker:

```bash
docker pull alpine/ansible
```

## Executando o Contêiner Docker do Ansible

Você pode executar o contêiner Docker do Ansible interativamente para executar comandos ou playbooks. Aqui está como fazer:

### Em Sistemas Unix/Linux/MacOS

```bash
docker network create ansible-net
docker run --rm -it --network ansible-net -v $(pwd):/workspace alpine/ansible bash
```

### Em Sistemas Windows (PowerShell)

```bash
docker network create ansible-net
docker run --rm -it --network ansible-net -v ${PWD}:/workspace alpine/ansible bash 
```

- `--rm`: Remove o contêiner após ele sair.
- `-it`: Executa o contêiner em modo interativo.
- `-v $(pwd):/workspace`: Monta o diretório atual em `/workspace` dentro do contêiner.

## Diretório de Trabalho

Por padrão, seu diretório atual é montado em `/workspace` dentro do contêiner. Você pode colocar seus playbooks, arquivos de inventário e configurações do Ansible nesse diretório para usá-los dentro do contêiner.

## Testando sua conexão SSH
Criando chave ssh

```
ssh-keygen -t rsa -b 4096 -C "seu_email@exemplo.com"
ssh-copy-id usuario@host_remoto
```

Execute os comandos, dentro da pasta workspace

```
apk update && apk add openssh-keygen
chmod 600 id_rsa.pub
ssh -i id_rsa seu_user@IP_EXTERNO
```
## Executando um Playbook Ansible

Para executar um playbook do Ansible, siga estas etapas:

1. Coloque seu playbook (`playbook.yml`) e arquivo de inventário (`inventory.ini`) no diretório atual.
2. Execute o seguinte comando:

   ```bash
   docker run --rm -it -v $(pwd):/workspace ansible/ansible:latest ansible-playbook -i /workspace/inventory.ini /workspace/playbook.yml
   ```

## Instalando Dependências Adicionais

Se seus playbooks exigirem pacotes Python ou dependências de sistema adicionais, você pode instalá-los no contêiner em execução. Por exemplo:

```bash
docker run --rm -it -v $(pwd):/workspace alpine/ansible:latest bash

# Dentro do contêiner:
pip install <nome-do-pacote>
```

Para tornar essas mudanças persistentes, pode ser necessário criar uma imagem Docker personalizada com suas dependências adicionais. Aqui está um exemplo de Dockerfile:

```Dockerfile
FROM alpine/ansible:latest
RUN pip install <nome-do-pacote>
```

Construa e use a imagem personalizada:

```bash
docker build -t custom-ansible .
docker run --rm -it -v $(pwd):/workspace custom-ansible bash
```

## Comandos Comuns

### Verificar Versão do Ansible

```bash
ansible --version
```

### Testar Conectividade

```bash
ansible -i /workspace/inventory.ini all -m ping
```

### Executar Comando Ad-Hoc

```bash=
ansible all -m file -a "path={{ dir_path }} state=directory" -e "dir_path=/usr/test" -i inventory.ini
```

## Limpando

Como o contêiner é executado com `--rm`, ele será automaticamente limpo após sair. 

## Solução de Problemas

- Certifique-se de que os caminhos do inventário e do playbook estão corretos.
- Se houver problemas de permissão, tente usar `sudo` ao executar comandos Docker.

Para mais assistência, consulte a [documentação do Ansible](https://docs.ansible.com/) ou a [documentação do Docker](https://docs.docker.com/).