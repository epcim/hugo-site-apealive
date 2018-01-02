+++
date = "2017-12-29T12:01:07+02:00"
draft = false
title = "Salt-Formulas updates"
tags = ["salt", "formulas"]
+++

Sum up all features on salt-formulas project (https://github.com/salt-formulas).
For the first, and only this time, for the whole year.

The most features comes from Mirantis and it's MCP product portfolio,
however the public participation in the past year was also important.


<!--more-->

As the I generated it, and as I have done only limited post-processing the content might contain
some formatting issues. Further reviews will come "seasonal" and hopefully better formatted.

If you are using salt-formulas, mind:

* we foked reclass (https://github.com/salt-formulas/reclass) version, especially check the "develop" branch
* there are many updates in salt-formulas doc at http://salt-formulas.readthedocs.io/en/latest
* there is saltclass ext_pillar in Salt merged, and I shared a system level for it (https://github.com/epcim/saltclass-system)


# Formula airflow


###  Michael Kutý


  Support storing logs on S3.


>	            remote:
>	              enabled: true
>	              directory: s3://tmp/logs/prd
>	              connection_id: db01
>	              encrypt: false


  Add ability to load connections and variables.


>	          variable:
>	            my_var:
>	              name: my_var_name
>	              value: TOKEN
>	              type: postgresql


  Split roles to worker and server.


>	        worker:
>	          enabled: true


  Add installation from source.


>	          source:
>	            engine: git
>	            address: https://github.com/apache/incubator-airflow.git
>	            rev: master       
>	            pipplugin:
>	              engine: pip
>	          connection:
>	            db01:
>	              name: db01
>	              host: localhost
>	              port: 1234
>	              user: username
>	              database: db_name
>	              password: password
>	              type: postgres
>	              extra:
>	                token: secret


  Split dags and plugins.


>	          dag:
>	            dagbag:
>	              engine: git
>	              address: git@gitlab.com:group/dags.git
>	              rev: master
>	          plugin:
>	            pack-one:


# Formula aodh


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Nadya Shakhat


  Add coordination support via Redis


  Aodh is an alarming service for OpenStack. It used to be a part of Ceilometer, but starting from Mitaka it
  is a separate project. Aodh supports several types of alarms like threshold, event, composite and gnocchi-specific.


  In cluster mode, coordination is enabled via tooz with Redis backend.  


  MySQL is used as a data backend for alarms and alarm history.


  Cluster aodh service


>	          version: mitaka
>	          ttl: 86400
>	          cluster: true 
>	        database:
>	          engine: "mysql+pymysql"
>	          host: 10.0.106.20
>	          port: 3306
>	          name: aodh
>	          user: aodh
>	          password: password
>	        bind:
>	          port: 8042
>	        identity:
>	          engine: keystone
>	          host: 10.0.106.20 
>	          port: 35357
>	          tenant: service
>	          password: password 
>	        message_queue:
>	          engine: rabbitmq
>	          port: 5672
>	          user: openstack
>	          virtual_host: '/openstack'
  * https://docs.openstack.org/cli-reference/aodh.html
  * https://docs.openstack.org/developer/aodh/


###  Petr Jediný


  Support for Ocata


  Parameterized configuration for Ocata


  Configure service under apache2


  Other changes:


>	    Relates-To: #PROD-10651 #PROD-10652
>	        cache:
>	          members:
>	          - host: 10.10.10.10
>	              port: 11211
>	          - host: 10.10.10.11
>	          - host: 10.10.10.12


# Formula apache


###  Aleš Komárek


  Update README.rst


  Apache Formula


  Sample Pillars


  Tuned up log configuration.


  More Information


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Simon Pasquier


  Add ability to configure the apache logs


  This change supports a new entry in the model to tune the configuration
  of the error and custom logs. If absent, it defaults to the same
  settings as before.


  Tune the log configuration:


>	      parameters:
>	        apache:
>	          server:
>	            site:
>	              foo:
>	                enabled: true
>	                type: static
>	                log:
>	                  custom:
>	                    enabled: true
>	                    file: /var/log/apache2/mylittleponysitecustom.log
>	                    format: >-
  %{X-Forwarded-For}i %l %u %t \"%r\" %>s %b %D \"%{Referer}i\" \"%{User-Agent}i\"


>	                  error:
>	                    enabled: false
>	                    file: /var/log/apache2/foo.error.log
>	                    level: notice


# Formula aptcacher


###  Damian Szeluga


  aptcacher renamed to apt_cacher_ng


>	      apt_cacher_ng:


  Fix readme


>	      aptcacher:
>	        server:
>	          enabled: true
>	          bind:
>	            address: 0.0.0.0
>	            port: 3142
>	          proxy: 'http://proxy-user:proxy-pass@proxy-host:9999'
>	          passthruurl:
>	            - 'repos.influxdata.com'
>	            - 'packagecloud.io'
>	            - 'packagecloud-repositories.s3.dualstack.us-west-1.amazonaws.com'
>	            - 'launchpad.net'
>	            - 'apt.dockerproject.org'
>	          passhthrupattern:
>	            - '\.key$'
>	            - '\.gpg$'
>	            - '\.pub$'
>	            - '\.jar$'


  Fix broken formula + add couple more features


  More advanced setup with Proxy and passthru patterns


>	  		aptcacher:
>	  			server:
>	  				enabled: true
>	  				bind:
>	  					address: 0.0.0.0
>	  					port: 3142
>	  				proxy: 'http://proxy-user:proxy-pass@proxy-host:9999'
>	  				passthruurl:
>	  					- 'repos.influxdata.com'
>	  					- 'packagecloud.io'
>	  					- 'packagecloud-repositories.s3.dualstack.us-west-1.amazonaws.com'
>	  					- 'launchpad.net'
>	  					- 'apt.dockerproject.org'
>	  				passhthrupattern:
>	  					- '\.key$'
>	  					- '\.gpg$'
>	  					- '\.pub$'
>	  					- '\.jar$'


###  Filip Pytloun


  Version 2017.3
  aptcacher


  * https://www.unix-ag.uni-kl.de/~bloch/acng/


###  Pavel Cizinsky


  init commit


  apt-cacher-ng


  Apt-Cacher NG is a caching HTTP proxy intended for use with download clients of system distribution's package managers.


  Sample pillars


  Single apt-cacher service


>	      apt-cacher:


  Read more


  * https://www.unix-ag.uni-kl.de/~bloch/acng/ 


# Formula aptly


###  Filip Pytloun


  Add support for defining s3/swift endpoints


  Define s3 endpoint:


>	      parameters:
>	        aptly:
>	          server:
>	            endpoint:
>	              mys3endpoint:
>	                engine: s3
>	                awsAccessKeyID: xxxx
>	                awsSecretAccessKey: xxxx
>	                bucket: test


  Unify Makefile, .gitignore and update readme


# Formula artifactory


###  Alexander Evseev


  Refactor configuration


  Repository configuration


  Sample pillar above shows basic repository configuration, but you can use any parameters
  described in https://www.jfrog.com/confluence/display/RTF/Repository+Configuration+JSON


  This module does direct map from pillar parameters to repository JSON description
  with two aliases for compatibility:


  * repo_type -> rclass
  * package_type -> packageType


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme
  * https://www.jfrog.com/confluence/display/RTF/Repository+Configuration+JSON


# Formula avinetworks


###  Richard Felkl


  added support for init scripts


>	          saltmaster_ip: 10.0.0.90


  fixed bugs with mitaka


>	          disk_format: qcow2


  Introduced Avinetworks Vantage formula draft


  Avinetworks formula


  Sample pillars


  Salt formula to setup Avi Networks LBaaS


>	      avinetworks:
>	        server:
>	          enabled: true
>	          identity: cloud1
>	          image_location: http://...
>	          public_network: INET1


>	        client:


  External links


>	  - https://kb.avinetworks.com/installing-avi-vantage-for-openstack-2/


# Formula backupninja


###  Ales Komarek


  Docfixes


  Backupninja formula


  Backupninja allows you to coordinate system backup by dropping a few simple
  configuration files into /etc/backup.d/. Most programs you might use for
  making backups don't have their own configuration file format.


  Backupninja provides a centralized way to configure and schedule many
  different backup utilities. It allows for secure, remote, incremental
  filesytem backup (via rdiff-backup), compressed incremental data, backup
  system and hardware info, encrypted remote backups (via duplicity), safe
  backup of MySQL/PostgreSQL databases, subversion or trac repositories, burn


  CD/DVDs or create ISOs, incremental rsync with hardlinking.


>	          key:
  client1.domain.com:


>	              key: ssh-key


  More information


###  Andrey


  Allow specifying local engine for client-side storage


  If backupninja backs up the database to the local storage
  there is no need to use any engine, no engine config file needs
  to be created.


  Backup client with local storage


>	      backupninja:
>	        client:
>	          enabled: true
>	          target:
>	            engine: local


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Jiri Broulik


  backup fixes


>	              enabled: true


# Formula barbican


###  Kirill Bespalov


  MySQL TLS support


  Add ability to use tls for database connections.


  PROD-15652


  In order to trust remote server's certificate during establishing tls
  connection the CA cert must be provided at client side. By default
  system wide installed CA certs are used. You can change this behavior
  by specifying cacert_file and cacert params (optional).


  See examples below:


>	  - **RabbitMQ**
>	  - **MySQL**


>	   barbican:
>	     server:
>	        database:
>	          ssl:
>	            enabled: True
>	            cacert: cert body if the cacert_file does not exists
>	            cacert_file: /etc/openstack/mysql-ca.pem


  RabbitMQ TLS support


  Add ability to use tls for messaging.


  PROD-15653


  Configuring TLS communications


  **RabbitMQ**


>	        message_queue:
>	          port: 5671
>	            cacert_file: /etc/openstack/rabbitmq-ca.pem


###  Oleg Iurchenko


  Add a feature to import DogTag root cert from Salt Mine


  This patch adds a posibility to export  DogTag root cert
  from Salt Mine


  There are few sources (engines) to define KRA admin cert:


  Engine #1: Define KRA admin cert by pillar.


  To define KRA admin cert by pillar need to define the following:


>	      barbican:
>	        server:
>	          dogtag_admin_cert:
>	            engine: manual
>	            key: |
  ... key data ...


  Engine #2: Receive DogTag cert from Salt Mine.


  DogTag formula sends KRA cert to dogtag_admin_cert mine function.


>	            engine: mine
>	            minion: ...name of minion which has installed DogTag..


  Engine #3: No operations.


  In case of some additional steps to install KRA certificate which
  are out of scope for the formula, the formula has 'noop' engine
  to perform no operations. If 'noop' engine is defined the formula will
  do nothing to install KRA admin cert.


>	            engine: noop


###  Petr Jediný


  Barbican/Dogtag plugin


>	              dogtag_port: 8443
>	              store_plugin: dogtag_crypto


  Lower sql_idle_timeout to 180s


  HAProxy has default timout 300s so we need to lower it bellow this limit
  by default.
  reconnects before MySQL can drop the connection. If you run MySQL with HAProxy
  you need to consider haproxy client/server timeout parameters.


>	            sql_idle_timeout: 180


  Allow configuration of sql_idle_timeout


  This helps to avoid `MySQL server has gone away` errors.


  MySQL server has gone away


  MySQL uses a default `wait_timeout` of 8 hours, after which it will drop
  idle connections. This can result in 'MySQL Gone Away' exceptions. If you
  notice this, you can lower `sql_idle_timeout` to ensure that SQLAlchemy
  reconnects before MySQL can drop the connection.


>	          enabled: true
>	          version: ocata
>	          database:
>	            engine: "mysql+pymysql"
>	            host: 10.0.106.20
>	            port: 3306
>	            name: barbican
>	            user: barbican
>	            password: password
>	            sql_idle_timeout: 1200


  Basic barbican configuration


  Usual suspects:


>	    Services:
>	    Barbican:


  Add some information to README


  Barbican formula


  Barbican cluster service


>	          host_href: ''
>	          is_proxied: true
>	          plugin:
>	            simple_crypto:
>	              kek: "YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXoxMjM0NTY="
>	          store:
>	            software:
>	              crypto_plugin: simple_crypto
>	              store_plugin: store_crypto
>	              global_default: True
>	          bind:
>	            address: 10.0.106.20
>	            port: 9311
>	            admin_port: 9312
>	          identity:
>	            engine: keystone
>	            port: 35357
>	            domain: default
>	            tenant: service
>	          message_queue:
>	            engine: rabbitmq
>	            user: openstack
>	            virtual_host: '/openstack'
>	            members:
>	            - host: 10.10.10.10
>	              port: 5672
>	            - host: 10.10.10.11
>	            - host: 10.10.10.12
>	          cache:
>	              port: 11211


  Running behind loadbalancer


  If you are running behind loadbalancer, set the `host_href` to load balancer's
  address. You can set `host_href` empty and the api attempts autodetect correct
  address from http requests.


  Running behind proxy


  If you are running behind proxy, set the `is_proxied` parameter to `true`. This
  will allow `host_href` autodetection with help of proxy headers such as
  `X-FORWARDED-FOR` and `X-FORWARDED-PROTO`.


  Queuing asynchronous messaging


  By default is `async_queues_enable` set `false` to invoke worker tasks
  synchronously (i.e. no-queue standalone mode). To enable queuing asynchronous
  messaging you need to set it true.


>	          async_queues_enable: true


  Keystone notification listener


  To enable keystone notification listener, set the `ks_notification_enable`
  to true.
  `ks_notifications_allow_requeue` enables requeue feature in case of
  notification processing error. Enable this only when underlying transport
  supports this feature.


>	          ks_notifications_enable: true
>	          ks_notifications_allow_requeue: true


  Configuring plugins


  Dogtag KRA


>	            dogtag:
>	              pem_path: '/etc/barbican/kra_admin_cert.pem'
>	              dogtag_host: localhost
>	              dogtag_port: 8433
>	              nss_db_path: '/etc/barbican/alias'
>	              nss_db_path_ca: '/etc/barbican/alias-ca'
>	              nss_password: 'password123'
>	              simple_cmc_profile: 'caOtherCert'
>	              ca_expiration_time: 1
>	              plugin_working_dir: '/etc/barbican/dogtag'


  KMIP HSM


>	            kmip:
>	              username: 'admin'
>	              password: 'password'
>	              host: localhost
>	              port: 5696
>	              keyfile: '/path/to/certs/cert.key'
>	              certfile: '/path/to/certs/cert.crt'
>	              ca_certs: '/path/to/certs/LocalCA.crt'


  PKCS11 HSM


>	            p11_crypto:
>	              library_path: '/usr/lib/libCryptoki2_64.so'
>	              login: 'mypassword'
>	              mkek_label: 'an_mkek'
>	              mkek_length: 32
>	              hmac_label: 'my_hmac_label'


  Software Only Crypto


  `kek` is key encryption key created from 32 bytes encoded as Base64. You should
  not use this in production.


>	              kek: 'YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXoxMjM0NTY='


  Secret stores


>	              store_plugin: kmip_plugin
>	              store_plugin: dogtag_plugin
>	            pkcs11:
>	              crypto_plugin: p11_crypto


  Initial commit


  barbican formula


  Barbican is a REST API designed for the secure storage, provisioning and
  management of secrets such as passwords, encryption keys and X.509 Certificates.


  It is aimed at being useful for all environments, including large ephemeral


  Clouds.


  Sample pillars


  Single barbican service


  * https://docs.openstack.org/barbican/latest/


# Formula billometer


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula bind


###  Ales Komarek


  Documentation cleanup


  Bind formula


  BIND is open source software that enables you to publish your Domain Name System (DNS) information on the Internet, and to resolve DNS queries for your users. The name BIND stands for “Berkeley Internet Name Domain”, because the software originated in the early 1980s at the University of California at Berkeley.


  Sample pillars


>	      bind:
>	        server:
>	          enabled: true
>	          key:
>	            keyname:
>	              secret: xyz
>	              algorithm: hmac-sha512
>	          server:
  8.8.8.8:


>	              keys:
>	                - keyname
>	          zone:
  sub.domain.com:


>	              ttl: 86400
>	              root: "hostmaster@domain.com"
>	              type: master
>	              records:
>	              - name: @
>	                type: A
>	                ttl: 7200
>	                value: 192.168.0.5
  1.168.192.in-addr.arpa:


>	              notify: false
  slave.domain.com:


>	              type: slave
>	              notify: true
>	              masters:
>	                # Masters must be specified by IP address
>	                - 8.8.8.8
>	                - 8.8.4.4
>	          dnssec:
>	            enabled: true
>	          # Don't hide version
>	          version: true
>	          # Allow recursion, better don't on public dns servers
>	          recursion:
>	            hosts:
>	              - localhost


  Read more


  * https://github.com/theforeman/puppet-dns
  * https://help.ubuntu.com/community/BIND9ServerHowto
  * https://www.isc.org/downloads/bind/


###  Filip Pytloun


  Add client role to configure rndc


  Server


  Client


>	        client:
>	          option:
>	            default:
>	              server: localhost
>	              port: 953
>	              key: keyname


  Allow definition of controls


>	          control:
>	            local:
>	              enabled: true
>	              bind:
>	                address: 127.0.0.1
>	                port: 953
>	              allow:
>	                - 127.0.0.1
>	                - xyz


  You can use following command to generate key:


  dnssec-keygen -a HMAC-SHA512 -b 512 -n HOST -r /dev/urandom mykey


  Unify Makefile, .gitignore and update readme


# Formula bird


###  Aleš Komárek


  Update and rename README.md to README.rst


  BIRD Formula


  The BIRD project aims to develop a fully functional dynamic IP routing daemon primarily targeted on (but not limited to) Linux, FreeBSD and other UNIX-like systems and distributed under the GNU General Public License. 


  Sample Pillars


>	      bird:
>	        server:
>	          enabled: True
>	          logging:
>	            engine: syslog
>	          protocol:
>	            my_ospf:
>	              type: ospf
>	              tick: 2
>	              rfc1583compat: True
>	              ecmp: True
>	              area:
  0.0.0.0:


>	                  interface:
>	                    p3p1:
>	                      type: ptp
>	                      paramX: xxx
>	                    p3p2:
>	                    tap0: {}
>	                    vhost0:
>	                      hello: 9
>	                      type: broadcast


  More Information


  * http://bird.network.cz/
  * https://gitlab.labs.nic.cz/labs/bird/wikis/home


# Formula cadf


###  Aleš Komárek


  docfix


  CADF Formula


  The Cloud Auditing Data Federation (CADF) standard defines a full event model anyone can use
  to fill in the essential data needed to certify, self-manage and self-audit application security
  in cloud environments.


  Sample Pillars


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula calico


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula cassandra


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Jiri Broulik


  cassandra backup


  Backup client with ssh/rsync remote host


>	      cassandra:
>	        backup:
>	          client:
>	            enabled: true
>	            full_backups_to_keep: 3
>	            hours_before_full: 24
>	            target:
>	              host: cfg01


  More options to relocate local backups can be done using salt-formula-backupninja.


  Backup client with local backup only


  Backup server rsync


>	          server:
>	            full_backups_to_keep: 5
>	            key:
>	              cassandra_pub_key:
>	                enabled: true
>	                key: ssh_rsa


  Client restore from local backup:


>	            restore_latest: 1
>	            restore_from: local


  Client restore from remote backup:


>	            restore_from: remote


# Formula ccp


###  Ales Komarek


  Fix to source


>	          nodes:
  'ctl':


>	              roles:
>	              - controller
>	              - openvswitch
  ctl0[2-3]:


>	              - compute


  Getting there


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula ceilometer


###  Aleš Komárek


  Update README.rst


  Ceilometer Formula


  Sample Pillars


  More Information


###  Dmitry Ukov


  Policy.json should be defined by user


  User can override and add values to policy.json by creating flat
  key-value structure under ceilometer:server:policy.


  Configuration of policy.json file


>	      ceilometer:
>	        server:
  ....


>	          policy:
>	            segregation: 'rule:context_is_admin'
>	            # Add key without value to remove line from policy.json
  'telemetry:get_resource':


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Nadya Shakhat


  Add coordination for a central agent
  billing, across all current OpenStack components with work underway to


  This formula provides different backends for Ceilometer data: MongoDB, InfluxDB. Also,


  Graphite and direct (to Elasticsearch) publishers are available. If InfluxDB is used
  as a backend, heka is configured to consume messages from RabbitMQ and write in to


  InfluxDB, i.e. ceilometer collector service is not used in this configuration.


>	          version: mitaka


  Databases configuration


  MongoDB example:


>	            members:
>	            - host: 10.0.106.10
>	              port: 27017
>	            - host: 10.0.106.20
>	            - host: 10.0.106.30
>	            password: password


  InfluxDB/Elasticsearch example:


>	          database:
>	            influxdb:
>	              host: 10.0.106.10
>	              port: 8086
>	              user: ceilometer
>	              password: password
>	              database: ceilometer
>	            elasticsearch:
>	              enabled: true
>	              port: 9200


###  Ondrej Smola


  added support for CORS parameters


  Enable CORS parameters


>	          cors:
>	            allowed_origin: https:localhost.local,http:localhost.local
>	            expose_headers: X-Auth-Token,X-Openstack-Request-Id,X-Subject-Token
>	            allow_methods: GET,PUT,POST,DELETE,PATCH
>	            allow_headers: X-Auth-Token,X-Openstack-Request-Id,X-Subject-Token
>	            allow_credentials: True
>	            max_age: 86400


###  Petr Jediný


  Introduce Newton and Ocata support


  Newton support by Jakub Pavlík <pavlk.jakub@gmail.com>


  Parameterized configuration files for ceilometer in Newton and Ocata.


  For Ocata move deprecated ceilometer-api to webserver


  Other changes:




  Ceilometer instance discovery method


>	        agent:
>	          discovery_method: naive


  Keystone auth caching


>	          cache:
>	              - host: 10.10.10.10
>	                port: 11211
>	              - host: 10.10.10.11
>	              - host: 10.10.10.12


# Formula ceph


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Jiri Broulik


  monitoring


  PROD-15486


  By default monitoring is setup to collect information from MON and OSD nodes. To change the default values add the following pillar to MON nodes.


>	          space_used_warning_threshold: 0.75
>	          space_used_critical_threshold: 0.85
>	          apply_latency_threshold: 0.007
>	          commit_latency_threshold: 0.7
>	          pool_space_used_utilization_warning_threshold: 0.75
>	          pool_space_used_critical_threshold: 0.85
>	          pool_write_ops_threshold: 200
>	          pool_write_bytes_threshold: 70000000
>	          pool_read_bytes_threshold: 70000000
>	          pool_read_ops_threshold: 1000


  dmcrypt support / osd disk encryption support
  related prod:


  PROD-15919


>	                dmcrypt: true


  update Readme for Bluestore / add ceph.common into init
  * Block.db location for Bluestore


  There are two ways to setup block.db:
  * **Colocated** block.db partition is created on the same disk as partition for the data. This setup is easier for installation and it doesn't require any other disk to be used. However, colocated setup is significantly slower than dedicated)
  * **Dedicate** block.db is placed on different disk than data (or into partition). This setup can deliver much higher performance than colocated but it require to have more disks in servers. Block.db drives should be carefully selected because high I/O and durability is required.


  * Block.wal location for Bluestore


  There are two ways to setup block.wal - stores just the internal journal (write-ahead log):
  * **Colocated** block.wal uses free space of the block.db device.
  * **Dedicate** block.wal is placed on different disk than data (better put into partition as the size can be small) and possibly block.db device. This setup can deliver much higher performance than colocated but it require to have more disks in servers. Block.wal drives should be carefully selected because high I/O and durability is required.


  * Journal location for Filestore


  There are two ways to setup journal:
  * **Colocated** journal is created on the same disk as partition for the data. This setup is easier for installation and it doesn't require any other disk to be used. However, colocated setup is significantly slower than dedicated)
  * **Dedicate** journal is placed on different disk than data (or into partition). This setup can deliver much higher performance than colocated but it require to have more disks in servers. Journal drives should be carefully selected because high I/O and durability is required.


  Readme update with Bluestore compression options


  Inline compression for Bluestore backend


>	      ceph:
>	        setup:
>	          pool:
>	            volumes:
>	              pg_num: 256
>	              pgp_num: 256
>	              type: replicated
>	              crush_rule: hdd
>	              application: rbd
>	              compression_algorithm: snappy
>	              compression_mode: aggressive
>	              compression_required_ratio: .875
  ...


  adding manage non admin / mon key keyring capability


  Ceph manage keyring keys


  Keyrings are dynamically generated unless specified by the following pillar.


>	        common:
>	          manage_keyring: true
>	          keyring:
>	            glance:
>	              name: images
>	              key: AACf3ulZFFPNDxAAd2DWds3aEkHh4IklZVgIaQ==
>	              caps:
>	                mon: "allow r"
>	                osd: "allow class-read object_prefix rdb_children, allow rwx pool=images"


  fixes for kraken and lower versions


  For Kraken and earlier releases application param is not needed.


>	              - osd


  extend crush map and keyring setup


>	              crush_rule: sata
>	              crush_rule: ssd


  Generate CRUSH map - Recommended way


  It is required to define the `type` for crush buckets and these types must start with `root` (top) and end with `host`. OSD daemons will be assigned to hosts according to it's hostname. Weight of the buckets will be calculated according to weight of it's children.


  If the pools that are in use have size of 3 it is best to have 3 children of a specific type in the root CRUSH tree to replicate objects across (Specified in rule steps by 'type region').


>	          crush:
>	            enabled: True
>	            tunables:
>	              choose_total_tries: 50
>	              choose_local_tries: 0
>	              choose_local_fallback_tries: 0
>	              chooseleaf_descend_once: 1
>	              chooseleaf_vary_r: 1
>	              chooseleaf_stable: 1
>	              straw_calc_version: 1
>	              allowed_bucket_algs: 54
>	            type:
>	              - root
>	              - region
>	              - rack
>	              - host
>	            root:
>	              - name: root-ssd
>	              - name: root-sata
>	            region:
>	              - name: eu-1
>	                parent: root-sata
>	              - name: eu-2
>	              - name: eu-3
>	                parent: root-ssd
>	              - name: us-1
>	            rack:
>	              - name: rack01
>	                parent: eu-1
>	              - name: rack02
>	                parent: eu-2
>	              - name: rack03
>	                parent: us-1
>	            rule:
>	              sata:
>	                ruleset: 0
>	                type: replicated
>	                min_size: 1
>	                max_size: 10
>	                steps:
>	                  - take take root-ssd
>	                  - chooseleaf firstn 0 type region
>	                  - emit
>	              ssd:
>	                ruleset: 1
>	                  - take take root-sata


  Generate CRUSH map - Alternative way


  It's necessary to create per OSD pillar.


>	        osd:
>	            - type: root
>	              name: root1
>	            - type: region
>	              name: eu-1
>	            - type: rack
>	              name: rack01
>	            - type: host
>	              name: osd001


  Apply CRUSH map


  Before you apply CRUSH map please make sure that settings in generated file in /etc/ceph/crushmap are correct.


>	            enforce: true
>	            images:
>	            vms:


  Persist CRUSH map


  After the CRUSH map is applied to Ceph it's recommended to persist the same settings even after OSD reboots.


>	          crush_update: false


  moving osd keyring to service level


  crush map fix


>	          version: luminous
>	          fsid: a619c5fc-c4ed-4f22-9ed2-66cf2feca23d
>	          public_network: 10.0.0.0/24, 10.1.0.0/24
>	          cluster_network: 10.10.0.0/24, 10.11.0.0/24
>	            bootstrap-osd:
>	                mon: "allow profile bootstrap-osd"
  ....


>	          crush_parent: rack01
>	          journal_size: 20480                     (20G)
>	          bluestore_block_db_size: 10073741824    (10G)
>	          bluestore_block_wal_size: 10073741824   (10G)
>	                - chooseleaf firstn 0 type failure_domain


  grains / crush / auto generate keyrings


>	                class: ssd
>	                weight: 1.666


  Ceph client roles - ...Deprecated - use ceph:common instead


  ceph osd fixes


>	              key: BQBHPYhZv5mYDBAAvisaSzCTQkC5gywGUp/voA==


>	          ceph_host_id: '39'
>	          journal_size: 20480
>	          bluestore_block_db_size: 1073741824    (1G)
>	          bluestore_block_wal_size: 1073741824   (1G)
>	          bluestore_block_size: 807374182400     (800G)
>	          backend:
>	            filestore:
>	              disks:
>	              - dev: /dev/sdm
>	                enabled: false
>	                rule: hdd
>	                journal: /dev/ssd
>	                fs_type: xfs
>	                class: bestssd
>	                weight: 1.5
>	              - dev: /dev/sdl
>	            bluestore:
>	              - dev: /dev/sdb
>	              - dev: /dev/sdc
>	                block_db: /dev/ssd
>	                block_wal: /dev/ssd
>	              - dev: /dev/sdd


###  Mateusz Los


  ceph mon backup


  Ceph cluster is accessed using network and thus you need to have decend capacity to handle all the client. There are two networks required for cluster: **public** network and cluster network. Public network is used for client connections and MONs and OSDs are listening on this network. Second network ic called **cluster** networks and this network is used for communication between OSDs.


  Ceph monitor backups


  Backup client with ssh/rsync remote host


>	        backup:
>	          client:
>	            enabled: true
>	            full_backups_to_keep: 3
>	            hours_before_full: 24
>	            target:
>	              host: cfg01


  Backup client with local backup only


  Backup server rsync


>	          server:
>	            full_backups_to_keep: 5
>	            key:
>	              ceph_pub_key:
>	                enabled: true
>	                key: ssh_rsa


###  Ondrej Smola


  added mgr role - only for luminous


  Ceph mgr roles


  The Ceph Manager daemon (ceph-mgr) runs alongside monitor daemons, to provide additional monitoring and interfaces to external monitoring and management systems. Since the 12.x (luminous) Ceph release, the ceph-mgr daemon is required for normal operations. The ceph-mgr daemon is an optional component in the 11.x (kraken) Ceph release.


  By default, the manager daemon requires no additional configuration, beyond ensuring it is running. If there is no mgr daemon running, you will see a health warning to that effect, and some of the other information in the output of ceph status will be missing or stale until a mgr is started.


>	        mgr:
>	          enabled: true
>	          dashboard:
>	            host: 10.103.255.252
>	            port: 7000


  Added ceph mon and osd funcionality (#5)


  Try to define what we are goint to achieve.


  Ceph formula


  Ceph provides extraordinary data storage scalability. Thousands of client
  hosts or KVMs accessing petabytes to exabytes of data. Each one of your
  applications can use the object, block or file system interfaces to the same


  RADOS cluster simultaneously, which means your Ceph storage system serves as a
  flexible foundation for all of your data storage needs.


  Use salt-formula-linux for initial disk partitioning.


  Common metadata for all nodes/roles


>	          version: kraken
>	              param1: value1
>	              param2: value1
>	              param3: value1
>	            pool_section:
>	              param1: value2
>	              param2: value2
>	              param3: value2
>	          members:
>	          - name: cmn01
>	            host: 10.0.0.1
>	          - name: cmn02
>	            host: 10.0.0.2
>	          - name: cmn03
>	            host: 10.0.0.3
>	            admin:
>	              key: AQBHPYhZv5mYDBAAvisaSzCTQkC5gywGUp/voA==
>	                mds: "allow *"
>	                mgr: "allow *"
>	                mon: "allow *"
>	                osd: "allow *"


  Optional definition for cluster and public networks. Cluster network is used
  for replication. Public network for front-end communication.


  Ceph mon (control) roles


>	  Monitors: A Ceph Monitor maintains maps of the cluster state, including the
  monitor map, the OSD map, the Placement Group (PG) map, and the CRUSH map.


  Ceph maintains a history (called an “epoch”) of each state change in the Ceph


  Monitors, Ceph OSD Daemons, and PGs.


>	          config:
>	            mon:
>	              key: value
>	              key: AQAnQIhZ6in5KxAAdf467upoRMWFcVg5pbh1yg==


  Ceph OSD (storage) roles


>	            osd:
>	          host_id: 10
>	          copy_admin_key: true
>	          journal_type: raw
>	          dmcrypt: disable
>	          osd_scenario: raw_journal_devices
>	          fs_type: xfs
>	          disk:
  '00':


>	              rule: hdd
>	              dev: /dev/vdb2
>	              journal: /dev/vdb1
>	              class: besthdd
>	              weight: 1.5
  '01':


>	              dev: /dev/vdc2
>	              journal: /dev/vdc1
  '02':


>	              dev: /dev/vdd2
>	              journal: /dev/vdd1


  Ceph client roles


  Simple ceph client service


>	        client:
>	            monitoring:


  At OpenStack control settings are usually located at cinder-volume or glance-
  registry services.


  Ceph gateway


  Rados gateway with keystone v2 auth backend


>	        radosgw:
>	          hostname: gw.ceph.lab
>	          bind:
>	            address: 10.10.10.1
>	            port: 8080
>	          identity:
>	            engine: keystone
>	            api_version: 2
>	            host: 10.10.10.100
>	            port: 5000
>	            user: admin
>	            password: password
>	            tenant: admin


  Rados gateway with keystone v3 auth backend


>	            api_version: 3
>	            project: admin
>	            domain: default


  Ceph setup role


  Replicated ceph storage pool


>	            replicated_pool:
>	              crush_ruleset_name: 0


  Erasure ceph storage pool


>	            erasure_pool:
>	              type: erasure
>	              erasure_code_profile: 


  Ceph monitoring


  Collect general cluster metrics


  Collect metrics from monitor and OSD services


  More information


  Documentation and bugs


###  Simon Pasquier


  Add support for Ceph monitoring


  This change adds support for Ceph monitoring:


  Because Telegraf runs as a container on the monitoring nodes and
  requires a working Ceph client configuration, this  change also adds
  support for deploying Ceph client in container mode.


  Client pillar - usually located at cinder-volume or glance-registry.


  Monitoring Ceph cluster - collect cluster metrics


>	            global:
  mon initial members: ceph1,ceph2,ceph3
  mon host: 10.103.255.252:6789,10.103.255.253:6789,10.103.255.254:6789


>	              key: 00000000000000000000000000000000000000==
>	        monitoring:
>	          cluster_stats:
>	            ceph_user: monitoring


  Monitoring Ceph services - collect metrics from monitor and OSD services


>	          node_stats:


###  Tomáš Kukrál


  describe architecture


  Daemons


  Ceph uses several daemons to handle data and cluster state. Each daemon type requires different computing capacity and hardware optimization.


  These daemons are currently supported by formula:


  * MON (`ceph.mon`)
  * OSD (`ceph.osd`)
  * RGW (`ceph.radosgw`)


  Architecture decisions


  Please refer to upstream achritecture documents before designing your cluster. Solid understanding of Ceph principles is essential for making architecture decisions described bellow.


>	  http://docs.ceph.com/docs/master/architecture/


  * Ceph version


  There is 3 or 4 stable releases every year and many of nighty/dev release. You should decide which version will be used since the only stable releases are recommended for production. Some of the releases are marked LTS (Long Term Stable) and these releases receive bugfixed for longer period - usually until next LTS version is released.


  * Number of MON daemons


  Use 1 MON daemon for testing, 3 MONs for smaller production clusters and 5 MONs for very large production cluster. There is no need to have more than 5 MONs in normal environment because there isn't any significant benefit in running more than 5 MONs. Ceph require MONS to form quorum so you need to heve more than 50% of the MONs up and running to have fully operational cluster. Every I/O operation will stop once less than 50% MONs is availabe because they can't form quorum.


  * Number of PGs


  Placement groups are providing mappping between stored data and OSDs. It is necessary to calculate number of PGs because there should be stored decent amount of PGs on each OSD. Please keep in mind *decreasing number of PGs* isn't possible and *increading* can affect cluster performance.


>	  http://docs.ceph.com/docs/master/rados/operations/placement-groups/
>	  http://ceph.com/pgcalc/


  * Daemon colocation


  It is recommended to dedicate nodes for MONs and RWG since colocation can have and influence on cluster operations. Howerver, small clusters can be running MONs on OSD node but it is critical to have enough of resources for MON daemons because they are the most important part of the cluster.


  Installing RGW on node with other daemons isn't recommended because RGW daemon usually require a lot of bandwith and it harm cluster health.


  * Journal location


  There are two way to setup journal:
  * **Colocated** journal is located (usually at the beginning) on the same disk as partition for the data. This setup is easier for installation and it doesn't require any other disk to be used. However, colocated setup is significantly slower than dedicated)
  * **Dedicate** journal is placed on different disk than data. This setup can deliver much higher performance than colocated but it require to have more disks in servers. Journal drives should be carefully selected because high I/O and durability is required.


  * Store type (Bluestore/Filestore)


  Recent version of Ceph support Bluestore as storage backend and backend should be used if available.


>	  http://docs.ceph.com/docs/master/rados/configuration/bluestore-config-ref/


  * Cluster and public network


  Ceph cluster is accessed using network and thus you need to have decend capacity to handle all the client. There are two networks required for cluster: **public** network and cluster network. Public network is used for client connections and MONs and OSDs are listening on this network. Second network ic called **cluster** networks and this network is used for communication between OSDs. 


  Both networks should have dedicated interfaces, bonding interfaces and dedicating vlans on bonded interfaces isn't allowed. Good practise is dedicate more throughput for the cluster network because cluster traffic is more important than client traffic.


  * Pool parameters (size, min_size, type)


  You should setup each pool according to it's expected usage, at least `min_size` and `size` and pool type should be considered.


  * Cluster monitoring


  * Hardware


  Please refer to upstream hardware recommendation guide for general information about hardware.


  Ceph servers are required to fulfil special requirements becauce load generated by Ceph can be diametrically opposed to common load.


>	  http://docs.ceph.com/docs/master/start/hardware-recommendations/


  Basic management commands


  Cluster
  ********


>	  - :code:`ceph health` - check if cluster is healthy (:code:`ceph health detail` can provide more information)


  root@c-01:~# ceph health


  HEALTH_OK


>	  - :code:`ceph status` - shows basic information about cluster


  root@c-01:~# ceph status
  cluster e2dc51ae-c5e4-48f0-afc1-9e9e97dfd650
  health HEALTH_OK
  monmap e1: 3 mons at {1=192.168.31.201:6789/0,2=192.168.31.202:6789/0,3=192.168.31.203:6789/0}
  election epoch 38, quorum 0,1,2 1,2,3
  osdmap e226: 6 osds: 6 up, 6 in
  pgmap v27916: 400 pgs, 2 pools, 21233 MB data, 5315 objects
  121 GB used, 10924 GB / 11058 GB avail
  400 active+clean
  client io 481 kB/s rd, 132 kB/s wr, 185 op/


  MON
  ****


>	  http://ceph.com/docs/master/rados/troubleshooting/troubleshooting-mon/


  OSD


>	  http://ceph.com/docs/master/rados/troubleshooting/troubleshooting-osd/


>	  - :code:`ceph osd tree` - show all OSDs and it's state


  root@c-01:~# ceph osd tree


  ID WEIGHT   TYPE NAME     UP/DOWN REWEIGHT PRIMARY-AFFINITY


>	    -4        0 host c-04
>	    -1 10.79993 root default
>	    -2  3.59998     host c-01
  0  1.79999         osd.0      up  1.00000          1.00000
  1  1.79999         osd.1      up  1.00000          1.00000


>	    -3  3.59998     host c-02
  2  1.79999         osd.2      up  1.00000          1.00000
  3  1.79999         osd.3      up  1.00000          1.00000


>	    -5  3.59998     host c-03
  4  1.79999         osd.4      up  1.00000          1.00000
  5  1.79999         osd.5      up  1.00000          1.00000


>	  - :code:`ceph osd pools ls` - list of pool


  root@c-01:~# ceph osd lspools
  0 rbd,1 test


  PG
  ***


>	  http://ceph.com/docs/master/rados/troubleshooting/troubleshooting-pg


>	  - :code:`ceph pg ls` - list placement groups


  root@c-01:~# ceph pg ls | head -n 4
  pg_stat	objects	mip	degr	misp	unf	bytes	log	disklog	state	state_stamp	v	reported	up	up_primary	acting	acting_primary	last_scrub	scrub_stamp	last_deep_scrub	deep_scrub_stamp
  0.0	11	0	0	0	0	46137344	3044	3044	active+clean	2015-07-02 10:12:40.603692	226'10652	226:1798	[4,2,0]	4	[4,2,0]	4	0'0	2015-07-01 18:38:33.126953	0'0	2015-07-01 18:17:01.904194
  0.1	7	0	0	0	0	25165936	3026	3026	active+clean	2015-07-02 10:12:40.585833	226'5808	226:1070	[2,4,1]	2	[2,4,1]	2	0'0	2015-07-01 18:38:32.352721	0'0	2015-07-01 18:17:01.904198
  0.2	18	0	0	0	0	75497472	3039	3039	active+clean	2015-07-02 10:12:39.569630	226'17447	226:3213	[3,1,5]	3	[3,1,5]	3	0'0	2015-07-01 18:38:34.308228	0'0	2015-07-01 18:17:01.904199


>	  - :code:`ceph pg map 1.1` - show mapping between PG and OSD


  root@c-01:~# ceph pg map 1.1
  osdmap e226 pg 1.1 (1.1) -> up [5,1,2] acting [5,1,2]


  divide setup to crush, keyring and pool, fix tests


>	    ceph:
>	      setup:
>	        crush:
>	          enabled: True
>	          tunables:
>	            choose_total_tries: 50
>	          type:
>	            - root
>	            - region
>	            - rack
>	            - host
>	          root:
>	            - name: root1
>	            - name: root2
>	          region:
>	            - name: eu-1
>	              parent: root1
>	            - name: eu-2
>	            - name: us-1
>	              parent: root2
>	          rack:
>	            - name: rack01
>	              parent: eu-1
>	            - name: rack02
>	              parent: eu-2
>	            - name: rack03
>	              parent: us-1
>	          rule:
>	            sata:
>	              ruleset: 0
>	              min_size: 1
>	              max_size: 10
>	              steps:
>	                - take crushroot.performanceblock.satahss.1
>	                - choseleaf firstn 0 type failure_domain
>	                - emit


  add crushmap template, fix tests


  Generate CRUSH map


  It is required to define the `type` for crush buckets and these types must start with `root` (top) and end with `host`. OSD daemons will be assigned to hosts according to it's hostname. Weight of the buckets will be calculated according to weight of it's childen.


>	    crush:
>	      enabled: True
>	      tunables:
>	        choose_total_tries: 50
>	      type:
>	        - root
>	        - region
>	        - rack
>	        - host
>	      root:
>	        - name: root1
>	        - name: root2
>	      region:
>	        - name: eu-1
>	          parent: root1
>	        - name: eu-2
>	        - name: us-1
>	          parent: root2
>	      rack:
>	        - name: rack01
>	          parent: eu-1
>	        - name: rack02
>	          parent: eu-2
>	        - name: rack03
>	          parent: us-1
>	      rule:
>	        sata:
>	          ruleset: 0
>	          type: replicated
>	          min_size: 1
>	          max_size: 10
>	          steps:
>	            - take crushroot.performanceblock.satahss.1
>	            - choseleaf firstn 0 type failure_domain
>	            - emit


# Formula chrony


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula cinder


###  Alexander Noskov


  Add Cinder Block Device driver backend (#18)


  Cinder setup with Block Device driver


>	      cinder:
>	        volume:
>	          enabled: true
>	          backend:
>	            bdd:
>	              engine: bdd
>	              enabled: true
>	              type_name: bdd
>	              devices:
>	                - sdb
>	                - sdc
>	                - sdd


  Add possibility to specify osapi_volume_base_URL and public_endpoint


  Running Cinder application without SSL under load balancer with SSL, we should
  set osapi_volume_base_URL and public_endpoint with proper endpoints for the clients.


  public_endpoint and osapi_volume_base_url parameters:
  "public_endpoint" is used for configuring versions endpoint,
  "osapi_volume_base_URL" is used to present Cinder URL to users.


  They are useful when running Cinder under load balancer in SSL.


>	        controller:
>	          public_endpoint_address: https://${_param:cluster_domain}:8776


###  Alexey Chekunov


  NetApp backend support


  Cinder setup with NetApp


>	            netapp:
>	              engine: netapp
>	              type_name: netapp
>	              user: openstack
>	              vserver: vm1
>	              server_hostname: 172.18.2.3
>	              password: password
>	              storage_protocol: nfs
>	              transport_type: https
>	              lun_space_reservation: enabled
>	              use_multipath_for_image_xfer: True
>	                - 172.18.1.2:/vol_1
>	                - 172.18.1.2:/vol_2
>	                - 172.18.1.2:/vol_3
>	                - 172.18.1.2:/vol_4
>	        compute:


###  Andrii Ostapenko


  Allow to specify custom volumes query filters


  Cinder setup with custom non-admin volume query filters:


>	          query_volume_filters:
>	            - name
>	            - status
>	            - metadata
>	            - availability_zone
>	            - bootable


###  Damian Szeluga


  Add AZ fallback


>	          availability_zone_fallback: True


###  Dmitry Stremkouski


  netapp backend should have ability to set
  nas_secure_file_operations and nas_secure_file_permissions.


>	              nas_secure_file_operations: false
>	              nas_secure_file_permissions: false


###  Dmitry Stremkovskiy


  Adding ability to configure cinder_internal_tenant_project_id and cinder_internal_tenant_user_id options


>	          cinder_internal_tenant_user_id: f46924c112a14c80ab0a24a613d95eef
>	          cinder_internal_tenant_project_id: b7455b8974bb4064ad247c8f375eae6c


  Adding ability to set nas_secure_file_permissions and nas_secure_file_operations options


>	          nas_secure_file_permissions: false
>	          nas_secure_file_operations: false


  Unhardcode service user/group uid/gid values


  Warn to not change cinder uid/gid values after user is created


>	          cinder_uid: 304
>	          cinder_gid: 304


###  Dmitry Ukov


  Policy.json should be defined by user


  User can override and add values to policy.json by creating flat
  key-value structure under cinder:controller:policy.


  Configuration of policy.json file


  ....


>	          policy:
  'volume:delete': 'rule:admin_or_owner'


>	            # Add key without value to remove line from policy.json
  'volume:extend':


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Jakub Pavlik


  fix netapp compute side. Do not introduce new role for package


>	      linux:
>	        system:
>	          package:
>	            nfs-common:
>	              version: latest


###  Jiri Broulik


  cinder client


  Client role


>	        client:
>	          identity:
>	            host: 127.0.0.1
>	            port: 35357
>	            project: service
>	            user: cinder
>	            password: pwd
>	            protocol: http
>	            endpoint_type: internalURL
>	            region_name: RegionOne
>	            ceph:
>	              type_name: standard-iops
>	              engine: ceph
>	              key:
>	                conn_speed: fibre-10G


  cinder NFS


  Cinder setup with NFS


>	          default_volume_type: nfs-driver
>	            nfs-driver:
>	              engine: nfs
>	              type_name: nfs-driver
>	              volume_group: cinder-volume
>	              path: /var/lib/cinder/nfs
>	              - 172.16.10.110:/var/nfs/cinder
>	              options: rw,sync


###  Kirill Bespalov


  OpenStack HTTPS Endpoints support


  Communication between services usually done via internal
  endpoints that are located in internal network. In some
  cases it is required to encrypt traffic even on internal
  network. This patch unhardcode communication protocol between


  Cinder and other services. Also adds possibility to specify
  ca_file to verify SSL certificates of remote peers.


  PROD-15735


  Configuring TLS communications


  **Note:** by default system wide installed CA certs are used, so ``cacert_file`` param is optional, as well as ``cacert``.


>	  - **RabbitMQ TLS**
>	   cinder:
  controller, volume:


>	          port: 5671
  (optional) cacert: cert body if the cacert_file does not exists
  (optional) cacert_file: /etc/openstack/rabbitmq-ca.pem
  (optional) version: TLSv1_2


>	  - **MySQL TLS**
>	     controller:
>	        database:
  (optional) cacert_file: /etc/openstack/mysql-ca.pem


>	  - **Openstack HTTPS API**


>	        identity:
>	           protocol: https
  (optional) cacert_file: /etc/openstack/proxy.pem


>	        glance:


  RabbitMQ TLS support


  OSCORE-381


>	    Releases: Mitaka, Newton, Ocata
>	    Usage: see README.rst
>	          audit:


  **Client-side RabbitMQ TLS configuration.**


  |


  To enable TLS for oslo.messaging you need to provide the CA certificate.


  By default system-wide CA certs are used. Nothing should be specified except `ssl.enabled`.


>	    cinder:
  controller or volume:


>	        message_queue:
>	          ssl:
>	            enabled: True


  Use `cacert_file` option to specify the CA-cert file path explicitly:


>	            cacert_file: /etc/ssl/rabbitmq-ca.pem


  To manage content of the `cacert_file` use the `cacert` option:


>	            cacert: |


  ...


>	            cacert_file: /etc/openstack/rabbitmq-ca.pem


>	  Notice:
  * The `message_queue.port` is set to **5671** (AMQPS) by default if `ssl.enabled=True`.
  * Use `message_queue.ssl.version` if you need to specify protocol version. By default is TLSv1 for python < 2.7.9 and TLSv1_2 for version above.


  cinder type-key normal-storage set hplh:data_pl=r-10-2 hplh:provisioning=full


###  Michel Nederlof


  Add ceph backend option to report discard support


>	              report_discard_supported: True


  Adding availability zone documentation


  Cinder setup with custom availability zones:


>	          default_availability_zone: my-default-zone
>	          storage_availability_zone: my-custom-zone-name


  The default availability zone is used when a volume has been created, without specifying a zone in the create request. (this zone must exist in your configuration obviously)


  The storage availability zone is the actual zone where the node belongs to. Make sure to specify this per node.


  Check the documentation of OpenStack for more information


###  Oleg Iurchenko


  Add Barbican integration


  This patch adds Barbican integration to Cinder


>	          barbican:
>	            enabled: true


  Enable Barbican integration


###  Ondrej Smola


  enable support for cors params


  Enable CORS parameters


>	          cors:
>	            allowed_origin: https:localhost.local,http:localhost.local
>	            expose_headers: X-Auth-Token,X-Openstack-Request-Id,X-Subject-Token
>	            allow_methods: GET,PUT,POST,DELETE,PATCH
>	            allow_headers: X-Auth-Token,X-Openstack-Request-Id,X-Subject-Token
>	            allow_credentials: True
>	            max_age: 86400


  added support for cinder-backup service


  Enable cinder-backup service for ceph


>	          version: mitaka
>	          backup:
>	            engine: ceph
>	            ceph_conf: "/etc/ceph/ceph.conf"
>	            ceph_pool: backup
>	            ceph_stripe_count: 0
>	            ceph_stripe_unit: 0
>	            ceph_user: cinder
>	            ceph_chunk_size: 134217728
>	            restore_discard_excess_bytes: false


  added cinder ldev range for hitashi vsp storage


  Cinder setup with Hitachi VPS with defined ldev range


>	            hus100_backend:
>	              type_name: HUS100
>	              backend: hus100_backend
>	              engine: hitachi_vsp
>	              connection: FC
>	              ldev_range: 0-1000


###  Simon Pasquier


  Allow to configure the pagination


>	          osapi_max_limit: 500


###  stelucz


  add enable_force_upload to sample pillars


>	          enable_force_upload: true
>	          nable_force_upload: true


# Formula collectd


###  Aleš Komárek


  Update README.rst


  Collectd formula


  External links


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula decapod


###  Ales Komarek


  Basic structure


  Decapod formula


  Decapod is intendend to simplify deployment and lifecycle management of Ceph.


  Sample pillars


  Single decapod service


>	      decapod:
>	        server:
>	          enabled: true


  Read more


  * http://decapod.readthedocs.io/en/latest/


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Mateusz los


  readme


>	     decapod:
>	      server_discovery_key: https://github.com/Mirantis/ceph-lcm/blob/master/containerization/files/devconfigs/config.yaml api['server_discovery_token']
>	      decapod_ip: 127.0.0.1


>	      # as default, all ssd disks will be configured as journal devices,
>	      # if you want to use them as osd you need to define ssdpools and ssd_size
>	      ssdpools:
>	        - /dev/sdb
>	        - /dev/sdc
>	        - /dev/sdd
>	        - /dev/sde
>	      ssd_size: 1.1T
>	      # If you are using ssdpools variable you also need to specify journal devices
>	      cache_devices:
>	        - /dev/xvde1
>	        - /dev/xvde2


>	      # decapod needs ansible user to work
>	      ansible_private_key:
>	      ansible_public_key:


>	      decapod_user: "root"
>	      decapod_pass: "root"


>	      # ceph internal network
>	      storage_network: "192.168.0.0/24"
>	      # ceph frontend network
>	      frontend_network: "192.168.1.0/24"


>	      # internal network interface on physical and virtual nodes
>	      phys_mon_interface: "eth0.1"
>	      vm_mon_interface: "ens2"


>	      journal_size: 512
>	      max_open_files: 131072


>	          # if you want to use them as osd you need to define ssdpools and ssd_size


>	        client:
>	          admin_key: AQCvCbtToC6MDhAATtuT70Sl+DymPCfDSsyV4w==
>	          users:
>	                  key: AQCvCbtToC6MDhAATtuT70Sl+DymPCfDSsyV4w==
>	                  caps:
>	                    osd: 'allow r'
>	                    mon: 'allow class-read object_prefix rbd_children, allow rwx pool=cinder'
>	            pools:
>	              - nova:
>	                  rule: 0
>	                  pg: 100
>	              - cinder:


  Decapod Server
  decapod


>	          server_discovery_key: https://github.com/Mirantis/ceph-lcm/blob/master/containerization/files/devconfigs/config.yaml api['server_discovery_token']
>	          decapod_ip: 127.0.0.1
>	          # as default, all ssd disks will be configured as journal devices,
  if you want to use them as osd you need to define ssdpools and ssd_size


>	          ssdpools:
>	            - /dev/sdb
>	            - /dev/sdc
>	            - /dev/sdd
>	            - /dev/sde
>	          ssd_size: 1.1T
>	          # If you are using ssdpools variable you also need to specify journal devices
>	          cache_devices:
>	            - /dev/xvde1
>	            - /dev/xvde2


>	          # decapod needs ansible user to work
>	          ansible_private_key:
>	          ansible_public_key:


>	          decapod_user: "root"
>	          decapod_pass: "root"


>	          # ceph internal network
>	          storage_network: "192.168.0.0/24"
>	          # ceph frontend network
>	          frontend_network: "192.168.1.0/24"


>	          # internal network interface on physical and virtual nodes
>	          phys_mon_interface: "eth0.1"
>	          vm_mon_interface: "ens2"


>	          journal_size: 512
>	          max_open_files: 131072


  Decapod Client


>	    decapod:
>	      client:
>	        admin_key: AQCvCbtToC6MDhAATtuT70Sl+DymPCfDSsyV4w==
>	        users:
>	          - nova:
>	              key: AQCvCbtToC6MDhAATtuT70Sl+DymPCfDSsyV4w==
>	              caps:
>	                osd: 'allow r'
>	                mon: 'allow class-read object_prefix rbd_children, allow rwx pool=nova'
>	          - cinder:
>	                mon: 'allow class-read object_prefix rbd_children, allow rwx pool=cinder'
>	        pools:
>	              rule: 0
>	              pg: 100


  Decapod Discover


# Formula dekapod


###  Ales Komarek


  Restructure begun


  Subproject commit 0d5262b500e56c5c008909b386bbc9e49662e98e


###  Filip Pytloun


  Update formulas


  Subproject commit 93f03ec2dd2c69c4ec40c38bf34785e5145c13b3


  Add more formulas


  Subproject commit 2c74054c69950ecde71194cab4d3af04ac3ce92e


# Formula designate


###  Aleš Komárek


  Update README.rst


  Designate formula


  Designate provides DNSaaS services for OpenStack.


  Sample pillars


###  Alexander Noskov


  Refactoring of formula to support external DNS server


>	            backend:
>	              bind9:
>	                rndc_key: AahjHKbdslHOLs42h/asQA==


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Mykyta Karpin


  Update Designate docs
  other changes:


  For Designate with BIND9 local backend:


>	      designate:
>	        server:
>	          enabled: true
>	          region: RegionOne
>	          domain_id: 5186883b-91fb-4891-bd49-e6769234a8fc
>	          version: ocata
>	          backend:
>	            bind9:
>	              rndc_key: 4pc+X4PDqb2q+5o72dISm72LM1Ds9X2EYZjqg+nmsS7FhdTwzFFY8l/iEDmHxnyjkA33EQC8H+z0fLLBunoitw==
>	              rndc_algorithm: hmac-sha512
>	          bind:
>	            api:
>	              address: 127.0.0.1
>	          database:
>	            engine: mysql
>	            host: 127.0.0.1
>	            port: 3306
>	            name:
>	              main_database: designate
>	              pool_manager: designate_pool_manager
>	            user: designate
>	            password: passw0rd
>	          identity:
>	            engine: keystone
>	            port: 35357
>	            tenant: service
>	          message_queue:
>	            engine: rabbitmq
>	            members:
>	            - host: 127.0.0.1
>	            user: openstack
>	            password: password
>	            virtual_host: '/openstack'
>	          pools:
>	            default:
>	              description: 'default pool'
>	              attributes:
>	                service_tier: GOLD
>	              ns_records:
>	                - hostname: 'ns1.example.org.'
>	                  priority: 10
>	                - host: 127.0.0.1
>	                default_target:
>	                  type: bind9
>	                  description: 'default target'
>	                  masters:
>	                    - host: 127.0.0.1
>	                      port: 5354
>	                  options:
>	                    host: 127.0.0.1
>	                    port: 53
>	                    rndc_host: 127.0.0.1
>	                    rndc_port: 953
>	                    rndc_key_file: /etc/designate/rndc.key


  *domain_id* parameter is UUID of DNS zone managed by designate-sink service. This zone will 
  be populated by A records for fixed and floating ip addresses of spawned VMs. After designate
  is deployed and zone is created, this parameter should be updated accordingly to UUID of
  newly created zone. Then designate state should be reapplied.


  Pools pillar for BIND9 master and multiple slaves setup:


>	      pools:
>	        default:
>	          description: 'default pool'
>	          attributes:
>	            service_tier: GOLD
>	          ns_records:
>	            - hostname: 'ns1.example.org.'
>	              priority: 10
>	          nameservers:
>	            - host: 192.168.0.1
>	              port: 53
>	            - host: 192.168.0.2
>	            - host: 192.168.0.3
>	          targets:
>	            default_target:
>	              type: bind9
>	              description: 'default target'
>	              masters:
>	                - host: 192.168.0.4
>	                  port: 5354
>	              options:
>	                host: 192.168.0.4
>	                port: 53
>	                rndc_host: 192.168.0.4
>	                rndc_port: 953
>	                rndc_key_file: /etc/designate/rndc.key


# Formula devops-portal


###  Ilya Kharin


  Add debian specification


  DevOps Portal


  The DevOps Portal provides dashboards and services to boost operational and
  support needs.


  Sample pillars
  ~~~~~~~~~~~~~~


  The DevOps Portal supports only predefined set of services, add services into
  pillars to make them accessable from the portal. For example let's consider
  how to add a Jenkins service:


>	      devops_portal:
>	        config:
>	          service:
>	            jenkins:
>	              endpoint:
>	                address: 172.16.10.254
>	                port: 8081
>	                https: true


# Formula docker


###  Aleš Komárek


  Update README.rst


  Docker Formula


  Sample Pillars


  Docker Host


  Docker Swarm


  Metadata for worker.


  Docker Client


  Using Docker Compose
  ~~~~~~~~~~~~~~~~~~~~


  Docker Registry


  More Information


###  Filip Pytloun


  Add support for docker stack deploy


  There are two states that provides this functionality:


>	  - docker.client.stack
>	  - docker.client.compose


  Stack is new and works with Docker Swarm Mode. Compose is legacy and works
  only if node isn't member of Swarm.


  Metadata for both states are similar and differs only in implementation.


  Stack
  ^^^^^


>	      docker:
>	        client:
>	          stack:
>	            django_web:
>	              enabled: true
>	              update: true
>	              environment:
>	                SOMEVAR: somevalue
>	              service:
>	                db:
>	                  image: postgres
>	                web:
>	                  image: djangoapp
>	                  volumes:
>	                    - /srv/volumes/django:/srv/django
>	                  ports:
>	                    - 8000:8000
>	                  depends_on:
>	                    - db


  Compose
  ^^^^^^^


  Service


  Unify Makefile, .gitignore and update readme


###  Pavel Svimbersky


  Add module for mgmt services inside container


  Docker container service management


  Enforce the service in container is started


>	      contrail_control_started:
  dockerng_service.start:


>	          - container: f020d0d3efa8
>	          - service: contrail-control


  or


>	          - container: contrail_controller


  Enforce the service in container is stoped


>	      contrail_control_stoped:
  dockerng_service.stop:


  Enforce the service in container will be restarted


>	      contrail_control_restart:
  dockerng_service.restart:


  Enforce the service in container is enabled


>	      contrail_control_enable:
  dockerng_service.enable:


  Enforce the service in container is disabled


>	      contrail_control_disable:
  dockerng_service.disable:


###  Richard Felkl


  Added client.registry role to mirror docker images


  Registry
  ^^^^^^^^


>	          registry:
>	            target_registry: apt:5000
>	            image:
>	              - registry: docker
>	                name: compose:1.8.0
>	              - registry: tcpcloud
>	                name: jenkins:latest
>	              - registry: ""
>	                name: registry:2
>	                target_registry: myregistry


###  Ruslan Khozinov


  Allow configure experimental mode


  Experimental mode allows to see logs of a swarm service,
  e.g. docker service logs <service_id>


>	          experimental: true


###  Simon Pasquier


  Add possibility to specify Compose file version


  This change allows to set the Compose file version in the model instead
  of the hardcoded value.


>	              version: "3.1"


###  Tomáš Kukrál


  fix README for insecure registries
  option is called insecure-registries


>	            insecure-registries:


  remove supported OS from README


  add support for proxy in docker


  Configure proxy for docker host


>	        host:
>	          proxy:
>	            enabled: true
>	            http: http://user:pass@proxy:3128
>	            https: http://user:pass@proxy:3128
>	            no_proxy:
>	              - localhost
>	              - 127.0.0.1
>	              - docker-registry


  add support for docker daemon.json configuration


>	          options:
>	            bip: 172.31.255.1/16
>	            insecure_registries:
>	              - 10.0.0.1
>	            log-driver: json-file
>	            log-opts:
>	              max-size: 50m


# Formula dovecot


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula elasticsearch


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Volodymyr Stoiko


  Extend template definition options


  This change adds:


  Client where you download an index template that is stored in the directory


  Client where you download an index template from the metadata definition and force index creation:


>	      elasticsearch:
>	        client:
>	          enabled: true
>	          server:
>	            host: elasticsearch.host
>	            port: 9200
>	          index:
>	            my_index:
>	              enabled: true
>	              force_operation: true
>	              definition:
>	                template: notifications
>	                settings:
>	                  number_of_shards: 5
>	                  number_of_replicas: 1
>	                mappings:
>	                  notification:
>	                    properties:
>	                      applicationId:
>	                        type: long
>	                      content:
>	                        type: text
>	                        fields:
>	                          keyword:
>	                            type: keyword
>	                            ignore_above: 256


# Formula etcd


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  mceloud


  change image url param (#7)


>	          image: etcd:latest


###  Tomáš Kukrál


  copy etcd from images
  when server.image is set then binary is copied from docker image
  etcd Formula


  Possible `source.engine`:


>	  - **pkg** - install etcd package (default)
>	  - **docker_hybrid** - copy binaries from docker image (specified in `server.image`)


  etcd proxy


  Run etcd on k8s


  Copy etcd binary from container


>	      etcd:
>	        server:
>	          image: quay.io/coreos/etcd:latest


  * https://github.com/coreos/etcd


  add support for etcd over ssl


  Certificates


  Use certificate authentication (for peers and clients). Certificates must be prepared in advance.


>	          enabled: true
>	          ssl:
>	            enabled: true
>	          bind:
>	            host: 10.0.175.101
>	          token: $(uuidgen)
>	          members:
>	          - host: 10.0.175.101
>	            name: etcd01
>	            port: 4001


# Formula ffmpeg


###  Ales Komarek


  Updated docs to rst


  ffmpeg formula


  A complete, cross-platform solution to record, convert and stream audio and video.


  Sample pillars


>	      ffmpeg:
>	        server:
>	          enabled: true
>	          input:
>	            video0:
>	              source: /dev/video0
>	              bind:
>	                host: 192.168.2.1
>	                port: 8888
>	              video_format: mjpeg
>	              width: 640
>	              height: 480
>	              format: mpeg
>	              codec: avi


>	  note: type in your browser http://192.168.2.1:8888/video0.mjpeg


  Read more


  * https://www.ffmpeg.org/


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula flower


###  Aleš Komárek


  Update and rename README.md to README.rst


  Flower Formula


  Flower is a web based tool for monitoring and administrating Celery clusters.


  Sample Pillars


  Flower single broker


>	      flower:
>	        server:
>	          enabled: true
>	          bind:
>	            port: 5555
>	            address: 0.0.0.0
>	          broker:
>	            engine: redis
>	            host: localhost
>	            port: 6379
>	            number: 0


  Flower with multiple brokers


>	          message_queue:
>	            location_hklab01:
>	              bind:
>	                port: 5555
>	                address: 0.0.0.0
>	              broker:
>	                engine: rabbitmq
>	                host: localhost
>	                port: 5672
>	                virtual_host: /test
>	                user: test
>	                password: test


  Flower with redis broker


  More Information


  * https://github.com/mher/flower


# Formula fluentbit


###  Petr Michalec


  cleanup deprecated keys + README


>	   - service.fluentbit.config.input.metrics
>	   - service.fluentbit.config.filter.stdout
>	   - service.fluentbit.config.output.influx
>	   - service.fluentbit.config.output.forward


  implement basic functionality


  Fluent Bit is an open source and multi-platform Log Forwarder which allows you to collect data/logs from different sources, unify and send them to multiple destinations. It's fully compatible with Docker and Kubernetes environments.


  **NOTE: WORK IN PROGRES**


>	  NOTE: DESIGN OF THIS FORMULA IS NOT YET STABLE AND MAY CHANGE
>	    fluentbit:
>	      enabled: true
>	      service: &service
>	        flush: 10
>	        daemon: 'on'
>	        log_level: info
>	        parsers_file: parsers.conf
>	      service:
  defaults.conf:


>	          service: \*service
  td-agent-bit.conf:


>	            - '@INCLUDE defaults.conf'


  Config files are rendered from these ``section`` sections:


>	      config:
>	        input: {}
>	        output: {}
>	        parser: {}
>	        service: {}
>	        filter: {}


  ``fluentbit:conf`` section suport syntax can be yaml, plain text or list.


  Yaml structured examples:


>	            service:
>	              flush: 10
>	            output:
>	              name: es
>	              match: '*'


>	      input:
  metrics.conf:


>	          cpu:
>	            name: cpu
>	            tag: my_cpu
>	          local_disk:
>	            name: disk
>	            tag: storage
  systemd.conf:


>	          systemd:
>	            tag: 'host.*'
>	            systemd_filter:
>	              - _SYSTEM_UNIT=*.service
>	              - _SYSTEM_UNIT=*.network
>	              - _SYSTEM_UNIT=*.boot
>	      output:
  elastic.conf:


>	          es:
>	            match: 'my*'
>	            name: es


>	          stdout:
>	            # name: stdout
>	      parser:
  custom.conf: |
  @INCLUDE parsers.conf


  Plaint text structured example:


  td-agent-bit.conf: |
  [SERVICE]


  Daemon off


  @SET KEY=VAL


  [CUSTOM]
  xyz = aaa


  @INCLUDE filters_out.conf


  List structured example is used for example for include statemetns in the main ``td-agent-bit.conf`` file:


>	            - '@INCLUDE metrics_in.conf'
>	            - '@INCLUDE elastic_out.conf'


  If the filter key may be specified multiple times, define it as a list.


>	        systemd:
>	          tag: 'host.*'
>	          systemd_filter:
>	            - _SYSTEM_UNIT=*.service
>	            - _SYSTEM_UNIT=*.boot


  You may use ``section`` in any ``fluentbit:*:*.conf`` section, but for convenience and clean pillars there is special one ``mixed`` for
  config files where you will mix individual sections and setup:


>	      mixed:
  proc.conf:


>	          proc_input:
>	            section: input
>	            name: proc
>	            tag: my_proc
>	          proc_to_stdout:
>	            section: output
>	            name: stdout


  Sample shared metadata/service pillars


  This functionality requires `<https://github.com/salt-formulas/reclass>`_
  and probably you want to reuse all features of salt-formulas and shared
  system model `<https://github.com/Mirantis/reclass-system-salt-model/blob/master/fluentbit>`_.


  There are most common pre-defined service classes for common input:


>	  classes:
>	   - system.fluentbit.single
>	   # the above should load some of these available:
>	   - service.fluentbit.support
>	   - service.fluentbit.config.input.system
>	   - service.fluentbit.config.output.stdout
  * http://fluentbit.io/


  initial configuration


  fluentbit formula


  Service fluentbit description


  Sample pillars


  Single fluentbit service


>	      fluentbit:
>	        fluentbit:
>	          enabled: true
>	          version: icehouse


  More information


  * a link


  * links


# Formula fluentd


###  Aleš Komárek


  Update and rename README.md to README.rst


  Fluentd Formula


  Many web/mobile applications generate huge amount of event logs
  (c,f. login, logout, purchase, follow, etc). Analyzing these event
  logs can be quite valuable for improving services. However, collecting
  these logs easily and reliably is a challenging task.


  Fluentd solves the problem by having: easy installation, small footprint,
  plugins reliable buffering, log forwarding, etc.


  Sample Pillars


>	  		fluentd:
>	  		  server:
>	  		    enabled: true
>	  		    plugins:
>	  		    - fluent-plugin-elasticsearch
>	  		    - fluent-plugin-mongo
>	  		    config:
>	  		    - name: forward
>	  		      type: input
>	  		      bind:
>	  		        port: 24224
>	  		        host: 0.0.0.0
>	  		    - name: elasticsearch
>	  		      type: output
>	  		        port: 9200
>	  		        host: localhost
>	  		    - name: mongodb
>	  		      	port: localhost
>	  		      	host: localhost


  More Information


  * http://fluentd.org/
  * http://docs.fluentd.org/
  * http://docs.fluentd.org/categories/recipes


###  Bartosz Kupidura


  Fluentd initial commit
  **NOTE: WORK IN PROGRES**


>	  NOTE: DESIGN OF THIS FORMULA IS NOT YET STABLE AND MAY CHANGE
>	  NOTE: FORMULA NOT COMPATIBLE WITH OLD VERSION


  General pillar structure


>	    fluentd:
>	      config:
>	        label:
>	          filename:
>	            input:
>	              input_name:
  params


>	            filter:
>	              filter_name:


>	              filter_name2:


>	            match:
>	              match_name:


>	        input:
>	            input_name:


>	            input_name2:


>	          filename2:
>	            input_name3:


>	        filter:
>	            filter_name:


>	            filter_name2:


>	            filter_name3:


>	        match:
>	            match_name:


  Example pillar


>	      enabled: true
>	          monitoring:
>	              parse_log:
>	                tag: 'docker.monitoring.{alertmanager,remote_storage_adapter,prometheus}.*'
>	                type: parser
>	                reserve_data: true
>	                key_name: log
>	                parser:
>	                  type: regexp
>	                  format: >-
  /^time="(?<time>[^ ]*)" level=(?<severity>[a-zA-Z]*) msg="(?<message>.+?)"/


>	                  time_format: '%FT%TZ'
>	              remove_log_key:
>	                type: record_transformer
>	                remove_keys: log
>	              docker_log:
>	                tag: 'docker.**'
>	                type: file
>	                path: /tmp/flow-docker.log
>	          grok_example:
>	              test_log:
>	                type: tail
>	                path: /var/log/test
>	                tag: test.test
>	                  type: grok
>	                  custom_pattern_path: /etc/td-agent/config.d/global.grok
>	                  rule:
>	                    - pattern: >-
  %{KEYSTONEACCESS}


>	          syslog:
>	              add_severity:
>	                tag: 'syslog.*'
>	                enable_ruby: true
>	                record:
>	                  - name: severity
>	                    value: 'record["pri"].to_i - (record["pri"].to_i / 8).floor * 8'
>	              severity_to_string:
>	                    value: '{"debug"=>7,"info"=>6,"notice"=>5,"warning"=>4,"error"=>3,"critical"=>2,"alert"=>1,"emerg"=>0}.key(record["severity"])'
>	              severity_for_telegraf:
>	                tag: 'syslog.*.telegraf'
>	                key_name: message
  /^(?<time>[^ ]*) (?<severity>[A-Z])! (?<message>.*)/


>	              severity_for_telegraf_string:
>	                    value: '{"debug"=>"D","info"=>"I","notice"=>"N","warning"=>"W","error"=>"E","critical"=>"C","alert"=>"A","emerg"=>"E"}.key(record["severity"])'
>	              prometheus_metric:
>	                tag: 'syslog.*.*'
>	                type: prometheus
>	                label:
>	                  - name: ident
>	                    type: variable
>	                    value: ident
>	                    value: severity
>	                metric:
>	                  - name: log_messages
>	                    type: counter
>	                    desc: The total number of log messages.
>	              rewrite_tag_key:
>	                type: rewrite_tag_filter
>	                rule:
>	                    regexp: '^(.*)'
>	                    result: '__TAG__.$1'
>	              syslog_log:
>	                path: /tmp/syslog
>	            syslog_log:
>	              type: tail
>	              label: syslog
>	              path: /var/log/syslog
>	              tag: syslog.syslog
>	              parser:
>	                type: regexp
>	                format: >-
  '/^\<(?<pri>[0-9]+)\>(?<time>[^ ]*) (?<host>[^ ]*) (?<ident>[a-zA-Z0-9_\/\.\-]*)(?:\[(?<pid>[0-9]+)\])?(?:[^\:]*\:)? *(?<message>.*)$/'


>	                time_format: '%FT%T.%L%:z'
>	            auth_log:
>	              path: /var/log/auth.log
>	              tag: syslog.auth


>	          prometheus:
>	            prometheus:
>	              type: prometheus
>	            prometheus_monitor:
>	              type: prometheus_monitor
>	            prometheus_output_monitor:
>	              type: prometheus_output_monitor
>	          forward:
>	            forward_listen:
>	              type: forward
>	              port: 24224
>	              bind: 0.0.0.0
>	          docker_monitoring:
>	            docker_monitoring:
>	              tag: 'docker.monitoring.{alertmanager,remote_storage_adapter,prometheus}.*'
>	              type: relabel
>	              label: monitoring


# Formula foreman


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme
  * http://mauricio.github.io/2014/02/09/foreman-and-environment-variables.html


# Formula freeipa


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  James Shewey


  Filename was incorrect


  FreeIPA


  This forumla installs and configured the FreeIPA Identity Management service 
  and client.


  Sample pillars


  Client


>	      freeipa:
>	        client:
>	          enabled: true
>	          server: ipa.example.com
>	          domain: {{ salt['grains.get']('domain', '') }}
>	          realm: {{ salt['grains.get']('domain', '').upper() }}
>	          hostname: {{ salt['grains.get']('fqdn', '') }}


  To automatically register the client with FreeIPA, you will first need to 
  create a Kerberos principal. Start by creating a service account in FreeIPA. 


  You may wish to restrict that users permissions to only host creation (see https://www.freeipa.org/page/HowTos#Working_with_FreeIPA). Next, you will 
  need to obtain a kerberos ticket as admin on the IPA server, then generate
  a service account principal.


  ``kinit admin``


  ``ipa-getkeytab -p service-account@EXAMPLE.com -k ./principal.keytab -s freeipahost.example.com``


  ``scp ./principal.keytab user@saltmaster.example.com:/srv/salt/freeipa/files/principal.keytab``


  Then add to your pillar:


>	          install_principal:
>	            source: salt://freeipa/files/principal.keytab
>	            mode: 0600
>	            principal_user: "service-account"
>	            file_user: "root"
>	            file_group: "root"


  This will allow your client to use FreeIPA's JSON interface to create a host 
  entry with a One Time Password and then register to the FreeIPA server. For 
  security purposes, the kerberos principal will only be pushed down to the client 
  if the installer reports it is not registered to the FreeIPA server and will be 
  removed from the client as soon as the endpoint has registered with the FreeIPA 
  server.


  Additionally, the openssh formula (see 


>	  https://github.com/salt-formulas/salt-formula-openssh) is needed and is a 
  dependency for this formula. Configure it thusly:


>	      openssh:
>	        server:
>	          public_key_auth: true
>	          gssapi_auth: true
>	          kerberos_auth: false
>	          authorized_keys_command:
>	            command: /usr/bin/sss_ssh_authorizedkeys
>	            user: nobody


  If you wish to update DNS records using nsupdate, add:


>	          nsupdate:
>	            - name: test.example.com
>	              ipv4:
>	                - 8.8.8.8
>	              ipv6:
>	                - 2a00:1450:4001:80a::1009
>	              ttl: 1800
>	              keytab: /etc/krb5.keytab


  For requesting certificates using certmonger:


>	          cert:
  "HTTP/www.example.com":


>	              user: root
>	              group: www-data
>	              mode: 640
>	              cert: /etc/ssl/certs/http-www.example.com.crt
>	              key: /etc/ssl/private/http-www.example.com.key


  Server


>	          realm: IPA.EXAMPLE.COM
>	          domain: ipa.example.com
>	          admin:
>	            password: secretpassword
>	          ldap:


  Server definition for new verion of freeipa (4.3+). Replicas dont require 
  generation of gpg file on master. But principal user has to be defined with


>	          principal_user: admin
>	          servers:
>	          - idm01.ipa.example.com
>	          - idm02.ipa.example.com
>	          - idm03.ipa.example.com


  Disable CA. Default is True.


>	          ca: false


  Disable LDAP access logs but enable audit


>	            logging:
>	              access: false
>	              audit: true


  Read more


  * http://www.freeipa.org/page/Quick_Start_Guide


  Add automatic host attachment (#2)


  First draft of preinstaller module which uses a keytab and JSON interface to programattically execute ipa host-add on the freeipa server to create our own host entry to attach to. I am sure there are bugs.


>	    DeprecationWarning: Starting in 2015.5, cmd.run uses python_shell=False by default, which doesn't support shellisms (pipes, env variables, etc). cmd.run is currently aliased to cmd.shell to prevent breakage. Please switch to cmd.shell or set python_shell=True to avoid breakage in the future, when this aliasing is removed.


  This reverts commit 0573511f430f1fd2c7ea7c62c506e0de78d4ff4d.


  This reverts commit dd6f14fd80496f8e9449ac9d18be15995a3b40c5.


  This reverts commit a93b43bc120f6da48cfd70c0a88ecb1f45fb019b.


  This reverts commit 9f15c957d3e5d4706dae13df6a4008230b2b590e.


  This reverts commit 64bb556864087310f5e0256268d2a0238e7ba579.


  This reverts commit bd85a2855146541757eacabb4f897e2ee0db699f.


  This reverts commit a812734a659d340cbdc8027d56ca854daaee2b17.


  Needed to specify file user permissions separate from principal permissions because user doesn't exist on the system yet, so can't be the file owner.


  Verified on my setup


###  Ondrej Smola


  added support for new version of freeipa cluster installation


  Server definition for new verion of freeipa (4.3+). Replicas dont require generation of gpg file on master. But principal user has to be defined with


# Formula galera


###  Dmitry Kalashnik


  Add new soft parameters


  Make max_connections and innodb_buffer_pool_size configurable
  through soft params instead of hard.


  Configurable soft parameters


>	  - **galera_innodb_buffer_pool_size** - the default value is 3138M
>	  - **galera_max_connections** - the default value is 20000
>	      _param:
>	        galera_innodb_buffer_pool_size: 1024M
>	        galera_max_connections: 200 


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Kirill Bespalov


  Galera cluster TLS Support


  Enable TLS support:


>	      galera:
  slave or master:


>	           ssl:
>	            enabled: True


>	            # path
>	            cert_file: /etc/mysql/ssl/cert.pem
>	            key_file: /etc/mysql/ssl/key.pem
>	            ca_file: /etc/mysql/ssl/ca.pem


>	            # content (not required if files already exists)
>	            key: << body of key >>
>	            cert: << body of cert >>
>	            cacert_chain: << body of ca certs chain >>


>	        galera_max_connections: 200


  Make innodb_buffer_pool_size configurable


>	    Usage:


  If innodb_buffer_pool_size is not set then 35% of the available
  ram will be allocated for the buffer pool.


  InnoDB parameters


>	  - **innodb_buffer_pool_size** - the default value is 35% of the available ram


>	  Usage:


>	          master:
>	            innodb_buffer_pool_size: 1024M
>	          slave:


  Enter current password for root (enter for none):


  New password:


  Re-enter new password:
  6. uncomment all wsrep* lines except first server, where leave only in my.cnf wsrep_cluster_address='gcomm://';


###  Petr Michalec


  Version specified on pillar


>	        version:
>	          mysql: 5.6
>	          galera: 3


  add clustercheck script (avoid splitbrain)


>	                  - grant_option: True


  Additional check params:


>	        clustercheck:
>	          - enabled: True
>	          - user: clustercheck
>	          - password: clustercheck
>	          - available_when_donor: 0
>	          - available_when_readonly: 1
>	          - port 9200


  Additional users


  Additional mysql users:


>	      mysql:
>	        server:
>	          users:
>	            - name: clustercheck
>	              password: clustercheck
>	              database: '*.*'
>	              grants: PROCESS
>	              grant_option: False
>	            - name: inspector
>	              host: 127.0.0.1
>	              password: password
>	              databases:
>	                mydb:
>	                  - database: mydb
>	                  - table: mytable
>	                  - grant_option: False
>	                  - grants:
>	                    - all privileges


# Formula galera2


###  Dmitry Kalashnik


  Add new soft parameters


  Make max_connections and innodb_buffer_pool_size configurable
  through soft params instead of hard.


  Configurable soft parameters


>	  - **galera_innodb_buffer_pool_size** - the default value is 3138M
>	  - **galera_max_connections** - the default value is 20000
>	      _param:
>	        galera_innodb_buffer_pool_size: 1024M
>	        galera_max_connections: 200 


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Kirill Bespalov


  Galera cluster TLS Support


  Enable TLS support:


>	      galera:
  slave or master:


>	           ssl:
>	            enabled: True


>	            # path
>	            cert_file: /etc/mysql/ssl/cert.pem
>	            key_file: /etc/mysql/ssl/key.pem
>	            ca_file: /etc/mysql/ssl/ca.pem


>	            # content (not required if files already exists)
>	            key: << body of key >>
>	            cert: << body of cert >>
>	            cacert_chain: << body of ca certs chain >>


>	        galera_max_connections: 200


  Make innodb_buffer_pool_size configurable


>	    Usage:


  If innodb_buffer_pool_size is not set then 35% of the available
  ram will be allocated for the buffer pool.


  InnoDB parameters


>	  - **innodb_buffer_pool_size** - the default value is 35% of the available ram


>	  Usage:


>	          master:
>	            innodb_buffer_pool_size: 1024M
>	          slave:


  Enter current password for root (enter for none):


  New password:


  Re-enter new password:
  6. uncomment all wsrep* lines except first server, where leave only in my.cnf wsrep_cluster_address='gcomm://';


###  Petr Michalec


  Version specified on pillar


>	        version:
>	          mysql: 5.6
>	          galera: 3


  add clustercheck script (avoid splitbrain)


>	                  - grant_option: True


  Additional check params:


>	        clustercheck:
>	          - enabled: True
>	          - user: clustercheck
>	          - password: clustercheck
>	          - available_when_donor: 0
>	          - available_when_readonly: 1
>	          - port 9200


  Additional users


  Additional mysql users:


>	      mysql:
>	        server:
>	          users:
>	            - name: clustercheck
>	              password: clustercheck
>	              database: '*.*'
>	              grants: PROCESS
>	              grant_option: False
>	            - name: inspector
>	              host: 127.0.0.1
>	              password: password
>	              databases:
>	                mydb:
>	                  - database: mydb
>	                  - table: mytable
>	                  - grant_option: False
>	                  - grants:
>	                    - all privileges


# Formula galera3


###  Dmitry Kalashnik


  Add new soft parameters


  Make max_connections and innodb_buffer_pool_size configurable
  through soft params instead of hard.


  Configurable soft parameters


>	  - **galera_innodb_buffer_pool_size** - the default value is 3138M
>	  - **galera_max_connections** - the default value is 20000
>	      _param:
>	        galera_innodb_buffer_pool_size: 1024M
>	        galera_max_connections: 200 


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Kirill Bespalov


  Galera cluster TLS Support


  Enable TLS support:


>	      galera:
  slave or master:


>	           ssl:
>	            enabled: True


>	            # path
>	            cert_file: /etc/mysql/ssl/cert.pem
>	            key_file: /etc/mysql/ssl/key.pem
>	            ca_file: /etc/mysql/ssl/ca.pem


>	            # content (not required if files already exists)
>	            key: << body of key >>
>	            cert: << body of cert >>
>	            cacert_chain: << body of ca certs chain >>


>	        galera_max_connections: 200


  Make innodb_buffer_pool_size configurable


>	    Usage:


  If innodb_buffer_pool_size is not set then 35% of the available
  ram will be allocated for the buffer pool.


  InnoDB parameters


>	  - **innodb_buffer_pool_size** - the default value is 35% of the available ram


>	  Usage:


>	          master:
>	            innodb_buffer_pool_size: 1024M
>	          slave:


  Enter current password for root (enter for none):


  New password:


  Re-enter new password:
  6. uncomment all wsrep* lines except first server, where leave only in my.cnf wsrep_cluster_address='gcomm://';


###  Petr Michalec


  add clustercheck script (avoid splitbrain)


>	                  - grant_option: True


  Additional check params:


>	        clustercheck:
>	          - enabled: True
>	          - user: clustercheck
>	          - password: clustercheck
>	          - available_when_donor: 0
>	          - available_when_readonly: 1
>	          - port 9200


  Additional users


  Additional mysql users:


>	      mysql:
>	        server:
>	          users:
>	            - name: clustercheck
>	              password: clustercheck
>	              database: '*.*'
>	              grants: PROCESS
>	              grant_option: False
>	            - name: inspector
>	              host: 127.0.0.1
>	              password: password
>	              databases:
>	                mydb:
>	                  - database: mydb
>	                  - table: mytable
>	                  - grant_option: False
>	                  - grants:
>	                    - all privileges


# Formula gateone


###  Aleš Komárek


  Update README.rst


  GateOne Formula


  Sample Pillars


  More Information


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula gerrit


###  Alexander Noskov


  Add possibility to inherit access for project from another project


>	              inherit_access: All-Projects


  By default "Submit Type" is: merge if necessary


>	              action: "fast forward only"


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula git


###  Ales Komarek


  Docfixes


###  Botond Zoltán


  Add SSL varification related examples


  This change adds the SSL verification related examples to the
  readme file.


  GIT with user and SSL setup


>	      git:
>	        client:
>	          disable_ssl_verification: True
>	          enabled: true
>	          user:
>	          - user:
>	              name: jdoe
>	              email: j@doe.com


  Reclass with GIT with user and SSL setup


>	          - user: ${linux:system:user:jdoe}


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Richard Felkl


  added support for custom git repos + mirror fix


>	            - name: custom-repo-1
>	            - name: custom-repo-2


  Reclass with GIT over HTTP server setup. Requires web server. Mirrored upsream repos example.


>	        server:
>	          directory: /srv/git
>	          repos:


  introduced git.server role


  Reclass with GIT over HTTP server setup. Requires web server.


>	            - name: gerritlib
>	              url: https://github.com/openstack-infra/gerritlib.git
>	            - name: jeepyb
>	              url: https://github.com/openstack-infra/jeepyb.git


# Formula gitlab


###  Ales Komarek


  doc fixes


  Gitlab server with local MTA and PostgreSQL database


>	            engine: 'postgresql'
>	          server_name: 'repo1.domain.com'


  Gitlab repository enforcement with import url repository and deploy keys and
  hooks.


  docfixes


  Sample metadata


>	          source:
>	            engine: pkg
>	            from: 'gitlab@domain.com'
>	            no_reply: 'no-reply@domain.com'
>	          server_name: 'repo.domain.com'


  More information


  Documentation cleanup


  Gitlab formula


  Gitlab is a free git repository management application based on Ruby on Rails.


  It is distributed under the MIT License and its source code can be found on


  Github. It is a very active project with a monthly release cycle and ideal for
  businesses that want to keep their code private. Consider it as a self hosted


  Github but open source.


  Server role


  Client role


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula gitolite


###  Filip Pytloun


  Fix readme


>	      server:
>	        user:
>	          testusr:
>	            key: ssh-rsa ...
>	        group:
>	          admin:
>	            members:
>	              - testusr
>	        repository:
>	          gitolite-admin:
>	            name: gitolite-admin
>	            permission:
  "RW+":


>	                - "@admin"
  "RW (?!master|develop|release/)":


>	                - testusr


  Initial commit


  gitolite formula


  Service gitolite description


  Sample pillars


  Single gitolite service


>	  server:
>	    user:
>	      testusr:
>	        key: ssh-rsa ...
>	    group:
>	      admin:
>	        members:
>	          - testusr
>	    repository:
>	      gitolite-admin:
>	        name: gitolite-admin
>	        permission:


>	            - "@admin"


>	            - testusr


  More information


  * http://gitolite.com/gitolite/index.html


  * links


# Formula glance


###  Aleš Komárek


  Update README.rst


  Glance formula


  Sample pillars


  Keystone and cinder region


>	      glance:
>	        server:
>	          enabled: true
>	          version: kilo
  ...


>	          identity:
>	            engine: keystone
>	            host: 127.0.0.1
>	            region: RegionTwo


  Ceph integration glance


>	          version: juno
>	          storage:
>	            engine: rbd,http
>	            user: glance
>	            pool: images
>	            chunk_size: 8
>	            client_glance_key: AQDOavlU6BsSJhAAnpFR906mvdgdfRqLHwu0Uw==


  RabbitMQ HA setup


  Enable auditing filter (CADF):


  Client role


  Glance images


>	    glance:
>	      client:
>	        enabled: true
>	          profile_admin:
>	            image:
>	              cirros-test:
>	                visibility: public
>	                protected: false
>	                location: http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-i386-disk.img


  Usage


  Import new public image


>	      glance image-create --name 'Windows 7 x86_64' --is-public true --container-format bare --disk-format qcow2  < ./win7.qcow2


  Change new image's disk properties


>	      glance image-update "Windows 7 x86_64" --property hw_disk_bus=ide


  Change new image's NIC properties


>	      glance image-update "Windows 7 x86_64" --property hw_vif_model=rtl8139


  External links


###  Dmitry Stremkovskiy


  Unhardcode glance user/group uid/gid values


  Warn to not change glance uid/gid values after user is created


>	          glance_uid: 302
>	          glance_gid: 302


###  Dmitry Ukov


  Policy.json should be defined by user


  User can override and add values to policy.json by creating flat
  key-value structure under glance:server:policy.


  Configuration of policy.json file


  ....


>	          policy:
>	            publicize_image: "role:admin"
>	            # Add key without value to remove line from policy.json
>	            add_member:


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Kirill Bespalov


  RabbitMQ TLS support


  OSCORE-380


>	    Releases: Mitaka, Newton, Ocata
>	    Usage: see README.rst


  Client-side RabbitMQ TLS configuration:


  To enable TLS for oslo.messaging you need to provide the CA certificate.


  By default system-wide CA certs are used. Nothing should be specified except `ssl.enabled`.


>	      server:


>	        message_queue:
>	          ssl:
>	            enabled: True


  Use `cacert_file` option to specify the CA-cert file path explicitly:


>	            cacert_file: /etc/ssl/rabbitmq-ca.pem


  To manage content of the `cacert_file` use the `cacert` option:


>	            cacert: |


>	            cacert_file: /etc/openstack/rabbitmq-ca.pem


>	  Notice:
  * The `message_queue.port` is set to **5671** (AMQPS) by default if `ssl.enabled=True`.
  * Use `message_queue.ssl.version` if you need to specify protocol version. By default is TLSv1 for python < 2.7.9 and TLSv1_2 for version above.


###  Michel Nederlof


  Add support for showing / returing multiple locations (#8)


  Enable Viewing Multiple Locations


  If you want to expose all locations available (for example when you have
  multiple backends configured), then you can configure this like so:


>	          show_multiple_locations: True
>	          location_strategy: store_type
>	          store_type_preference: rbd,swift,file


  Please note: the show_multiple_locations option is deprecated since Newton and is planned
  to be handled by policy files _only_ starting with the Pike release.


  This feature is convenient in a scenario when you have swift and rbd configured and want to
  benefit from rbd enhancements.


  Adding support for (multiple) swift backends (#7)


  Another way, which also supports multiple swift backends, can be configured like this:


>	          version: mitaka
>	            engine: swift,http
>	            swift:
>	              store:
>	                endpoint_type: publicURL
>	                container: glance
>	                create_container_on_put: true
>	                retry_get_count: 5
>	                references:
>	                  my_objectstore_reference_1:
>	                    auth:
>	                      address: http://keystone.example.com:5000/v2.0
>	                      version: 2
>	                    user: 2ec7966596504f59acc3a76b3b9d9291:glance-user
>	                    key: someRandomPassword


###  mnederlof


  Allow ability to use image cache (#5)


  Enable Glance Image Cache:


>	          image_cache:
>	            enabled: true
>	            enable_management: true
>	            directory: /var/lib/glance/image-cache/
>	            max_size: 21474836480


###  Oleg Iurchenko


  Add Barbican integration


  This patch adds Barbican integration to Glance


>	          barbican:


  Barbican integration glance


>	            barbican:
>	              enabled: true


###  Ondrej Smola


  enable support for cors params


  Enable CORS parameters


>	          cors:
>	            allowed_origin: https:localhost.local,http:localhost.local
>	            expose_headers: X-Auth-Token,X-Openstack-Request-Id,X-Subject-Token
>	            allow_methods: GET,PUT,POST,DELETE,PATCH
>	            allow_headers: X-Auth-Token,X-Openstack-Request-Id,X-Subject-Token
>	            allow_credentials: True
>	            max_age: 86400


###  Petr Michalec


  update readme, cirros image url and add it to tests


>	          - name: "CirrOS"
>	            file: cirros-0.4.0-x86_64-disk.img
>	            source: https://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img
>	            visibility: true


###  Richard Felkl


  Introduce glance client role


###  RobertJansen1


  swift as glance backend (#2)


  This reverts commit 4fdd899db23cdb9e26c158b74397ede79495a136.


  Swift integration glance


>	                auth:
>	                  address: http://keystone.example.com:5000/v2.0
>	                  version: 2
>	                user: 2ec7966596504f59acc3a76b3b9d9291:glance-user
>	                key: someRandomPassword


###  Simon Pasquier


  Allow to configure the pagination parameters


>	          api_limit_max: 100
>	          limit_param_default: 50


  The pagination is controlled by the *api_limit_max* and *limit_param_default*
  parameters as shown above:


  * *api_limit_max* defines the maximum number of records that the server will
  return.


  * *limit_param_default* is the default *limit* parameter that
  applies if the request didn't defined it explicitly.


# Formula glusterfs


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula gnocchi


# Formula gource


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula grafana


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Guillaume Thouvenin


  Allow the installation of Grafana plugins


  Server with two additionals plugins. It requires to have access to the Internet.


>	      grafana:
>	        server:
>	          enabled: true
>	          plugins:
>	            grafana-piechart-panel:
>	              enabled: true
>	            grafana-example-app:


# Formula graphite


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula haproxy


###  Adam Tengler


  Add support for tcp-check and http-check configuration


  Custom listener with tcp-check options specified (for Redis cluster with Sentinel)


>	    haproxy:
>	      proxy:
>	        listen:
>	          redis_cluster:
>	            service_name: redis
>	            check:
>	              tcp:
>	                enabled: True
>	                options:
>	                  - send PING\r\n
>	                  - expect string +PONG
>	                  - send info\ replication\r\n
>	                  - expect string role:master
>	                  - send QUIT\r\n
>	                  - expect string +OK
>	            binds:
>	              - address: ${_param:cluster_address}
>	                port: 6379
>	            servers:
>	              - name: ${_param:cluster_node01_name}
>	                host: ${_param:cluster_node01_address}
>	                params: check inter 1s
>	              - name: ${_param:cluster_node02_name}
>	                host: ${_param:cluster_node02_address}
>	              - name: ${_param:cluster_node03_name}
>	                host: ${_param:cluster_node03_address}


###  Brian McQueen


  readme to change listens to listen and bind to binds


>	          listen:
>	            https-in:
>	              binds:
>	              - address: 0.0.0.0
>	                port: 443
>	              servers:
>	              - name: server1
>	                host: 10.0.0.1
>	                port: 8443
>	              - name: server2
>	                host: 10.0.0.2
>	                params: 'maxconn 256'
>	                address: 0.0.0.0
>	            listen:
>	              mysql:
>	                type: mysql
>	                binds:
>	                - address: 10.0.88.70
>	                  port: 3306
>	                servers:
>	                - name: node1
>	                  host: 10.0.88.13
>	                  params: check inter 15s fastinter 2s downinter 1s rise 5 fall 3
>	                - name: node2
>	                  host: 10.0.88.14
>	                  params: check inter 15s fastinter 2s downinter 1s rise 5 fall 3 backup
>	                - name: node3
>	                  host: 10.0.88.15
>	              rabbitmq:
>	                type: rabbitmq
>	                  port: 5672
>	                  port: 5673
>	                  params: check inter 5000 rise 2 fall 3
>	                  params: check inter 5000 rise 2 fall 3 backup
>	              keystone-1:
>	                type: general-service
>	                - address: 10.0.106.170
>	                  port: 5000
>	                  params: check


###  Filip Pytloun


  Add support for deploying SSL certificates


  It's also possible to use multiple certificates for one listener (eg. when
  it's bind on multiple interfaces):


>	      haproxy:
>	        proxy:
>	            dummy_site:
>	              mode: http
>	                - address: 127.0.0.1
>	                  port: 8080
>	                  ssl:
>	                    enabled: true
>	                    key: |
  my super secret key follows


>	                    cert: |
  certificate


>	                    chain: |


  CA chain (if any)


>	                - address: 127.0.1.1
>	                  port: 8081


  Definition above will result in creation of ``/etc/haproxy/ssl/dummy_site``
  directory with files ``1-all.pem`` and ``2-all.pem`` (per binds).


  Unify Makefile, .gitignore and update readme


###  Guillaume Thouvenin


  Renamed the key 'check' into 'health-check'


  The key 'check' is already used in meta/heka.yml to enable/disable the
  monitoring of the haproxy backends.


>	            health-check:


###  Ildar Svetlov


  Add customizable forwardfor option


  The Reliable, High Performance TCP/HTTP Load Balancer.


>	                params: check inter 5000 rise 2 fall 3


  Enable customisable ``forwardfor`` option in ``defaults`` section.


>	        enabled: true
>	        mode: tcp
>	        logging: syslog
>	        max_connections: 1024
>	        forwardfor:
>	          enabled: true
>	          except:
>	          header:
>	          if-none: false


>	          except: 127.0.0.1
>	          header: X-Real-IP


###  Sergey Otpuschennikov


  Add ability to create redirect


  Frontend for routing between exists listeners via URL with SSL an redirects.


  You can use one backend for several URLs.


>	          service_proxy:
>	            mode: http
>	            balance: source
>	            format: end
>	             - address: ${_param:haproxy_bind_address}
>	               port: 80
>	               ssl: ${_param:haproxy_frontend_ssl}
>	               ssl_port: 443
>	            redirects:
>	             - code: 301
>	               location: domain.com/images
>	               conditions:
>	                 - type: hdr_dom(host)
>	                   condition: images.domain.com
>	            acls:
>	             - name: gerrit
>	                   condition: gerrit.domain.com
>	             - name: jenkins
>	                   condition: jenkins.domain.com
>	             - name: docker
>	               backend: artifactroy
>	                   condition: docker.domain.com


# Formula heat


###  Aleš Komárek


  Update README.rst


  Heat Formula


  Sample Pillars


###  Dennis Dmitriev


  Allow keystone endpoint_type interpolation for Heat clients


>	            endpoint_type_default: internalURL
>	            endpoint_type_heat: publicURL


###  Dmitry Stremkouski


  One should have an ability to set up max_nested_stack_depth option


  Customer requires from us to set up max_nested_stack_depth in
  heat.conf.


  This option is not enabled and has value of 5 by default.


  We need to enable this option in templates so customer would be
  able to set it to a desired value.


  Customer-Found


  PROD-15878


>	          max_nested_stack_depth: 10


  One should have an ability to set up max_stacks_per_tenant option


  Customer requires from us to set up max_stacks_per_tenant in


  This option is not enabled and has value of 100 by default.


  PROD-15877


>	          max_stacks_per_tenant: 150


###  Dmitry Ukov


  Policy.json should be defined by user


  User can override and add values to policy.json by creating flat
  key-value structure under heat:server:policy.


  Configuration of policy.json file


>	      heat:
>	        server:
  ....


>	          policy:
>	            deny_stack_user: 'not role:heat_stack_user'
  'cloudformation:ValidateTemplate': 'rule:deny_stack_user'


>	            # Add key without value to remove line from policy.json
  'cloudformation:DescribeStackResource':


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


>	      https://wiki.openstack.org/wiki/Meetings/openstack-salt


###  Jiri Broulik


  iterate and enforce multiple git repos


>	          template:
>	            admin:
>	              domain: default
>	              source:
>	                engine: git
>	                address: git@repo.domain.com/admin-templates.git
>	                revision: master
>	            default:
>	                address: git@repo.domain.com/default-templates.git


###  Kirill Bespalov


  RabbitMQ TLS support


  OSCORE-387


>	    Releases: Mitaka, Newton, Ocata
>	    Usage: see README.rst


  Heat system definition of several stacks/systems


  Client-side RabbitMQ TLS configuration:


  |


  To enable TLS for oslo.messaging you need to provide the CA certificate.


  By default system-wide CA certs are used. Nothing should be specified except `ssl.enabled`.


>	        message_queue:
>	          ssl:
>	            enabled: True


  Use `cacert_file` param to specify the CA-cert file location explicitly:


>	            cacert_file: /etc/ssl/rabbitmq-ca.pem


  To manage content of the `cacert_file` use the `cacert` param:


>	            cacert: { file content here }
>	            cacert_file: /etc/openstack/rabbitmq-ca.pem


>	  Notice:
  * The `message_queue.port` is set to **5671** (AMQPS) by default if `ssl.enabled=True`.
  * Use `message_queue.ssl.version` if you need to specify protocol version. By default is TLSv1 for python < 2.7.9 and TLSv1_2 for version above.


###  Oleksii Chupryn


  Add ability to configure protocol for


>	              protocol: http


###  Ondrej Smola


  parametrized heat clients_keystone paramater


  Define server clients keystone parameter


>	          clients:
>	            keystone:
>	              protocol: https
>	              host: 10.0.106.10
>	              port: 5000
>	              insecure: false


  enable support for cors params


  Enable CORS parameters


>	          cors:
>	            allowed_origin: https:localhost.local,http:localhost.local
>	            expose_headers: X-Auth-Token,X-Openstack-Request-Id,X-Subject-Token
>	            allow_methods: GET,PUT,POST,DELETE,PATCH
>	            allow_headers: X-Auth-Token,X-Openstack-Request-Id,X-Subject-Token
>	            allow_credentials: True
>	            max_age: 86400


# Formula heka


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Ildar Svetlov


  Make max_message_size customizable


>	          max_message_size: 262144
  * ``max_message_size: 262144``


# Formula helm


###  Ales Komarek


  Doc cleanup, introduced environmental params


  Helm formula


  More Information


  * https://github.com/kubernetes/charts
  * https://fabric8.io/helm/


###  Petr Michalec


  Rebase to master + minor updates
  which just re-call the helm.release_managed


  such as the version of `kubectl` to install and the path where the binary should


  Optionally installs a Tiller deployment to the Kubernetes cluster per the


###  tmeneau


>	    task: make changes requested in code review


  The changes included with this commit are:
  binaries


  See the [default reclass pillar configuration](metadata/service/client.yml) for 
  a documented example pillar file.


>	    fix: change detection and speed for releases_managed
  for most of the Helm global parameters)


  Refs salt-formulas/salt-formula-helm#6


  Refs salt-formulas/salt-formula-helm#9
  manages releases in it.


  Availale States


  The default state applied by this formula (e.g. if just applying `helm`) will
  apply the `helm.releases_managed` state.


  `kubectl_installed`


  Optionally installs the kubectl binary per the configured pillar values,
  such as the version of `kubectl` to instlal and the path where the binary should
  be installed.


  `kubectl_configured`


  Manages a kubectl configuration file and gce_token json file per the configured
  pillar values. Note that the available configuration values allow the path of
  the kube config file to be placed at a different location than the default 
  installation path; this is recommended to avoid confusion if the kubectl 
  binary on the minion might be manually used with multiple contexts.


  **includes**:
  * `kubectl_installed`


  `client_installed`


  Installs the helm client binary per the configured pillar values, such as where 
  helm home should be, which version of the helm binary to install and that path
  for the helm binary.


  * `kubectl_installed


  `tiller_installed`


  Optionally installs a Tiller deployment to the kubernetes cluster per the
  `helm:client:tiller:install` pillar value. If the pillar value is set to 
  install tiller to the cluster, the version of the tiller installation will
  match the version of the Helm client installed per the `helm:client:version`
  configuration parameter


  * `client_installed`
  * `kubectl_configured`


  `repos_managed`


  Ensures the repositories configured per the pillar (and only those repositories) 
  are registered at the configured helm home, and synchronizes the local cache 
  with the remote repository with each state execution.


  `releases_managed`


  Ensures the releases configured with the pillar are in the expected state with
  the Kubernetes cluster. This state includes change detection to determine 
  whether the pillar configurations match the release's state in the cluster.


  Note that changes to an existing release's namespace will trigger a deletion and 
  re-installation of the release to the cluster.


  * `tiller_installed`
  * `repos_managed`


  Availale Modules


  To view documentation on the available modules, run: 


  `salt '{{ tgt }}' sys.doc helm`


  Known Issues


  1. Unable to remove all user supplied values


  If a release previously has had user supplied value overrides (via the 
  release's `values` key in the pillar), subsequently removing all `values`
  overrides (so that there is no more `values` key for the release in the 
  pillar) will not actually update the Helm deployment. To get around this,
  specify a fake key/value pair in the release's pillar; Tiller will override
  all previously user-supplied values with the new fake key and value. For 


>	  example:


>	      helm:
>	        client:
>	          releases:
>	            zoo1:
>	              enabled: true
  ...


>	              values:
>	                fake_key: fake_value


>	    fix: split client.sls into distinct, dedicated SLS files


  Additionally export a `constants` dict from the `map.jinja` to handle
  any shared or verbose constants — such as file paths, environment
  variables, etc… — and make the individual SLS files more concise. Also,
  fix a minor logic issue introduced in commit c42a332 that would not
  reference the kubectl configuration managed by this formula if the
  kubectl binary is not installed by the formula.


  Fixes salt-formulas/salt-formula-helm#8


  The default pillar configuration will install the helm client on the target 
  node, and Tiller to the Kubernetes cluster (assuming kubectl config or local 
  cluster endpoint have already been configured.


>	    fix: add sensible defaults and defensive property references


  Additionally deprecate certain duplicated or unnecessary configuration
  parameters, such as:
  version


>	    helm:client:bind:address
  since that’s an implementation detail of the formula that shouldn’t
  matter to consumers


  Fixes salt-formulas/salt-formula-helm#2


  See the [pillar.example](pillar.example) for a documented example pillar file.


  Example Configurations


  _The following examples demonstrate configuring the formula for different
  use cases._


>	          version: 2.6.0  # defaults to 2.6.2 currently
>	              # directly translated to cluster definition in kubeconfig
>	              cluster: 
>	              cluster_name: kubernetes.example
>	              # directly translated to user definition in kubeconfig
>	              user:
>	              user_name: admin 
>	              cluster:
>	              user_name: gce_user


###  Yuriy Taraday


  Add user guide


  Helm Formula README


  Add pillar examples to README


  This formula installs Helm client, installs Tiller on Kubernetes cluster and
  creates releases in it.


  Enable formula, install helm client on node and tiller on Kubernetes (assuming
  already configured kubectl config or local cluster endpoint):


  Change version of helm being downloaded and installed:


>	          version: 2.6.0  # defaults to 2.4.2 currently
>	          download_hash: sha256=youneedtocalculatehashandputithere


  Don't install tiller and use existing one exposed on some well-known address:


>	          tiller:
>	            install: false
>	            host: 10.11.12.13:14151


  Change namespace where tiller is isntalled and looked for:


>	            namespace: not-kube-system  # kube-system is default


  Install Mirantis repository and deploy zookeper chart from it:


>	          repos:
>	            mirantisworkloads: https://mirantisworkloads.storage.googleapis.com/
>	              name: my-zookeeper
>	              chart: mirantisworkloads/zookeeper  # we reference installed repo
>	              version: 1.2.0  # select any available version
>	                logLevel: INFO  # any values used by chart can specified here


  Delete that release:


>	              enabled: false


  Install kubectl and manage remote cluster:


>	          kubectl:
>	            install: true  # installs kubectl 1.6.7 by default
>	            config:
>	              cluster:  # directly translated to cluster definition in kubeconfig
>	                server: https://kubernetes.example.com
>	                certificate-authority-data: base64_of_ca_certificate
>	              user:  # same for user
>	                username: admin
>	                password: uberadminpass


  Change kubectl download URL and use it with GKE-based cluster:


>	            install: true
>	            download_url: https://dl.k8s.io/v1.6.7/kubernetes-client-linux-amd64.tar.gz
>	            download_hash: sha256=calculate_hash_here
>	                server: https://3.141.59.265
>	                auth-provider:
>	                  name: gcp
>	              gce_service_token: base64_of_json_token_downloaded_from_cloud_console


  Initial cookiecutter result


  helm


  Service helm description


  Sample pillars


  Single helm service


>	          enabled: true
>	          version: icehouse


  Development and testing


  Development and test workflow with `Test Kitchen <http://kitchen.ci>`_ and
  `kitchen-salt <https://github.com/simonmcc/kitchen-salt>`_ provisioner plugin.


  Test Kitchen is a test harness tool to execute your configured code on one or more platforms in isolation.


  There is a ``.kitchen.yml`` in main directory that defines *platforms* to be tested and *suites* to execute on them.


  Kitchen CI can spin instances locally or remote, based on used *driver*.


  For local development ``.kitchen.yml`` defines a `vagrant <https://github.com/test-kitchen/kitchen-vagrant>`_ or
  `docker  <https://github.com/test-kitchen/kitchen-docker>`_ driver.


  To use backend drivers or implement your CI follow the section `INTEGRATION.rst#Continuous Integration`__.


  The `Busser <https://github.com/test-kitchen/busser>`_ *Verifier* is used to setup and run tests
  implementated in `<repo>/test/integration`. It installs the particular driver to tested instance
  (`Serverspec <https://github.com/neillturner/kitchen-verifier-serverspec>`_,
  `InSpec <https://github.com/chef/kitchen-inspec>`_, Shell, Bats, ...) prior the verification is executed.


>	  Usage:


>	    # list instances and status
  kitchen list


>	    # manually execute integration tests
  kitchen [test || [create|converge|verify|exec|login|destroy|...]] [instance] -t tests/integration


>	    # use with provided Makefile (ie: within CI pipeline)
  make kitchen


  Read more


  * links


# Formula home-assistant


###  Ales Komarek


  Git config


  Home Assistant formula


  Home Assistant is an open-source home automation platform running on Python 3.


  Track and control all devices at home and automate control.
  home-assistant service wit git based configuration


>	      home_assistant:
>	        server:
>	          enabled: true
>	          bind:
>	            address: 0.0.0.0
>	            port: 8123
>	          config:
>	            engine: git
>	            address: '${_param:home_assistant_config_repository}'
>	            branch: ${_param:home_assistant_config_revision}


  More information


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula horizon


###  Adam Tengler


  Manage policy files in Horizon


  Manage policy files in Horizon conf directory, either dynamically
  from Salt Mine or statically from Horizon formula directory.


  Horizon with policy files metadata. With source mine you can obtain real time policy file state from targeted node (OpenStack control node), provided you have policy file published to specified grain key. Source file will obtain static policy definition from formula files directory.


>	      horizon:
>	        server:
>	          enabled: true
>	          policy:
>	            identity:
>	              source: mine
>	              host: ctl01.my-domain.local
>	              name: keystone_policy.json
>	              grain_name: keystone_policy
>	              enabled: true
>	            compute:
>	              source: file
>	              name: nova_policy.json
>	            network:
>	              name: neutron_policy.json
>	            image:
>	              name: glance_policy.json
>	            volume:
>	              name: cinder_policy.json
>	            telemetry:
>	              name: ceilometer_policy.json
>	            orchestration:
>	              name: heat_policy.json


  SESSION_ENGINE parameter introduced, pillar for SESSION_TIMEOUT changed. Actualized pillar for horizon.server.cluster service


  Horizon with custom SESSION_ENGINE (default is "signed_cookies", valid options are: "signed_cookies", "cache", "file") and SESSION_TIMEOUT


>	          enabled: True
>	          secure: True
>	          session:
>	            engine: 'cache'
>	            timeout: 43200


###  Ales Komarek


  Fixed PROD-9967


  Horizon Formula


  Horizon is the canonical implementation of OpenStack’s Dashboard, which
  provides a web based user interface to OpenStack services including Nova,


  Swift, Keystone, etc.


  Sample Pillars


  Horizon with enabled SSL security (when SSL is realised by proxy)


  More Information


###  Dmitry Stremkovskiy


  multidomain and default_domain options should be independent and configurable


  Multidomain setup for horizon


>	          default_domain: MYDOMAIN
>	          multidomain: True


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Oleksii Chupryn


  Define identity api version in api_versions dict


>	          api_versions:
>	            identity: 2
>	              api_versions:
>	                identity: 2
>	                identity: 3


# Formula hovercraft


###  dresl


  Proper title
  hovercraft-formula


  Cleanup


>	  parameters:
>	    hovercraft:
>	      server:
>	        slides:
>	          name_of_slides:
>	            builder: html
>	            path: source
>	            source: 
>	              engine: git
>	              address: git_address
>	              rev: master


  Update readme


  Hovercraft’s power comes from the combination of reStructuredText’s convenience with the cool of impress.js, together with a flexible and powerful solution to position the slides.


>	      http://hovercraft.readthedocs.io/
>	      https://github.com/salt-formulas/salt-formula-hovercraft/issues
>	      https://github.com/salt-formulas/salt-formula-hovercraft


  Add files


  Hovercraft


  Sphinx is a tool that makes it easy to create intelligent and beautiful documentation, written by Georg Brandl and licensed under the BSD license. It was originally created for the new Python documentation, and it has excellent facilities for the documentation of Python projects, but C/C++ is already supported as well, and it is planned to add special support for other languages as well.


  Sample pillars


  Simple documentation with local source


>	      sphinx:
>	        server:
>	          enabled: true
>	          doc:
>	            board:
>	              builder: 'html'
>	              source: 
>	                engine: local
>	                path: '/path/to/sphinx/documentation'


  Simple documentation with Git source


>	                engine: git
>	                address: 'git@repo1.domain.com/repo.git'
>	                revision: master


  Simple documentation with reclass source


>	                engine: reclass


  Read more


  * http://sphinx-doc.org/tutorial.html


# Formula hubblestack


###  Petr Michalec


  Initial version


  hubblestack formula


  Hubble is a modular, open-source security compliance framework. The project provides on-demand profile-based auditing,
  real-time security event notifications, automated remediation, alerting and reporting.


  More information


  *  https://github.com/hubblestack/hubble-salt


  Deviations from hubblestack.io hubble-salt formula


  As no ``gitfs`` is used paths are shifted from ``salt://`` to ``salt://hubblestack``.


  Sample pillars


  Required configuration:


>	    hubblestack:
>	      nova:
>	        saltenv: base
>	        module_dir: salt://hubblestack/hubblestack_nova
>	        profile_dir: salt://hubblestack/hubblestack_nova_profiles


  * links


# Formula influxdb


###  abednarik


  Update tests and README about custom paths


  Single-node influxdb where you specify paths for data and metastore directories. Custom
  directories are created by this formula:


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Petr Michalec


>	    FEATURE: add custom ad-hoc queries for schedulled run, etc
>	              continuous_query:


  Prunning data and data management:


  Intended to use in scheduled jobs, executed to maintain data life cycle above retention policy. These states are executed by
  ``query.sls`` and you are expected to trigger ``sls_id`` individually.


>	      influxdb:
>	        client:
>	          database:
>	            mydb1:
>	              query:
>	                drop_measurement_h2o: >-


  DROP MEASUREMENT h2o_quality


>	                drop_shard_h2o: >-


  DROP SHARD h2o_quality


>	                drop_series_h2o_feet: >-


  DROP SERIES FROM "h2o_feet"


>	                drop_series_h2o_feet_loc_smonica: >-


  DROP SERIES FROM "h2o_feet" WHERE "location" = 'santa_monica'


>	                delete_h2o_quality_rt3: >-


  DELETE FROM "h2o_quality" WHERE "randtag" = '3'


>	                delete_h2o_quality: >-


  DELETE FROM "h2o_quality"


  salt \* state.sls_id influxdb_query_delete_h2o_quality influxdb.query


  FEATURE, add continuous query support


  Create an continuous queries:


>	              continuos_query:
>	                cq_avg_bus_passengers: >-


  SELECT mean("passengers") INTO "transportation"."three_weeks"."average_passengers" FROM "bus_data" GROUP BY time(1h)


###  Simon Pasquier


  Enable telemetry for InfluxDB relay


>	          telemetry:
>	            enabled: true
>	            bind:
>	              address: 127.0.0.1
>	              port: 9196


  Add support for influxdb-relay


  InfluxDB relay with HTTP outputs:


>	        relay:
>	          enabled: true
>	          listen:
>	            http_backend:
>	              type: http
>	              bind:
>	                address: 127.0.0.1
>	                port: 9096
>	              output:
>	                server1:
>	                  location: http://server1:8086/write
>	                  timeout: 20s
>	                  buffer_size_mb: 512
>	                  max_batch_kb: 1024
>	                  max_delay_interval: 30s
>	                server2:
>	                  location: http://server2:8086/write


  Add client role


  The client role is responsible for provisioning the users, databases
  and privileges. It is required when running InfluxDB in a container
  because the deployment of InfluxDB and the provisioning phase are
  decoupled. Non-containerized deployments are left unchanged with the
  provisioning managed by the server state.


  InfluxDB client for configuring databases, users and retention policies:


>	          server:
>	            protocol: http
>	            host: 127.0.0.1
>	            port: 8086
>	            user: admin
>	            password: foobar
>	          user:
>	            user1:
>	              enabled: true
>	              admin: true
>	              name: username1
>	              name: mydb1
>	              retention_policy:
>	              - name: rp_db1
>	                duration: 30d
>	                replication: 1
>	                is_default: true
>	          grant:
>	            username1_mydb1:
>	              user: username1
>	              database: mydb1
>	              privilege: all


  Expose more parameters for the data service


>	            cache_max_memory_size: 524288000
>	            cache_snapshot_memory_size: 26214400
>	            cache_snapshot_write_cold_duration: "5m"
>	            compact_full_write_cold_duration: "2h"2h"
>	            max_values_per_tag: 5000


  Expose max-series-per-database parameter


  InfluxDB server with customized parameters for the data service:


>	        server:
>	          data:
>	            max_series_per_database: 20000000


# Formula iptables


###  Dennis van Dok


  add the option to specify the family per rule to support ipv6 (#3)


>	    Closes: #2
>	            enabled: True


  IPv6 is supported as well


>	      parameters:
>	        iptables:
>	          service:
>	            ipv6: True
>	            chain:
>	              INPUT:
>	                rules:
>	                  - protocol: tcp
>	                    family: ipv6
>	                    destination_port: 22
>	                    source_network: 2001:DB8::/32
>	                    jump: ACCEPT


###  Dmitry Stremkouski


  Adding comment option to iptables rule


>	                    comment: Blah


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Nitin Madhok


  Correct parameters spelling


###  Piotr Pieprzycki


  Changed file permissions - fix (#14)


  added README example


  Support logging with custom prefix and log level


>	              POSTROUTING:
>	                  - table: nat
>	                    protocol: tcp
>	                    match: multiport
>	                    destination_ports:
>	                      - 21
>	                      - 80
>	                      - 443
>	                      - 2220
>	                    source_network: '10.20.30.0/24'
>	                    log_level: 7
>	                    log_prefix: 'iptables-logging: '
>	                    jump: LOG


# Formula ironic


###  Vasyl Saienko


  Initial commit


  This patch adds initial formula that allow to install Ironic api
  and conductor.


  ironic


  Service ironic description


  Sample pillars


  Single ironic service


>	    ironic:
>	      api:
>	        enabled: true
>	        version: mitaka
>	        bind:
>	          address: 0.0.0.0
>	          port: 6385
>	        database:
>	          engine: mysql
>	          host: localhost
>	          port: 3306
>	          name: ironic
>	          user: ironic
>	          password: password
>	        identity:
>	          engine: keystone
>	          region: RegionOne
>	          port: 35357
>	          tenant: service
>	        message_queue:
>	          engine: rabbitmq
>	          port: 5672
>	          user: openstack
>	          virtual_host: '/openstack'
>	      conductor:


  Standalone ironic without keystone


>	          engine: noauth


# Formula isc-dhcp


###  Ales Komarek


  Documentation fixes


  ISC DHCP formula


  Sample pillars


  More information


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula java


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula jenkins


###  Ales Komarek


  Jenkins job templating


  Jenkins formula


  Jenkins is an application that monitors executions of repeated jobs, such as
  building a software project or jobs run by cron.


  Setup jenkins client, works with Salt 2016.3+, supports pipeline workflow
  projects only now.


  Master role


  Jenkins master with experimental plugin source support


  SMTP server settings


>	      jenkins:
>	        master:
>	          email:
>	            engine: "smtp"
>	            host: "smtp.domain.com"
>	            user: "user@domain.cz"
>	            password: "smtp-password"
>	            port: 25


  Script approvals


>	          approved_scripts:
>	          - method groovy.json.JsonSlurperClassic parseText java.lang.String


  User enforcement


>	          user:
>	            admin:
>	              api_token: xxxxxxxxxx
>	              password: admin_password
>	              email: admin@domain.com
>	            user01:
>	              password: user_password
>	              email: user01@domain.com


  Agent (slave) role


  Client role


  Inline Groovy scripts


  GIT controlled groovy scripts


  Using job templates in similar way as in jjb. For now just 1 defined param is
  supported.


>	        client:
>	          job_template:
>	            test_workflow_template:
>	              name: test-{{formula}}-workflow
>	              template:
>	                type: workflow
>	                display_name: Test jenkins {{name}} workflow
>	                param:
>	                  repo_param:
>	                    type: string
>	                    default: repo/{{formula}}
>	                script:
>	                  repository: base
>	                  file: workflows/test_formula_workflow.groovy
>	              param:
>	                formula:
>	                - aodh
>	                - linux
>	                - openssh


  Interpolating parameters for job templates.


>	      _param:
>	        salt_formulas:
>	        - aodh
>	        - git
>	        - nova
>	        - xorg
  ...


>	                formula: ${_param:salt_formulas}


>	          job:
>	            my-amazing-job:
>	              type: workflow
>	          node:
>	            node01:
>	              remote_home: /remote/home/path
>	              desc: node-description
>	              num_executors: 1
>	              node_mode: Normal
>	              ret_strategy: Always
>	              labels:
>	                - example
>	                - label
>	              launcher:
>	                 type: jnlp
>	                - label 
>	                 type: ssh
>	                 host: test-launcher
>	                 port: 22
>	                 username: launcher-user
>	                 password: launcher-pass
>	          label:
>	            node-name:
>	              lbl_text: label-offline
>	              append: false # set true for label append instead of replace
>	            team_domain: example.com
>	            token: slack-token
>	            room: slack-room
>	            token_credential_id: cred_id 
>	            send_as: Some slack user


  External links


###  Filip Pytloun


  Add support for replacing more params using job templates


  Or simply define multiple jobs and it's parameters to replace from template:


>	     jenkins:
>	       client:
>	         job_template:
>	           test_workflow_template:
>	             name: test-{{name}}-{{myparam}}
>	             template:


>	             jobs:
>	               - name: firstjob
>	                 myparam: dummy
>	               - name: secondjob
>	                 myparam: dummyaswell


  Unify Makefile, .gitignore and update readme


###  Jakub Josef


  Fixed credentials enforcing, updated readme


  Jenkins Global env properties enforcing


>	       jenkins:
>	         client:
>	           globalenvprop:
>	             OFFLINE_DEPLOYMENT:
>	               enabled: true
>	               name: "OFFLINE_DEPLOYMENT" # optional, default using dict key
>	               value: "true"


  Added jenkins master configuration possibility


  Configure Jenkins master


>	            master:
>	              node_mode: Normal # or Exclusive


  Implemented artifactory server enforcing


  Artifactory server enforcing


>	          artifactory:
>	            my-artifactory-server:
>	              enabled: true
>	              url: https://path-to-my-library
>	              credential_id: github


  Improved Jenkins SMTP settings


  Jenkins admin user email enforcement from client


>	          smtp:
>	            admin_email: "My Jenkins <jenkins@myserver.com>"


  Extended jenkins views enforcing by Categorize Views


>	             include_regex: ".*"
>	  - include_regex for ListView and CategorizedJobsView
>	  - categories for CategorizedJobsView


  Categorized views


>	          view:
>	            my-categorized-view:
>	              type: CategorizedJobsView
>	              include_regex: ".*"
>	              categories:
>	                - group_regex: "aptly-.*-nightly-testing"
>	                  naming_rule: "Nightly -> Testing"
>	                - group_regex: "aptly-.*-nightly-production"
>	                  naming_rule: "Nightly -> Production"


  Implemented jenkins scripts approving from client size


  Script approvals from client


>	            - method groovy.json.JsonSlurperClassic parseText java.lang.String


  Implemented Jenkins global libs configuration by salt.


>	            token_credential_id: cred_id


  Pipeline global libraries setup


>	          lib:
>	            my-pipeline-library:
>	              branch: master # optional, default master
>	              implicit: true # optional default true


  Implemented max keep builds property on jobs


  Setting job max builds to keep (amount of last builds stored on Jenkins master)


>	              discard:
>	                build:
>	                  keep_num: 5
>	                  keep_days: 5
>	                artifact:
>	                  keep_num: 6
>	                  keep_days: 6


  Impemented Jenkins jobs cleanup - uninstallation of all undefined jobs.


  Purging undefined jobs from Jenkins


>	          purge_jobs: true


  Implemented Jenkins Slack plugin configuration.


  Slack plugin configuration


>	          slack:
>	             team_domain: example.com
>	             token: slack-token
>	             room: slack-room
>	             token_credential_id: cred_id 
>	             send_as: Some slack user


  Implemented SMTP settings from client side via script api.


  SMTP server settings from master


  SMTP server settings from client


>	            username: "user@domain.cz"
>	            ssl: false
>	            reply_to: reply_to@address.com


  Matrix security extended to use GlobalMatrixAuthStrategy or ProjectMatrixAuthStrategy


>	              # set true for use ProjectMatrixAuthStrategy instead of GlobalMatrixAuthStrategy
>	              project_based: false  


  Implemented Jenkins views enforcing.


  Views enforcing from client


>	           my-list-view:
>	             enabled: true
>	             type: ListView
>	             include_regex: ".\*."
>	           my-view:
>	             # set false to disable
>	             type: MyView


  View specific params:


>	  - include_regex for ListView


  Implemented LDAP config and matrix auth security enforcements.


  LDAP configuration (depends on LDAP plugin)


>	          security:
>	            ldap:
>	              server: 1.2.3.4
>	              root_dn: dc=foo,dc=com
>	              user_search_base: cn=users,cn=accounts
>	              manager_dn: ""
>	              manager_password: password
>	              user_search: ""
>	              group_search_base: ""
>	              inhibit_infer_root_dn: false


  Matrix configuration (depends on auth-matrix plugin)


>	            matrix:
>	              permissions:
>	                Jenkins:
>	                  # administrator access
>	                  ADMINISTER:
>	                    - admin
>	                  # read access (anonymous too)
>	                  READ:
>	                    - anonymous
>	                    - user1
>	                    - user2
>	                  # agents permissions
>	                  MasterComputer: 
>	                    BUILD: 
>	                      - user3
>	                # jobs permissions
>	                hudson: 
>	                  model:
>	                    Item:
>	                      BUILD: 
>	                        - user4


  `Common matrix strategies <https://github.com/arbabnazar/configuration/blob/c08a5eaf4e04a68d2481375502a926517097b253/playbooks/roles/tools_jenkins/templates/projectBasedMatrixSecurity.groovy.j2>`_


###  Tomáš Kukrál


  add support for job timer


  I'd like to run some jobs on daily basis and this PR add this
  functionality.


>	                timer:
>	                  spec: "H H * * *"


# Formula jupyter


###  Ales Komarek


  Added schema, fixed variable requirements


>	            requirements: true


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula kalliope


###  Ales Komarek


  Initial commit


  Kalliope Formula


  Kalliope is a modular always-on voice controlled personal assistant designed
  for home automation.


  Sample Pillars


  Single kalliope service with synapses defined


>	      kalliope:
>	        server:
>	          enabled: true
>	          bind:
>	            address: 0.0.0.0
>	            port: 5000
>	          synapse:
>	            default-synapse:
>	              signals:
>	              - order: "default-synapse"
>	              neurons:
>	              - say:
>	                  message:
>	                  - "I haven't understood"
>	                  - "I don't know this order"
>	                  - "I don't recognize that order"


  Single kalliope service with extra resources defined


>	          trigger:
>	            primary:
>	              engine: snowboy
>	              default: true
>	              pmdl_file: "trigger/kalliope-EN-12samples.pmdl"
>	          speech_to_text:
>	            google:
>	              engine: google
>	              language: "en-EN"
>	          text_to_speech:
>	          resource:
>	            hue:
>	              type: neuron
>	              source:
>	                engine: git
>	                address: https://github.com/kalliope-project/kalliope_neuron_hue.git


  More Information


  * https://github.com/kalliope-project/kalliope


  * links


# Formula kedb


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula keepalived


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Petr Michalec


  Allow multiple vrrp scripts and weight


>	              track_script:
>	                check_random_exit:
>	                  interval: 10
>	                check_port:
>	                  weight: 50
>	              weight: 50


  foundation for vrrp check scripts


>	              track_script: check_haproxy
>	              track_script: check_random_exit
>	            check_haproxy:
>	              name: check_pidof
>	              args:
>	                - haproxy
>	            check_mysql_port:
>	              name: check_port
>	                - 3306
>	                - TCP
>	                - 4
>	            check_ssh:
>	              args: "22"
>	            check_mysql_cluster:
>	                # github: olafz/percona-clustercheck
>	                # <user> <pass> <available_when_donor=0|1> <log_file> <available_when_readonly=0|1> <defaults_extra_file>
>	                - clustercheck
>	                - available_when_donor=0
>	                - available_when_readonly=0
>	            check_random_exit:


  add track_script option


  Track/vrrp scripts for keepalived instance:


>	      keepalived:
>	        cluster:
>	          enabled: True
>	          instance:
>	            VIP2:
>	              priority: 100
>	              virtual_router_id: 10
>	              password: pass
>	              addresses:
>	              - 192.168.11.1
>	              - 192.168.11.2
>	              interface: eth0
>	              track_script: haproxy_check
>	            VIP3:
>	              virtual_router_id: 11
>	              - 192.168.10.1
>	              - 192.168.10.2
>	              track_script: random_check
>	          vrrp_scripts:
>	            random_check:
>	              interval: 10
>	              content: |
>	                #!/bin/bash
  exit $(($RANDOM%2))


###  Tomáš Kukrál


  add suport for keepalived over unicast


  Keepalived can be used via unicast and it is required for for
  running keepalived in Amazon VPC.


  You can includes `unicast_src_ip` in list of peers because it will be
  skipped.


  Use unicast


>	            VIP1:
>	              nopreempt: True
>	              priority: 100 (highest priority must be on primary server, different for cluster members)
>	              virtual_router_id: 51
>	              address: 192.168.10.1
>	              unicast_src_ip: 172.16.10.1
>	              unicast_peer:
  172.16.10.2
  172.16.10.3


###  Vasyl Saienko


  Allow to set auth_type for VRRP group


  Keepalived supports two auth_types: PASS and AH


  This patch allows to set auth_type per VRRP instance and change
  default value to AH


>	              auth_type: AH
>	              auth_type: PASS


# Formula keystone


###  Adam Tengler


  Keystone policy module, states and grain


  Keystone with custom policies. Keys with specified rules are created or set to this value if they already exists. Keys with no value (like our "existing_rule") are deleted from the policy file.


>	      keystone:
>	        server:
>	          enabled: true
>	          policy:
>	            new_rule: "rule:admin_required"
>	            existing_rule:


###  Andrey


  Keystone configures parameter of admin project.


  By default admin_project_name and admin_project_domain_name are undefined.


  This affects Heat client while listing the stacks. For any user having
  admin rights in the tenant, all stacks across the entire cloud are shown.


  Setting up default admin project name and domain


  ....


>	          admin_project:
>	            name: "admin"
>	            domain: "default"


###  Dmitry Ukov


  Policy.json should be defined by user


  Implementation has been moved from template based to pillar based. User
  can override and add values to policy.json by creating flat key-value
  structure under keystone:server:policy.


  Configuration of policy.json file


>	            admin_or_token_subject: 'rule:admin_required or rule:token_subject'


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Jiri Broulik


  endpoint token fix


>	                project: admin
>	                region_name: RegionOne
>	                protocol: https
>	        client:
>	          server:
>	            keystone01:
>	              admin:
>	                host: 10.0.0.2
>	                port: 5000
>	                project: 'admin'
>	                user: admin
>	                password: 'workshop'
>	            keystone02:
>	                host: 10.0.0.3


  keystone tenat quota setup fix


>	                  quota:
>	                    instances: 100
>	                    cores: 24
>	                    ram: 151200
>	                    floating_ips: 50
>	                    fixed_ips: -1
>	                    metadata_items: 128
>	                    injected_files: 5
>	                    injected_file_content_bytes: 10240
>	                    injected_file_path_bytes: 255
>	                    key_pairs: 100
>	                    security_groups: 20
>	                    security_group_rules: 40
>	                    server_groups: 20
>	                    server_group_members: 20


  Tenant quotas


>	                project: 'token'
>	                password: 'passwd'
>	              roles:
>	              - admin
>	              - member
>	              project:
>	                tenant01:
>	                  description: "test env"


  Usage


  Apply state `keystone.client.service` first and then `keystone.client` state.


###  Kirill Bespalov


  RabbitMQ TLS support


>	    Usage: see README.rst
>	    Releases: Mitaka, Newton, Ocata


  OSCORE-383


  Client-side RabbitMQ TLS configuration:


  |


  By default system-wide CA certs are used. Nothing should be specified except `ssl.enabled`.


>	    keystone:
>	      server:


>	        message_queue:
>	          ssl:
>	            enabled: True


  Use `cacert_file` option to specify the CA-cert file path explicitly:


>	            cacert_file: /etc/ssl/rabbitmq-ca.pem


  To manage content of the `cacert_file` use the `cacert` option:


>	            cacert: |


  ...


>	            cacert_file: /etc/openstack/rabbitmq-ca.pem


>	  Notice:
  * The `message_queue.port` is set to **5671** (AMQPS) by default if `ssl.enabled=True`.
  * Use `message_queue.ssl.version` if you need to specify protocol version. By default is TLSv1 for python < 2.7.9 and TLSv1_2 for version above.


###  mnederlof


  Add k2k identity backend


  Use a custom identity driver with custom options


>	          backend: k2k
>	          k2k:
>	            auth_url: 'https://keystone.example.com/v2.0'
>	            read_user: 'example_user'
>	            read_pass: 'password'
>	            read_tenant_id: 'admin'
>	            identity_driver: 'sql'
>	            id_prefix: 'k2k:'
>	            domain: 'default'
>	            caching: true
>	            cache_time: 600


###  Oleksii Chupryn


  Add support of Keystone OIDC Federation


  Some parameters are optional while some other ones are exlusive between each other.


  Enable SAML2 Federated keystone


>	            saml2:
>	              protocol: saml2
>	              remote_id_attribute: Shib-Identity-Provider
>	              shib_url_scheme: https
>	              shib_compat_valid_user: 'on'
>	              - https://${_param:cluster_public_host}/horizon/auth/websso/


  Enable OIDC Federated keystone


>	          auth_methods:
>	          - password
>	          - token
>	          - oidc
>	          federation:
>	          oidc:
>	              protocol: oidc
>	              remote_id_attribute: HTTP_OIDC_ISS
>	              remote_id_attribute_value: https://accounts.google.com
>	              oidc_claim_prefix: "OIDC-"
>	              oidc_response_type: id_token
>	              oidc_scope: "openid email profile"
>	              oidc_provider_metadata_url: https://accounts.google.com/.well-known/openid-configuration
>	              oidc_client_id: <openid_client_id>
>	              oidc_client_secret: <openid_client_secret>
>	              oidc_crypto_passphrase: openstack
>	              oidc_redirect_uri: https://key.example.com:5000/v3/auth/OS-FEDERATION/websso/oidc/redirect
>	              oidc_oauth_introspection_endpoint: https://www.googleapis.com/oauth2/v1/tokeninfo
>	              oidc_oauth_introspection_token_param_name: access_token
>	              oidc_oauth_remote_user_claim: user_id
>	              oidc_ssl_validate_server: 'off'
>	          federated_domain_name: Federated
>	          federation_driver: keystone.contrib.federation.backends.sql.Federation
>	          trusted_dashboard:
>	            - https://${_param:cluster_public_host}/auth/websso/
>	      apache:
>	          pkgs:
>	            - apache2
>	            - libapache2-mod-auth-openidc
>	          modules:
>	            - wsgi
>	            - auth_openidc


>	  Notes: Ubuntu Trusty repository doesn't contain libapache2-mod-auth-openidc package. Additonal repository should be added to source list.


  Rename  websso to federation


  Add ability to configure keystone auth methods


  Keystone auth methods


>	          - external
>	          - oauth1


>	          - saml2


  Add ability to provide extra parameters to config
  since Mitaka openstack release


  Extra config params in keystone.conf (since Mitaka release)


>	          extra_config:
>	            ini_section1:
>	              param1: value
>	              param2: value
>	            ini_section2:


  Add support of new param - federated_domain_name


>	            federated_domain_name: Federated


  Add ability to specify ShibURLScheme


>	            shib_url_scheme: https


###  Ondrej Smola


  added support for cors parameters


  Enable CORS parameters


>	          cors:
>	            allowed_origin: https:localhost.local,http:localhost.local
>	            expose_headers: X-Auth-Token,X-Openstack-Request-Id,X-Subject-Token
>	            allow_methods: GET,PUT,POST,DELETE,PATCH
>	            allow_headers: X-Auth-Token,X-Openstack-Request-Id,X-Subject-Token
>	            allow_credentials: True
>	            max_age: 86400


###  Ramon Melero


  LDAP packages are missing


  When trying to add ldap configurations we get the following error first:
  2017-08-15 15:29:20.130 9467 ERROR keystone.common.wsgi     import ldap.filter
  2017-08-15 15:29:20.130 9467 ERROR keystone.common.wsgi ImportError: No module named ldap.filter


  Fixed by installing python-ldap, then we get the following error:
  2017-08-15 15:38:01.892 12591 ERROR keystone.common.wsgi     from keystone.identity.backends.ldap import common as common_ldap
  2017-08-15 15:38:01.892 12591 ERROR keystone.common.wsgi   File "/usr/lib/python2.7/dist-packages/keystone/identity/backends/ldap/common.py", line 25, in <module>
  2017-08-15 15:38:01.892 12591 ERROR keystone.common.wsgi     import ldappool
  2017-08-15 15:38:01.892 12591 ERROR keystone.common.wsgi ImportError: No module named ldappool
  fixed by adding python-ldappool
  also found error in documentation syntax that was causing this:


>	    local:
>	            external:
>	              description: "Testing domain"
>	              backend: ldap
>	              assignment:
>	                backend: sql
>	              ldap:
>	                url: "ldaps://idm.domain.com"
>	                suffix: "dc=cloud,dc=domain,dc=com"
>	                # Will bind as uid=keystone,cn=users,cn=accounts,dc=cloud,dc=domain,dc=com
>	                uid: keystone
>	                password: password


###  Richard Felkl


  Added identity information to salt minion conf


  Multiple servers example


>	      client:
>	        enabled: true
>	          keystone01:
>	            admin:
>	              host: 10.0.0.2
>	              port: 5000
>	              project: 'admin'
>	              user: admin
>	              password: 'workshop'
>	              region_name: RegionOne
>	              protocol: https
>	          keystone02:
>	              host: 10.0.0.3


# Formula kibana


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula knot


# Formula kodi


###  Ales Komarek


  Updated docs to rst


  KODI formula


  Kodi (formerly known as XBMC) is a software media center for playing videos, music, pictures, games, and more.


  Sample pillars


>	      kodi:
>	        server:
>	          enabled: True


  Usage


  plugin repositories
  tvheadend


  Read more


  * https://code.google.com/p/dmd-xbmc/
  * http://kodi-czsk.github.io/repository/
  * https://tvheadend.org/projects/tvheadend/wiki/AptRepository
  * https://kodi.tv/


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula kubernetes


###  Ales Komarek


  Service update orchestrations


  Kubernetes is an open-source system for automating deployment, scaling, and
  management of containerized applications. This formula deploys production
  ready Kubernetes and generate Kubernetes manifests as well. 


  Sample Pillars


  More Information
  * https://github.com/Juniper/kubernetes/blob
  /opencontrail-integration/docs /getting-started-guides/opencontrail.md
  * https://github.com/kubernetes/kubernetes/tree/master/cluster/saltbase


###  Andrey Shestakov


  Add Designate support for externaldns.


  This change allows to pass Openstack credentials to externaldns when provider
  is Designate.


  Enable external DNS addon with Designate provider


>	      parameters:
>	        kubernetes:
>	          common:
>	            addons:
>	              externaldns:
>	                externaldns:
>	                  enabled: True
>	                  domain: company.mydomain
>	                  provider: designate
>	                  designate_os_options:
>	                    OS_AUTH_URL: https://keystone_auth_endpoint:5000
>	                    OS_PROJECT_DOMAIN_NAME: default
>	                    OS_USER_DOMAIN_NAME: default
>	                    OS_PROJECT_NAME: admin
>	                    OS_USERNAME: admin
>	                    OS_PASSWORD: password
>	                    OS_REGION_NAME: RegionOne


  Update virtlet deployment procedure.


  Added dockershim service.


  Removed kubelet.conf as not required.


  Bump version to v0.8.0.


>	                image: mirantis/virtlet:v0.8.0


###  Filip Pytloun


  Add state to control rbac


  Role-based access control


  To enable RBAC, you need to set following option on your apiserver:


>	      kubernetes:
>	        master:
>	          auth:
>	            mode: RBAC


  Then you can use ``kubernetes.control.role`` state to orchestrate role and
  rolebindings. Following example shows how to create brand new role and binding
  for service account:


>	      control:
>	        role:
>	          etcd-operator:
>	            kind: ClusterRole
>	            rules:
>	              - apiGroups:
>	                  - etcd.coreos.com
>	                resources:
>	                  - clusters
>	                verbs:
>	                  - "*"
>	                  - extensions
>	                  - thirdpartyresources
>	                  - create
>	                  - storage.k8s.io
>	                  - storageclasses
>	                  - ""
>	                  - replicasets
>	            binding:
>	              etcd-operator:
>	                kind: ClusterRoleBinding
>	                namespace: test # <-- if no namespace, then it's clusterrolebinding
>	                subject:
>	                  etcd-operator:
>	                    kind: ServiceAccount


  Simplest possible use-case, add user test edit permissions on it's test


>	  namespace:


>	        control:
>	          role:
>	            edit:
>	              kind: ClusterRole
>	              # No rules defined, so only binding will be created assuming role
>	              # already exists
>	              binding:
>	                test:
>	                  namespace: test
>	                  subject:
>	                    test:
>	                      kind: User


  Make auth options configurable


  Enable basic, token and http authentication, disable ssl auth, create some
  static users:


>	            basic:
>	              enabled: true
>	              user:
>	                jdoe:
>	                  password: dummy
>	                  groups:
>	                    - system:admin
>	            http:
>	              header:
>	                user: X-Remote-User
>	                group: X-Remote-Group
>	            ssl:
>	              enabled: false
>	            token:
>	                  token: dummytoken


  Unify Makefile, .gitignore and update readme


  Revert "update sources of k8s and calico installation"


  This reverts commit 76ecb2d41fc078054259ba68a7ba9720dbf02968.


###  Jakub Pavlik


  Kubernetes StorageClass for AWS EBS


  Kubernetes Storage Class


  AWS EBS storageclass integration. It also requires to create IAM policy and profiles for instances and tag all resources by KubernetesCluster in EC2.


>	        common:
>	          addons:
>	            storageclass:
>	              aws_slow:
>	                name: slow
>	                enabled: True
>	                default: True
>	                provisioner: aws-ebs
>	                type: gp2
>	                iopspergb: "10"
>	                zones: xxx


  Enable Virtlet Addon for Kubernetes


  Enable virtlet addon for kubernetes deployment.


>	    Initiative: PROD-10135
>	    Signed-off-by: Sergii Golovatiuk <sgolovatiuk@mirantis.com>


  Enable virtlet addon


>	          master:
>	              virtlet:
>	                enabled: true
>	                namespace: kube-system
>	                hosts:
>	                - cmp01
>	                - cmp02
>	                image: mirantis/virtlet:latest


###  Marek Celoud


  change kubelet connection to secure endpoint/use ssl certs


  Label node:


>	    kubernetes:
>	      master:
>	        label:
>	          label01:
>	            value: value01
>	            node: node01
>	            enabled: true
>	            key: key01


###  Matthew Mosesohn


  Add support for openstack cloudprovider


  Enable OpenStack cloud provider


>	            cloudprovider:
>	              enabled: True
>	              type: openstack
>	              params:
>	                auth_url: https://openstack.mydomain:5000/v3
>	                username: nova
>	                password: nova
>	                region: RegionOne
>	                tenant_id: 4bce4162d8744c599e350099cfa22a0a
>	                domain_name: default
>	                subnet_id: 72407854-aca6-4cf1-b873-e9affb09484b
>	                lb_version: v2


  Add externaldns addon with CoreDNS support


  Enable external DNS addon with CoreDNS provider


>	                coredns:
>	                  provider: coredns


  Add state for kubernetes federation


  Enable Kubenetes Federation control plane


>	            federation:
>	              name: federation
>	              namespace: federation-system
>	              source: https://dl.k8s.io/v1.6.6/kubernetes-client-linux-amd64.tar.gz
>	              hash: 94b2c9cd29981a8e150c187193bab0d8c0b6e906260f837367feff99860a6376
>	              service_type: NodePort
>	              dns_provider: coredns
>	              childclusters:
>	                - secondcluster.mydomain
>	                - thirdcluster.mydomain


  Set cluster name and domain
  cluster_name : mycluster


>	            cluster_name: cluster


  New variable kubernetes_cluster_domain


  Use cluster_domain/domain variable consistently across all templated files.


  All kubeconfig fields contain cluster domain for uniqueness.


  Using kubernetes_cluster_domain param now to allow physical servers
  to have a different domain from kubernetes cluster if necessary, but
  the default keeps them the same.


  Set cluster domain


>	            kubernetes_cluster_domain: mycluster.domain


  Refactor contrail-network-controller


>	            contrail_network_controller:
>	              image: yashulyak/contrail-controller:latest


  Add mtu for calico


>	              mtu: 1500
>	            mtu: 1500


  add calico policy controller


  Also fix check for add-on if its namespace is not kube-system.


  Enable calico-policy addon


>	              calico_policy:


  By default kube-apiserver, kube-scheduler, kube-controllermanager, kube-proxy, etcd running in docker containers through manifests. For stable production environment this should be run in systemd.


  Running with calico-policy controller:


>	        pool:
>	          network:
>	            engine: calico


###  Petr Michalec


  add PV storageclass


>	              nfs_shared:
>	                name: elasti01
>	                provisioner: nfs
>	                spec:
>	                  name: elastic_data
>	                  nfs:
>	                    server: 10.0.0.1
>	                    path: /exported_path


###  Sergii Golovatiuk


  Add Google CloudDNS support to external-dns


>	              coredns:
>	                domain: company.mydomain
>	                provider: coredns
>	                provider: designate
>	                designate_os_options:
>	                  OS_AUTH_URL: https://keystone_auth_endpoint:5000
>	                  OS_PROJECT_DOMAIN_NAME: default
>	                  OS_USER_DOMAIN_NAME: default
>	                  OS_PROJECT_NAME: admin
>	                  OS_USERNAME: admin
>	                  OS_PASSWORD: password
>	                  OS_REGION_NAME: RegionOne
>	                provider: aws
>	                aws_options:
>	                  AWS_ACCESS_KEY_ID: XXXXXXXXXXXXXXXXXXXX
>	                  AWS_SECRET_ACCESS_KEY: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


  Enable external DNS addon with Google CloudDNS provider


>	                provider: google
>	                google_options:
>	                  key: ''
>	                  project: default-123
  key should be exported from google console and processed as `cat key.json | tr -d '\n'`


  Add AWS support for externaldns.


  Enable external DNS addon with AWS provider


>	                  provider: aws
>	                  aws_options:
>	                    AWS_ACCESS_KEY_ID: XXXXXXXXXXXXXXXXXXXX
>	                    AWS_SECRET_ACCESS_KEY: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


  Move addons to common section


  Doc-Impact


>	              image: gcr.io/google_containers/hyperkube:v1.6.5
>	                image: mirantis/virtlet:v0.7.0
>	            namespace:


###  Swann Croiset


  Explicitly configure the insecure_port for apiserver


>	              secure_port: 443
>	              insecure_address: 127.0.0.1
>	              insecure_port: 8080


###  Tomáš Kukrál


  minor fixes to cloudprovider features


>	              provider: openstack


  fix typho in readme
  ssh cfg01 "sudo ssh ctl01 /etc/kubernetes/kubeconfig.sh" > ~/.kube/config


  fix hardcoded contrail-api server


>	            config:
>	              api:
>	                host: 10.0.170.70


  add kubeconfig generator
  ready Kubernetes and generate Kubernetes manifests as well.


  You can download `kubectl` configuration and connect to your cluster. However,
  keep in mind `kubernetes_control_address` needs to be accessible from your computer:


  mkdir -p ~/.kube
  [ -f ~/.kube/config ] && cp -v ~/.kube/config ~/.kube/config-backup
  ssh cfg01 "sudo ssh ctl01 /etc/kubenetes/kubeconfig.sh" > ~/.kube/config
  kubectl get no


  `cfg01` is Salt master node and `ctl01` is one of Kubernetes masters


  switch kube-network-manager to addon


>	            kube_network_manager:
>	              namespace: kube-system
>	            image: yashulyak/contrail-controller:latest


  Dashboard public IP must be configured when Contrail network is used:


>	            public_ip: 1.1.1.1


  remove yaml apply


  apply custom yaml files


  Apply custom yaml files


>	          services:
>	            myservice:
>	              files:
>	                - /srv/kubernetes/myservice-svc.yml
>	                - /srv/kubernetes/myservice-pvc.yml
>	                - /srv/kubernetes/myservice-deploy.yml


  add parameter for verbosity


  This PR add posibility to set verbosity of kube daemons. Default value
  is 2.


  Configure service verbosity


>	            verbosity: 2
>	          pool:


  update metadata for dns autoscaler


  Using `enabled: True` to conform with the rest of metadata structures.


  Introductiong poll-perios-seconds parameter


  Enable autoscaler for dns addon. Poll period can be skipped.


>	              dns:
>	                domain: cluster.local
>	                replicas: 1
>	                server: 10.254.0.10
>	                autoscaler:
>	                  enabled: true
>	                  poll-period-seconds: 60


  enable prometheus metrics in felix


  Calico Felix can listen on port 9091 (configurable) and export
  prometheus metrics here.


  Enable Prometheus metrics in Felix


>	            prometheus:


  add netchecker addon


  Enable helm-tiller addon


  Enable netchecker addon


>	              netchecker:


  add helm-tiller as addon


  Enable helm-tiller addons


>	              helm:


  syntax fix in README


  update version in README


>	              image: gcr.io/google_containers/hyperkube:v1.5.2


  add support for etcd over ssl


  Running with secured etcd:


>	            etcd:
>	              ssl:


  allow to pass options to daemons


  Requested for labs deployment.


  Pass aditional parameters to daemons:


>	            apiserver:
>	              daemon_opts:
>	                storage-backend: pigeon
>	            controller_manager:
>	                log-dir: /dev/nulL
>	            kubelet:
>	                max-pods: "6"


  update sources of k8s and calico installation
  move basic k8s setup to common
  copy cni from hyperkube
  configurable calico node image
  use calico/cni image for obtaining cnis
  use calico/ctl image for obtaining calicoctl binary
  add cross requirement for k8s services and hyperkube
  update metadata for new pillar model
  update manifests to use hyperkube from common
  **REQUIRED:** Define image to use for hyperkube, CNIs and calicoctl image


>	            hyperkube:
>	              image: gcr.io/google_containers/hyperkube:v1.4.6
>	            network:
>	              calicoctl:
>	                image: calico/ctl
>	              cni:
>	                image: calico/cni


# Formula leonardo


###  Ales Komarek


  Support for single app management


  Django-Leonardo formula


  Python/django based CMS.


  Sample metadata


  Without setting formula produce somethink like this ``Example app`` from your
  site name ``site_name``


  More information


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme
  * https://github.com/leonardo-modules/leonardo-auth-ldap


###  Jakub Josef


  Added posibility to disable strict host checking on proxy nodes.


>	              # disable strict host check on nginx proxy at app node
>	              dev: true


# Formula letsencrypt


###  Alexander Bauer


  Add `install_units` option to install Systemd units even when `method: pkg` (#16)


  This can be passed in the case that the provided package does not
  include the `.service` and `.timer` files.


  If the ``certbot`` package doesn't include Systemd ``.service`` and
  ``.timer`` files, you can set them to be installed by this formula by
  supplying ``install_units: True`` and ``cli``.


>	        letsencrypt:
>	          client:
>	            source:
>	              engine: pkg
>	              cli: /usr/bin/certbot
>	              install_units: true


###  Filip Pytloun


  Update name for multidomain


>	            # Following will produce multidomain certificate:
  site.dummy.org:


>	              enabled: true
>	              names:
>	                - dummy.org
>	                - www.dummy.org


  You are able to use multidomain certificates:


>	      letsencrypt:
>	        client:
>	          email: sylvain@home
>	          staging: true
>	          auth:
>	            method: apache
>	          domain:
>	            keynotdomain:
>	              name: ls.opensource-expert.com
>	              - www.ls.opensource-expert.com
>	              - vim22.opensource-expert.com
>	              - www.vim22.opensource-expert.com
  rm.opensource-expert.com:


>	              - www.rm.opensource-expert.com
  vim7.opensource-expert.com:


>	              - www.vim7.opensource-expert.com
  vim88.opensource-expert.com:


>	              - www.vim88.opensource-expert.com
>	              - awk.opensource-expert.com
>	              - www.awk.opensource-expert.com


  Unify Makefile, .gitignore and update readme


  Fix metadata model


  Installation


  Usage


  Default authentication method using standalone server on specified port.


  But this won't work without configuration of apache/nginx (read on) unless you
  don't have webserver running so you can select port 80 or 443.


>	          email: root@dummy.org
>	            method: standalone
>	            type: http-01
>	            port: 9999
  dummy.org:


  www.dummy.org:


  However ACME server always visits port 80 (or 443) where most likely Apache or


  Nginx is listening. This means that you need to configure
  ``/.well-known/acme-challenge/`` to proxy requests on localhost:9999.


  For example, ensure you have following configuration for Apache:


>	  ::


  ProxyPass "/.well-known/acme-challenge/" "http://127.0.0.1:9999/.well-known/acme-challenge/" retry=1


  ProxyPassReverse "/.well-known/acme-challenge/" "http://127.0.0.1:9999/.well-known/acme-challenge/"


  <Location "/.well-known/acme-challenge/">


  ProxyPreserveHost On


  Order allow,deny


  Allow from all


  Require all granted
  </Location>


  You can also use ``apache`` or ``nginx`` auth methods and let certbot do
  what's needed, this should be the simplest option.


>	          auth: apache


  Alternatively you can use webroot authentication (using eg. existing apache
  installation serving directory for all sites):


>	            method: webroot
>	            path: /var/www/html
>	            port: 80


  It's also possible to override auth method or other options only for single


>	  domain:


>	              auth:
>	                method: webroot
>	                path: /var/www/html/dummy.org
>	                port: 80


  Legacy configuration


  * `Certbot authentication plugins <https://letsencrypt.readthedocs.io/en/latest/using.html#getting-certificates-and-choosing-plugins>`_


  Use certbot and add more installation options


>	    Fixes: #1


  There are 3 installation methods available:


>	  - package (default for Debian)


  For Debian Jessie, you need to use jessie-backports repository. For Ubuntu,
  use Launchpad PPA providing certbot package. You can use linux formula to
  manage these APT sources.


>	  - URL to certbot-auto (default)


  This is default installation method for systems with no available certbot
  package.


>	              engine: url
>	              url: "https://dl.eff.org/certbot-auto"


>	  - Docker container


  Alternate installation method where Docker image is used to provide certbot
  tool and executed using wrapper script.


>	              engine: docker
>	              image: "deliverous/certbot"


  Common metadata:


# Formula libvirt


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme
  * https://github.com/bechtoldt/saltstack-libvirt-formula


###  Michael Polenchuk


  Get unix_sock_group & config_sys as an option


>	          unix_sock_group: libvirt


# Formula linux


###  Ales Komarek


  Allow mining for the dns records for local hosts records


  Use ``/etc/environment`` for static system wide variable assignment after
  boot. Variable expansion is frequently not supported.


  The profile.d scripts are being sourced during .sh execution and support
  variable expansion in opposite to /etc/environment global settings in
  ``/etc/environment``.


  Linux with hosts collected from mine


  In this case all dns records defined within infrastrucuture will be passed to
  local hosts records or any DNS server. Only hosts with `grain` parameter to
  true will be propagated to the mine.


>	      linux:
>	        network:
>	          purge_hosts: true
>	          mine_dns_records: true
>	          host:
>	            node1:
>	              address: 192.168.10.200
>	              grain: true
>	              names:
>	              - node2.domain.com
>	              - service2.domain.com
  setting custom TX queue length for tap interfaces


###  Aleš Komárek


  Update README.rst


  Linux Fomula


  Sample Pillars


  Linux System


  Cmds_Alias {{ alias }}={{ commands }}
  saltuser1 ALL=(ALL) NOPASSWD: ALL


###  Andrey Shestakov


  Allow configure systemd


  Systemd settings:


>	        system:
  ...


>	          systemd:
>	            system:
>	              Manager:
>	                DefaultLimitNOFILE: 307200
>	                DefaultLimitNPROC: 307200
>	            user:
>	                DefaultLimitCPU: 2
>	                DefaultLimitNPROC: 4


###  Andrii Petrenko


>	    Feature: automatically set txqueuelen for all tap* network interfaces
>	    Config:
>	    linux:
  in case of configuration parameter defined will create file:
  with content:


  KERNEL==”tap[0-9a-z\-]*", RUN+="/sbin/ip link set %k txqueuelen 10000"
  **setting custom TX queue length for tap interfaces**


>	          tap_custom_txqueuelen: 10000


###  azvyagintsev


  Extend linux.user


  Linux with system users, some with password set:


  If no 'password' variable has been passed - any predifined password
  will be removed.


>	              full_name: 'With clear password'
>	              hash_password: true
>	              password: "userpassword"
>	            mark:
>	              name: 'mark'
>	              enabled: true
>	              full_name: "unchange password'
>	              home: '/home/mark'
>	              password: false
>	            elizabeth:
>	              name: 'elizabeth'
>	              full_name: 'With hased password'
>	              home: '/home/elizabeth'
>	              password: "$6$nUI7QEz3$dFYjzQqK5cJ6HQ38KqG4gTWA9eJu3aKx6TRVDFh6BVJxJgFWg2akfAA7f1fCxcSUeOJ2arCO6EEI6XXnHXxG10"


###  Bruno Binet


  Add system.autoupdates state (#61)
  only Debian-based systems are supported for now


  Linux with autoupdates (automatically install security package updates)


>	          autoupdates:
>	            enabled: true
>	            mail: root@localhost
>	            mail_only_on_error: true
>	            remove_unused_dependencies: false
>	            automatic_reboot: true
>	            automatic_reboot_time: "02:00"


###  Dmitry Stremkouski


  One should be able to change ovs port type if its not virtual.


  If ovs port is virtual, we use OVSIntPort to create it.


  Otherwise it should be OVSPort.


  I've added new key: ovs_port_type to not intersect with current
  deployments and not hurt anyone.


  I've updated doc to have an example of ovs peering patch.


  Customer-Found


>	            br-prv:
>	              type: ovs_bridge
>	              mtu: 65000
>	            br-ens7:
>	              name: br-ens7
>	              proto: manual
>	              mtu: 9000
>	              use_interfaces:
>	              - ens7
>	            patch-br-ens7-br-prv:
>	              name: ens7-prv
>	              ovs_type: ovs_port
>	              type: ovs_port
>	              bridge: br-ens7
>	              port_type: patch
>	              peer: prv-ens7
>	            patch-br-prv-br-ens7:
>	              name: prv-ens7
>	              bridge: br-prv
>	              peer: ens7-prv
>	            ens7:
>	              name: ens7
>	              ovs_port_type: OVSPort
>	              ovs_bridge: br-ens7


###  Filip Pytloun


  Add linux.system.apt state


  Setup custom apt config options:


>	          apt:
>	            config:
>	              compression-workaround:
  "Acquire::CompressionTypes::Order": "gz"


>	              docker-clean:
  "DPkg::Post-Invoke":


>	                  - "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"
  "APT::Update::Post-Invoke":


  Add linux.system.directory state


  Ensure presence of directory:


>	          directory:
  /tmp/test:


>	              user: root
>	              group: root
>	              mode: 700
>	              makedirs: true


  Add ca_certificates into readme


>	    Fixes: #120


  Certificates
  ~~~~~~~~~~~~


  Add certificate authority into system trusted CA bundle


>	          ca_certificates:
>	            mycert: |


  MIICPDCCAaUCEHC65B0Q2Sk0tjjKewPMur8wDQYJKoZIhvcNAQECBQAwXzELMAkG


  A1UEBhMCVVMxFzAVBgNVBAoTDlZlcmlTaWduLCBJbmMuMTcwNQYDVQQLEy5DbGFz
  cyAzIFB1YmxpYyBQcmltYXJ5IENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTk2


  MDEyOTAwMDAwMFoXDTI4MDgwMTIzNTk1OVowXzELMAkGA1UEBhMCVVMxFzAVBgNV


  BAoTDlZlcmlTaWduLCBJbmMuMTcwNQYDVQQLEy5DbGFzcyAzIFB1YmxpYyBQcmlt


  YXJ5IENlcnRpZmljYXRpb24gQXV0aG9yaXR5MIGfMA0GCSqGSIb3DQEBAQUAA4GN


  ADCBiQKBgQDJXFme8huKARS0EN8EQNvjV69qRUCPhAwL0TPZ2RHP7gJYHyX3KqhE


  BarsAx94f56TuZoAqiN91qyFomNFx3InzPRMxnVx0jnvT0Lwdd8KkMaOIG+YD/is


  I19wKTakyYbnsZogy1Olhec9vn2a/iRFM9x2Fe0PonFkTGUugWhFpwIDAQABMA0G


  CSqGSIb3DQEBAgUAA4GBALtMEivPLCYATxQT3ab7/AoRhIzzKBxnki98tsX63/Do
  lbwdj2wsqFHMc9ikwFPwTtYmwHYBV4GSXiHx0bH/59AhWM1pF+NEHJwZRDmJXNyc


  AA9WjQKZ7aKQRUzkuxCkPfAyAw7xzvjoyVGM5mKf5p/AfbdynMk2OmufTqj/ZA1k


  Add support for sysfs


  Sysfs
  ~~~~~


  Install sysfsutils and set sysfs attributes:


>	          sysfs:
>	            scheduler:
  block/sda/queue/scheduler: deadline


>	            power:
>	              mode:
  power/state: 0660


>	              owner:
  power/state: "root:power"
  devices/system/cpu/cpu0/cpufreq/scaling_governor: powersave


  Use cron job identifier to be able to update command


  By default it will use name as an identifier, unless identifier key is
  explicitly set or False (then it will use Salt's default behavior which is
  identifier same as command resulting in not being able to change it)


>	              identifier: cmd1


  Unify Makefile, .gitignore and update readme


  Allow enforcing of whole /etc/hosts


  Parameter purge_hosts will enforce whole /etc/hosts file, removing entries
  that are not defined in model except defaults for both IPv4 and IPv6 localhost
  and hostname + fqdn.


  It's good to use this option if you want to ensure /etc/hosts is always in a
  clean state however it's not enabled by default for safety.


>	            # No need to define this one if purge_hosts is true
>	            hostname:
>	              address: 127.0.1.1
>	              - ${linux:network:fqdn}
>	              - ${linux:network:hostname}


###  Jakub Pavlik


  Extend by mkfs for XFS filesystem


>	                    mkfs: True
>	                    type: xfs


  Disk partitioning


  Ability to create partitions on empty disks.


  Create partitions on disk. Specify size in MB. It expects empty
  disk without any existing partitions.


>	        linux:
>	          storage:
>	            disk:
>	              first_drive:
>	                name: /dev/loop1
>	                type: gpt
>	                partitions:
>	                  - size: 200 #size in MB
>	                    type: fat32
>	                  - size: 300 #size in MB
>	                    type: ext4
  /dev/vda1:


>	                  - size: 5
>	                    type: ext2
>	                  - size: 10


###  Jakub Josef


  Added ability to enable SETENV in sudoers


>	              setenv: true # Enable sudo -E option


  Linux OVS dpdk vxlan tunnel endpoint ip address


  Add possiblity to add ip address and mtu on dpdk ovs bridge to
  be able use VXLAN as tenant segmentation.


>	    Epic: PROD-8957
  **DPDK OVS bridge for VXLAN**


  If VXLAN is used as tenant segmentation then ip address must be set on br-prv


>	          interface:
>	              type: dpdk_ovs_bridge
>	              address: 192.168.50.0
>	              netmask: 255.255.255.0


  Linux OVS-dpdk and multiqueue support


  Introduce dpdk support for linux OVS configuration.


  It configures dpdk interface bind, ovs dpdk ports, bonding,
  parameters for dpdk cpu pmd and set multique queues for specific
  ovs dpdk interfaces.


>	    Epic: PROD-8958
>	            - 8.8.4.4
>	            - 8.8.8.8
>	            - my.example.com
>	            - example.com
>	            - ndots: 5
>	            - timeout: 2
>	            - attempts: 2


  DPDK OVS interfaces


  **DPDK OVS NIC**


>	          bridge: openvswitch
>	          dpdk:
>	            driver: uio/vfio-pci
>	          openvswitch:
>	            pmd_cpu_mask: "0x6"
>	            dpdk_socket_mem: "1024,1024"
>	            dpdk_lcore_mask: "0x400"
>	            memory_channels: 2
>	            dpkd0:
>	              name: ${_param:dpdk_nic}
>	              pci: 0000:06:00.0
>	              driver: igb_uio/vfio
>	              type: dpdk_ovs_port
>	              n_rxq: 2


  **DPDK OVS Bond**


>	            dpdk_second_nic:
>	              name: ${_param:primary_second_nic}
>	              bond: dpdkbond0
>	            dpdk_first_nic:
>	              name: ${_param:primary_first_nic}
>	              pci: 0000:05:00.0
>	            dpdkbond0:
>	              type: dpdk_ovs_bond
>	              mode: active-backup


  Linux storage


  File swap configuration


  Partition swap configuration


  Implement isolcpu grub configuration


  Separate cpu for host os from workload.


>	    Epic: PROD-8959


  Isolate CPU options
  ~~~~~~~~~~~~~~~~~~~


  Remove the specified CPUs, as defined by the cpu_number values, from the general kernel


  SMP balancing and scheduler algroithms. The only way to move a process onto or off an
  "isolated" CPU is via the CPU affinity syscalls. cpu_number begins at 0, so the
  maximum value is 1 less than the number of CPUs on the system.


>	          kernel:
>	            isolcpu: 1,2,3,4,5,6,7 # isolate first cpu 0


  SRIOV support


  Enable SR-IOV support on server.


>	    Epic: PROD-8956


  Intel SR-IOV


  PCI-SIG Single Root I/O Virtualization and Sharing (SR-IOV) specification defines a standardized mechanism to virtualize PCIe devices. The mechanism can virtualize a single PCIe Ethernet controller to appear as multiple PCIe devices.


>	            sriov: True
>	            unsafe_interrupts: False # Default is false. for older platforms and AMD we need to add interrupt remapping workaround
>	          rc:
>	            local: |
>	              #!/bin/sh -e
>	              # Enable 7 VF on eth1
  echo 7 > /sys/class/net/eth1/device/sriov_numvfs; sleep 2; ifup -a
  exit 0


  Hugepages support


  Grub hugepages configuration and mount point action.


  Huge Pages


  Huge Pages give a performance boost to applications that intensively deal
  with memory allocation/deallocation by decreasing memory fragmentation.


>	            hugepages:
>	              small:
>	                size: 2M
>	                count: 107520
>	                mount_point: /mnt/hugepages_2MB
>	                mount: false/true # default false
>	              large:
>	                default: true # default automatically mounted
>	                size: 1G
>	                count: 210
>	                mount_point: /mnt/hugepages_1GB


>	  Note: not recommended to use both pagesizes in concurrently.


###  Jiri Broulik


  README fix for purging repos


  Remove all repositories:


>	          purge_repos: true


  nfs storage mount


  NFS mount


>	      storage:
>	        enabled: true
>	        mount:
>	          nfs_glance:
>	            path: /var/lib/glance/images
>	            device: 172.16.10.110:/var/nfs/glance
>	            file_system: nfs
>	            opts: rw,sync


  cpu governor


  CPU
  ~~~


  Disable ondemand cpu mode service:


>	          cpu:
>	            governor: performance


###  Marek Celoud


  add service management support


  Services
  ~~~~~~~~


  Stop and disable linux service:


>	          service:
  apt-daily.timer:


>	              status: dead


  Possible status is dead (disable service by default), running (enable service by default), enabled, disabled.


###  Oleg Bondarev


  This is required in order to use vfio-pci driver.


  More info: http://docs.openvswitch.org/en/latest/intro/install/dpdk/


>	            driver: uio/vfio
>	              driver: igb_uio/vfio-pci


  This enables a more fine tuned dpdk for better performance.


  More details on pmd-rxq-affinity config:


>	    http://docs.openvswitch.org/en/latest/howto/dpdk/
>	              pmd_rxq_affinity: "0:1,1:2"


###  Oleksandr Vlasov


  Add dhclient basic configuration


>	            # package manager fallback defaults


  DHCP client configuration


  None of the keys is mandatory, include only those you really need. For full list
  of available options under send, supersede, prepend, append refer to dhcp-options(5)


>	       linux:
>	         network:
>	           dhclient:
>	             enabled: true
>	             backoff_cutoff: 15
>	             initial_interval: 10
>	             reboot: 10
>	             retry: 60
>	             select_timeout: 0
>	             timeout: 120
>	             send:
>	               - option: host-name
>	                 declaration: "= gethostname()"
>	             supersede:
>	                 declaration: "spaceship"
>	               - option: domain-name
>	                 declaration: "domain.home"
>	               #- option: arp-cache-timeout
>	               #  declaration: 20
>	             prepend:
>	               - option: domain-name-servers
>	                 declaration:
>	                   - 8.8.8.8
>	                   - 8.8.4.4
>	               - option: domain-search
>	                   - example.com
>	                   - eng.example.com
>	             #append:
>	               #- option: domain-name-servers
>	               #  declaration: 127.0.0.1
>	             # ip or subnet to reject dhcp offer from
>	             reject:
>	               - 192.33.137.209
>	               - 10.0.2.0/24
>	             request:
>	               - subnet-mask
>	               - broadcast-address
>	               - time-offset
>	               - routers
>	               - domain-name
>	               - domain-name-servers
>	               - domain-search
>	               - host-name
>	               - dhcp6.name-servers
>	               - dhcp6.domain-search
>	               - dhcp6.fqdn
>	               - dhcp6.sntp-servers
>	               - netbios-name-servers
>	               - netbios-scope
>	               - interface-mtu
>	               - rfc3442-classless-static-routes
>	               - ntp-servers
>	             require:
>	             # if per interface configuration required add below
>	             interface:
>	               ens2:
>	                 initial_interval: 11
>	                 reject:
>	                   - 192.33.137.210
>	               ens3:
>	                 initial_interval: 12
>	                   - 192.33.137.211


###  Petr Jediný


  Introduce ipflush_onchange


  Debian manual proto interfaces


  When you are changing interface proto from static in up state to manual, you
  may need to flush ip addresses. For example, if you want to use the interface
  and the ip on the bridge. This can be done by setting the ``ipflush_onchange``
  to true.


>	            eth1:
>	              type: eth
>	              mtu: 9100
>	              ipflush_onchange: true


  Add concat and remove for interfaces.d


  Concatinating and removing interface files


  Debian based distributions have `/etc/network/interfaces.d/` directory, where
  you can store configuration of network interfaces in separate files. You can
  concatinate the files to the defined destination when needed, this operation
  removes the file from the `/etc/network/interfaces.d/`. If you just need to
  remove iface files, you can use the `remove_iface_files` key.


>	          concat_iface_files:
>	          - src: '/etc/network/interfaces.d/50-cloud-init.cfg'
>	            dst: '/etc/network/interfaces'
>	          remove_iface_files:
>	          - '/etc/network/interfaces.d/90-custom.cfg'


###  Petr Michalec


  Add linux.network.systemd support


  Linux network systemd settings:


>	            link:
>	              10-iface-dmz:
>	                Match:
>	                  MACAddress: c8:5b:67:fa:1a:af
>	                  OriginalName: eth0
>	                Link:
>	                  Name: dmz0
>	            netdev:
>	              20-bridge-dmz:
>	                match:
>	                  name: dmz0
>	                network:
>	                  mescription: bridge
>	                  bridge: br-dmz0
>	            network:
>	            # works with lowercase, keys are by default capitalized
>	              40-dhcp:
>	                  name: '*'
>	                  DHCP: yes


  Add system.env, system.profile, system.proxy and configure proxy under system.repo


  Package manager proxy setup globally:


>	          repo:
>	            apt-mk:
>	              source: "deb http://apt-mk.mirantis.com/ stable main salt"


>	          proxy:
>	            pkg:
>	              ftp:   ftp://ftp-proxy-for-apt.host.local:2121


>	            # NOTE: Global defaults for any other componet that configure proxy on the system.
>	            #       If your environment has just one simple proxy, set it on linux:system:proxy.
>	            #
>	            # fall back system defaults if linux:system:proxy:pkg has no protocol specific entries
>	            # as for https and http
>	            ftp:   ftp://proxy.host.local:2121
>	            http:  http://proxy.host.local:3142
>	            https: https://proxy.host.local:3143


  Package manager proxy setup per repository:


>	            debian:


>	              # per repository proxy
>	              proxy:
>	                enabled: true
>	                http:  http://maas-01:8080
>	                https: http://maas-01:8080


>	            # package manager fallback defaults 
>	            # used if linux:system:repo:apt-mk:proxy has no protocol specific entries
>	              ftp:   ftp://proxy.host.local:2121
>	              #http:  http://proxy.host.local:3142
>	              #https: https://proxy.host.local:3143
  ... 


>	            # global system fallback system defaults


  RC
  ~~


  Configure global environment variables
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  Linux /etc/environment:
  ``/etc/environment`` is for static system wide variable assignment after boot. Variable expansion is frequently not supported.


>	          env:
>	            BOB_VARIABLE: Alice


>	            BOB_PATH:
>	              - /srv/alice/bin
>	              - /srv/bob/bin


>	            ftp_proxy:   none
>	            http_proxy:  http://global-http-proxy.host.local:8080
>	            https_proxy: ${linux:system:proxy:https}
>	            no_proxy:
>	              - 192.168.0.80
>	              - 192.168.1.80
>	              - .domain.com
>	              - .local
>	          # NOTE: global defaults proxy configuration.
>	            noproxy:


  Configure profile.d scripts
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~


  Linux /etc/profile.d:


  The profile.d scripts are being sourced during .sh execution and support variable expansion in opposite to /etc/environment
  global settings in ``/etc/environment``.


>	          profile:
>	            locales: |
  export LANG=C
  export LC_ALL=C
  vi_flavors.sh: |
  export PAGER=view
  export EDITOR=vim
  alias vi=vim
  shell_locales.sh: |
  export LANG=en_US
  export LC_ALL=en_US.UTF-8
  shell_proxies.sh: |
  export FTP_PROXY=ftp://127.0.3.3:2121
  export NO_PROXY='.local'
  ~~~~~~~~~~~~~~~~
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  Add sudo state, salt-managed aliases,users,groups


  Linux with system users, some with password set


  Configure sudo for users and groups under ``/etc/sudoers.d/``.


  This ways ``linux.system.sudo`` pillar map to actual sudo attributes:


>	     # simplified template:


  {{ user }}   {{ hosts }}=({{ runas }}) NOPASSWD: {{ commands }}
  %{{ group }} {{ hosts }}=({{ runas }}) NOPASSWD: {{ commands }}


>	     # when rendered:


>	      system:
>	        sudo:
>	          enabled: true
>	          alias:
>	            host:
>	              LOCAL:
>	              - localhost
>	              PRODUCTION:
>	              - db1
>	              - db2
>	            runas:
>	              DBA:
>	              - postgres
>	              - mysql
>	              SALT:
>	              - root
>	            command:
>	              # Note: This is not 100% safe when ALL keyword is used, user still may modify configs and hide his actions.
>	              #       Best practice is to specify full list of commands user is allowed to run.
>	              SUPPORT_RESTRICTED:
>	              - /bin/vi /etc/sudoers*
>	              - /bin/vim /etc/sudoers*
>	              - /bin/nano /etc/sudoers*
>	              - /bin/emacs /etc/sudoers*
>	              - /bin/su - root
>	              - /bin/su -
>	              - /bin/su
>	              - /usr/sbin/visudo
>	              SUPPORT_SHELLS:
>	              - /bin/sh
>	              - /bin/ksh
>	              - /bin/bash
>	              - /bin/rbash
>	              - /bin/dash
>	              - /bin/zsh
>	              - /bin/csh
>	              - /bin/fish
>	              - /bin/tcsh
>	              - /usr/bin/login
>	              - /usr/bin/su
>	              - /usr/su
>	              ALL_SALT_SAFE:
>	              - /usr/bin/salt state*
>	              - /usr/bin/salt service*
>	              - /usr/bin/salt pillar*
>	              - /usr/bin/salt grains*
>	              - /usr/bin/salt saltutil*
>	              - /usr/bin/salt-call state*
>	              - /usr/bin/salt-call service*
>	              - /usr/bin/salt-call pillar*
>	              - /usr/bin/salt-call grains*
>	              - /usr/bin/salt-call saltutil*
>	              SALT_TRUSTED:
>	              - /usr/bin/salt*
>	          users:
>	            # saltuser1 with default values: saltuser1 ALL=(ALL) NOPASSWD: ALL
>	            saltuser1: {}
>	            saltuser2:
>	              hosts:
>	              - LOCAL
>	            # User Alias DBA
>	            DBA:
>	              - ALL
>	              commands:
>	              - ALL_SALT_SAFE
>	          groups:
>	            db-ops:
>	              - '!PRODUCTION'
>	              runas:
>	              - DBA
>	              - /bin/cat *
>	              - /bin/less *
>	              - /bin/ls *
>	            salt-ops:
>	              - 'ALL'
>	              - SALT
>	              - SUPPORT_SHELLS
>	            salt-ops-2nd:
>	              name: salt-ops
>	              nopasswd: false
>	              - '!SUPPORT_SHELLS'
>	              - '!SUPPORT_RESTRICTED'


###  Piotr Kruk


  add startsector for partitions
  disk without any existing partitions. (set startsector=1, if you want to start partitions from 2048)


>	                startsector: 1


###  Serhiy Ovsianikov


  Add atop


  Linux with atop service:


>	          atop:
>	            interval: 20
>	            logpath: "/var/log/atop"
>	            outfile: "/var/log/atop/daily.log"


###  Simon Pasquier


  Add linux.storage.loopback state


  This state allows to configure loopback device(s). This isn't meant to
  be used in production but offers a cheap way to test Cinder with LVM
  volumes.


  Linux with local loopback device


>	        storage:
>	          loopback:
>	            disk1:
>	              file: /srv/disk1
>	              size: 50G


###  teoyaomiqui


  RIL-267 Adding cpu governor and kernel module opts (#101)


  Configure or blacklist kernel modules with additional options to `/etc/modprobe.d` following example 
  will add `/etc/modprobe.d/nf_conntrack.conf` file with line `options nf_conntrack hashsize=262144`:


>	            module:
>	              nf_conntrack:
>	                option:
>	                  hashsize: 262144


  Enable cpufreq governor for every cpu:


###  Tomas Kamm


  fixed typo in sudo part


>	          aliases:


###  Tomáš Kukrál


  add support for kernel modules


  Load kernel modules and add them to `/etc/modules`:


>	            modules:
>	              - nf_conntrack
>	              - tp_smapi
>	              - 8021q


###  Vladimir Eremin


  netconsole remote kernel logger


  To configure:


  It works with both static and DHCP interfaces, and applies online.


  You could use bash-scripting in netconsole.conf.


  You could override the MAC.


  See tests/pillar/system.sls for further information.


  Netconsole Remote Kernel Logging


  Netconsole logger could be configured for configfs-enabled kernels
  (`CONFIG_NETCONSOLE_DYNAMIC` should be enabled). Configuration applies both in
  runtime (if network is already configured), and on-boot after interface
  initialization. Notes:


  * receiver could be located only in same L3 domain
  (or you need to configure gateway MAC manually)
  * receiver's MAC is detected only on configuration time
  * using broadcast MAC is not recommended


>	      parameters:
>	          system:
>	            netconsole:
>	              port: 514 (optional)
>	              loglevel: debug (optional)
>	              target:
  192.168.0.1:


>	                  interface: bond0
>	                  mac: "ff:ff:ff:ff:ff:ff" (optional)


# Formula lldp


###  Damian Szeluga


  Fix readme and tests
  ====


###  Marcin Iwinski


  fixing README


  Link Layer Discovery Protocol service.


>	          #list of interfaces handling LLDPBPDUs


  initial commit
  ===


  LLDP 


  Link Layer Discovery Protocol services.


  Sample pillars


  LLDP client


>	      lldp:
>	        client:
>	          enabled: true
>	          intefaces:
>	          - eth0
>	          - eth1


# Formula logrotate


###  Filip Pytloun


  Allow deploying logrotate jobs using support meta


  Cross-formula relationship


  It's possible to use support meta to define logrotate rules from within other
  formula.


  Example ``meta/logrotate.yml`` for horizon formula:


>	      job:
>	        horizon:
>	          - files:
>	              - /var/log/horizon/*.log
>	            options:
>	              - compress
>	              - delaycompress
>	              - missingok
>	              - notifempty
>	              - rotate: 10
>	              - daily
>	              - minsize: 20M
>	              - maxsize: 500M
>	              - postrotate: "if /etc/init.d/apache2 status > /dev/null; then /etc/init.d/apache2 reload > /dev/null; fi"


  Unify Makefile, .gitignore and update readme


# Formula maas


###  azvyagintsev


  Add network commissioning script


  EME-70


>	          00-maas-05-simplify-network-interfaces: /etc/maas/files/commisioning_scripts/00-maas-05-simplify-network-interfaces


>	    Modules: add wait_for_machine_status function


>	      maas:
>	        cluster:
>	          enabled: true
>	          role: master/slave


  Module function's example:


  * Wait for status of selected machine's:


>	     cat maas/machines/wait_for_machines_ready.sls


  ...


>	      wait_for_machines_ready:
  module.run:


>	        - name: maas.wait_for_machine_status
>	        - kwargs:
>	              machines:
>	                - kvm01
>	                - kvm02
>	              timeout: 1200 # in seconds
>	              req_status: "Ready"
>	        - require:
>	          - cmd: maas_login_admin


  If module run w/\o any extra paremeters - `wait_for_machines_ready` will wait for defined in salt machines. In those case, will be usefull to skip some machines:


>	     cat maas/machines/wait_for_machines_deployed.sls


>	              req_status: "deployed"
>	              ignore_machines:
>	                 - kvm01 # in case it's broken or whatever


  List of avaibled `req_status` defined in global variable:


###  Damian Szeluga


  Updated readme


>	      salt_master_ip: 192.168.0.10
>	        commissioning_scripts:
  00-maas-06-create-raid.sh: /srv/salt/reclass/scripts/commisioning_script.sh


>	        maas_config:
>	          domain: mydomain.local
>	          http_proxy: http://192.168.0.10:3142
>	          commissioning_distro_series: xenial
>	          default_distro_series: xenial
>	          default_osystem: 'ubuntu'
>	          default_storage_layout: lvm
>	          disk_erase_with_secure_erase: true
>	          dnssec_validation: 'no'
>	          enable_third_party_drivers: true
>	          maas_name: cfg01
>	          network_discovery: 'enabled'
>	          active_discovery_interval: '600'
>	          ntp_external_only: true
>	          ntp_servers: 10.10.11.23 10.10.11.24
>	          upstream_dns: 192.168.12.13
>	          enable_http_proxy: true
>	          default_min_hwe_kernel: ''
>	         sshprefs:
>	          - 'ssh-rsa ASDFOSADFISdfasdfasjdklfjasdJFASDJfASdf923@AAAAB3NzaC1yc2EAAAADAQABAAACAQCv8ISOESGgYUOycYw1SAs/SfHTqtSCTephD/7o2+mEZO53xN98sChiFscFaPA2ZSMoZbJ6MQLKcWKMK2OaTdNSAvn4UE4T6VP0ccdumHDNRwO3f6LptvXr9NR5Wocz2KAgptk+uaA8ytM0Aj9NT0UlfjAXkKnoKyNq6yG+lx4HpwolVaFSlqRXf/iuHpCrspv/u1NW7ReMElJoXv+0zZ7Ow0ZylISdYkaqbV8QatCb17v1+xX03xLsZigfugce/8CDsibSYvJv+Hli5CCBsKgfFqLy4R5vGxiLSVzG/asdjalskjdlkasjdasd/asdajsdkjalaksdjfasd/fa/sdf/asd/fas/dfsadf blah@blah'


  Expand readme


>	    maas:
>	      region:
>	        theme: mirantis
>	        bind:
>	          host: 192.168.0.10:5240
>	          port: 5240
>	        admin:
>	          username: exampleuser
>	          password: examplepassword
>	          email:  email@example.com
>	        database:
>	          engine: null
>	          host: localhost
>	          name: maasdb
>	          password: qwqwqw
>	          username: maas
>	        enabled: true
>	        user: mirantis
>	        token: "89EgtWkX45ddjMYpuL:SqVjxFG87Dr6kVf4Wp:5WLfbUgmm9XQtJxm3V2LUUy7bpCmqmnk"
>	        fabrics:
>	          test-fabric:
>	            description: Test fabric
>	        subnets:
>	          subnet1:
>	            fabric: test-fabric
>	            cidr: 2.2.3.0/24
>	            gateway_ip: 2.2.3.2
>	            iprange:
>	              start: 2.2.3.20
>	              end: 2.2.3.250
>	        dhcp_snippets:
>	          test-snippet:
>	            value: option bootfile-name "tftp://192.168.0.10/snippet";
>	            description: Test snippet
>	            enabled: true
>	            subnet: subnet1
>	        boot_resources:
>	          bootscript1:
>	            title: bootscript
>	            architecture: amd64/generic
>	            filetype: tgz
>	            content: /srv/salt/reclass/nodes/path_to_file
>	        package_repositories:
>	          Saltstack:
>	            url: http://repo.saltstack.com/apt/ubuntu/14.04/amd64/2016.3/
>	            distributions:
>	                 - trusty
>	            components:
>	                - main
>	                - extra
>	            arches: amd64
>	                 Version: GnuPG v2


  mQENBFOpvpgBCADkP656H41i8fpplEEB8IeLhugyC2rTEwwSclb8tQNYtUiGdna9
  m38kb0OS2DDrEdtdQb2hWCnswxaAkUunb2qq18vd3dBvlnI+C4/xu5ksZZkRj+fW
  tArNR18V+2jkwcG26m8AxIrT+m4M6/bgnSfHTBtT5adNfVcTHqiT1JtCbQcXmwVw


  WbqS6v/LhcsBE//SHne4uBCK/GHxZHhQ5jz5h+3vWeV4gvxS3Xu6v1IlIpLDwUts
  kT1DumfynYnnZmWTGc6SYyIFXTPJLtnoWDb9OBdWgZxXfHEcBsKGha+bXO+m2tHA
  gNneN9i5f8oNxo5njrL8jkCckOpNpng18BKXABEBAAG0MlNhbHRTdGFjayBQYWNr


  YWdpbmcgVGVhbSA8cGFja2FnaW5nQHNhbHRzdGFjay5jb20+iQE4BBMBAgAiBQJT
  qb6YAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRAOCKFJ3le/vhkqB/0Q


  WzELZf4d87WApzolLG+zpsJKtt/ueXL1W1KA7JILhXB1uyvVORt8uA9FjmE083o1
  yE66wCya7V8hjNn2lkLXboOUd1UTErlRg1GYbIt++VPscTxHxwpjDGxDB1/fiX2o
  nK5SEpuj4IeIPJVE/uLNAwZyfX8DArLVJ5h8lknwiHlQLGlnOu9ulEAejwAKt9CU
  4oYTszYM4xrbtjB/fR+mPnYh2fBoQO4d/NQiejIEyd9IEEMd/03AJQBuMux62tjA
  /NwvQ9eqNgLw9NisFNHRWtP4jhAOsshv1WW+zPzu3ozoO+lLHixUIz7fqRk38q8Q
  9oNR31KvrkSNrFbA3D89uQENBFOpvpgBCADJ79iH10AfAfpTBEQwa6vzUI3Eltqb
  9aZ0xbZV8V/8pnuU7rqM7Z+nJgldibFk4gFG2bHCG1C5aEH/FmcOMvTKDhJSFQUx
  uhgxttMArXm2c22OSy1hpsnVG68G32Nag/QFEJ++3hNnbyGZpHnPiYgej3FrerQJ
  zv456wIsxRDMvJ1NZQB3twoCqwapC6FJE2hukSdWB5yCYpWlZJXBKzlYz/gwD/Fr


  GL578WrLhKw3UvnJmlpqQaDKwmV2s7MsoZogC6wkHE92kGPG2GmoRD3ALjmCvN1E


  PsIsQGnwpcXsRpYVCoW7e2nW4wUf7IkFZ94yOCmUq6WreWI4NggRcFC5ABEBAAGJ


  AR8EGAECAAkFAlOpvpgCGwwACgkQDgihSd5Xv74/NggA08kEdBkiWWwJZUZEy7cK


  WWcgjnRuOHd4rPeT+vQbOWGu6x4bxuVf9aTiYkf7ZjVF2lPn97EXOEGFWPZeZbH4
  vdRFH9jMtP+rrLt6+3c9j0M8SIJYwBL1+CNpEC/BuHj/Ra/cmnG5ZNhYebm76h5f


  T9iPW9fFww36FzFka4VPlvA4oB7ebBtquFg3sdQNU/MmTVV4jPFWXxh4oRDDR+8N
  1bcPnbB11b5ary99F/mqr7RgQ+YFF0uKRE3SKa7a+6cIuHEZ7Za+zhPaQlzAOZlx
  fuBmScum8uQTrEF5+Um5zkwC7EXTdH1co/+/V/fpOtxIg4XO4kcugZefVm5ERfVS


  MA==
  =dtMN


>	        machines:
>	          machine1:
>	            interfaces:
>	              - one1: "11:22:33:44:55:66"
>	            power_parameters:
>	              power_type: ipmi
>	              power_address: '192.168.10.10'
>	              power_user: bmc_user
>	              power_password: bmc_password
>	        devices:
>	          machine1-ipmi:
>	            interface:
>	              ip_address: 192.168.10.10
>	              subnet: cidr:192.168.10.0/24
>	            mac: '66:55:44:33:22:11'


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Jiri Broulik


  maas-proxy upstream proxy support and jenkins slave proxy port


>	        upstream_proxy:
>	          address: 10.0.0.1
>	          port: 8080


###  Maciej Relewicz


  fixes


>	              mac: "11:22:33:44:55:66"
>	            distro_series: xenial
>	            hwe_kernel: hwe-16.04


###  Martin Polreich


  Add restore script for Maas DB


  MAAS region service with backup data


>	        region:
>	          database:
>	            initial_data:
>	              source: cfg01.local
>	              host: 192.168.0.11


###  Michael Polenchuk


  Mend machines status


  Remove lower() function to prevent an exception of


>	              req_status: "Deployed"


###  Ondrej Smola


  added user and password for maas upstream proxy


>	          user: username      #OPTIONAL
>	          password: password  #OPTIONAL


  added support for power driver setting


>	              #Optional (for legacy HW)
>	              power_driver: LAN


###  Petr Ruzicka


  Fix documentation and add virsh power_type support


>	              # Used in case of power_type: virsh
>	              power_id: my_libvirt_vm_name


###  Richard Felkl


  added support local mirrors


  Usage of local repos


>	      cluster:
>	          port: 80
>	        saltstack_repo_key: |
>	          Version: GnuPG v2


>	        saltstack_repo_xenial: "http://${_param:local_repo_url}/ubuntu-xenial stable salt"
>	        saltstack_repo_trusty: "http://${_param:local_repo_url}/ubuntu-trusty stable salt"


###  Roald Nefs


  Added link to official Ubuntu MAAS website


  Added link to official Ubuntu MAAS website in the 'Read more' section of README.rst.
  * https://maas.io/


# Formula magnum


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula mayan


###  Ales Komarek


  Docfix


  Mayan Formula


  Automated OCR of documents, automatic categorization, flexible metadata,
  extensive access control, Mayan EDMS has all this to offers and many more
  features to help you tame your documents.


  Sample pillars


  More Information


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme
  * https://openode.readthedocs.org/en/latest/install_mayan_server.html


# Formula memcached


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula midonet


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme
  * http://www.midokura.com/midonet/


# Formula model-manager


###  Adam Tengler


  Fixed server.sls and parametrized configuration


>	          secret_key: supersecretkey
>	            address: https://github.com/salt-formulas/django-model-manager.git
>	            protocol: https
>	            model_template:
>	              remote: http
>	              url: https://git.my-gitlab.io/group/project/raw/master/context.yaml
>	              job: generator-job
>	          delivery:


###  Ales Komarek


  Keystone identity docs
  model-manager service with Keystone authentication


>	            host: keystone.endpoint.com
>	            api_version: 3


  Use-cases doc image fix


>	     :width: 60%


  Use-cases doc


>	     :scale: 50%
>	     :align: center


  Use cases for the model-manager service are:


  * Streamline the model generation of complex infrastructures
  * Wath the deployment process installing services across infrastructure
  * Align monitoring checks and metrics to infrastructure


  Visualization


  Documentation fixes
  model-manager formula


  Model-manager is a service for manipulating the metadata models of the


  SaltStack/reclass based deployments. It covers model management at various
  stages of deployment life-cycles.


  Sample metadata


  model-manager service with keystone authentication


>	      model_manager:
>	        server:
>	          enabled: true
>	          source:
>	            engine: git
>	            address: git@github.com:salt-formulas/django-model-manager.git
>	            revision: master
>	          identity:
>	            engine: keystone
>	            address: git@repo.com:repo.git


  model-manager service with model generator and Jenkins integration


>	          config_files:
>	          - _4000_integration
>	          - _4010_models_panel_group
>	          - _4020_integration_overview_panel
>	          - _4030_integration_modeldesigner_panel
>	          integration:
>	            engine: jenkins
>	            protocol: http
>	            host: 127.0.0.1
>	            port: 8080
>	            user: model-manager
>	            password: password
>	          model_template:


  model-manager service with Salt master integration


>	          - _5000_delivery
>	          - _5010_resource_management_panel_group
>	          - _5020_delivery_resource_topology_panel
>	          - _5030_delivery_salt_control_panel
>	          orchestration:
>	            engine: salt
>	            port: 6969


  * http://salt-formulas.readthedocs.io/en/latest/develop/overview-reclass.html


  Documentation and bugs


>	      https://github.com/salt-formulas/salt-formula-model-manager/issues


  Initial commit


  model_manager formula


  Service model_manager description


  Sample pillars


  Single model_manager service


>	          version: icehouse


  More information


  * a link


  * links


# Formula monasca


# Formula mongodb


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula moodle


###  Aleš Komárek


  docfix


  Moodle Formula


  Moodle is a Course Management System (CMS), also known as a Learning


  Management System (LMS) or a Virtual Learning Environment (VLE). It is
  a Free web application that educators can use to create effective online
  learning sites.


  Sample Pillars


>	      moodle:
>	        enabled: true
>	        apps:
>	        - enabled: true
>	          name: 'uni'
>	          prefix: 'uni_' # max 5 chars
>	          version: '2.5'
>	          database:
>	            engine: 'postgresql'
>	            host: '127.0.0.1'
>	            name: 'moodle_uni'
>	            password: 'pwd'
>	            user: 'moodle_uni'
>	          cache:
>	            engine: 'memcached'
>	          themes:
>	          - name: uni
>	            source:
>	              type: git
>	              address: git@repo.git.cz:domain/repo.git
>	              branch: master


  More Information


  * https://moodle.org/plugins/view.php?plugin=cachestore_apc
  * http://midact.com/content/moodle-how-enable-memcached
  * http://docs.moodle.org/dev/The_Moodle_Universal_Cache_%28MUC%29
  * http://docs.moodle.org/24/en/Cron


# Formula mosquitto


###  Ales Komarek


  Doc fixes
  mosquitto formula


  External links


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula motion


# Formula murano


###  Aleš Komárek


  Update README.rst


  Murano formula


>	          murano_agent_queue:
>	            engine: rabbitmq
>	            port: 5672
>	            members:
>	            - host: 192.168.1.13
>	            - host: 192.168.1.14
>	            - host: 192.168.1.15
>	            user: openstack
>	            password: supersecretcatalogpassword


  External links


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Pavel Cizinsky


  add insecure param/fix murano_agent_queue


>	          insecure: false
>	            host: 192.168.1.10


# Formula mysql


###  Ales Komarek


  Readme fix


  MySQL Formula


  MySQL is the world's second most widely used open-source relational database
  management system (RDBMS).


  Sample Metadata


  Standalone setups


  Database with initial data


>	      mysql:
>	        server:
>	          enabled: true
>	          database:
>	            datatabese_with_init_data:
>	              encoding: 'utf8'
>	              users:
>	              - name: 'username'
>	                password: 'password'
>	                host: 'localhost'
>	                rights: 'all privileges'
>	              initial_data:
>	                engine: backupninja
>	                source: backup.host
>	                host: original-host-name
>	                database: original-database-name


  MySQL Galera cluster


  MySQL Galera cluster is configured for ring connection between 3 nodes. Each
  node should have just one member.


  MySQL client


  Sample Usage


  More Information


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Jiri Broulik


  restore db


  Database with initial data (Restore DB)


>	        client:
>	          server:
>	            database:
>	              admin:
>	                host: localhost
>	                port: 3306
>	                user: ${_param:mysql_admin_user}
>	                password: ${_param:mysql_admin_password}
>	                encoding: utf8
>	              database:
>	                neutron_upgrade:
>	                  encoding: utf8
>	                  users:
>	                  - name: neutron
>	                    password: ${_param:mysql_neutron_password}
>	                    host: '%'
>	                    rights: all
>	                    host: ${_param:single_address}
>	                  initial_data:
>	                    engine: backupninja
>	                    source: ${_param:backupninja_backup_host}
>	                    host: ${linux:network:fqdn}
>	                    database: neutron


  The provided setup restores db named neutron_upgrade with data from db called neutron.


# Formula nagios


###  Dmitrii Sutagin


  Add multi-user functionality


  Nagios UI configrations with HTTP basic authentication (use "readonly" flag to specify readonly users)


>	                # this is the main admin, it cannot have a 'readonly' flag.
>	                # 'users' section is optional, allows defining additional users.
>	                users:
>	                  - username: nagios_admin_2
>	                    password: secret2
>	                  - username: nagios_user
>	                    password: secret3
>	                    readonly: true


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Jaymes Mosher


  Adds notification handlers for Slack, Salesforce, and Pagerduty.


  Also adding tests.


  Nagios Notification Handlers


  You can configure notification handlers.  Currently supported handlers are SMTP, Slack,


  Salesforce, and Pagerduty.


>	      nagios:
>	        server:
>	          enabled: true
>	          notification:
>	            slack:
>	              enabled: true
>	              webhook_url: https://hooks.slack.com/services/abcdef/12345
>	            pagerduty:
>	              key: abcdef12345
>	            sfdc:
>	              client_id: abcdef12345
>	              client_secret: abcdef12345
>	              username: abcdef
>	              password: abcdef
>	              auth_url: https://abcedf.my.salesforce.com
>	              environment: abcdef
>	              organization_id: abcdef


>	      # SMTP without auth
>	            smtp:
>	              auth: false
>	              url: smtp://127.0.0.1:25
>	              from: nagios@localhost
>	              # Notification email subject can be defined, must be one line
>	              # default subjects are:
>	              host_subject: >-
  ** $NOTIFICATIONTYPE$ Host Alert: $HOSTNAME$ is $HOSTSTATE$ **


>	              service_subject: >-
  ** $NOTIFICATIONTYPE$ Service Alert: $HOSTNAME$/$SERVICEDESC$ is $SERVICESTATE$ **


>	      # An example using a Gmail account as a SMTP relay
>	              auth: login
>	              url: smtp://smtp.gmail.com:587
>	              from: <you>@gmail.com
>	              starttls: true
>	              username: foo
>	              password: secret


  Each handler adds two commands, `notify-host-by-<HANDLER>`, and `notify-service-by-<HANDLER>`, that you can
  reference in a contact.


>	          objects:
>	            contact:
>	              sfdc:
>	                alias: sfdc
>	                contactgroups:
>	                  - Operator
>	                email: root@localhost
>	                host_notification_commands: notify-host-by-sfdc
>	                host_notification_options: d,r
>	                host_notification_period: 24x7
>	                host_notifications_enabled: 1
>	                service_notification_commands: notify-service-by-sfdc
>	                service_notification_options: c,r
>	                service_notification_period: 24x7
>	                service_notifications_enabled: 1


  By default in Stacklight, notifications are only enabled for `00-top-clusters` and individual host
  and SSH checks.  If you want to enable notifications for all checks you can enable this value:


>	            alarm_enabled_override: true


  The notification interval defaults to zero, which will only send one notification when the alert
  triggers.  You can override the interval if you want notifications to repeat.  For example, to
  have them repeat every 30 minutes:


>	            hosts:
>	              generic_host_tpl:
>	                notification_interval: 30
>	            services:
>	              generic_service_tpl:


  Platform support


###  Swann Croiset


  Use by default IPv4 for Host IP addresses


>	            grain_interfaces: 'ip4_interfaces' # the default


  Fix typo in README


  There are 2 different ways to configure the Host IP adddresses, the preferred way


  Configure Host IP address belonging to a network


  Fixes issue #6


>	                network: 10.0.0.0/8


  Note about dynamic hosts IP addresses configuration:


  There are 2 different ways to configure the Host IP adddress, the prefered way
  is to define the **network** of the nodes to pickup the first IP address found
  belonging to this network.


>	          dynamic:
>	            enabled: true
>	              - target: '*'
>	                contact_groups: Operator


  The alternative way is to define the **interface** list, to pickup the first IP
  address of the first interface found.


>	                interface:
>	                - eth0
>	                - ens0


  If both properties are defined, the **network** option wins and the **interface** is
  ignored.


# Formula network


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula neutron


###  Aleš Komárek


  Update README.rst


  Neutron Formula


  Sample Pillars


>	  Note: If you want contrail lbaas then backend is only required. Lbaas in
  pillar should be define only if it should be disabled.


  Neutron VXLAN tenant networks with Network nodes


  With DVR for East-West and Network node for North-South.
  routers will only be utilized for traffic that is router within the cloud
  infrastructure and that remains encapsulated. External traffic will be 
  routed to via the network nodes. 


  Neutron Server


  Network Node


  Neutron VXLAN tenant networks with Network Nodes with DVR


  With DVR for East-West and North-South, DVR everywhere, Network node for SNAT.


  Advanced Neutron Features (DPDK, SR-IOV)


  Neutron Client


###  Dennis Dmitriev


  Allow keystone endpoint_type interpolation for Neutron models


>	            endpoint_type: internal


###  Dmitry Stremkouski


  One should be able to set up different mtus for different physnets
  external_mtu may differ from tenant_net_mtu


  This patchset fixes that issue


  Customer-Found


  Specify different mtu values for different physnets


>	      neutron:
>	        server:
>	          version: mitaka
>	          backend:
>	            external_mtu: 1500
>	            tenant_net_mtu: 9000
>	            ironic_net_mtu: 9000


  One should be able to set path_mtu value for neutron


>	          path_mtu: 1500


  Fixing inaccurate physnet mapping iterations


  In order to handle situations, when external vlan ranges are not
  applicable, we should iterate properly to generate config file.


  Removing physnet1 hardcode in such case.


>	    Pillar:
  is not set by default anywhere, so it would be True and this
  patch does not break backward compatibility for physnet1 hardcode.


  Adding ironic physnet handling


  Disable physnet1 bridge


  By default we have external access turned on, so among any physnets in
  your reclass there would be additional one: physnet1, which is mapped to
  br-floating


  If you need internal nets only without this bridge, remove br-floating
  and configurations mappings. Disable mappings for this bridge on


>	  neutron-servers:


>	          external_access: false


>	  gateways:


>	        gateway:


  compute nodes:


>	        compute:


###  Dmitry Ukov


  Policy.json should be defined by user


  User can override and add values to policy.json by creating flat
  key-value structure under neutron:server:policy.


  Configuration of policy.json file


  ....


>	          policy:
>	            create_subnet: 'rule:admin_or_network_owner'
  'get_network:queue_id': 'rule:admin_only'


>	            # Add key without value to remove line from policy.json
  'create_network:shared':


###  Elena Ezhova


  Revert "Refactor mechanism driver metadata"


  This reverts commit 79ffa26858d682f404984175dc1ab93863a149ad.


  Fixes PROD-14994


>	              ovs:
>	                driver: openvswitch
>	              sriov:
>	                driver: sriovnicswitch


  Refactor mechanism driver metadata


  Using a quite heavy nested dict structure for defining a list of
  mechanism driver to load is an overkill. This change simplifies
  the structure by turning it into a list.


  The mechanism driver meta for gateway and compute nodes is now moved
  to the system level (like it is already done for control nodes).


  The l2population mechanism driver is still enabled by default,
  however its enablement is no longer unconditional.


>	              - openvswitch
>	              - l2population
>	              - sriovnicswitch


  Remove references to the neutron:server:plugin parameter


  This parameter is present in service- and system-level metadata
  even though it became oblosete somewhere around adoption of Kilo
  release of OpenStack when it was replased by the


>	    neutron:server:backend:engine param. Its presense currently only
  clutters metadata and the formula and confuses users.


  This change removes references to this param from the formula and
  fixes the 2 remaining cases of its usage:


  Add FWaaS support


  This adds all necessary FWaaS configuration for the Ocata version.


  Both V1 and V2 versions can be enabled, however only V1 is operable
  in this release.


  PROD-13639


  Neutron FWaaSv1 enablement


>	    neutron:
>	      fwaas:
>	        enabled: true
>	        version: ocata
>	        api_version: v1


  Allow configuring Neutron LBaaSv2 with Octavia


  Updated lbaas settings in neutron-server.conf to allow enabling
  neutron_lbaas with Octavia driver.


  Neutron LBaaSv2 enablement


>	            octavia:
>	              engine: octavia
>	              driver_path: 'neutron_lbaas.drivers.octavia.driver.OctaviaDriver'
>	              base_url: 'http://127.0.0.1:9876'
>	              driver_path: 'avi_lbaasv2.avi_driver.AviDriver'
>	  Note: If the Contrail backend is set, Opencontrail loadbalancer would be enabled
  automatically. In this case lbaas should disabled in pillar:


>	          enabled: false


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Ilya Chukhnakov


  Make VLAN-aware-VMs configurable


  VLAN-aware-VMs are only supported with OVS firewall driver.


  This patch makes the feature configurable and leaves it disabled
  by default to ensure the feature is only available on supported
  configurations to avoid confusion.


  Neutron with VLAN-aware-VMs


>	          vlan_aware_vms: true


###  Jakub Pavlik


  OVS-dpdk support


  Introduce dpdk support for neutron OVS configuration


>	    Epic: PROD-8957


  Neutron OVS DPDK


  Enable datapath netdev for neutron openvswitch agent


  ...


>	          dpdk: True


>	          plugin: ml2
>	            engine: ml2


>	            mechanism:


  SRIOV support in Neutron OVS


  Enable SRIOV support for Neutron OVS


>	    Epic: PROD-8956


  Neutron OVS SR-IOV


>	            tenant_network_types: "flat,vlan" # Can be mixed flat,vlan,vxlan
>	            sriov:
>	              nic_one:
>	                devname: eth1
>	                physical_network: physnet3


###  Jiri Broulik


  neutron floating IPs implementation


  Floating IP addresses


>	        client:
>	          enabled: true
>	          server:
>	            identity:
>	              floating_ip:
>	                prx01-instance:
>	                  server: prx01.mk22-lab-basic.local
>	                  subnet: private-subnet1
>	                  network: public-net1
>	                  tenant: demo
>	                gtw01-instance:


  Instance port in the stated subnet will be associated with the dynamically generated floating IP.


  neutron client per tenant


  Client role


  Neutron networks


>	              network:
>	                inet1:
>	                  shared: False
>	                  admin_state_up: True
>	                  router_external: True
>	                  provider_physical_network: inet
>	                  provider_network_type: flat
>	                  provider_segmentation_id: 2
>	                  subnet:
>	                    inet1-subnet1:
>	                      cidr: 192.168.90.0/24
>	                      enable_dhcp: False
>	                inet2:
>	                  tenant: admin
>	                  provider_network_type: "vlan"
>	                    inet2-subnet1:
>	                      cidr: 192.168.92.0/24
>	                    inet2-subnet2:
>	                      cidr: 192.168.94.0/24
>	                      enable_dhcp: True
>	            identity1:


  Neutron routers


>	              router:
>	                inet1-router:
>	                  gateway_network: inet
>	                  interfaces:
>	                    - inet1-subnet1
>	                    - inet1-subnet2


>	      TODO: implement adding new interfaces to a router while updating it


  Neutron security groups


>	              security_group:
>	                security_group1:
>	                  description: security group 1
>	                  rules:
>	                    - direction: ingress
>	                      ethertype: IPv4
>	                      protocol: TCP
>	                      port_range_min: 1
>	                      port_range_max: 65535
>	                      remote_ip_prefix: 0.0.0.0/0
>	                      protocol: UDP
>	                      protocol: ICMP


>	      TODO: implement updating existing security rules (now it adds new rule if trying to update existing one)


  neutron client


>	                   description: security group 1
>	                   rules:
>	                     - direction: ingress
>	                       ethertype: IPv4
>	                       protocol: TCP
>	                       port_range_min: 1
>	                       port_range_max: 65535
>	                       remote_ip_prefix: 0.0.0.0/0
>	                       protocol: UDP
>	                       protocol: ICMP


###  Kirill Bespalov


  OpenStack HTTPS Endpoints support


  Communication between services usually done via internal
  endpoints that are located in internal network. In some
  cases it is required to encrypt traffic even on internal
  network. This patch unhardcode communication protocol between


  Glance and other services. Also adds possibility to specify
  ca_file to verify SSL certificates of remote peers.


  This change is fully backward compatible.


  Configuring TLS communications


  **Note:** by default system wide installed CA certs are used, so ``cacert_file`` param is optional, as well as ``cacert``.


>	  - **RabbitMQ TLS**
>	   neutron:
  server, gateway, compute:


>	          port: 5671
  (optional) cacert: cert body if the cacert_file does not exists
  (optional) cacert_file: /etc/openstack/rabbitmq-ca.pem
  (optional) version: TLSv1_2


>	  - **MySQL TLS**
>	     server:
>	        database:
  (optional) cacert_file: /etc/openstack/mysql-ca.pem


>	  - **Openstack HTTPS API**
>	        identity:
>	           protocol: https
  (optional) cacert_file: /etc/openstack/proxy.pem


  RabbitMQ TLS support


  OSCORE-385


>	    Releases: Mitaka, Newton, Ocata
>	    Usage: see README.rst


  Client-side RabbitMQ TLS configuration:


  |


  To enable TLS for oslo.messaging you need to provide the CA certificate.


  By default system-wide CA certs are used. Nothing should be specified except `ssl.enabled`.


>	        message_queue:
>	          ssl:
>	            enabled: True


  Use `cacert_file` option to specify the CA-cert file path explicitly:


>	            cacert_file: /etc/ssl/rabbitmq-ca.pem


  To manage content of the `cacert_file` use the `cacert` option:


>	            cacert: |


>	            cacert_file: /etc/openstack/rabbitmq-ca.pem


>	  Notice:
  * The `message_queue.port` is set to **5671** (AMQPS) by default if `ssl.enabled=True`.
  * Use `message_queue.ssl.version` if you need to specify protocol version. By default is TLSv1 for python < 2.7.9 and TLSv1_2 for version above.


###  Mykyta Karpin


  Allow to set workers for neutron


  This change adds ability to set custom workers number for neutron
  defined in pillar, backward compatibility is kept and hardcoded values
  from template will be used.


>	          api_workers: 2
>	          rpc_workers: 2
>	          rpc_state_report_workers: 2
>	            workers: 2


###  Oleg Bondarev


  Use a separate dir for vhost_user sockets


  Currently when OVS-DPDK is enabled, instances fail to spawn
  due to permissions mismatch, see nova bug for details:


>	    https://bugs.launchpad.net/nova/+bug/1670950


  This patch updates openvswitch agent config to use a separate
  directory for the sockets. Nova formula patch:


>	    https://gerrit.mcp.mirantis.net/#/c/11213/ takes care
  of creating the dir with proper permissions.


  Corresponding reclass-system patch is:


>	    https://gerrit.mcp.mirantis.net/13307/
>	          vhost_socket_dir: /var/run/openvswitch


###  Oleg Iurchenko


  Add Designate integration


  This patch adds Designate support


  Neutron with Designate


>	            extension:
>	              dns:
>	                enabled: True
>	                host: 127.0.0.1
>	                port: 9001
>	                protocol: http


  Add OVN support


  Install docs:


>	    https://docs.openstack.org/networking-ovn/latest/install/index.html


  Partial Prod: PROD-15003


>	    Co-Authored-By: Elena Ezhova <eezhova@mirantis.com>


  Neutron with OVN


  Control node:


>	            engine: ovn
>	              ovn:
>	                driver: ovn
>	            tenant_network_types: "geneve,flat"


  Compute node:


>	          local_ip: 10.2.0.105
>	          controller_vip: 10.1.0.101


  Change extensions list type


  This patch changes type of extensions pillar to dictionary


  qos


  Add extensions list


  This patch adds extensions list instead of hardcoded.


  Enable Neutron extensions (QoS, DNS, etc.)


>	              - dns
>	              - qos


  Allow disabling security groups


  For some use cases it might be needed to disable security groups.


  For example best DPDK performance can be achieved only with disabled
  security groups.


  Neutron with security groups disabled


>	          security_groups_enabled: False


###  Ondrej Smola


  enable support for cors params


  Enable CORS parameters


>	          cors:
>	            allowed_origin: https:localhost.local,http:localhost.local
>	            expose_headers: X-Auth-Token,X-Openstack-Request-Id,X-Subject-Token
>	            allow_methods: GET,PUT,POST,DELETE,PATCH
>	            allow_headers: X-Auth-Token,X-Openstack-Request-Id,X-Subject-Token
>	            allow_credentials: True
>	            max_age: 86400


  added avinetworks lbaas funcionality


  Neutron lbaas provides on the controller node


>	      server:
>	        lbaas:
>	          providers:
>	            avi_adc:
>	              enabled: true
>	              engine: avinetworks
>	              controller_address: 10.182.129.239
>	              controller_user: admin
>	              controller_password: Cloudlab2016
>	              controller_cloud_name: Default-Cloud
>	            avi_adc2:


>	  Note: If you want contrail lbaas then backend is only required. Lbaas in pillar should be define only if it should be disabled.


>	          enabled: disabled


###  Richard Felkl


  added support for custom endpoint type


>	              endpoint_type: internalURL


###  Simon Pasquier


  Add suport for availability zones


  Neutron supports availability zones but only for DHCP and L3 agents.


>	          availability_zone: az1


###  Swann Croiset


  Configure pagination


  The pagination is useful to retrieve a large bunch of resources,
  because a single request may fail (timeout).


>	          allow_pagination: true
>	          pagination_max_limit: 100
>	  Note: The pagination is useful to retrieve a large bunch of resources,
  because a single request may fail (timeout). This is enabled with both
  parameters *allow_pagination* and *pagination_max_limit* as shown above.


###  Thom Gerdes


  Allow setting some VXLAN paramters


  Allow setting the multicast group and the VNI range that will be used
  when using the ML2 plugin.


  Additonal VXLAN tenant network settings


  The default multicast group of 224.0.0.1 only multicasts to a single subnet.


  Allow overriding it to allow larger underlay network topologies.


>	          vxlan:
>	            group: 239.0.0.0/8
>	            vni_ranges: "2:65535"


###  Vasyl Saienko


  Cover bridge physnet mapping for Ironic


  Ironic in flat scenario require a separate neutron flat network.


  This patch adds physnet3:br-baremetal to bridge_mappings when
  neutron.gateway.ironic_enabled is defined
  is suggested only for those who really know what they're doing with Neutron).
  infrastructure and that remains encapsulated. External traffic will be
  routed to via the network nodes.


  The intention is that each tenant will require at least two (2) vrouters
  one to be utilised


>	            password: pass
>	          dvr: False


  This section describes a network solution that utilises VxLAN
  overlay networks with DVR with North-South and East-West. Network


>	          external_access: True


# Formula nfs


###  Aleš Komárek


  Update and rename README.md to README.rst


  NFS Formula


  Sample Pillars


  NFS Server: Basic sharing


>	      nfs:
>	        server:
>	          enabled: true
>	          share:
>	            home_majklk:
>	              path: /home/majklk
>	              host:
>	                inter:
>	                  host: 10.10.10.0/24
>	                  params:
>	                  - rw
>	                  - no_root_squash
>	                  - sync
>	                pub:
>	                  host: 10.0.0.0/24


  NFS Client with mounted directory


>	        client:
>	          mount:
>	            samba1:
>	              path: /media/myuser/public/
>	              fstype: nfs
>	              host: //192.168.0.1/storage


  NFS mount


>	      linux:
>	        storage:
>	         mount:
>	            nfs:
>	              enabled: true
>	              path: /var/lib/glance
>	              file_system: nfs
>	              device: 10.0.103.152:/storage/glance/vpc20


  More Information


  * http://wiki.ubuntu.cz/nfs


###  Tomáš Kukrál


  fix README


>	              device: 192.168.0.1:/home/majklk


# Formula nginx


###  Aleš Komárek


  Update README.rst


  Nginx Formula


  Sample Pillars


  More Information


###  Dmitry Stremkovskiy


  Presenting upstream feature for nginx


  With this feature you will be able to set up nginx load balancer


  Simple load balancer


>	      nginx:
>	        server:
>	          upstream:
>	            horizon-upstream:
>	              backend1:
>	                address: 10.10.10.113
>	                port: 8078
>	                opts: weight=3
>	              backend2:
>	                address: 10.10.10.114
>	          site:
>	            nginx_proxy_openstack_web:
>	              enabled: true
>	              type: nginx_proxy
>	              name: openstack_web
>	              proxy:
>	                upstream_proxy_pass: http://horizon-upstream
>	              host:
>	                name: 192.168.0.1
>	                port: 31337


  Presenting stream feature for nginx. TCP/UDP port proxy/balancing


  With this patchset you will be able to set up tcp or udp proxy.


  Simple TCP/UDP proxy


>	          stream:
>	            rabbitmq:
>	                port: 5672
>	              backend:
>	                server1:
>	                  address: 10.10.10.113
>	                  port: 5672
>	                  least_conn: true
>	                  hash: "$remote_addr consistent"
>	            unbound:
>	                bind: 127.0.0.1
>	                port: 53
>	                protocol: udp
>	                  port: 5353


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Niklaus Giger


  Fix Readme: type names must preceeded by nginx_


>	              type: nginx_static


###  Ondrej Smola


  Added possibility to disable proxy_request_buffering in nginx


>	                request_buffer: false


###  Ramon Melero


  Handle dynamic nginx ssl options
  ssl protocol options for nginx are hard coded in the formula
  added documentation for changing nginx ssl options


  Change nginx server ssl protocol options in openstack/proxy.yml


>	            site01:
>	              name: site01
>	                name: site01.domain.com
>	              ssl:
>	                enabled: true
>	                key_file:  /srv/salt/pki/${_param:cluster_name}/${salt:minion:cert:proxy:common_name}.key
>	                cert_file: /srv/salt/pki/${_param:cluster_name}/${salt:minion:cert:proxy:common_name}.crt
>	                chain_file: /srv/salt/pki/${_param:cluster_name}/${salt:minion:cert:proxy:common_name}-with-chain.crt
>	                protocols: TLSv1 TLSv1.1 TLSv1.2
>	                ciphers: "ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:ECDHE-ECDSA-DES-CBC3-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-CBC3-SHA:!DSS"
>	                prefer_server_ciphers: true
>	                ecdh_curve: secp521r1


# Formula nodejs


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula nova


###  Aleš Komárek


  Update README.rst


  Nova Formula


  Sample Pillars


###  Damian Szeluga


  Expand readme, clean up code and move client.identity outside az


>	          aggregates:
>	          - hosts_with_fc
>	          - hosts_with_ssd


  Create aggregates + add hosts to aggregates


  Aggregates


>	      nova:
>	        client:
>	          enabled: true
>	          server:
>	            identity:
>	              aggregates:
>	              - aggregate1
>	              - aggregate2


###  Dmitry Stremkovskiy


  Adding ability to set cinder/cross_az_attach setting


>	          cross_az_attach: false


  Unhardcoding disk_cachemodes nova option


>	          disk_cachemodes: network=writeback,block=none


  Adding ability to set DEFAULT/host


>	          host: node-12.domain.tld


  Unhradcoding compute.user.groups for nova. Upgrade related


  Group membership for user nova (upgrade related)


>	        compute:
  ...


>	          user:
>	            groups:
>	            - libvirt


  Presenting upgrade_levels option


  Upgrade levels


>	        controller:
>	          upgrade_levels:
>	            compute: juno


  Unhardcoding my_ip option for compute


>	          my_ip: 10.1.0.16


  Adding support for instances_path


  Nova configured with NFS


>	          instances_path: /mnt/nova/instances


>	      linux:
>	        storage:
>	          mount:
>	            nfs_nova:
>	              enabled: true
>	              path: ${nova:compute:instances_path}
>	              device: 172.31.35.145:/data
>	              file_system: nfs
>	              opts: rw,vers=3


###  Dmitry Ukov


  Policy.json should be defined by user


  User can override and add values to policy.json by creating flat
  key-value structure under nova:controller:policy.


  Configuration of policy.json file


  ....


>	          policy:
>	            context_is_admin: 'role:admin or role:administrator'
  'compute:create': 'rule:admin_or_owner'


>	            # Add key without value to remove line from policy.json
  'compute:create:attach_network':


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Jakub Pavlik


  CPU pinning & Hugepages libvirt mounts


  Hugepages mount point definition for libivirt. Nova vcpu pin set
  parameter definition.


>	    Epic: PROD-8959


  CPU pinning & Hugepages


  CPU pinning of virtual machine instances to dedicated physical CPU cores.


  Hugepages mount point for libvirt.


>	    nova:
>	      controller:
>	        scheduler_default_filters: "DifferentHostFilter,RetryFilter,AvailabilityZoneFilter,RamFilter,CoreFilter,DiskFilter,ComputeFilter,ComputeCapabilitiesFilter,ImagePropertiesFilter,ServerGroupAntiAffinityFilter,ServerGroupAffinityFilter,NUMATopologyFilter,AggregateInstanceExtraSpecsFilter"


>	      compute:
>	        vcpu_pin_set: 2,3,4,5
>	        hugepages:
>	          mount_points:
>	          - path: /mnt/hugepages_1GB
>	          - path: /mnt/hugepages_2MB


  SRIOV support


  Enable SRIOV support in nova scheduler and compute.


>	    Epic: PROD-8956


  SRIOV


  Add PciPassthroughFilter into scheduler filters and NICs on specific compute nodes.


>	        sriov: true
>	        scheduler_default_filters: "DifferentHostFilter,RetryFilter,AvailabilityZoneFilter,RamFilter,CoreFilter,DiskFilter,ComputeFilter,ComputeCapabilitiesFilter,ImagePropertiesFilter,ServerGroupAntiAffinityFilter,ServerGroupAffinityFilter,PciPassthroughFilter"


>	        sriov:
>	          nic_one:
>	            devname: eth1
>	            physical_network: physnet1


###  Jiri Broulik


  nova availability zones


>	          availability_zone: availability_zone_01
>	              flavor1:
>	              flavor2:
>	                flavor_id: auto
>	                ram: 4096
>	                disk: 20
>	                vcpus: 2


  Availability zones


>	              availability_zones:
>	              - availability_zone_01
>	              - availability_zone_02


  introduce nova client implementation


  Client role


  Nova flavors


>	      client:
>	        enabled: true
>	        server:
>	          identity:
>	            flavor:
>	              jirka-flavor1:
>	                flavor_id: 10
>	                disk: 10
>	                vcpus: 1
>	          identity1:


###  Kalynovskyi


  Adding feature to support lvm for ephemeral VMs


  Nova with ephemeral configured with LVM


>	          lvm:
>	            ephemeral: yes
>	            images_volume_group: nova_vg
>	            nova_vg:
>	              name: nova_vg
>	              devices:
>	                - /dev/sdf
>	                - /dev/sdd
>	                - /dev/sdg
>	                - /dev/sde
>	                - /dev/sdc
>	                - /dev/sdj
>	                - /dev/sdh


###  Kirill Bespalov


  RabbitMQ TLS support


>	    Releases: Mitaka, Newton, Ocata
>	    Usage: see README.rst


  OSCORE-140


  Client-side RabbitMQ TLS configuration:


  To enable TLS for oslo.messaging you need to provide the CA certificate.


  By default system-wide CA certs is used. Nothing should be specified except `ssl.enabled`.


>	        message_queue:
>	          ssl:
>	            enabled: True


  Use `cacert_file` option to specify the CA-cert file path explicitly:


>	            cacert_file: /etc/ssl/rabbitmq-ca.pem


  To manage content of the `cacert_file` use the `cacert` option:


>	            cacert: |


>	            cacert_file: /etc/openstack/rabbitmq-ca.pem


>	  Notice:
  * The `message_queue.port` is set to **5671** (AMQPS) by default if `ssl.enabled=True`.
  * Use `message_queue.ssl.version` if you need to specify protocol version. By default is TLSv1 for python < 2.7.9 and TLSv1_2 for version above.


>	       compute:


###  kkalynovskyi


  Change allows to set user and group for QEMU processes run by the system instance


  And specify whether libvirt should dynamically change file ownership to match the


  Configured user/group above


  Group and user to be used for QEMU processes run by the system instance


>	          qemu:
>	            user: nova
>	            group: cinder
>	            dynamic_ownership: 1


###  Michel Nederlof


  Add option max_concurrent_live_migrations


  Number of concurrent live migrates


  Default is to have no concurrent live migrations (so 1 live-migration at a time).


  Excerpt from config options page (https://docs.openstack.org/ocata/config-reference/compute/config-options.html):


  Maximum number of live migrations to run concurrently. This limit is
  enforced to avoid outbound live migrations overwhelming the host/network
  and causing failures. It is not recommended that you change this unless
  you are very sure that doing so is safe and stable in your environment.


  Possible values:


>	    - 0 : treated as unlimited.
>	    - Negative value defaults to 0.
>	    - Any positive integer representing maximum number of live migrations to run concurrently.


  To configure this option:


>	        max_concurrent_live_migrations: 1  # (1 is the default)


  Update README with exmple of configuring the config drive


  Config drive options


  See example below on how to configure the options for the config drive.


>	        config_drive:
>	          forced: True  # Default: True
>	          cdrom: True  # Default: False
>	          format: iso9660  # Default: vfat
>	          inject_password: False  # Default: False


  Updating to singular groupname and hide empty section if no workaround defined


>	        workaround:


  Add configurable workaround to enable live snapshots


  Nova compute workarounds


  Live snapshotting is disabled by default in nova. To enable this, it needs a manual switch.


  From manual:


>	    # When using libvirt 1.2.2 live snapshots fail intermittently under load
>	    # (likely related to concurrent libvirt/qemu operations). This config
>	    # option provides a mechanism to disable live snapshot, in favor of cold
>	    # snapshot, while this is resolved. Cold snapshot causes an instance
>	    # outage while the guest is going through the snapshotting process.
>	    #
>	    # For more information, refer to the bug report:
>	    #   https://bugs.launchpad.net/nova/+bug/1334398


  Configurable pillar data:


>	        workarounds:
>	          disable_libvirt_livesnapshot: False


  Adding Trim/Unmap support for libvirt / ceph


  Hardware Trip/Unmap Support


  To enable TRIM support for ephemeral images (thru nova managed images), libvirt has this option.


>	        libvirt:
>	          hw_disk_discard: unmap


  In order to actually utilize this feature, the following metadata must be set on the image as well, so the SCSI unmap is supported.


>	    glance image-update --property hw_scsi_model=virtio-scsi <image>
>	    glance image-update --property hw_disk_bus=scsi <image>


  Allow a custom filter to be used / injected.


  Custom Scheduler filters


  If you have a custom filter, that needs to be included in the scheduler, then you can include it like so:


>	        scheduler_custom_filters:
>	        - my_custom_driver.nova.scheduler.filters.my_custom_filter.MyCustomFilter


>	        # Then add your custom filter on the end (make sure to include all other ones that you need as well)
>	        scheduler_default_filters: "DifferentHostFilter,RetryFilter,AvailabilityZoneFilter,RamFilter,CoreFilter,DiskFilter,ComputeFilter,ComputeCapabilitiesFilter,ImagePropertiesFilter,ServerGroupAntiAffinityFilter,ServerGroupAffinityFilter,PciPassthroughFilter,MyCustomFilter"


###  Oleg Iurchenko


  Add Barbican integration to Nova


  This patch adds Barbican integration to Nova


>	          barbican:
>	            enabled: true


  Enable Barbican integration


###  Ondrej Smola


  added cors support into nova controller


  Enable CORS parameters


>	          cors:
>	            allowed_origin: https:localhost.local,http:localhost.local
>	            expose_headers: X-Auth-Token,X-Openstack-Request-Id,X-Subject-Token
>	            allow_methods: GET,PUT,POST,DELETE,PATCH
>	            allow_headers: X-Auth-Token,X-Openstack-Request-Id,X-Subject-Token
>	            allow_credentials: True
>	            max_age: 86400


###  Petr Michalec


  Add opt. resume guests on host boot (#10)


>	          resume_guests_state_on_host_boot: False


###  Petr Jediný


  SR-IOV VFs need to be accesible by qemu


  SR-IOV


###  Simon Pasquier


  Allow to configure the pagination


>	          osapi_max_limit: 500


###  Thom Gerdes


  Allow overriding the  scheduler_host_manager


  Deployments with Ironic need a custom host manager. Allow overriding it.


  Don't add PciPassthroughFilter explicitly to the active filters.
  nova.scheduler.filters.all_filters should include this if it's in the
  default filters, and if it is removed from scheduler_default_filters in
  the pillar, the new scheduler_custom_filters will allow users to
  manually add it.


  Scheduler Host Manager


  Specify a custom host manager.


>	        scheduler_host_manager: ironic_host_manager


  Allow setting cpu_mode
  libvirt CPU mode


  Allow setting the model of CPU that is exposed to a VM. This allows better
  support live migration between hypervisors with different hardware, among other
  things. Defaults to host-passthrough.


>	        cpu_mode: host-model


# Formula ntp


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula octavia


###  Elena Ezhova


  Add creation of Octavia private key to the manager state


  Relates to PROD-12506


>	          ssh:
>	            private_key: |


  MIIEpAIBAAKCAQEAtjnPDJsQToHBtoqIo15mdSYpfi8z6DFMi8Gbo0KCN33OUn5u


  OctbdtjUfeuhvI6px1SCnvyWi09Ft8eWwq+KwLCGKbUxLvqKltuJ7K3LIrGXkt+m
  qZN4O9XKeVKfZH+mQWkkxRWgX2r8RKNV3GkdNtd74VjhP+R6XSKJQ1Z8b7eHM10v
  6IjTY/jPczjK+eyCeEj4qbSnV8eKlqLhhquuSQRmUO2DRSjLVdpdf2BB4/BdWFsD


  YOmX7mb8kpEr9vQ+c1JKMXDwD6ehzyU8kE+1kVm5zOeEy4HdYIMpvUfN49P1anRV
  2ISQ1ZE+r22IAMKl0tekrGH0e/1NP1DF5rINMwIDAQABAoIBAQCkP/cgpaRNHyg8


  ISKIHs67SWqdEm73G3ijgB+JSKmW2w7dzJgN//6xYUAnP/zIuM7PnJ0gMQyBBTMS


  NBTv5spqZLKJZYivj6Tb1Ya8jupKm0jEWlMfBo2ZYVrfgFmrfGOfEebSvmuPlh9M
  vuzlftmWVSSUOkjODmM9D6QpzgrbpktBuA/WpX+6esMTwJpOcQ5xZWEnHXnVzuTc


  SncodVweE4gz6F1qorbqIJz8UAUQ5T0OZTdHzIS1IbamACHWaxQfixAO2s4+BoUK


  ANGGZWkfneCxx7lthvY8DiKn7M5cSRnqFyDToGqaLezdkMNlGC7v3U11FF5blSEW
  fL1o/HwBAoGBAOavhTr8eqezTchqZvarorFIq7HFWk/l0vguIotu6/wlh1V/KdF+
  aLLHgPgJ5j+RrCMvTBoKqMeeHfVGrS2udEy8L1mK6b3meG+tMxU05OA55abmhYn7
  7vF0q8XJmYIHIXmuCgF90R8Piscb0eaMlmHW9unKTKo8EOs5j+D8+AMJAoGBAMo4
  8WW+D3XiD7fsymsfXalf7VpAt/H834QTbNZJweUWhg11eLutyahyyfjjHV200nNZ
  cnU09DWKpBbLg7d1pyT69CNLXpNnxuWCt8oiUjhWCUpNqVm2nDJbUdlRFTzYb2fS


  ZC4r0oQaPD5kMLSipjcwzMWe0PniySxNvKXKInFbAoGBAKxW2qD7uKKKuQSOQUft
  aAksMmEIAHWKTDdvOA2VG6XvX5DHBLXmy08s7rPfqW06ZjCPCDq4Velzvgvc9koX
  d/lP6cvqlL9za+x6p5wjPQ4rEt/CfmdcmOE4eY+1EgLrUt314LHGjjG3ScWAiirE


  QyDrGOIGaYoQf89L3KqIMr0JAoGARYAklw8nSSCUvmXHe+Gf0yKA9M/haG28dCwo
  780RsqZ3FBEXmYk1EYvCFqQX56jJ25MWX2n/tJcdpifz8Q2ikHcfiTHSI187YI34
  lKQPFgWb08m1NnwoWrY//yx63BqWz1vjymqNQ5GwutC8XJi5/6Xp+tGGiRuEgJGH


  EIPUKpkCgYAjBIVMkpNiLCREZ6b+qjrPV96ed3iTUt7TqP7yGlFI/OkORFS38xqC
  hBP6Fk8iNWuOWQD+ohM/vMMnvIhk5jwlcwn+kF0ra04gi5KBFWSh/ddWMJxUtPC1
  2htvlEc6zQAR6QfqXHmwhg1hP81JcpqpicQzCMhkzLoR1DC6stXdLg==


>	            user: octavia
>	            group: octavia


  Update SSL metadata


  Depends on: https://gerrit.mcp.mirantis.net/7678


  Related PROD: PROD-11933


>	            client_cert_key: '/etc/octavia/certs/client.key'
>	            client_cert_all: '/etc/octavia/certs/client_all.pem'


  Get Octavia network resources data from mine


  Get the following data from mine:


  Related prod: PROD-11917


  Get amphora image owner ID from mine


  Add api and manager states and metadata


  Added tests and updated the README.rst


  Octavia is an open source, operator-scale load balancing solution designed to
  work with OpenStack. It accomplishes its delivery of load balancing services
  by managing a fleet of virtual machines, known as amphorae, which it spins up
  on demand.


  Octavia is designed to “plug in” to Neutron LBaaS in the same way that any
  proprietary vendor solution would: through a Neutron LBaaS version 2 driver
  interface. Octavia plans to supplant Neutron LBaaS as the load balancing
  solution for OpenStack. At that time, third-party vendor drivers that presently
  “plug in” to Neutron LBaaS will plug in to Octavia instead. For end-users,
  this transition should be relatively seamless, because Octavia supports
  the Neutron LBaaS v2 API and it has a similar CLI interface.


  Octavia API service pillar:


>	        api:
>	          version: ocata
>	          bind:
>	            address: 127.0.0.1
>	            port: 9876
>	          database:
>	            engine: mysql
>	            host: 127.0.0.1
>	            port: 3306
>	            name: octavia
>	            password: password
>	          identity:
>	            engine: keystone
>	            region: RegionOne
>	            port: 35357
>	            tenant: service
>	          message_queue:
>	            engine: rabbitmq
>	            port: 5672
>	            user: openstack
>	            virtual_host: '/openstack'
>	          haproxy_amphora:
>	            client_cert: '/etc/octavia/certs/client.pem'
>	            server_ca: '/etc/octavia/certs/ca_01.pem'


  Octavia manager service pillar:


>	      octavia:
>	        manager:
>	          enabled: true
>	          certificates:
>	            ca_private_key_passphrase: foobar
>	            ca_private_key: '/etc/octavia/certs/private/cakey.pem'
>	            ca_certificate: '/etc/octavia/certs/ca_01.pem'
>	          controller_worker:
>	            amp_boot_network_list: '01d3edaa-422c-40b9-b265-425c981691e7'
>	            amp_flavor_id: '967972bb-ab54-4679-9f53-bf81d5e28154'
>	            amp_image_owner_id: '68520e9f926441ddb37b7c744c4005b7'
>	            amp_image_tag: amphora
>	            amp_secgroup_list: '9fcd532e-5715-423a-8e3f-51abddbe7705'
>	            amp_ssh_key_name: octavia_ssh_key
>	            loadbalancer_topology: 'SINGLE'
>	          health_manager:
>	            bind_ip: 192.168.0.12
>	            heartbeat_key: 'insecure'
>	          house_keeping:
>	            spare_amphora_pool_size: 0


  Initial commit


  Setup formula's skeleton


  Octavia


  Install and configure Octavia.


  Sample pillars


>	        server:


  More information


  Octavia developer documentation:


>	      https://docs.openstack.org/developer/octavia


  Release notes:


>	      https://docs.openstack.org/releasenotes/octavia


# Formula octoprint


###  Ales Komarek


  Docfix


  The web interface for your 3D printer.


  Single printer [deprecated]


  Multi printers setup


>	      octoprint:
>	        server:
>	          enabled: true
>	          source:
>	            engine: git
  address 'https://github.com/foosel/OctoPrint.git'


>	            rev: "master"
>	          printer:
>	            printer01:
>	              bind:
>	                address: 0.0.0.0
>	                port: 5001
>	              device:
>	                bus: serial
>	                port: /dev/ACM01
>	                model: prusa-mk2
>	              camera:
>	                protocol: mjpg
>	                url: localhost
>	                port: 1234
>	            printer02:
>	                port: /dev/ACM02
>	                model: prusa-clone
>	                port: 5002


  More Information


  Readme fix


  The snappy web interface for your 3D printer.


  External links


  Updated docs to rst


  Octoprint formula


  The responsive web interface for 3D printer


  Sample pillars


  OctoPrint web UI with printers.


>	            engine: serial
>	            webcam: true
>	          webcam:
>	            host: localhost
>	            port: 1234


  Read more


  * http://octoprint.org/
  * https://github.com/foosel/OctoPrint


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula odoo


# Formula openbook


# Formula opencontrail


###  Ales Komarek


  Enforcing virtual routers, config/analytics/database nodes


  Contrail client


  Basic parameters with identity and host configs


>	    opencontrail:
>	      client:
>	        identity:
>	          user: admin
>	          project: admin
>	          password: adminpass
>	          host: keystone_host
>	        config:
>	          host: contrail_api_host
>	          port: contrail_api_ort


  Enforcing virtual routers


  ...


>	        virtual_router:
>	          cmp01:
>	            ip_address: 172.16.0.11
>	            dpdk_enabled: True
>	          cmp02:
>	            ip_address: 172.16.0.12


  Enforcing control nodes


>	        bgp_router:
>	          ntw01:
>	            type: control-node
>	          nwt02:
>	          nwt03:
>	            ip_address: 172.16.0.13


  Enforcing edge BGP routers


>	          mx01:
>	            type: router
>	            ip_address: 172.16.0.21
>	            asn: 64512
>	          mx02:
>	            ip_address: 172.16.0.22


  Enforcing config nodes


>	        config_node:
>	          ctl01:
>	          ctl02:


  Enforcing database nodes


>	        database_node:
>	          ntw02:


  Enforcing analytics nodes


>	        analytics_node:
>	          nal01:
>	            ip_address: 172.16.0.31
>	          nal02:
>	            ip_address: 172.16.0.32


  Install compute node


###  Aleš Komárek


  Update README.rst


  OpenContrail Formula


  Sample Pillars


  Kubernetes support


  Debugging


###  Andrey


  Define metadata_secret for vrouter agent


  Set up metadata secret for the Vrouter


  In order to get cloud-init within the instance to properly fetch 
  instance metadata, metadata_proxy_secret in the Vrouter agent config
  should match the value in nova.conf. The administrator should define
  it in the pillar:


>	      opencontrail:
>	        compute:
>	          metadata:
>	            secret: opencontrail


###  Dmitry Stremkovskiy


  Enabling log4j.rootLogger configuration parameter


>	    Synopsis: By default, logger is using TRACE parameter which leads
>	    Fix:      One can configure log4j.rootLogger to use INFO parameter
>	          rootlogger: "INFO, CONSOLE"


  Unhardcoding concurrent_compactors variable


>	    Tags: Customer-Related
>	          concurrent_compactors: 1


  Adding ability to set DEFAULT/hostname


>	          hostname: node-12.domain.tld


  Unhardcoding compaction_throughput_mb_per_sec variable


>	          compaction_throughput_mb_per_sec: 16


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Jakub Pavlik


  Parametrize socket_mem for dpdk vrouter


>	            taskset: "0x0000003C00003C"
>	            socket_mem: "1024,1024"


  OpenContrail DPDK support


  Enable DPDK vrouter agent installation and configuration


>	    Epic: PROD-9023


  DPDK vRouter


>	          dpdk:
>	            enabled: true
>	            taskset: 0x0000003C00003C
>	          interface:
>	            mac_address: 90:e2:ba:7c:22:e1
>	            pci: 0000:81:00.1


###  Marek Celoud


  Enable multiple workers for alarm-gen


  Increase number of alarm-gen workers


  Port prefix will increment used ports by workers starting with 5901.


>	      collector:
>	        alarm_gen:
>	          workers: 1
>	          port_prefix: 59


###  Michel Nederlof


  Add configuration options for Default and vDNS default forwarders


  The default forwarders are read from resolv.conf file
  so basically it is just rendering a custom resolv.conf file
  and configuring the location.


  Contrail DNS custom forwarders


  By default Contrail uses the /etc/resolv.conf file to determine the upstream DNS servers.


  This can have some side-affects, like resolving internal DNS entries on you public instances.


  In order to overrule this default set, you can configure nameservers using pillar data.


  The formula is then responsible for configuring and generating a alternate resolv.conf file.


>	  Note: this has been patched recently in the Contrail distribution of Mirantis:
>	  https://github.com/Mirantis/contrail-controller/commit/ed9a25ccbcfebd7d079a93aecc5a1a7bf1265ea4
>	  https://github.com/Mirantis/contrail-controller/commit/94c844cf2e9bcfcd48587aec03d10b869e737ade


  To change forwarders for the default-dns option (which is handled by compute nodes):


>	      compute:
  ....


>	        dns:
>	          forwarders:
>	          - 8.8.8.8
>	          - 8.8.4.4


  To change forwarders for vDNS zones (handled by control nodes):


>	      control:


  Ability to configure default quotas for new projects (#27)


  As documented on the Juniper / Contrail wiki:


>	    https://github.com/Juniper/contrail-controller/wiki/Defining-default-Quotas


  Configuring OpenStack default quotasx


>	      config:
>	        quota:
>	          network: 5
>	          subnet: 10
>	          router: 10
>	          floating_ip: 100
>	          secgroup: 1000
>	          secgroup_rule: 1000
>	          port: 1000
>	          pool: -1
>	          member: -1
>	          health_monitor: -1
>	          vip: -1


  Enforcing physical routers
  h


###  Pavel Svimbersky


  Config only


  Added Global VRouter config to OC client


  Enforcing global vrouter config


>	        global_vrouter_config:
>	          name: global-vrouter-config
>	          parent_type: global-system-config
>	          encap_priority: "MPLSoUDP,MPLSoGRE"
>	          vxlan_vn_id_mode: automatic
>	          fq_names:
>	            - 'default-global-system-config'
>	            - 'default-global-vrouter-config'


###  Petr Jediný


  Parameterization of cassandra gc logging rotation


  Cassandra GC logging


  From Contrail version 3 you can set a way you want to handle Cassandra GC logs.


  The behavior is controlled by `cassandra_gc_logging`. Valid values are
  'rotation' (default), 'legacy' and false.


>	  - 'rotation' is supported by JDK 6u34 7u2 or later and handles rotation of log
  files automatically.


>	  - 'legacy' is a way to support older JDKs and you will need to handle logs by
  other means. This can be handled for example by using
  `- service.opencontrail.database.cassandra_log_cleanup` in your reclass model.


>	  - false will disable the cassandra gc logging


>	        database:
>	          cassandra_gc_logging: false


  Add LBaaSv2 Barbican support


  Barbican support is needed for HTTPS termination


  In order to get cloud-init within the instance to properly fetch


  Add auth info for Barbican on compute nodes


>	          lbaas:
>	            secret_manager:
>	              engine: barbican
>	              identity:
>	                user: admin
>	                password: "supersecretpassword123"
>	                tenant: admin


  Add gateway_mode configuration


  Compute nodes with gateway_mode


  Gateway mode: can be server/ vcpe (default is none)


>	          gateway_mode: server


  Introduce RPF default override


  Override RPF default in Contrail API


  From MCP1.1 with OpenContrail >= 3.1.1 you can override RPF default for newly
  created virtual networks. This can be useful for usecases like running


  Calico and K8S in overlay. The `override_rpf_default_by` has valid values
  `disable`, `enable`. If not defined, the configuration fallbacks to Contrail
  default - currently `enable`.


>	          override_rpf_default_by: 'disable'


  Periodic keystone project resync switch


  Add ability to switch from on demand mode.


  Contrail version must >= 3.0. It is useful especially for Keystone v3.


  Switch from on demand to periodic keystone sync


  This can be useful when you want to sync projects from OpenStack to Contrail
  automatically. The period of sync is 60s.


>	          identity:
>	            sync_on_demand: false


  For OpenContrail version >= 3.1.1 and Cassandra >= 2.1 we should override WebUI's cassandra port from 9160 to 9042.


  Add link local services provisioning support


  Enforcing Link Local Services


>	        linklocal_service:
>	           # example with dns name address (only one permited)
>	           meta1:
>	             lls_ip: 10.0.0.23
>	             lls_port: 80
>	             ipf_addresses: "meta.example.com"
>	             ipf_port: 80
>	           # example with multiple ip addresses
>	           meta2:
>	             ipf_addresses:
>	             - 10.10.10.10
>	             - 10.20.20.20
>	             - 10.30.30.30
>	           # example with one ip address
>	           meta3:
>	           # example with name override
>	           lls_meta4:
>	             name: meta4


###  Petr Michalec


  Add's support for Juniper Contrail packaging + test-kitchen (#2)


  Package source


  Formula support OpenContrail as well as Juniper Contrail package repository in the backend.


  Differences withing the configuration and state run are controlled by
  ``opencontrail.common.vendor: [opencontrail|juniper]`` pillar attribute.


  Default value is set to ``opencontrail``.


  Juniper releases tested with this formula:


>	   - 3.0.2.x


  To use Juniper Contrail repository as a source of packages override pillar as in this example:


>	        common:
>	          vendor: juniper


  Parameterize cassandra port in OpenContrail WebUI


  OpenContrail WebUI version >= 3.1.1


  For OpenContrail version >= 3.1.1 and Cassandra >=2.1 we should override WebUI's cassandra port from 9160 to 9042.


  For appropriate node at class level:


>	        web:
>	          database:
>	            port: 9042


###  Vasyl Saienko


  Extend contrail fromula


  This patch extends contrail states/modules and client to
  be able of:


  TSN nodes


  Configure TSN nodes


>	        enabled: true
>	        tor:
>	          enabled: true
>	          bind:
>	            port: 8086
>	          agent:
>	            tor01:
>	              id: 0
>	              port: 6632
>	              host: 127.0.0.1
>	              address: 127.0.0.1


>	        physical_router:
>	          router1:
>	            name: router1
>	            dataplane_ip: 1.2.3.4
>	            management_ip: 1.2.3.4
>	            vendor_name: ovs
>	            product_name: ovs
>	            agents:
>	             - tsn0-0
>	             - tsn0


  Enforcing physical/logical interfaces for routers


  opencontrail


>	      physical_router:
>	        router1:


>	            port1:
>	              name: port1
>	              logical_interface:
>	                port1_l:
>	                  name: 'port1.0'
>	                  vlan_tag: 0
>	                  interface_type: L2
>	                  virtual_machine_interface:
>	                    port1_port:
>	                      name: port1_port
>	                      ip_address: 192.168.90.107
>	                      mac_address: '2e:92:a8:af:c2:21'
>	                      security_group: 'default'
>	                      virtual_network: 'virtual-network'


  Look for neighbours, if VM has 2, it's ok


# Formula openldap


###  Filip Pytloun


  Initial commit
  openldap


  Sample pillars


  Client


>	      openldap:
>	        client:
>	          server:
>	            basedn: dc=example,dc=local
>	            host: ldap.example.local
>	            tls: true
>	            port: 389
>	            auth:
>	              user: cn=admin,dc=example,dc=local
>	              password: dummypass
>	          entry:
>	            people:
>	              type: ou
>	              classes:
>	                - top
>	                - organizationalUnit
>	              entry:
>	                jdoe:
>	                  type: cn
>	                  # Change attributes that already exists with different content
>	                  action: replace
>	                  # Delete all other attributes
>	                  purge: true
>	                  attr:
>	                    uid: jdoe
>	                    uidNumber: 20001
>	                    gidNumber: 20001
>	                    gecos: John Doe
>	                    givenName: John
>	                    sn: Doe
>	                    homeDirectory: /home/jdoe
>	                    loginShell: /bin/bash
>	                  classes:
>	                    - posixAccount
>	                    - inetOrgPerson
>	                    - top
>	                    - ldapPublicKey
>	                    - shadowAccount
>	                karel:
>	                  # Simply remove cn=karel
>	                  enabled: false


  Read more


>	  - https://docs.saltstack.com/en/latest/ref/states/all/salt.states.ldap.html#manage-entries-in-an-ldap-database


# Formula openode


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme
  * http://openode.readthedocs.org/


# Formula openssh


###  Dmitry Stremkouski


  Adding option for openssh to disable dns resolvings


>	          use_dns: False


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Jiri Broulik


  Readme pillar client fix


>	              private_key:
>	                type: rsa
>	                key: ${_param:root_private_key}


###  Marek Celoud


  add option to add DSA keys


  Enable DSA legacy keys:


>	      openssh:
>	        server:
>	          dss_enabled: true


###  Petr Michalec


  Configure Client/ServerAlive* options


  Configure keep alive settings:


>	        client:
>	          alive:
>	            interval: 600
>	            count: 3


>	            keep: yes
>	      #
>	      # will give you an timeout of 30 minutes (600 sec x 3)


###  Tomas Kamm


  fix for backward compatibility for old reclass model definition with new salt 2017xx (#9)


>	                fingerprint_hash_type: sha256|md5


# Formula openvpn


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Michael Kutý


  Added support for google-authenticator.


  Changed auth.type to auth.engine.


  OpenVPN server with custom auth


>	      openvpn:
>	        server:
  ...


>	          interface:
>	            topology: subnet
>	            network: 10.0.8.0
>	            netmask: 255.255.255.0
>	          auth:
>	            engine: pam/google-authenticator
>	          ssl:
>	            authority: Domain_Service_CA
>	            certificate: server.domain.com


  OpenVPN client auth


>	        client:
>	          enabled: true
>	          tunnel:
>	            tunnel01:
>	              auth:
>	                engine: pam/google-authenticator
>	              ssl:
>	                engine: salt
>	                authority: Domain_Service_CA
>	                certificate: client.domain.com


###  Roald Nefs


  Updated link to Ubuntu guide in README.rst


  Updated link to Ubuntu guide in README.rst to the latest LTS version.
  * https://help.ubuntu.com/lts/serverguide/openvpn.html


# Formula openvstorage


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula owncloud


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula packer


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula panko


# Formula pgbouncer


# Formula php


###  Aleš Komárek


  docfix


  PHP Formula


  PHP is a widely-used general-purpose scripting language that is especially
  suited for Web development and can be embedded into HTML.


  Sample Pillars


>	      php:
>	        environment:
>	          enabled: true
>	          cache:
>	            engine: 'apc'
>	            shm_size: 128
>	            max_file_size: '10M'


  More Information


  * http://www.php.net/manual/en/


# Formula postfix


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula postgresql


###  Adam Tengler


  Support for PostgreSQL cluster deployment added


>	                enabled: true
>	                pkgs:
>	                - postgresql-9.1-postgis-2.1


  Cluster


  Basic streaming replication.


  Master node


>	    postgresql:
>	      server:
>	        enabled: true
>	        version: 9.6
>	        bind:
>	          address: 0.0.0.0
>	        database:
>	          mydb: ...
>	      cluster:
>	        role: master
>	        mode: hot_standby
>	        members:
>	        - host: "172.16.10.101"
>	        - host: "172.16.10.102"
>	        - host: "172.16.10.103"
>	        replication_user:
>	          name: repuser
>	          password: password
>	    keepalived:
>	        enabled: True
>	        instance:
>	          VIP:
>	            notify_action:
>	              master:
>	                - 'if [ -f /root/postgresql/flags/failover ]; then touch /var/lib/postgresql/${postgresql:server:version}/main/trigger; fi'
>	              backup:
>	                - 'if [ -f /root/postgresql/flags/failover ]; then service postgresql stop; fi'
>	              fault:


  Slave node


>	        role: slave
>	        master:
>	          host: "172.16.10.100"
>	          port: 5432
>	          user: repuser


  Multi-master cluster with 2ndQuadrant bi-directional replication plugin


>	        version: 9.4
>	          mydb:
>	            extension:
>	              bdr:
>	              btree_gist:
  ...


>	        mode: bdr
>	        local: "172.16.10.101"


>	        local: "172.16.10.102"
>	        master: "172.16.10.101"


  Sample usage


  Read more


###  Ales Komarek


  Fixed readme, allow conditional database names


  PostgreSQL Formula


  PostgreSQL, often simply Postgres, is an object-relational database management
  system available for many platforms including Linux, FreeBSD, Solaris,


  Microsoft Windows and Mac OS X. It is released under the PostgreSQL License,
  which is an MIT-style license, and is thus free and open source software.


  PostgreSQL is developed by the PostgreSQL Global Development Group, consisting
  of a handful of volunteers employed and supervised by companies such as Red


  Hat and EnterpriseDB.


  Single deployment


  Single database server with initial data


>	            users:
>	            - name: 'username'


  Database extensions


  Master-slave cluster


>	      postgresql:
>	        server:
>	          enabled: true
>	          version: 9.6
>	          bind:
>	            address: 0.0.0.0
>	          database:
>	            mydb: ...
>	        cluster:
>	          role: master
>	          mode: hot_standby
>	          members:
>	          - host: "172.16.10.101"
>	          - host: "172.16.10.102"
>	          - host: "172.16.10.103"
>	          replication_user:
>	            name: repuser
>	            password: password
>	      keepalived:
>	          enabled: True
>	          instance:
>	            VIP:
>	              notify_action:
>	                master:
>	                  - 'if [ -f /root/postgresql/flags/failover ]; then touch /var/lib/postgresql/${postgresql:server:version}/main/trigger; fi'
>	                backup:
>	                  - 'if [ -f /root/postgresql/flags/failover ]; then service postgresql stop; fi'
>	                fault:


  Slave nodes


>	          role: slave
>	          master:
>	            host: "172.16.10.100"
>	            port: 5432
>	            user: repuser


  Multi-master cluster


>	          version: 9.4
>	            mydb:
>	              extension:
>	                bdr:
>	                  enabled: true
>	                btree_gist:
>	          mode: bdr
>	          local: "172.16.10.101"
>	          local: "172.16.10.102"
>	          master: "172.16.10.101"


  More information


###  Filip Pytloun


  Fix database pillar in readme and make db users optional


>	    Closes: #10
>	            databasename:
>	              encoding: 'UTF8'
>	              locale: 'cs_CZ'
>	              users:
>	                - name: 'username'
>	                  password: 'password'
>	                  host: 'localhost'
>	                  rights: 'all privileges'
>	              initial_data:
>	                engine: backupninja
>	                source: backup.host
>	                host: original-host-name
>	                database: original-database-name
>	              - name: 'username'
>	                password: 'password'
>	                host: 'localhost'
>	                rights: 'all privileges'
>	                  createdb: true
>	                postgis_topology:
>	                fuzzystrmatch:
>	                postgis_tiger_geocoder:
>	                postgis:
>	                  pkgs:
>	                  - postgresql-9.1-postgis-2.1


  Add client role


  Client


>	        client:
>	          server:
>	            server01:
>	              admin:
>	                host: database.host
>	                port: 5432
>	                user: root
>	                password: password
>	              database:
>	                mydb:
>	                  encoding: 'UTF8'
>	                  locale: 'en_US'
>	                  users:
>	                  - name: test
>	                    password: test
>	                    host: localhost
>	                    createdb: true
>	                    rights: all privileges


  Unify Makefile, .gitignore and update readme
  * https://gist.github.com/ibussieres/11262268 - upgrade instructions for ubuntu


###  Volodymyr Stoiko


  Add support for simple queries


>	                  init:
>	                    maintenance_db: mydb
>	                    queries:
>	                    - INSERT INTO login VALUES (11, 1) ;
>	                    - INSERT INTO device VALUES (1, 11, 42);


# Formula powerdns


###  Ivan Suzdal


  Add api/api_key parameters


  Also add axfr_ips,version_string and webserver*
  as configurable parameters.


  Related PROD: 11411


>	        axfr_ips:
>	          - 10.11.0.0/16
>	          - 127.0.0.1
>	        api:
>	          enabled: true
>	          key: SecurePass
>	        webserver:
>	          password: SuperSecurePass
>	          address: 0.0.0.0
>	          port: 8081


  Huge changes in powerdns


  This split simplifies process of adding new types of backends.


  To add new backend type we just need describe required steps in
  particular state file, add backend config and specify the engine
  in powerdns:server:backend pillar.


>	    powedns:
>	      server:
>	        enabled: true
>	        backend:
>	          engine: mysql
>	          host: localhost
>	          port: 3306
>	          name: pdns
>	          user: pdns
>	          password: password
>	        bind:
>	          port: 53


  PowerDNS server with sqlite backend


>	    powerdns:
>	          engine: sqlite
>	          dbname: pdns.sqlite
>	          dbpath: /var/lib/powerdns
>	          address: 127.0.0.1
>	          port: 55
>	        default-soa-name: ns1.domain.tld
>	        soa-minimum-ttl: 3600


# Formula pritunl


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula prometheus


###  Bartosz Kupidura


  Add ssl options for etcd


>	            cert_name: prometheus-server.crt
>	            key_name: prometheus-server.key
>	            scheme: https
>	            ssl_dir: /opt/prometheus/config
>	            member:
>	              - host: ${_param:cluster_node01_address}
>	                port: ${_param:cluster_node01_port}
>	              - host: ${_param:cluster_node02_address}
>	                port: ${_param:cluster_node02_port}
>	              - host: ${_param:cluster_node03_address}
>	                port: ${_param:cluster_node03_port}


  Get dns autodiscovery from reclass


>	          dns:
>	            - name: 'pushgateway'
>	              domain:
>	              - 'tasks.prometheus_pushgateway'
>	              type: A
>	              port: 9091
>	            - name: 'prometheus'
>	              - 'tasks.prometheus_server'
>	              port: 9090
>	            api_ip: ${_param:kubernetes_control_address}
>	          etcd:
>	            - host: ${_param:cluster_node01_address}
>	              port: ${_param:cluster_node01_port}
>	            - host: ${_param:cluster_node02_address}
>	              port: ${_param:cluster_node02_port}
>	            - host: ${_param:cluster_node03_address}
>	              port: ${_param:cluster_node03_port}


  Better grain handling for telegraf


  Replace '-' to '_' in prometheus config dir


  Add possibility to add recording rules


>	          config: /srv/volumes/prometheus
>	        recording:
>	          - name: 'instance:fd_utilization'
>	            query: >-
  process_open_fds / process_max_fds


  Add prometheus, alertmanager, pushgateway configs


  Sample pillars


  Configure prometheus server


>	    prometheus:
>	      server:
>	        enabled: true
>	        dir:
>	          config: /srv/volumes/prometheus-config
>	          config_in_container: /opt/prometheus/config
>	        bind:
>	          port: 9090
>	          address: 0.0.0.0
>	        external_port: 15010
>	        target:
>	          kubernetes:
>	            api_ip: 127.0.0.1
>	            cert_name: kubelet-client.crt
>	            key_name: kubelet-client.key
>	          etcd: ${etcd:server:members}
>	        alert:
>	          PrometheusTargetDown:
>	            if: 'up != 1'
>	            labels:
>	              severity: down
>	            annotations:
>	              summary: 'Prometheus target down'
>	        storage:
>	          local:
>	            engine: "persisted"
>	            retention: "360h"
>	            memory_chunks: 1048576
>	            max_chunks_to_persist: 524288
>	            num_fingerprint_mutexes: 4096
>	        alertmanager:
>	          notification_queue_capacity: 10000
>	        config:
>	          global:
>	            scrape_interval: "15s"
>	            scrape_timeout: "15s"
>	            evaluation_interval: "1m"
>	            external_labels:
>	              region: 'region1'


  Configure alertmanager


>	      alertmanager:
>	          port: 9093
>	        external_port: 15011
>	            resolve_timeout: 5m
>	          route:
>	            group_by: ['alertname', 'region', 'service']
>	            group_wait: 60s
>	            group_interval: 5m
>	            repeat_interval: 3h
>	            receiver: HTTP-notification
>	          inhibit_rules:
>	            - source_match:
>	                severity: 'down'
>	              target_match:
>	                severity: 'critical'
>	              equal: ['region', 'service']
>	                severity: 'warning'
>	              equal: ['alertname', 'region', 'service']
>	          receivers:
>	            - name: 'HTTP-notification'
>	              webhook_configs:
>	                - url: http://127.0.0.1
>	                  send_resolved: true


  Configure pushgateway


>	      pushgateway:
>	        external_port: 15012


###  Filip Pytloun


  Initial commit


  Salt Prometheus formula


  Power your metrics and alerting with a leading open-source monitoring
  solution.


###  Konstantin Hontar


  Add Slack and mail receiver to AlertManager config


>	            - name: 'HTTP-slack'
>	              slack_configs:
>	                - api_url: http://127.0.0.1/slack
>	            - name: 'smtp'
>	              email_configs:
>	                - to: test@example.com
>	                  from: test@example.com
>	                  smarthost: example.com
>	                  auth_username: username
>	                  auth_password: password


###  Martin Polreich


  Added Kitchen tests and Travis


>	            enabled: true
>	            endpoint:
>	              - name: 'pushgateway'
>	                domain:
>	                - 'tasks.prometheus_pushgateway'
>	                type: A
>	                port: 9091
>	              - name: 'prometheus'
>	                - 'tasks.prometheus_server'
>	                port: 9090
>	              scheme: https
>	              ssl_dir: /opt/prometheus/config
>	              cert_name: prometheus-server.crt
>	              key_name: prometheus-server.key
>	              member:
>	                - host: ${_param:cluster_node01_address}
>	                  port: ${_param:cluster_node01_port}
>	                - host: ${_param:cluster_node02_address}
>	                  port: ${_param:cluster_node02_port}
>	                - host: ${_param:cluster_node03_address}
>	                  port: ${_param:cluster_node03_port}
>	          instance:fd_utilization:


###  Ondrej Smola


  iadded posibility to define two endpoint in one receiver + test pillars + update Readme


  This option is usefull when all alarms should be send to two or more receivers simultaneously - without need to use continue parameter


>	            group_by: ['region', 'service']
>	            receiver: default
>	          inhibit_rule:
>	            InhibitCriticalWhenDown:
>	              enabled: true
>	              source_match:
>	            InhibitWarningWhenDown:
>	            InhibitWarningWhenCritical:
>	          receiver:
>	            HTTP-notification:
>	                localhost:
>	                  url: http://127.0.0.1
>	            HTTP-slack:
>	                slack:
>	                  api_url: http://127.0.0.1/slack
>	            smtp:
>	                email:
>	                  to: test@example.com
>	            #Two endpoints in one receiver
>	            Multi-receiver:
>	                webhook:


# Formula pypiserver


# Formula python


###  Ales Komarek


  Fixed readme


  Python formula
  service.environment.environment:


  Basic Python environment
  service.environment.development:


  Python development environment
  python.environment.django:


  Python Django environment


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Richard Felkl


  changed local mirror url handling


>	    Related: PROD-15581
>	                protocol: http
>	                host: pypi.local


  fixed bug with empty user list


>	            root:


  added support for local pypi mirrors


  Using offline mirrors


>	      python:
>	        environment:
>	          enabled: true
>	          user:
>	          - root:
>	              name: root
>	              pypi_user: user
>	              pypi_password: password
>	              pypi_mirror:
>	                host: http://pypi.local
>	                port: 8084
>	                upstream_fallback: true
>	                user: user
>	                password: password


# Formula rabbitmq


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Kirill Bespalov


  Allow to use two ways of certs/keys files management:
  1) via specifing a path of a file:
  2) via specifing a path and content of a file:


  The files management via authority must be removed as an unused.


  To enable support of TLS for rabbitmq-server you need to provide a path to cacert, server cert and private key :


>	            key_file: /etc/rabbitmq/ssl/key.pem
>	            cert_file: /etc/rabbitmq/ssl/cert.pem
>	            ca_file: /etc/rabbitmq/ssl/ca.pem


  To manage content of these files you can either use the following options:


>	     rabbitmq:
>	        server:
>	          enabled: true
  ...


>	          ssl:
>	            enabled: True
>	            cacert_chain: |


  Or you can use the `salt.minion.cert` salt state which
  creates all required files according to defined reclass model [1]. In this case you need just to enable ssl and nothing more:


  1. https://github.com/Mirantis/reclass-system-salt-model/tree/master/salt/minion/cert/rabbitmq


  TLS support for RabbitMQ


>	              pattern: '^(?!amq\.).*'


  Enable TLS support


  The certs and private key passing:


>	            key: |


>	            cert: |


  Also you can pass them via specifing a name of ca authority at salt master:


>	            authority: CA_Authority_Name


  In this case keys and certs will be pulled from:


  `salt://pki/{{ authority }}/certs/{ rabbitmq.{cert|key} | ca.cert }`


>	  --


  Defaut port for TLS is **5671**:


>	    rabbitmq:
>	      server:
>	        bind:
>	           port: 5671


  [{nodes,[{disc,['rabbit@ctl-1','rabbit@ctl-2','rabbit@ctl-3']}]},


###  Nick Metz


  Fix for #42, samples for host/policy configuration wrong


>	          host:
  '/monitor':


>	              enabled: true
>	              user: 'monitor'
>	              password: 'password'


>	              policies:
>	              - name: HA
>	                pattern: '^(?!amq\.).*'
>	                definition: '{"ha-mode": "all"}'


# Formula rally


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme
  * https://trello.com/b/DoD8aeZy/rally


###  Jiri Broulik


  parametrize endpoints


>	                endpoint_type: internal


# Formula reclass


###  Ales Komarek


  Interpolation in node cycling generation


  Reclass model with multiple node defined and interpolation enabled


>	     :language: yaml


  Node classification/declassification - reactors and orchestration pipelines


  Classify node after creation and unclassify on node deletion


>	      salt:
>	        master:
>	          reactor:
  reclass/minion/classify:


>	            - salt://reclass/reactor/node_register.sls
  reclass/minion/declassify:


>	            - salt://reclass/reactor/node_unregister.sls


  Event to trigger the node classification


  salt-call event.send 'reclass/minion/classify' "{'node_master_ip': '$config_host', 'node_ip': '${node_ip}', 'node_domain': '$node_domain', 'node_cluster': '$node_cluster', 'node_hostname': '$node_hostname', 'node_os': '$node_os'}"


  You can send any parameters in the event payload, all will be checked
  against dynamic node classification conditions.


  Both actions will use the minion ID as the node_name to be updated.


  Event to trigger the node declassification


  salt-call event.send 'reclass/minion/declassify'


  Documentation fixes


  Reclass storage with archive data source


  Reclass storage with archive data source with content hash check


  Sample class mapping for dynamic classification


  Reclass Formula


  Sample Metadata


  Reclass storage with simple class mappings


  Reclass models with dynamic node classification


  More Information


  doc fix
  reclass is an “external node classifier” (ENC) as can be used with automation
  tools, such as Puppet, Salt, and Ansible. It is also a stand-alone tool for
  merging data sources recursively.


###  Aleš Komárek


  Update README.rst
  reclass formula


  External links


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula redis


###  Adam Tengler


  Readme updated


  Redis cluster master


>	      redis:
>	        cluster:
>	          enabled: True
>	          master:
>	            host: 192.168.1.100
>	            port: 6379
>	          mode: sentinel
>	          quorum: 2
>	          role: master
>	      supervisor:
>	        server:
>	          service:
>	            redis_sentinel:
>	              name: sentinel
>	              type: redis


  Redis cluster slave


>	          role: slave


###  Ales Komarek


  Docfix


  Redis formula


  key value storage


  Sample pillars


  Redis localhost server


>	      redis:
>	        server:
>	          enabled: true
>	          bind:
>	            address: 127.0.0.1 
>	            port: 6379
>	            protocol: tcp


  Redis world open


>	            address: 0.0.0.0 


  Redis modes


>	          appendfsync: no | everysec | always


  Redis cluster master


>	        cluster:
>	          enabled: True
>	          master:
>	            host: 192.168.1.100
>	          mode: sentinel
>	          quorum: 2
>	          role: master
>	      supervisor:
>	          service:
>	            redis_sentinel:
>	              name: sentinel
>	              type: redis


  Redis cluster slave


>	          role: slave


  Command usage


  Removes data from your connection's CURRENT database.


>	     redis-cli FLUSHDB


  Removes data from ALL databases.


>	     redis-cli FLUSHALL


  More information


  * http://redis.io/topics/admin
  * http://redis.io/topics/quickstart
  * http://redis.io/topics/persistence


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula redmine


###  Aleš Komárek


  renamed file


  Redmine Formula


  Redmine is a flexible project management web application. Written using the Ruby on Rails framework, it is cross-platform and cross-database.


  Sample pillars


>	      redmine:
>	        server:
>	          enabled: true
>	          version: '2.3'
>	          apps:
>	          - name: majklk
>	            database:
>	              engine: postgresql
>	              host: 127.0.0.1
>	              name: db_name
>	              password: pass
>	              user: user_name
>	            mail:
>	              host: host-mail
>	              user: email
>	              domain: domain


  More Information


  * http://www.redmine.org/
  * http://www.redmine.org/projects/redmine/wiki/RedmineInstall


# Formula robophery


###  Ales Komarek


  Something to test


  RoboPhery service with MQTT backend


>	        server:
>	          module_default:
>	            input_backends:
>	            - messages
>	            output_backends:
>	          backend:


  RoboPhery service with StatsD backend


>	      robophery:
>	          enabled: true
>	            - metrics


  RoboPhery service with filesystem backend


>	            - files
>	              engine: filesystem


  GPIO relay module


>	          gpio_enabled: True


  I2C HTU21 module


>	          module:
>	              read_interval: 2000


  BLE Parrot Flower Power module


>	          ble_enabled: True
>	            livingroom01-flower:
>	              engine: ble.flower_power
>	              addr: 00:11:22:33:44:55:66


  Ininial commit


  RoboPhery formula


  Python library for interfacing low level hardware sensors and actuators with MQTT bindings.


  Sample pillars


  Single robophery service


>	        service:
>	          platform: rpi/bbb/micro
>	          debug: False
>	          output_interval: 60
>	          output_backends:
>	          - messages
>	          - metrics
>	          - files
>	          output:
>	            messages:
>	              engine: mqtt
>	              host: 127.0.0.1
>	              port: 1100
>	            metrics:
>	              engine: statsd
>	            files:
>	              path: /log
>	            light01:
>	              engine: gpio.relay
>	              port: 22
>	            livingroom01-env:
>	              engine: i2c.htu21
>	              bus: 1
>	              read_interval: 1


# Formula roundcube


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula rsync


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Petr Michalec


  allow spec. timeout


>	          timeout: 300


# Formula rsyslog


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Swann Croiset


  Add syslog template per output file


  Custom templates


  It is possible to define a specific syslog template per output file instead of
  using the default one.


>	      rsyslog:
>	          output:
>	            file:
  /var/log/your-app.log:


>	                template: ""%syslogtag:1:32%%msg:::sp-if-no-1st-sp%%msg%\\n""
>	                filter: "if $programname startswith 'your-app' then"


  Add option to skip the log_collector configuration


  Support metadata


  If the *heka* support metadata is enabled, all output files are automatically
  parsed by the **log_collector** service.


  To skip the log_collector configuration, set the **skip_log_collector** to true.


>	                skip_log_collector: true


  Add stop processing option


  This allows to use dedicated log files for some services. This is
  especially useful when journald is around and forward logs to syslog.


>	             -/var/log/your-app.log:
>	                owner: syslog
>	                group: adm
>	                createmode: 0640
>	                umask: 0022
>	                stop_processing: true


###  teoyaomiqui


  Adding rsyslog remote server functionality (#6)


  Remote rsyslog server


  It is possible to have rsyslog act as remote server, collecting, storing or forwarding logs.


  This functionality is provided via rsyslog input/output modules, rulesets and templates.


>	        server:
>	          enabled: true
>	          module:
>	            imudp: {}
>	          template:
>	            RemoteFilePath:
>	              parameter:
>	                type: string
>	                string: /var/log/%HOSTNAME%/%programname%.log
>	          ruleset:
>	            remote10514:
>	              description: action(type="omfile" dynaFile="RemoteFilePath")
>	          input:
>	            imudp:
>	              port: 10514
>	              ruleset: remote10514


# Formula ruby


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula rundeck


###  Ilya Kharin


  Add ability to configure secret keys


  Configure Secret Keys
  ^^^^^^^^^^^^^^^^^^^^^


  It is possible to configure secret items in Key Storage in Rundeck:


>	       rundeck:
>	         client:
>	           enabled: true
>	           secret:
  openstack/username:


>	               type: password
>	               content: admin
  openstack/password:


>	               content: password
  openstack/keypair/private:


>	               type: private
>	               content: <private>
  openstack/keypair/public:


>	               type: public
>	               content: <public>


  It is possible to disable keys to be sure that they are not present in Rundeck:


>	      rundeck:


>	               enabled: false


  Add tests for the formula


  Sample pillars


  Configure Server
  ~~~~~~~~~~~~~~~~


  Rundeck is suppose to be configure for running in Docker Swarm and the server
  state prepares only configuration files, including binding parameters, system
  user, Rundeck users and API tokens:


>	        server:
>	          enabled: true
>	          user:
>	            uid: 550
>	            gid: 550
>	          api:
>	            host: 10.20.0.2
>	            port: 4440
>	            https: false
>	          ssh:
>	            user: runbook
>	            private_key: <private>
>	            public_key: <public>


>	          users:
>	            admin:
>	              name: admin
>	              password: password
>	              roles:
>	                - user
>	                - admin
>	                - architect
>	                - deploy
>	                - build
>	            john:
>	              name: John
>	              password: johnspassword
>	            kate:
>	              name: Kate
>	              password: katespassword


>	          tokens:
>	            admin: EcK8zhQw


  To configure Rundeck to use PostgreSQL instead of H2:


>	          datasource:
>	            engine: postgresql
>	            port: 5432
>	            username: ${_param:rundeck_postgresql_username}
>	            password: ${_param:rundeck_postgresql_password}
>	            database: ${_param:rundeck_postgresql_database}


  Configure Client


  Configure Projects
  ^^^^^^^^^^^^^^^^^^


  Projects can be configured with a set of nodes which are available to run jobs
  within them. Rundeck uses `rundeck:server:ssh` credentials to access nodes.


  Jobs can be configured from a separate GIT repository using the SCM Import
  plugin.


>	        client:
>	          project:
>	            project0:
>	              description: project
>	              node:
>	                node01:
>	                  nodename: node01
>	                  hostname: node01.cluster.local
>	                  username: runbook
>	                  tags: [ubuntu, docker]
>	                node02:
>	                  nodename: node02
>	                  hostname: node02.cluster.local
>	                  tags: [centos, docker]
>	              plugin:
>	                import:
>	                  address: http://gerrit.cluster.local/jobs/rundeck-jobs.git
>	                  branch: master


# Formula sahara


###  Aleš Komárek


  Update README.rst


  Sahara formula


  Sahara fomula


  The Sahara project provides a simple means to provision a data-intensive application cluster (Hadoop or Spark) on top of OpenStack.


  Sample pillars


  External links


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula salt


###  Adam Tengler


  Salt reactor features refactoring
  salt-call event.send 'salt/key/create' \
>	     "{'node_id': 'id-of-minion', 'node_host': '172.16.10.100', 'orch_post_create': 'kubernetes.orchestrate.compute_install', 'post_create_pillar': {'node_name': 'id-of-minion'}}"


###  Ales Komarek


  Add support for salt master engines


  Salt engine definition for saltgraph metadata collector


>	      salt:
>	        master:
>	          engine:
>	            graph_metadata:
>	              engine: saltgraph
>	              host: 127.0.0.1
>	              port: 5432
>	              user: salt
>	              password: salt
>	              database: salt


  Salt engine definition for sending events from docker events


>	            docker_events:
>	              docker_url: unix://var/run/docker.sock


  Added support for sync modules and pillar after minion start


  Synchronise modules and pillars on minion start.


>	          reactor:
  'salt/minion/*/start':


>	            - salt://salt/reactor/minion_start.sls


  Minion key create/delete - reactors and orchestration pipelines


  Run any defined orchestration pipeline


  Add and/or remove the minion key
  salt/key/create:


>	            - salt://salt/reactor/key_create.sls
  salt/key/remove:


>	            - salt://salt/reactor/key_remove.sls


  Event to trigger the key creation
  salt-call event.send 'salt/key/create' "{'node_name': 'id-of-minion', 'orch_post_create': 'kubernetes/orchestrate/compute_install.sls'}"


  You can add pass additional `orch_pre_create`, `orch_post_create`,
  `orch_pre_remove` or `orch_post_remove` parameters to the event to call
  extra orchestrate files. This can be useful for example for
  registering/unregistering nodes from the monitoring alarms or dashboards.


  The key creation event needs to be run from other machine than the one
  being registered.


  Event to trigger the key removal


  salt-call event.send 'salt/key/remove'


  Orchestrates and reactors


  Salt synchronise node pillar and modules after start


>	            - salt://salt/reactor/node_start.sls


  Trigger basic node install


  salt/minion/install:


>	            - salt://salt/reactor/node_install.sls


  Sample event to trigger the node installation


  salt-call event.send 'salt/minion/install'


  Run any orchestration pipeline


  Event to trigger the orchestration pipeline
  salt-call event.send 'salt/orchestrate/start' "{'orchestrate': 'salt/orchestrate/infra_install.sls'}"


  Classify node after start


  Event to trigger the node classification


  Salt orchestrate pipeline stars based on reactor triggers


  Salt Reactor system sample


  Run any orchestration pipeline from custom event


  salt/orchestrate/start:


>	            - salt://salt/reactor/orchestrate_start.sls


  Sample event to trigger the basic orchestration pipeline


  salt-call event.send 'salt/orchestrate/start' "{'orchestrate': 'salt/orchestrate/infra_install.sls'}


  Classify node from custom event


  reclass/minion/classify:


>	            - salt://reclass/reactor/node_register.sls


  Sample event to trigger the classification


  salt-call event.send 'reclass/minion/classify' "{'node_master_ip': '$config_host', 'node_ip': '${node_ip}', 'node_domain': '$node_domain', 'node_cluster': '$node_cluster', 'node_hostname': '$node_hostname', 'node_os': '$node_os'}"


  Reactor system, documentation fixes


  Salt Formula


  Salt is a new approach to infrastructure management. Easy enough to get
  running in minutes, scalable enough to manage tens of thousands of servers,
  and fast enough to communicate with them in seconds.


  Salt delivers a dynamic communication bus for infrastructures that can be used
  for orchestration, remote execution, configuration management and much more.


  Sample Metadata


  Salt master with base formulas and pillar metadata backend


  Salt master with reclass ENC metadata backend


  Salt master with pip based installation (optional)


  Install formula through system package management


  Salt master with logging handlers


  Salt master peer setup for remote certificate signing


  Salt Reactor system configuration


  salt/minion/*/start:


>	            - salt://reactor/minion-started.sls


  Salt syndic


  The master of masters


>	          enabled: true
>	          order_masters: True


  Lower syndicated master


>	        syndic:
>	          master:
>	            host: master-of-master-host
>	          timeout: 5


  Syndicated master with multiple master of masters


>	          masters:
>	          - host: master-of-master-host1
>	          - host: master-of-master-host2


  Salt-minion proxy


  Salt minion behind HTTP proxy


  Salt minion with PKI certificate authority (CA)


  Salt minion using PKI certificate


  More Information


  Support of multi-master-of-masters


  Salt syndic: Lower master with multi-master of masters


  Cleaned up salt-syndic features


  Salt syndic: Master of masters


  Salt syndic: Lower master


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Jiri Broulik


  proxy_minion fix


>	          proxy_minion:


  salt-proxy


  Salt proxy


  Salt proxy pillar


>	        minion:
>	          proxy:
>	            master: localhost
>	            device:
  vsrx01.mydomain.local:


>	                enabled: true
>	                engine: napalm
  csr1000v.mydomain.local:


  Proxy pillar for IOS device


>	      proxy:
>	        proxytype: napalm
>	        driver: ios
>	        host: csr1000v.mydomain.local
>	        username: root
>	        passwd: r00tme


  Proxy pillar for JunOS device


>	        driver: junos
>	        host: vsrx01.mydomain.local
>	        optional_args:
>	          config_format: set


###  Ondrej Smola


  added readme for salt minion http proxy


  Salt minion behind http proxy


>	            host: 127.0.0.1
>	            port: 3128


###  Petr Michalec


  allow-multiple-ext-pillars-and-reclass-options


  Salt master with multiple ext_pillars


>	     :language: yaml


  Encrypted pillars


>	  Note: NACL + below configuration will be available in Salt > 2017.7.


  External resources:


>	  - Tutorial to configure salt + reclass ext_pillar and nacl: http://apealive.net/post/2017-09-salt-nacl-ext-pillar/
>	  - Saltstack documentation: https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.nacl.html


  Configure salt NACL module:


>	    pip install --upgrade libnacl===1.5.2
>	    salt-call --local nacl.keygen /etc/salt/pki/master/nacl


>	      local:
  saved sk_file:/etc/salt/pki/master/nacl  pk_file: /etc/salt/pki/master/nacl.pub


>	          pillar:
>	            reclass: *reclass
>	            nacl:
>	              index: 99
>	          nacl:
>	            box_type: sealedbox
>	            sk_file: /etc/salt/pki/master/nacl
>	            pk_file: /etc/salt/pki/master/nacl.pub
>	            #sk: None
>	            #pk: None


  NACL encrypt secrets:


>	    salt-call --local nacl.enc 'my_secret_value' pk_file=/etc/salt/pki/master/nacl.pub
  hXTkJpC1hcKMS7yZVGESutWrkvzusXfETXkacSklIxYjfWDlMJmR37MlmthdIgjXpg4f2AlBKb8tc9Woma7q


>	    # or
  salt-run nacl.enc 'myotherpass'


  ADDFD0Rav6p6+63sojl7Htfrncp5rrDVyeE4BSPO7ipq8fZuLDIVAzQLf4PCbDqi+Fau5KD3/J/E+Pw=


  NACL encrypted values on pillar:


  Use Boxed syntax `NACL[CryptedValue=]` to encode value on pillar:


>	    my_pillar:
>	      my_nacl:
>	          key0: unencrypted_value
>	          key1: NACL[hXTkJpC1hcKMS7yZVGESutWrkvzusXfETXkacSklIxYjfWDlMJmR37MlmthdIgjXpg4f2AlBKb8tc9Woma7q]


  NACL large files:


  salt-call nacl.enc_file /tmp/cert.crt out=/srv/salt/env/dev/cert.nacl


>	    # or more advanced
  cert=$(cat /tmp/cert.crt)


>	    salt-call --out=newline_values_only nacl.enc_pub data="$cert" > /srv/salt/env/dev/cert.nacl


  NACL within template/native pillars:


>	    pillarexample:
>	        user: root
>	        password1: {{salt.nacl.dec('DRB7Q6/X5gGSRCTpZyxS6hlbWj0llUA+uaVyvou3vJ4=')|json}}
>	        cert_key: {{salt.nacl.dec_file('/srv/salt/env/dev/certs/example.com/cert.nacl')|json}}
>	        cert_key2: {{salt.nacl.dec_file('salt:///certs/example.com/cert2.nacl')|json}}


  Update readme trusted_ca_minions


  Salt minion trust CA certificates issued by salt CA on a specific host (ie: salt-master node)


>	    salt:
>	      minion:
>	        trusted_ca_minions:
>	          - cfg01


  version to be specified for salt formula


>	              keystone:
>	              nova:
>	                source: pkg
>	                name: salt-formula-keystone
>	                version: 0.1+0~20160818133412.24~1.gbp6e1ebb
>	              postresql:
>	                name: salt-formula-postgresql
>	                version: purged


  Formula keystone is installed latest version and the formulas without version are installed in one call to aptpkg module.


  If the version attribute is present sls iterates over formulas and take action to install specific version or remove it.


  The version attribute may have these values ``[latest|purged|removed|<VERSION>]``.


###  Sam Stoelinga


  Salt minion allow to specify HTTP backend


  This is useful when using proxies. The default Tornado backend does not
  utilize proxy environment variables and isn't able to set no_proxy variable.


  Salt minion to specify non-default HTTP backend. The default tornado backend
  does not respect HTTP proxy settings set as environment variables. This is
  useful for cases where you need to set no_proxy lists.


>	          backend: urllib2


###  Tomáš Kukrál


  set state_output to "changes"


  Terse output is not enough for debugging.


>	          state_output: changes


  configure state_output


  This option can configure default output of state calls. Terse (default
  option) will make each call to be on single line and make salt output
  better.


  Configure verbosity of state output (used for `salt` command)


>	          state_output: terse


# Formula selenium


###  Ales Komarek


  Revived the formula


  Selenium Formula


  Selenium automates browsers. That's it! What you do with that power is
  entirely up to you. Primarily, it is for automating web applications for
  testing purposes, but is certainly not limited to just that. Boring web-based
  administration tasks can (and should!) also be automated as well.


  Sample Metadata


  Selenium server grid hub


>	      selenium:
>	        hub:
>	          enabled: true


  Selenium server grid node with firefox and chrome


>	        node:
>	          hub:
>	            host: hub01.domain.com
>	          video:
>	            host: 127.0.0.1
>	            display: 99
>	          drivers:
>	          - firefox
>	          - chrome


  More Information


  * http://alex.nederlof.com/blog/2012/11/19/installing-selenium-with-jenkins-on-ubuntu/
  * http://www.seleniumhq.org/download/
  * https://sites.google.com/a/chromium.org/chromedriver/


# Formula sensu


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Guillaume Thouvenin


  Allow a client to unsubscribe to channel


  This patch allows a client to unsubscribe to a channel. It is used by
  example by collectd where we can have different checks. In StackLight we
  have a remote collectd that is running and also a collectd daemon. So
  there is two collectd processes. By default we subscribe to all channel
  according to our roles. But we don't want to subscribe to
  collectd.client, only to collectd.remote_client.


  Sensu Client with subscriptions explicitly disabled


>	      sensu:
>	        client:
>	          enabled: true
>	          message_queue:
>	            engine: rabbitmq
>	            host: rabbitmq
>	            port: 5672
>	            user: monitor
>	            password: pwd
>	            virtual_host: '/monitor'
>	          unsubscribe:
>	            - collectd.client
>	            - git.client


###  Pavel Cizinsky


  updated README for handlers


>	              sfdc_http_proxy: 'http://10.10.10.10:8888'
>	              token_cache_file: "/path/to/cache/token"


  Sensu Slack handler


>	        server:
>	          handler:
>	            default:
>	              enabled: true
>	              set:
>	              - slack
>	            stdout:
>	            slack:
>	              enabled: True
>	              channel: '#channel_name'
>	              webhook_url: 'https://hooks.slack.com/services/kastan12T/B57X3SDQA/fasfsaf0632hjkl3dsccLn9v'
>	              proxy_address: '10.10.10.10'
>	              proxy_port: '8888'


# Formula sentry


###  Ales Komarek


  docfixes


  Sentry is a realtime event logging and aggregation platform. At its core it
  specializes in monitoring errors and extracting all the information needed to
  do a proper post-mortem without any of the hassle of the standard user
  feedback loop.


  It’s important to note that Sentry should not be thought of as a log stream,
  but as an event aggregator. It fits somewhere in-between a simple metrics
  solution (such as Graphite) and a full-on log stream aggregator (like


  Logstash).


  Server behind proxy


  Sentry 8+ setup


  Sentry formula


  Sentry is a realtime event logging and aggregation platform. At its core it specializes in monitoring errors and extracting all the information needed to do a proper post-mortem without any of the hassle of the standard user feedback loop.


  It’s important to note that Sentry should not be thought of as a log stream, but as an event aggregator. It fits somewhere in-between a simple metrics solution (such as Graphite) and a full-on log stream aggregator (like Logstash).


  Sample pillars


  Standalone server


>	     :language: yaml


  Simple server with proxy


  More information


  * https://github.com/getsentry/sentry
  * https://docs.sentry.io/server/installation/


# Formula shibboleth


###  Alexander Noskov


  Code refactoring


  Shibboleth is among the world's most widely deployed federated identity solutions, connecting users to applications both within and between organizations.


  Sample pillars


>	    shibboleth:
>	      server:
>	        enabled: true
>	        keystone_protocol: http
>	        keystone_public_address: ${_param:proxy_vip_address_public}
>	        keystone_port: 5000
>	        idp_url: "https://saml.example.com/oam/fed"
>	        idp_metadata_url: "https://saml.example.com/oamfed/idp/metadata"
>	        attributes:
>	        - name: test
>	          id: test
>	          name_format: urn:oasis:names:tc:SAML:2.0:attrname-format:basic
>	        key: |


  MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDmM1NIxgQ3Y70Q


  GXoFQQnJ7nliaRtJR2xHAW47InyALQ+M3/VCtdFnNI0d2CHoytQ6mVg6BzOtdvT2
  ocEl0+LNkskSZsc6Nh59XooTQncL5PA7hXmo/nxCEgURH4oika5CC14K4hagwZca


  CQZvW1m9KwfVaNc0Va0KepH2lGI+VdxyZgRMifTMl9qDLYr++ftyFTNn5uit0Yh8
  9QFU4HLVvT0rHSQUTcFbvYE=


>	        certificate: |


  MIIDDzCCAfegAwIBAgIJAOvxYAMLVkHZMA0GCSqGSIb3DQEBBQUAMCMxITAfBgNV


  BAMTGGN0bC0wMS5qcGUyLmppb2Nsb3VkLmNvbTAeFw0xNzAxMTIxMDIwMTRaFw0y
  k3u0PIEqysz9sOpmuSmlY4FKRobYQ3viviTIMTTuqjoCAFKIApI3tZWOqj+zShje


  Xr4ue39/lvQLj2jXV+Q2TOovQA==


>	        idp_certificate: |


  CcnueWJpG0lHbEcBbjsifIAtD4zf9UK10Wc0jR3YIejK1DqZWDoHM6129PZ8kx5k
  aN5DvAdir7oYCpHwD5/WvHahUgsrtcz9s+pzRfiStvICVwqCsGquThZHe8YAgGpZ
  04UU/56ncPbsHf5asS3DvfVGw==


# Formula sphinx


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula spinnaker


# Formula squid


###  Ales Komarek


  Docfixes


  Squid Formula


  Sample Pillars


  Squid as proxy


>	      squid:
>	        proxy:
>	          enabled: true
>	          admin:
>	            user: manager
>	            password: passwd
>	          deny:
>	          - 192.168.2.30
>	          allow:
>	          - localnet


  More Information


  * https://raw.githubusercontent.com/saltstack-formulas/squid-formula
  * http://itkia.com/using-squid-to-cache-apt-updates-for-debian-and-ubuntu/
  * http://serverascode.com/2014/03/29/squid-cache-yum.html


# Formula stackstorm


# Formula statsd


###  Ales Komarek


  dofix and metadata fix


  Statsd formula


  More information


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula storm


# Formula suitecrm


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula superset


###  Michael Kutý


  Add cache to readme.


>	        cache:
>	          engine: redis
>	          host: ${_param:superset_cache_host}
>	          port: 6379
>	          number: 11


  Initial commit.


  superset


  Superset is a data exploration platform designed to be visual, intuitive and interactive.


  Sample pillars


  Single superset service


>	      superset:
>	        server:
>	          enabled: true
>	          backup: true
>	          debug: true
>	          auth:
>	            enabled: true
>	            user:
>	              test:
>	                username: test
>	                email: email@test.cz
>	                password: test
>	          bind:
>	            address: localhost
>	            protocol: tcp
>	            port: 8000
>	          worker: true
>	          secret_key: secret
>	          source:
>	            engine: pip
>	            version: 1.0.0       
>	          database:
>	            engine: postgres
>	            host: 127.0.0.1
>	            name: superset_prd
>	            password: password
>	            user: superset_prd
>	          broker:
>	            engine: redis
>	            port: 6379
>	            number: 10
>	          logging:
>	            engine: sentry
>	            dsn: dsn


>	      supervisor:
>	          service:
>	            superset:
>	              name: web
>	              type: superset
>	            superset_worker:
>	              name: worker


  Read more


  * https://github.com/airbnb/superset
  * http://airbnb.io/superset/index.html


# Formula supervisor


###  Aleš Komárek


  Update README.rst


  Supervisor Formula


  Sample Pillars


  More Information


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula swift


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula syncthing


# Formula taiga


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula telegraf


###  Bartosz Kupidura


  Move input definitions to support.yml


  Initial commit


  Salt Telegraf formula


  Power your metrics and alerting with a leading open-source monitoring
  solution.


  Sample pillars


>	    telegraf:
>	      agent:
>	        enabled: true
>	        interval: 15
>	        round_interval: false
>	        metric_batch_size: 1000
>	        metric_buffer_limit: 10000
>	        collection_jitter: 2
>	        output:
>	          prometheus_client:
>	            bind:
>	              address: 0.0.0.0
>	              port: 9126
>	            engine: prometheus
>	        input:
>	          diskio:
>	          processes:
>	          net:


###  Petr Michalec


  Add influxdb output


  Influx output


>	          influxdb:
>	            urls:
>	              - http://127.0.0.1:8086
>	            database: test-telegraf
>	            write_consistency: any
>	            timeout: 10s


# Formula tempest


###  Aleš Komárek


  docifx


  Tempest Formula


  This is a set of integration tests to be run against a live OpenStack cluster. Tempest has batteries of tests for OpenStack API validation, Scenarios, and other specific tests useful in validating an OpenStack deployment.


  Sample Pillars


>	      tempest:
>	        test:
>	          enabled: true
>	          source:
>	            engine: git
>	            address: git://github.com/openstack/tempest.git
>	            revision: master
>	          suite:
>	            identity:
>	              disable_ssl_certificate_validation: true
>	              auth_version: v3
>	              uri_v3:
>	              region: RegionOne 
>	            identity-feature-enabled:
>	              trust: true
>	              api_v2: false
>	              api_v3: true


  More Information


  * http://docs.openstack.org/developer/tempest/overview.html
  * http://www.slideshare.net/masayukiigawa/tempest-scenariotests-20140512?related=1
  * https://github.com/stackforge/puppet-tempest


# Formula tftpd-hpa


###  Ales Komarek


  Documentation fixes


  TFTPD HPA formula


  A TFTP server is mainly required for booting operating systems or
  configurations over the network.


  Sample pillars


  More information


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula tinyproxy


###  Dmitry Stremkouski


  Adding example variables


>	        listen: 172.16.21.101
>	        allow_nets:
>	        - 127.0.0.1
>	        - 172.16.21.0/24
>	        connect_ports:
>	        - 443
>	        upstream: 10.11.236.1:8080


  Populating formula from local repository


  TinyProxy Formula


  Sample Pillars


>	  TinyProxy: Basic configuration


>	      tinyproxy:
>	        enabled: true


  More Information


  * https://en.wikipedia.org/wiki/Tinyproxy


###  Filip Pytloun


  Productize formula


>	        server:
>	          enabled: true
>	          bind:
>	            address: 172.16.21.101
>	            port: 8888
>	          allow:
>	            - 127.0.0.1
>	            - 172.16.21.0/24
>	          deny:
>	            - 8.8.8.8
>	          connect_ports:
>	            - 443
>	          upstream: 10.11.236.1:8080


# Formula tvheadend


# Formula vagrant


###  Ales Komarek


  Allow version to control definition


>	                version: '2016.3'


  More information


  updated version


  Vagrant formula


  Vagrant provides easy to configure, reproducible, and portable work
  environments built on top of industry-standard technology and controlled by a
  single consistent workflow to help maximize the productivity and flexibility
  of you and your team.


  To achieve its magic, Vagrant stands on the shoulders of giants. Machines are
  provisioned on top of VirtualBox, VMware, AWS, or any other provider. Then,
  industry-standard provisioning tools such as shell scripts, Chef, or Puppet,
  can be used to automatically install and configure software on the machine.


>	                  status: suspended


  Sample usage


  Start and connect machine
  cd /srv/vagrant/<cluster_name>
  vagrant up <node_name>
  vagrant ssh <node_name>


  External links


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula varnish


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Martin Polreich


  Added tests script and sample pillars, Kitchen tests and Travis


  And Supervisor like this:: yaml


  Using nginx type:: yaml


# Formula virtualbox


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


# Formula wordpress


###  Ales Komarek


  Overhaul


  Wordpress formula


  Sample metadata


  Simple site


>	      wordpress:
>	        server:
>	          app:
>	            app_name:
>	              enabled: true
>	              version: '4.0'
>	              url: example.com
>	              title: TCPisekWeb
>	              admin_user: admin
>	              admin_password: password
>	              admin_email: nikicresl@gmail.com
>	              core_update: false
>	              theme_update: false
>	              plugin:
>	                bbpress:
>	                  engine: http
>	                  version: latest
>	                git_plugin:
>	                  engine: git
>	                  address: git@git.domain.com:git-repo
>	                  revision: master
>	              database:
>	                engine: mysql
>	                host: 127.0.0.1
>	                name: w_site
>	                password: password
>	                user: w_tcpisek
>	                prefix: tcpisek


  Read more


###  Aleš Komárek


  docfix


  Wordpress Formula


  WordPress is web software you can use to create a beautiful website or blog.


  More Information


  * http://codex.wordpress.org/Installing_WordPress
  * http://www.severalnines.com/blog/scaling-wordpress-and-mysql-multiple-servers-performance


# Formula xtrabackup


###  Jiri Broulik


  initial commit


  xtrabackup formula


  Xtrabackup allows you to backup and restore databases from full backups or full backups and its incrementals.


  Sample pillars


  Backup client with ssh/rsync remote host


>	      xtrabackup:
>	        client:
>	          enabled: true
>	          full_backups_to_keep: 3
>	          hours_before_full: 48
>	          hours_before_incr: 12
>	          database:
>	            user: username
>	            password: password
>	          target:
>	            host: cfg01


  More options to relocate local backups can be done using salt-formula-backupninja.


  Backup client with local backup only


  Backup client with ssh/rsync remote host with compression:


>	          compression: true
>	          compression_threads: 2


  Backup server rsync


>	        server:
>	          full_backups_to_keep: 5
>	          key:
>	            xtrabackup_pub_key:
>	              enabled: true
>	              key: key


  Client restore from local backups: 


>	          restore_full_latest: 1
>	          restore_from: local
>	          compressThreads: 2
>	          qpress:
>	            source: tar
>	            name: url


  Client restore from remote backups: 


>	          restore_from: remote


  More information


  * https://labs.riseup.net/code/projects/xtrabackup/wiki/Configuration
  * http://www.debian-administration.org/articles/351
  * http://duncanlock.net/blog/2013/08/27/comprehensive-linux-backups-with-etckeeper-xtrabackup/
  * https://github.com/riseuplabs/puppet-xtrabackup
  * http://www.ushills.co.uk/2008/02/backup-with-xtrabackup.html


###  Marcin Iwinski


  Spliting backup_dir in client runner.


  Required to support different backup_dir between client and server.


  Backup client with ssh/rsync to remote host with compression and non-default backup directory on server:


>	          enabled: false
>	          backup_dir: /srv/backup
  default location, same on both client and server side.


  Backup server rsync and non-default backup directory:


# Formula zookeeper


###  Filip Pytloun


  Unify Makefile, .gitignore and update readme


###  Jiri Broulik


  zookeeper backup


  Backup client with ssh/rsync remote host


>	      zookeeper:
>	        backup:
>	          client:
>	            enabled: true
>	            full_backups_to_keep: 3
>	            hours_before_full: 24
>	            target:
>	              host: cfg01


  More options to relocate local backups can be done using salt-formula-backupninja.


  Backup client with local backup only


  Backup server rsync


>	          server:
>	            full_backups_to_keep: 5
>	            key:
>	              zookeeper_pub_key:
>	                enabled: true
>	                key: ssh_rsa


  Client restore from local backup:


>	            restore_latest: 1
>	            restore_from: local


  Client restore from remote backup:


>	            restore_from: remote



