-- # Read write splitting
-- #INSERT INTO mysql_servers(hostgroup_id, hostname, port) VALUES (0,'192.168.50.2',3306);
-- #INSERT INTO mysql_servers(hostgroup_id, hostname, port) VALUES (1,'192.168.50.3',3306);
-- #INSERT INTO mysql_servers(hostgroup_id, hostname, port) VALUES (1,'192.168.50.4',3306);
-- #INSERT INTO mysql_users (username,password) VALUES ('chaos','letmein');
-- #INSERT INTO mysql_query_rules(active,match_pattern,destination_hostgroup,apply) VALUES(1,'^SELECT.*FOR UPDATE$',0,1);
-- #INSERT INTO mysql_query_rules(active,match_pattern,destination_hostgroup,apply) VALUES(1,'^SELECT',1,1);

-- #LOAD MYSQL SERVERS TO RUNTIME;
-- #LOAD MYSQL USERS TO RUNTIME;
-- #LOAD MYSQL QUERY RULES TO RUNTIME;

-- #SAVE MYSQL SERVERS TO DISK;
-- #SAVE MYSQL USERS TO DISK;
-- #SAVE MYSQL QUERY RULES TO DISK;



-- # Failover:-
-- INSERT INTO mysql_servers (hostgroup_id, hostname, port, max_replication_lag) VALUES (0, '192.168.50.2', 3306, 20);
-- INSERT INTO mysql_servers (hostgroup_id, hostname, port, max_replication_lag) VALUES (1, '192.168.50.3', 3306, 20);
-- INSERT INTO mysql_servers (hostgroup_id, hostname, port, max_replication_lag) VALUES (1, '192.168.50.4', 3306, 20);
-- INSERT INTO mysql_servers (hostgroup_id, hostname, port, max_replication_lag) VALUES (1, '192.168.50.2', 3306, 20);
-- INSERT INTO mysql_users (username,password) VALUES ('chaos','letmein');
-- #INSERT INTO mysql_users (username, password, active, default_hostgroup, max_connections) VALUES ('chaos', 'letemin', 1, 0, 2000);

-- INSERT INTO mysql_replication_hostgroups (writer_hostgroup, reader_hostgroup) VALUES (0, 1);
-- INSERT INTO mysql_query_rules (active, match_pattern, destination_hostgroup, cache_ttl, apply) VALUES (1, '^SELECT .* FOR UPDATE', 0, NULL, 1);
-- INSERT INTO mysql_query_rules (active, match_pattern, destination_hostgroup, cache_ttl, apply) VALUES (1, '^SELECT .*', 1, NULL, 1);


-- #UPDATE global_variables SET variable_value="monuser" WHERE variable_name="mysql-monitor_username";
-- #UPDATE global_variables SET variable_value="monpass" WHERE variable_name="mysql-monitor_password";
-- SET mysql-monitor_username='monuser';
-- SET mysql-monitor_password='monpass';
-- SET mysql-connect_timeout_server_max=20000;

-- LOAD MYSQL SERVERS TO RUNTIME;
-- LOAD MYSQL USERS TO RUNTIME;
-- LOAD MYSQL VARIABLES TO RUNTIME;
-- LOAD MYSQL QUERY RULES TO RUNTIME;

-- SAVE MYSQL SERVERS TO DISK;
-- SAVE MYSQL USERS TO DISK;
-- SAVE MYSQL VARIABLES TO DISK;
-- SAVE MYSQL QUERY RULES TO DISK;

-- # Failover:
INSERT INTO mysql_servers (hostgroup_id, hostname, port, max_replication_lag) VALUES (0, '10.8.0.152', 3306, 20);
INSERT INTO mysql_servers (hostgroup_id, hostname, port, max_replication_lag) VALUES (1, '10.8.0.153', 3306, 20);
INSERT INTO mysql_servers (hostgroup_id, hostname, port, max_replication_lag) VALUES (1, '10.8.0.154', 3306, 20);
INSERT INTO mysql_servers (hostgroup_id, hostname, port, max_replication_lag) VALUES (1, '10.8.0.152', 3306, 20);


INSERT INTO mysql_users (username, password, active, default_hostgroup, max_connections) VALUES ('chaos', 'letemin', 1, 0, 2000);
INSERT INTO mysql_replication_hostgroups (writer_hostgroup,reader_hostgroup,comment) VALUES (1,2,'cluster1');
-- INSERT INTO mysql_users (username,password) VALUES ('chaos','letmein');
INSERT INTO mysql_users(username,password,default_hostgroup) VALUES ('root','ou812',1);
INSERT INTO mysql_users(username,password,default_hostgroup) VALUES ('dba_util','Cheez9oo',1);
INSERT INTO mysql_replication_hostgroups (writer_hostgroup, reader_hostgroup) VALUES (0, 1);
INSERT INTO mysql_query_rules (active, match_pattern, destination_hostgroup, cache_ttl, apply) VALUES (1, '^SELECT .* FOR UPDATE', 0, NULL, 1);
INSERT INTO mysql_query_rules (active, match_pattern, destination_hostgroup, cache_ttl, apply) VALUES (1, '^SELECT .*', 1, NULL, 1);

UPDATE global_variables SET variable_value='monuser' WHERE variable_name='mysql-monitor_username';
UPDATE global_variables SET variable_value='monpass' WHERE variable_name='mysql-monitor_password';
UPDATE global_variables SET variable_value='2000' WHERE variable_name IN ('mysql-monitor_connect_interval','mysql-monitor_ping_interval','mysql-monitor_read_only_interval');

SET mysql-monitor_username='monuser';
SET mysql-monitor_password='monpass';
SET mysql-connect_timeout_server_max=20000;

LOAD MYSQL VARIABLES TO RUNTIME;
SAVE MYSQL VARIABLES TO DISK;

LOAD MYSQL SERVERS TO RUNTIME;
SAVE MYSQL SERVERS TO DISK;
SAVE MYSQL VARIABLES TO DISK;


LOAD MYSQL SERVERS TO RUNTIME;
LOAD MYSQL USERS TO RUNTIME;
LOAD MYSQL VARIABLES TO RUNTIME;
LOAD MYSQL QUERY RULES TO RUNTIME;

SAVE MYSQL SERVERS TO DISK;
SAVE MYSQL USERS TO DISK;
SAVE MYSQL VARIABLES TO DISK;
SAVE MYSQL QUERY RULES TO DISK;