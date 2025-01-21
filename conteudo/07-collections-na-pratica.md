# Módulo 07 - Handlers, Roles e Collections

## Usando Collection na prática

```yaml
---
- hosts: all
  collections:
    - my_namespace.my_collection
  tasks:
    - name: Use a module from the collection
      my_module:
        option1: value1
```
