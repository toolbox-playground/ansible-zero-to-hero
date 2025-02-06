# Usando o Modo de Coleta de Fatos Mínimo no Ansible para Melhor Desempenho

Por padrão, o Ansible executa “gathering facts” no início de cada playbook. Isso coleta informações detalhadas sobre o sistema remoto (como IPs, distribuição do SO, CPU, memória, etc.).

## Problema
- A coleta completa dos fatos (facts) pode ser demorada, especialmente em muitos hosts;  
- Em alguns casos, você não precisa de todas as informações, apenas de algumas específicas.

## Solução
- Podemos otimizar a coleta de fatos, reduzindo o tempo de execução do playbook!  

# Como Usar o Modo de Coleta de Fatos Mínimo

Existem três maneiras de otimizar a coleta de fatos no Ansible:

1. Desativar a Coleta de Fatos Totalmente (gather_facts: no)

Se o seu playbook não precisa de facts, desative a coleta para economizar tempo:

Playbook otimizado (sem coleta de fatos)
```yaml
- name: Playbook sem coleta de fatos
  hosts: all
  gather_facts: no  # 🔥 Desativa a coleta de fatos para melhorar o desempenho

  tasks:
    - name: Criar um diretório
      file:
        path: /opt/minha-app
        state: directory
```

**Quando usar?**
- Quando você não precisa de nenhuma informação sobre o sistema remoto;  
- Quando as tarefas do playbook não dependem de facts (ansible_os_family, ansible_hostname, etc.).  

2. Usar a Coleta de Fatos Parcial (gather_subset)

Se você precisa de algumas informações, mas não todas, pode coletar apenas um subconjunto de facts.

Exemplo de coleta mínima:
```yaml
- name: Playbook com coleta de fatos mínima
  hosts: all
  gather_facts: yes
  gather_subset:
    - min  # 🔥 Apenas coleta os fatos essenciais

  tasks:
    - name: Mostrar o nome do host
      debug:
        msg: "Este servidor é {{ ansible_hostname }}"
```

Grupos de coleta disponíveis (gather_subset)
|:---------:|:-------------------------------------------------:|
|all        |Todos os fatos (padrão)                            |
|min        |Fatos essenciais (hostname, SO básico, arquitetura)|
|hardware   |CPU, memória, discos                               |
|network    |Interfaces de rede                                 |
|virtual    |Se é uma VM, LXC ou físico                         |

Exemplo: Coletar apenas informações de rede e SO:
```yaml
gather_subset:
  - min
  - network
```

3. Armazenar Fatos em Cache para Reutilização (fact_caching)

Se você precisa de facts, mas quer evitar coletá-los repetidamente, pode armazená-los em cache.

Ativar cache no ansible.cfg
```ini
[defaults]
fact_caching = jsonfile
fact_caching_connection = /tmp/ansible_facts
fact_caching_timeout = 3600  # Mantém os fatos por 1 hora
```

Isso significa que, ao rodar o playbook uma vez, os fatos ficam armazenados e não precisam ser coletados novamente por 1 hora.

# Benefícios do Modo de Coleta Mínimo

- Reduz o tempo de execução do playbook  
- Evita informações desnecessárias, focando apenas no que você precisa  
- Otimiza a execução em grandes ambientes

##  Teste de Tempo (com e sem otimização)
```bash
time ansible-playbook -i aws_ec2.yaml meu_playbook.yaml  # Padrão (lento)
time ansible-playbook -i aws_ec2.yaml meu_playbook.yaml --limit 10 --forks 20  # Mais rápido!
```

# 🎯 Conclusão

- Se seu playbook não precisa de facts, desative (gather_facts: no);  
- Se precisa de algumas informações, use gather_subset para coletar só o necessário;  
- Se for rodar o playbook várias vezes, use cache (fact_caching).  