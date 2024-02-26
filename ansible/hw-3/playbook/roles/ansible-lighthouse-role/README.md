Role Name
=========

Role installs lighthouse

Requirements
------------

ansible >= 2.10

Role Variables
--------------

| Name              | Default Value                                                       | Description                    |
|-------------------|---------------------------------------------------------------------|--------------------------------|
| lighthouse_dir | "/var/www/lighthouse" | Installation directory |
| lighthouse_error_log | "lighthouse_error" | Nginx error log filename |
| lighthouse_access_log | "lighthouse_access" | Nginx access log filename |

Dependencies
------------

No dependencies

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - ansible-lighthouse-role

License
-------

MIT

Author Information
------------------

Kutukov Alexey
