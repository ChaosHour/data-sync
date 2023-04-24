#! /usr/bin/env zsh
#set -xv

################################################################################################################################################
# Created: 2021-03-31
# Updated: 2021-04-20
# @author:  Kurt Larsen
# Version: 1.0
#
#  Purpose: To encrypt the contents of the vaulted variables in the percona role located in the vars/main.yml file.
#
#  Usage: ./av.sh | grep -v 'Encryption'
# 
# Sample output:
# ./av.sh | grep -v 'Encryption'
# chaos_pass: !vault |
#          $ANSIBLE_VAULT;1.2;AES256;percona
#          30346566353763303535346562336564373165306536353164353137326230366430613534336539
#          6335616636396464653764646539373032333964616566610a393463343839366633643532623563
#          34373361363937343231613734636138313536656263346362643732383831323538613437323736
#          6339646132323565610a613636396463613762623834336530666130386139326438383134323036
#          6235
#
# Put this in the test.txt file: 
# L2=(ou812 slAv3 letmein admin s3cret monpass orc_pass Cheez9oo)
################################################################################################################################################
L1=(mysql_root_pass mysql_repl_pass chaos_pass proxysql_admin_pass sstuser_pass monuser_pass orchestrator_pass dba_util_pass)
source test.txt

declare -A TB=( ["${L1[1]}"]="${L2[1]}" ["${L1[2]}"]="${L2[2]}" ["${L1[3]}"]="${L2[3]}" ["${L1[4]}"]="${L2[4]}" ["${L1[5]}"]="${L2[5]}" ["${L1[6]}"]="${L2[6]}" ["${L1[7]}"]="${L2[7]}" ["${L1[8]}"]="${L2[8]}")

for key value in ${(kv)TB}
  do
    #printf "%s\n" ${value} ${key}
    ansible-vault encrypt_string --vault-id percona@password_file ${value} --name ${key}
  printf "%s\n\n"
done