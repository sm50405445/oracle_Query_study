create or replace synonym syn_channel for channels;

select count(*) from syn_channel;

alter user hr identified by HR Account UNLOCK;

create or replace public synonym syn_channel2 for channels;

grant select on syn_channel2 to public;

drop synonym syn_channel;

drop public synonym syn_channel2;