# Módulo 12 - Publicando Roles no GitLab

## Publicando Roles no GitLab
O GitLab é uma excelente plataforma para hospedar, versionar e compartilhar suas roles do Ansible. Vamos explorar como publicar e gerenciar roles no GitLab.

## Preparando sua Role para Publicação
1. Estrutura da Role
```
minha_role/
├── defaults/
├── handlers/
├── meta/
├── tasks/
├── templates/
├── tests/
├── vars/
└── README.md
```

2. Arquivo meta/main.yml:
```yaml
galaxy_info:
  author: Seu Nome
  description: Descrição da sua role
  company: Sua Empresa (opcional)
  license: license (GPL-2.0-or-later, MIT, etc)
  min_ansible_version: 2.9
  platforms:
    - name: Ubuntu
      versions:
        - all
```

## Criando um Repositório no GitLab
1. Acesse o GitLab e crie um novo projeto
2. Escolha um nome significativo (ex: ansible-role-nginx)
3. Inicialize com um README se desejar

## Publicando sua Role
Inicialize o Git na sua role local:
```bash
cd minha_role
git init
```

Adicione o repositório remoto:
```bash
git remote add origin git@gitlab.com:seu-usuario/ansible-role-nginx.git
```

Adicione, comite e envie os arquivos:
```bash
git add .
git commit -m "Versão inicial da role"
git push -u origin master
```

## Versionamento
1. Use tags para versões:
```bash
git tag -a v1.0.0 -m "Primeira versão"
git push origin v1.0.0
```
2. Mantenha um CHANGELOG.md atualizado

## CI/CD no GitLab
Crie um arquivo .gitlab-ci.yml:
```yaml
---
image: python:3.9

before_script:
  - pip install ansible molecule docker

stages:
  - test

molecule:
  stage: test
  script:
    - cd ansible-role-nginx
    - molecule test
```

2. Este pipeline executará testes Molecule automaticamente a cada push

## Sincronização com Ansible Galaxy
No Ansible Galaxy, vá para "My Content" > "Add Content"
Escolha "Import from GitLab"
Selecione seu repositório
Configure a sincronização automática

## Boas Práticas
Mantenha a documentação atualizada no README.md
Use branches para desenvolvimento (ex: develop, feature/nova-funcionalidade)
Revise e teste cuidadosamente antes de criar novas tags/versões
Responda a issues e pull requests de forma ativa
Publicar suas roles no GitLab não só facilita o versionamento e colaboração, mas também permite integração contínua e distribuição automática através do Ansible Galaxy.
