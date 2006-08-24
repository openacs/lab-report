-- $Id$

--
-- Drop hierarchy of privileges.
--
select acs_privilege__remove_child('lab_report_author','lab_report_read');
select acs_privilege__remove_child('lab_report_author','lab_report_write');
select acs_privilege__remove_child('read','lab_report_read');
select acs_privilege__remove_child('write','lab_report_write');

--
-- Drop privileges.
--
select acs_privilege__drop_privilege('lab_report_author');
select acs_privilege__drop_privilege('lab_report_write');
select acs_privilege__drop_privilege('lab_report_read');

--
-- Drop functions
--
drop function lr_report__new (
	integer,
	integer,
	integer,
	integer,
	timestamptz,
	integer,
	varchar,
	integer
);

drop function lr_section_content__new (
	integer,
	integer,
	integer,
	text,
	integer,
	integer,
	timestamptz,
	integer,
	varchar,
	integer
);

drop function lr_section_feedback__new (
	integer,
	integer,
	integer,
	integer,
	integer,
	varchar,
	integer,
	timestamptz,
	integer,
	varchar,
	integer
);

drop function lr_section_comment__new (
	integer,
	integer,
	integer,
	integer,
	text,
	integer,
	timestamptz,
	integer,
	varchar,
	integer
);


--
-- Drop tables
--
drop table lr_author;
drop table lr_author_group;
drop table lr_report;
drop table lr_section_content;
drop table lr_section_feedback;
drop table lr_section_comment;

delete from acs_objects where object_type='lr_report';
delete from acs_objects where object_type='lr_section_content';
delete from acs_objects where object_type='lr_section_feedback';
delete from acs_objects where object_type='lr_section_comment';

--
-- Drop object types.
--
select acs_object_type__drop_type ('lr_report', 'f');
select acs_object_type__drop_type ('lr_section_content', 'f');
select acs_object_type__drop_type ('lr_section_feedback', 'f');
select acs_object_type__drop_type ('lr_section_comment', 'f');


-- Drop service contract implementations.
\i lab-report-sc-drop.sql
