declaration template metaconfig/tnsnames/schema;

include 'pan/types';

# Protocol address section
type address = {
    'protocol' : string = 'TCP' with match(SELF,'^(TCP|UDP)$')
    'host' : type_hostname
    'port' : long(0..) = 1521
} = nlist();

type address_list = {
    'load_balance' ? string with match(SELF,'^(ON|OFF|YES|NO|TRUE|FALSE)$')
    'failover' ? string with match(SELF,'^(ON|OFF|YES|NO|TRUE|FALSE)$')
    'addresses' : address[]
} = nlist();

# Connect data section
type failover_mode = {
    'backup' ? type_hostname
    'type' : string with match(SELF,'^(SESSION|SELECT|NONE)$')
    'method' ? string with match(SELF,'^(BASIC|PRECONNECT)$')
} = nlist();

type connect_datum = {
    'service_name' : string
    'server' ? string with match(SELF,'^(DEDICATED|SHARED|POOLED)$')
    'failover_settings' ? failover_mode[1]
} = nlist();

# Tnsnames.ora section
type tnsnames_service = {
    'net_service_name' : string
    'address_lists' : address_list[]
    'connect_data' : connect_datum[1]
};
