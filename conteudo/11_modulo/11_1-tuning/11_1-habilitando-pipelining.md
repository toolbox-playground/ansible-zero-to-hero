# 🚀 Habilitando o Pipelining no Ansible

O pipelining no Ansible melhora o desempenho ao reduzir a quantidade de conexões SSH feitas para cada comando. Em vez de copiar temporariamente os módulos para o servidor remoto antes da execução, o Ansible os transmite diretamente via STDIN. Isso pode acelerar a execução de playbooks, especialmente em redes de baixa latência.

## Como Ativar o Pipelining no Ansible

Você pode habilitar o pipelining de duas formas:

### 1. Habilitar no arquivo ansible.cfg

No seu arquivo ansible.cfg, adicione ou edite a seguinte linha:

```ini
[ssh_connection]
pipelining = True
```

Isso garante que o pipelining está ativado em todas as execuções do Ansible.

### 2. Ativar via variável de ambiente

Se você não quiser alterar o ansible.cfg, pode ativá-lo temporariamente definindo a variável de ambiente antes de rodar o playbook:

```bash
ANSIBLE_PIPELINING=True ansible-playbook -i meu_playbook.yaml
```

#  Importante: O Pipelining Exige requiretty Desativado

O pipelining só funciona corretamente se o requiretty estiver desativado no sudoers.

Verificar e Corrigir requiretty

Se o seu servidor requer sudo, edite o arquivo sudoers e desative requiretty:
```bash
sudo visudo
```

Procure por:
```
Defaults requiretty
```

E comente a linha (ou remova):
```bash
# Defaults requiretty
```

Isso evita problemas com sudo ao usar pipelining.

# 🛠 Como Testar se o Pipelining Está Funcionando?

Depois de ativar, você pode verificar se ele está funcionando corretamente com debug:

```bash
ansible all -i aws_ec2.yaml -m ping -vvv
```

Se o pipelining estiver ativado, você verá menos conexões SSH sendo estabelecidas, tornando a execução mais rápida.

# 🎯 Benefícios do Pipelining

✅ Reduz o número de conexões SSH para cada tarefa
✅ Acelera a execução de playbooks, especialmente em redes mais lentas
✅ Pode reduzir o uso de CPU em servidores remotos
