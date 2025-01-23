# 📚 Instalação do Ansible Usando Python
Este guia descreve como instalar o Ansible usando o Python em qualquer sistema operacional que tenha Python 3.x instalado.

## ⚠️ Pré-requisitos
- Python 3.8+
- Pip (Gerenciador de pacotes do Python)
Verifique se ambos estão instalados:
```
python --version
pip --version
```

## 🐍 Instalando o Ansible com Python
### 1. Atualize o Pip
Antes de instalar, atualize o pip para garantir que você tenha a versão mais recente:
```
python -m pip install --upgrade pip
```

### 2. Instale o Ansible Usando Pip
Instalação Global (Recomendado para ambientes de produção)
```
pip install ansible
```
Em caso de erro por path, execute:
```
pip install ansible --prefix "C:\PythonLibs"
```

### Instalação em um Ambiente Virtual (Recomendado para desenvolvimento)
Crie um ambiente virtual:
```
python -m venv ansible-env
```

Linux/MacOS:
```
source ansible-env/bin/activate
```

Windows:
```
.\ansible-env\Scripts\activate
```

### Instale o Ansible no ambiente virtual:
```
pip install ansible
```

### 3. Verifique a Instalação
Após a instalação, verifique se o Ansible foi instalado corretamente:

```
ansible --version
```

### 🧹 Desinstalando o Ansible
Se precisar desinstalar o Ansible:

```
pip uninstall ansible
```

Se estiver usando um ambiente virtual, basta desativá-lo:
```
deactivate
```

```
rm -rf ansible-env
```