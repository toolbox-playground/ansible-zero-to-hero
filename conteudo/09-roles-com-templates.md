Exemplo
# Configuração do servidor {{ inventory_hostname }}
# Gerado por Ansible em {{ ansible_date_time.iso8601 }}

server {
    listen {{ nginx_port | default(80) }};
    server_name {{ server_name }};

    root {{ document_root | default('/var/www/html') }};
    index {{ index_files | default(['index.html', 'index.htm']) | join(' ') }};

    {% if access_log_enabled | default(true) %}
    access_log {{ access_log_path | default('/var/log/nginx/access.log') }};
    {% endif %}

    {% if error_log_enabled | default(true) %}
    error_log {{ error_log_path | default('/var/log/nginx/error.log') }};
    {% endif %}
}
