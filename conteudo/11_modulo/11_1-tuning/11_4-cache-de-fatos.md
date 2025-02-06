# Aproveitando o Cache de Fatos no Ansible para Melhor Desempenho

O cache de fatos no Ansible permite evitar coletar informações repetidamente, acelerando execuções consecutivas de playbooks.

## O Problema
- Por padrão, toda vez que você executa um playbook com gather_facts: yes, o Ansible recoleta todos os fatos do sistema remoto;  
- Para muitos hosts, isso desperdiça tempo e aumenta a carga da rede e CPU.

## A Solução: Cache de Fatos (fact_caching)

O Ansible pode armazenar os fatos coletados e reutilizá-los em execuções futuras, evitando repetir o processo desnecessariamente.

1. Como Ativar o Cache de Fatos no ansible.cfg

Você pode configurar o caching de fatos no seu arquivo ansible.cfg.

Exemplo de configuração (ansible.cfg):
```ini
[defaults]
gathering = smart
fact_caching = jsonfile  # Define o formato do cache
fact_caching_connection = /tmp/ansible_facts  # Define onde salvar os fatos
fact_caching_timeout = 3600  # Tempo de expiração do cache (3600s = 1 hora)
````

**Explicação das opções**
- gathering = smart → O Ansible só coleta novos fatos se não houver cache;  
- fact_caching = jsonfile → Usa um arquivo JSON como armazenamento;  
- fact_caching_connection = /tmp/ansible_facts → Define o diretório onde os fatos serão armazenados;  
- fact_caching_timeout = 3600 → O cache será válido por 1 hora.  

2. Usando o Cache de Fatos no Playbook

Depois de ativar o cache, seu playbook não precisará mais coletar os fatos a cada execução.

Playbook aproveitando cache:
```yaml
- name: Exemplo de Playbook com Cache de Fatos
  hosts: all
  gather_facts: yes  # Ele vai pegar do cache, se disponível

  tasks:
    - name: Mostrar a versão do sistema operacional
      debug:
        msg: "Este servidor está rodando {{ ansible_distribution }} {{ ansible_distribution_version }}"
```

Resultado: Se o cache estiver ativado, a segunda execução será muito mais rápida!

3. Limpando o Cache de Fatos (se necessário)

Se precisar limpar e forçar uma nova coleta de fatos, use:
```bash
ansible all -i aws_ec2.yaml -m setup --flush-cache
```

Isso remove o cache e força uma nova coleta.

4. Outras Opções de Cache no Ansible

O Ansible suporta múltiplos backends para armazenamento de cache:
|:---------:|:-----------------------------------------------------:|
|Backend    |Descrição                                              |
|jsonfile   |Salva fatos em arquivos JSON locais (recomendado)      |
|memory     |Armazena fatos apenas na memória RAM (não persiste)    |
|redis      |Usa um servidor Redis para armazenar fatos             |
|yaml       |Salva fatos em formato YAML                            |


Exemplo para usar Redis como backend:
```ini
[defaults]
fact_caching = redis
fact_caching_connection = localhost:6379:0
fact_caching_timeout = 86400  # 1 dia de cache
```
# 🎯 Benefícios do Cache de Fatos

- Evita coleta desnecessária, acelerando execuções consecutivas;  
- Reduz carga na rede e no servidor remoto;  
- Melhora a eficiência em ambientes grandes;  
- Configuração simples e flexível.  
