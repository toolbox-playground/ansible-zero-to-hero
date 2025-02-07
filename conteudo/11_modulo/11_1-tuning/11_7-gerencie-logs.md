# Gerencie Logs de Forma Inteligente no Ansible

Controle o detalhamento dos logs para focar no que realmente importa e economizar recursos.

## O Problema

Por padrão, o Ansible não armazena logs automaticamente.
Além disso, quando ativado, o log pode ser muito detalhado e ocupar espaço desnecessário, especialmente em execuções frequentes.

Solução: Configurar logs de forma eficiente para manter apenas as informações relevantes e evitar desperdício de espaço e recursos.

## 1. Ativar Logs no Ansible (ansible.cfg)

Se quiser armazenar logs de execução, edite o arquivo ansible.cfg e adicione:
```ini
[defaults]
log_path = /var/log/ansible.log  # 🔥 Define onde os logs serão salvos
log_format = yaml  # 🔥 Formato de log (json, yaml ou logstash)
```

Explicação
- log_path = /var/log/ansible.log → Define um arquivo para armazenar logs;  
- log_format = yaml → Usa um formato estruturado (pode ser json, logstash ou yaml).  

Importante: Certifique-se de que o Ansible tem permissão de escrita no diretório onde o log será salvo:
```bash
sudo touch /var/log/ansible.log
sudo chmod 666 /var/log/ansible.log  # Permite escrita
```

## 2. Controlar o Detalhamento dos Logs (verbosity)

O Ansible permite ajustar a quantidade de informações nos logs usando níveis de verbosidade:
```bash
ansible-playbook -i aws_ec2.yaml meu_playbook.yaml -v   # Verbose (nível 1)
ansible-playbook -i aws_ec2.yaml meu_playbook.yaml -vv  # Verbose (nível 2)
ansible-playbook -i aws_ec2.yaml meu_playbook.yaml -vvv # Muito detalhado (nível 3)
```

## Níveis de Verbosidade
|Opção  |Detalhamento                   |
|:-----:|:-----------------------------:|
|-v     |Erros e tarefas executadas     |
|-vv    |Logs detalhados                |
|-vvv   |Depuração avançada             |
|-vvvv  |Logs completos de conexão SSH  |

Quando usar?
-v para capturar informações essenciais.  
-vv ou -vvv apenas para debug de problemas.  

## 3. Registrar Logs Somente de Tarefas Específicas

Se não quiser gerar logs para tudo, mas apenas para tarefas críticas, use o módulo debug:

Exemplo de Playbook:
```yaml
- name: Configuração de Servidor
  hosts: all
  gather_facts: no

  tasks:
    - name: Instalar pacotes essenciais
      apt:
        name: nginx
        state: present

    - name: Registrar logs somente para esta etapa
      debug:
        msg: "Pacotes instalados com sucesso no servidor {{ ansible_hostname }}"
      when: ansible_distribution == "Ubuntu"
```

Isso reduz a quantidade de logs desnecessários e foca no que importa!

## 4. Evitar Logs Sensíveis (no_log: true)

Se você estiver armazenando logs, evite que dados sensíveis fiquem registrados.

Exemplo de Playbook com no_log:
```yaml
- name: Criar usuário com senha oculta nos logs
  hosts: all
  become: yes

  tasks:
    - name: Criar usuário admin
      user:
        name: admin
        password: "{{ 'SenhaSuperSecreta' | password_hash('sha512') }}"
      no_log: true  # 🔥 Evita que a senha apareça nos logs
```

Por que usar no_log: true?

- Evita que senhas e dados sensíveis sejam registrados;  
- Melhora a segurança dos logs em ambientes críticos.  

## 5. Redirecionar Logs para Monitoramento

Se você usa ELK (Elasticsearch, Logstash, Kibana), Grafana ou outro sistema de logs, pode redirecionar os logs para um servidor remoto.

Exemplo de configuração (ansible.cfg) para envio ao Logstash:
```ini
[defaults]
log_path = /var/log/ansible.log
log_format = json  # 🔥 Gera logs no formato JSON para integração com ELK
```

Agora você pode visualizar os logs do Ansible em dashboards e alertas!

# 🎯 Conclusão

- Ative logs em um arquivo específico (log_path);  
- Controle o nível de detalhamento (verbosity) para evitar logs desnecessários;  
- Registre logs apenas para tarefas importantes (debug);  
- Proteja informações sensíveis nos logs (no_log: true);  
- Redirecione logs para ferramentas de monitoramento (ELK, Grafana, etc.).

