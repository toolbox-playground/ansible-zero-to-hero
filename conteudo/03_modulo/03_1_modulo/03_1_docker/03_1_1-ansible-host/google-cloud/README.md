# Criação de Conta no Google Cloud Platform (GCP)

Este documento fornece um guia passo a passo para criar uma nova conta no Google Cloud Platform (GCP). Siga estas instruções para configurar sua conta e começar a usar os serviços do GCP.

## Pré-requisitos
Antes de começar, certifique-se de ter:
    - Um endereço de e-mail válido (de preferência uma conta Gmail para uma configuração mais rápida).

Passos para Criar uma Conta no GCP
### 1. Acesse o Site do GCP

Abra um navegador da web e acesse a página inicial do Google Cloud Platform.
Clique no botão "Comece gratuitamente".

### 2. Faça login na sua Conta Google

Se você ainda não estiver conectado a uma Conta Google, será solicitado que faça login ou crie uma nova conta Google.
Insira seu endereço de e-mail e senha.
Complete qualquer verificação de segurança adicional, se solicitado.

### 3. Configure sua Conta do GCP

Após fazer login, você será redirecionado para a página de configuração da conta GCP.
Preencha os detalhes necessários:
    - Tipo de Conta: Selecione "Individual" ou "Empresa" dependendo do seu caso de uso.
    - País: Escolha seu país de residência.
    - Informações Tributárias: Se aplicável, insira as informações tributárias necessárias.

Clique em "Próximo" para continuar.

### 4. Adicione Informações de Cobrança

Insira um método de pagamento válido (cartão de crédito ou débito).
O GCP usa essas informações para verificação de identidade e para habilitar serviços.
Nota: Você não será cobrado imediatamente; o GCP oferece uma camada gratuita com $300 em créditos para novos usuários.
Revise os termos e condições e aceite-os.
Clique em "Iniciar meu período gratuito" para concluir a configuração de cobrança.

### 4. Acesse o projeto

Acesse o projeto para que você criou.

### Configurando o SSH

# 🚀 Configurando SSH para uma VM no Google Cloud (Windows)

Se você está tentando conectar a uma VM do **Google Cloud** via **SSH no Windows** e recebeu o erro **"Permission denied (publickey)"**, siga este guia para corrigir o problema.

---

## 📌 1. Gerar uma Chave SSH no Windows

Se você ainda não tem uma chave SSH, gere uma nova usando **PowerShell**:

```powershell
ssh-keygen -t rsa -b 2048 -f C:\workspace\id_rsa -C "seu_email@gmail.com"
```

## 2. Adicionar a Chave SSH à VM no Google Cloud

```
$publicKey = Get-Content -Raw "C:\workspace\id_rsa.pub"
gcloud compute instances add-metadata instance-20250202-235554 --zone=us-central1-c --metadata "ssh-keys=seu_usuario:$publicKey"
```

## 3. Verificar se a Chave SSH foi Adicionada
Para garantir que a chave foi salva corretamente na VM, execute:

```
gcloud compute instances describe instance-20250202-235554 --zone=us-central1-c --format="value(metadata.ssh-keys)"
```

## 4 Conectar-se à VM via SSH

Agora, conecte-se à VM usando o SSH:

```
ssh -i C:\workspace\id_rsa seu_usuario@IP_EXTERNO
