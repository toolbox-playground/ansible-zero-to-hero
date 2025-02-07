# O que são “Forks” no Ansible?

Os forks determinam quantos hosts o Ansible pode gerenciar simultaneamente dentro de um playbook.
- Valor padrão: forks = 5  
- Se o valor for maior: O Ansible executa mais hosts em paralelo  
- Se o valor for muito alto: Pode sobrecarregar a máquina de controle (seu computador).  

# Como Aumentar os Forks no Ansible

Existem três maneiras principais de alterar o número de forks.

## 1. Configurar no ansible.cfg

A maneira mais persistente de aumentar o número de forks é no arquivo de configuração do Ansible.

Edite o ansible.cfg e adicione a seguinte configuração:
```ini
[defaults]
forks = 20  # Altere para um número maior conforme necessário
```

Isso define o número padrão de forks para todas as execuções do Ansible.

## 2. Definir Forks na Linha de Comando  

Se quiser alterar o número de forks apenas para uma execução específica, adicione -f ou --forks ao comando:

```bash
ansible-playbook -i meu_playbook.yaml --forks 20
```

*Isso sobrescreve o valor definido no ansible.cfg.*

## 3. Usar uma Variável de Ambiente  

Outra opção é definir os forks como uma variável de ambiente:
```bash
export ANSIBLE_FORKS=20
```

Depois, execute o playbook normalmente:
```bash
ansible-playbook -i meu_playbook.yaml
```

Isso aplica o novo limite de forks sem modificar arquivos de configuração.

# ⚠️ Qual o Valor Ideal para Forks?

O valor ideal de forks depende do seu ambiente:
- 5-10 forks → Pequenos ambientes (~10 hosts)  
- 20-50 forks → Ambientes médios (~50-100 hosts)  
- 100+ forks → Ambientes muito grandes (~500 hosts ou mais).  

## Atenção:
- Se os forks forem muito altos, sua máquina de controle pode ficar sobrecarregada;  
- Se os servidores gerenciados forem fracos, pode gerar alta carga nos hosts remotos;  
- Faça testes incrementais para encontrar o equilíbrio ideal no seu ambiente.  

# Como Testar o Impacto do Aumento de Forks?

Você pode medir o tempo de execução do seu playbook antes e depois de alterar os forks:

Antes (5 forks - padrão)
```bash
time ansible-playbook -i aws_ec2.yaml meu_playbook.yaml
```

Depois (20 forks):
```bash
time ansible-playbook -i aws_ec2.yaml meu_playbook.yaml --forks 20
```

Compare os tempos e veja se há melhora no desempenho!

# 🎯 Conclusão

- Aumentar os forks melhora o paralelismo e reduz o tempo de execução;  
- Três formas de configurar forks: ansible.cfg, linha de comando ou variável de ambiente;  
- Encontre o valor ideal testando diferentes números de forks no seu ambiente.