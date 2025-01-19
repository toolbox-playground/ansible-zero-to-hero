# Role Balancer (HAProxy)
## tasks/main.yml?

- name: Instalar HAProxy
  apt:
    name: haproxy
    state: present

- name: Configurar HAProxy
  template:
    src: haproxy.cfg.j2
    dest: /etc/haproxy/haproxy.cfg
  notify: Reiniciar HAProxy

- name: Garantir que HAProxy está rodando
  service:
    name: haproxy
    state: started
    enabled: yes

## templates/haproxy.cfg.j2:

frontend http_front
  bind *:80
  default_backend http_back

backend http_back
  balance roundrobin
  {% for host in groups['webservers'] %}
  server {{ host }} {{ hostvars[host]['ansible_host'] }}:80 check
  {% endfor %}



# Role Web-server (Apache)
## tasks/main.yml:

- name: Instalar Apache
  apt:
    name: apache2
    state: present

- name: Copiar página de teste
  template:
    src: index.html.j2
    dest: /var/www/html/index.html

- name: Garantir que Apache está rodando
  service:
    name: apache2
    state: started
    enabled: yes


## templates/index.html.j2:

<h1>Bem-vindo ao servidor {{ ansible_hostname }}</h1>
<p>Este é um servidor web gerenciado pelo Ansible.</p>



Usando as roles

# No seu playbook principal:

- hosts: balancers
  roles:
    - balancer

- hosts: webservers
  roles:
    - web-server



