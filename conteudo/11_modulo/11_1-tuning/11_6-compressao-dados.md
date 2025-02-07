# Compressão de Dados SSH no Ansible

Habilite a compressão para transferir arquivos grandes mais rapidamente!

## O Problema

Quando o Ansible executa tarefas que envolvem transferência de arquivos, como:
- Copiar arquivos grandes com copy ou synchronize  
- Enviar templates para servidores remotos  
- Fazer deploys que envolvem múltiplos arquivos  

O tempo de execução pode ser alto devido ao tamanho dos arquivos e velocidade da rede.  

Solução: Habilitar a compressão SSH para reduzir o volume de dados transferidos e acelerar execuções.

### 1. Como Habilitar a Compressão no Ansible (ansible.cfg)

A maneira mais eficiente e persistente de ativar a compressão SSH é no arquivo ansible.cfg.

Edite o ansible.cfg e adicione a seguinte configuração:
```ini
[ssh_connection]
compression = yes  # 🔥 Habilita compressão SSH
```

Explicação
- compression = yes → Ativa a compressão Gzip no SSH, reduzindo o tamanho dos arquivos enviados e recebidos.  

### 2. Ativar a Compressão via Linha de Comando

Se você não quiser modificar o ansible.cfg, pode ativar a compressão temporariamente ao rodar um playbook:
```bash
ANSIBLE_SSH_ARGS="-C" ansible-playbook -i aws_ec2.yaml meu_playbook.yaml
```

Ou para rodar um comando ad-hoc:
```bash
ANSIBLE_SSH_ARGS="-C" ansible all -i aws_ec2.yaml -m ping
```

Explicação  
- -C → Habilita a compressão SSH para aquela execução específica.  

### 3. Configurar Compressão no SSH Globalmente (~/.ssh/config)

Outra abordagem é ativar a compressão diretamente no SSH para todas as conexões Ansible.

Edite o arquivo ~/.ssh/config:
```ini
Host *
    Compression yes
```

Isso ativa a compressão para todas as conexões SSH, incluindo as usadas pelo Ansible.

### 4. Exemplo de Uso: Copiando Arquivos Grandes com Compressão

Se você estiver usando módulos como copy ou synchronize, a compressão pode acelerar a transferência.

Exemplo de Playbook:
```yaml
- name: Copiar arquivo grande com compressão SSH ativada
  hosts: all
  tasks:
    - name: Transferir um arquivo grande para o servidor remoto
      copy:
        src: /home/user/arquivo_grande.tar.gz
        dest: /tmp/arquivo_grande.tar.gz
        mode: '0644'
```

Se a compressão SSH estiver ativada (compression = yes), o tempo de transferência será menor!

# 🎯 Benefícios da Compressão SSH

- Reduz o volume de dados transferidos → Especialmente útil para arquivos grandes;  
- Melhora a performance em redes lentas → Útil para conexões com alta latência;  
- Fácil de configurar → Pode ser ativado via ansible.cfg, linha de comando ou SSH global.  
