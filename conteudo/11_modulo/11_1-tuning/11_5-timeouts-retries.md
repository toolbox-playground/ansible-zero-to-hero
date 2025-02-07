# 🚀 Otimize Timeouts e Retries no Ansible  
*Evite atrasos em hosts lentos ou instáveis ajustando tempos de espera e número de tentativas.*

## 📌 O Problema
Por padrão, o Ansible usa **timeouts longos** e **não tenta reconectar-se automaticamente** quando um host falha momentaneamente. Isso pode ser problemático quando:

- Você tem **hosts remotos com alta latência**.
- Há **perda intermitente de conexão** com servidores.
- O Ansible **demora para falhar** em hosts que não respondem.

✅ A solução é **ajustar os timeouts e o número de tentativas (retries)**!

## 1. Configurando Timeouts para Conexão SSH
Se um host demorar para responder, podemos **reduzir o tempo de espera** para evitar que a execução fique travada.

📄 **Edite o `ansible.cfg`**
```ini
[defaults]
timeout = 30  # Tempo máximo de espera para conexão (padrão é 10s)

[ssh_connection]
connect_timeout = 15  # Tempo de espera para conexão SSH (padrão é 10s)
```

**Explicação:**
- timeout = 30 → Define um tempo máximo global antes do Ansible desistir.  
- connect_timeout = 15 → Define o tempo máximo de espera para estabelecer a conexão SSH.

Importante lembrar:  
- Se seus hosts forem lentos, aumente o connect_timeout;  
- Se quiser que falhem mais rápido, reduza o valor.

## 2. Definindo Número de Tentativas (retries)

Se um host falhar temporariamente, podemos fazer o Ansible tentar novamente antes de desistir.

✅ Retry por Playbook

Podemos usar retries para tentar novamente tarefas que falham:

Exemplo de Playbook com Retries:
```yaml
- name: Instalar pacotes em servidores instáveis
  hosts: all
  gather_facts: no
  become: yes

  tasks:
    - name: Instalar pacote Nginx com retries
      apt:
        name: nginx
        state: present
      register: resultado
      retries: 5  # 🔥 Tenta novamente até 5 vezes
      delay: 10   # 🔥 Espera 10 segundos entre cada tentativa
      until: resultado eh successo  # Continua tentando até funcionar
```

**Explicação**
- retries: 5 → O Ansible tentará a tarefa até 5 vezes;  
- delay: 10 → Espera 10 segundos entre cada tentativa;  
- until: resultado is success → A tarefa só para quando for bem-sucedida.  

## 3. Configurar Tempo de Espera para Tarefas (async e poll)

Se uma tarefa demora muito (exemplo: reiniciar um serviço ou instalar um grande pacote), o Ansible pode não esperar tempo suficiente antes de falhar.

Exemplo de uso de async e poll:
```yaml
- name: Atualizar sistema com tempo máximo de espera
  hosts: all
  become: yes

  tasks:
    - name: Atualizar pacotes (tempo máximo 600s)
      apt:
        update_cache: yes
        upgrade: dist
      async: 600  # 🔥 Tempo máximo permitido para execução (10 minutos)
      poll: 10  # 🔥 Verifica o status a cada 10 segundos
```

**Explicação**
**- async: 600 →** Permite que a tarefa rode por até 10 minutos antes de falhar.
**- poll: 10 →** O Ansible verifica a cada 10 segundos se a tarefa terminou.

Ideal para tarefas demoradas, como atualizações de sistema ou deploys grandes.

## 4. Configurar Timeout de Reconexão (retries para conexão)

Se o host ficar offline momentaneamente, podemos fazer o Ansible tentar reconectar antes de desistir.

📄 Edite o ansible.cfg:
```ini
[ssh_connection]
retries = 3  # 🔥 Tenta reconectar até 3 vezes antes de falhar
```

Se os servidores forem instáveis, aumente retries para 5 ou mais.

# 🎯 Conclusão

- Ajuste timeout e connect_timeout para evitar travamentos em hosts lentos;  
- Use retries e delay para evitar falhas temporárias;  
- Use async e poll para tarefas demoradas;  
- Configure retries no SSH para melhorar reconexões automáticas.  

