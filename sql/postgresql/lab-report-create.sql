-- $Id$

--
-- Create some privileges.
--
begin;
        select acs_privilege__create_privilege('lab_report_author');
        select acs_privilege__create_privilege('lab_report_write');
       	select acs_privilege__create_privilege('lab_report_read');
end;

--
-- Define hierarchy of privileges.
--
begin;
        select acs_privilege__add_child('lab_report_author','lab_report_read');
        select acs_privilege__add_child('lab_report_author','lab_report_write');
	select acs_privilege__add_child('read', 'lab_report_read');
	select acs_privilege__add_child('write', 'lab_report_write');
end;


--
-- Create tables
--
create table lr_author (
	author_id		integer
				constraint lr_author_author_id_fk
				references users (user_id)
				on delete cascade,
	package_id		integer
				constraint lr_author_package_id_fk
				references apm_packages (package_id)
				on delete cascade
);

create table lr_author_group (
	group_id		integer
				constraint lr_author_group_grou_id_fk
				references groups (group_id)
				constraint lr_author_group_pk
				primary key,
	package_id		integer
				constraint lr_author_group_package_id_fk
				references apm_packages (package_id)
				on delete cascade
);
