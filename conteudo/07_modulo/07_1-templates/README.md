## Executando o Contêiner Docker do Ansible

Você pode executar o contêiner Docker do Ansible interativamente para executar comandos ou playbooks. Aqui está como fazer:

### Em Sistemas Unix/Linux/MacOS

```bash
docker network create ansible-net
docker run --rm -it --network ansible-net -v $(pwd):/workspace ansible/ansible bash
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

## Executando um Playbook Ansible

Para executar um playbook do Ansible, siga estas etapas:

1. Coloque seu playbook (`playbook.yml`) e arquivo de inventário (`inventory.ini`) no diretório atual.
2. Execute o seguinte comando:

   ```bash
   docker run --rm -it -v $(pwd):/workspace ansible/ansible:latest ansible-playbook -i /workspace/inventory.ini /workspace/playbook.yml
   ```

   ### Simulação de Máquinas com Docker e Uso do Ansible

1. Configurar o Inventário do Ansible

Crie um arquivo de inventário chamado inventory.ini com as informações dos contêineres:

[machines]
machine1 ansible_host=machine1 ansible_port=2222 ansible_user=root ansible_password=password
machine2 ansible_host=machine2 ansible_port=3333 ansible_user=root ansible_password=password

3. Testar Conectividade

Antes de executar um playbook, teste a conectividade com as máquinas usando o módulo ping do Ansible:

Se estiver tudo configurado corretamente, você verá uma resposta do tipo pong.

4. Executar o template

ansible -i inventory.ini machines -m setup --tree facts


5. Limpeza (Opcional)

Pare e remova os contêineres quando não forem mais necessários:

```
docker stop machine1 machine2
docker rm machine1 machine2
```

jq . /facts/machine1 > formatted_machine1.json
