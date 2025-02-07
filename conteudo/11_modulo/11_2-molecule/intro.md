# Molecule no Ansible: Testando Playbooks e Roles de Forma Automatizada

O Molecule é uma ferramenta poderosa para testar e validar playbooks e roles do Ansible. Ele permite rodar testes automatizados, garantindo que suas automações funcionem corretamente antes de serem aplicadas em produção.

## O Que é o Molecule?
O Molecule ajuda a desenvolver, testar e validar roles e playbooks do Ansible.  
Suporta múltiplos drivers para criar ambientes de teste, como:  
- Docker (mais comum para testes rápidos)  
- Vagrant (para VMs locais)  
- AWS EC2  
- Podman, Libvirt, Azure, GCP e mais.  

## Benefícios do Molecule
- Permite testes unitários e funcionais para playbooks/roles;  
- Testa a idempotência do Ansible (se rodar duas vezes, o resultado deve ser o mesmo);  
- Detecta erros antes da execução em produção;  
- Integra-se com CI/CD para automação de testes.  

1. Instalando o Molecule

Antes de usar o Molecule, instale as dependências:
```bash
pip install ansible molecule molecule-docker docker
```

Verifique se a instalação foi bem-sucedida:
```bash
molecule --version
```

2. Criando um Projeto Molecule

Podemos iniciar um projeto Molecule para testar uma role do Ansible.
```bash
molecule init role minha_role --driver-name docker
```

Isso cria a seguinte estrutura:
```
minha_role/
├── molecule/
│   └── default/
│       ├── converge.yml   # Playbook principal para testes
│       ├── molecule.yml   # Configuração do Molecule
│       ├── prepare.yml    # Configuração prévia dos hosts
│       ├── verify.yml     # Testes adicionais (opcional)
│       └── tests/         # Testes adicionais (opcional)
├── tasks/
│   ├── main.yml           # Código principal da Role
├── meta/
│   ├── main.yml           # Metadados da Role
```

3. Configurando o Molecule (molecule.yml)

Exemplo de configuração (molecule/default/molecule.yml):
```yaml
---
driver:
  name: docker

platforms:
  - name: ubuntu
    image: "geerlingguy/docker-ubuntu2204-ansible"
    privileged: true
    command: ""
    volumes:
      - "/sys/fs/cgroup:/sys/fs/cgroup:ro"
      
provisioner:
  name: ansible
  log: true

verifier:
  name: ansible
```

**Explicação**
- driver: docker → Usa Docker para os testes;  
- platforms → Define quais máquinas de teste serão criadas;  
- provisioner: ansible → O Ansible será usado para configurar os servidores de teste;  
- verifier: ansible → O Ansible verificará se os testes passaram.  

4. Criando um Teste no Molecule

O Molecule usa o arquivo converge.yml para testar a role.

Edite molecule/default/converge.yml:
```yaml
---
- name: Testar minha role
  hosts: all
  become: yes
  roles:
    - minha_role  # 🔥 Testamos a role dentro do Molecule
```

Agora, edite a role para fazer algo simples, como instalar o Nginx:

Edite tasks/main.yml:
```yaml
---
- name: Instalar Nginx
  apt:
    name: nginx
    state: present
    update_cache: yes
```

5. Executando os Testes

Agora, podemos rodar o pipeline completo do Molecule:
```bash
molecule test
```

Isso faz o seguinte:
1. Criar os containers (molecule create)  
2. Executar o playbook de testes (molecule converge)  
3. Testar a idempotência (molecule idempotence)  
4. Rodar testes adicionais (caso existam) (molecule verify)  
5. Destruir os containers no final (molecule destroy)  

Se preferir rodar os testes passo a passo, use:
```bash
molecule create      # Cria o ambiente
molecule converge    # Executa a role dentro do ambiente
molecule idempotence # Testa se a role é idempotente
molecule verify      # Verifica se os testes passaram
molecule destroy     # Remove o ambiente
```

6. Criando Testes Automatizados no Molecule

Podemos adicionar testes automatizados para validar a role.

Edite molecule/default/verify.yml:
```yaml
---
- name: Verificar se o Nginx está rodando
  hosts: all
  tasks:
    - name: Verifica se o serviço do Nginx está ativo
      command: systemctl is-active nginx
      register: nginx_status
      changed_when: false
      failed_when: "'inactive' in nginx_status.stdout"

    - name: Mostrar status do Nginx
      debug:
        msg: "Nginx está rodando corretamente!"
```

Agora, quando rodamos molecule test, ele verifica se o Nginx está ativo.

# 🎯 Conclusão

- O Molecule é uma ferramenta poderosa para testar roles e playbooks do Ansible;  
- Permite rodar testes automatizados antes de aplicar mudanças na infraestrutura;  
- Usa Docker (ou outras plataformas) para simular ambientes reais;  
- Pode ser integrado com CI/CD (GitHub Actions, GitLab, Jenkins, etc.).  
