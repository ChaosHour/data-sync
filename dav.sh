#! /usr/bin/env zsh
#set -xv
################################################################################################################################################
# Created: 2021-03-31
# Updated: 2021-04-20
# @author:  Kurt Larsen
# Version: 1.0
# 
# Purpose: To show the contents of the vaulted variables in the percona role located in the vars/main.yml file.
#
#  Usage: ./dav.sh
# 
# Sample output:
# ./dav.sh 
# localhost | SUCCESS => {
#     "mysql_root_pass": "password"
# }
################################################################################################################################################

L1=(mysql_root_pass mysql_repl_pass chaos_pass proxysql_admin_pass sstuser_pass monuser_pass orchestrator_pass dba_util_pass)

for i in ${L1}
  do
    ansible 'localhost,' -m ansible.builtin.debug -a var=${i} -e "@vars/main.yml" --vault-id percona@password_file
    #ansible 'localhost,' -m ansible.builtin.debug -a var=${i} -e "@test2.yml" --vault-id percona@password_file
done

