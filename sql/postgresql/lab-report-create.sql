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
-- Define object types.
--
select  acs_object_type__create_type (
    'lr_report',
    '#lab-report.report#',
    '#lab-report.reports#',
    'acs_object',
    'lr_report',
    'report_id',
    null,
    'f',
    null,
    null
);

select  acs_object_type__create_type (
    'lr_section_content',
    '#lab-report.section_content#',
    '#lab-report.section_content#',
    'acs_object',
    'lr_section_content',
    'content_id',
    null,
    'f',
    null,
    null
);


select  acs_object_type__create_type (
    'lr_section_feedback',
    '#lab-report.section_feedback#',
    '#lab-report.section_feedback#',
    'acs_object',
    'lr_section_feedback',
    'feedback_id',
    null,
    'f',
    null,
    null
);

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
				constraint lr_author_group_group_id_fk
				references groups (group_id)
				constraint lr_author_group_pk
				primary key,
	package_id		integer
				constraint lr_author_group_package_id_fk
				references apm_packages (package_id)
				on delete cascade
);

create table lr_report (
	report_id		integer
				constraint lr_report_pk
				primary key,
	template_id		integer
				constraint lr_report_template_id_fk
				references lrc_template (template_id)
				on delete cascade,
	author_id		integer
				constraint lr_report_author_id_fk
				references users (user_id)
				on delete cascade,
	package_id		integer
				constraint lr_report_package_id_fk
				references apm_packages (package_id)
				on delete cascade
);

create table lr_section_content (
	content_id		integer
				constraint lr_section_content_pk
				primary key,
	report_id		integer
				constraint lr_section_content_report_id_fk
				references lr_report (report_id)
				on delete cascade,
	section_id		integer
				constraint lr_section_content_section_id_fk
				references lrc_section (section_id)
				on delete cascade,
	package_id		integer
				constraint lr_section_content_package_id_fk
				references apm_packages (package_id)
				on delete cascade,
	content			text
);

create table lr_section_feedback (
	feedback_id		integer
				constraint lr_section_feedback_pk
				primary key,
	feedback_criteria_id	integer
				constraint lr_section_feedback_criteria_id_fk
				references lrc_feedback_criteria (feedback_criteria_id)
				on delete cascade,
	report_id		integer
				constraint lr_section_feedback_report_id_fk
				references lr_report (report_id)
				on delete cascade,
	section_id		integer
				constraint lr_section_feedback_section_id_fk
				references lrc_section (section_id)
				on delete cascade,
	instructor_id		integer
				constraint lrc_lab_instructor_id_fk
				references users(user_id),
	rating			varchar (5120),
	comment			text,
	package_id		integer
				constraint lr_section_feedback_package_id_fk
				references apm_packages (package_id)
				on delete cascade
);


--
-- Create functions
--
select define_function_args('lr_report__new','report_id,template_id,author_id,package_id,creation_date;now,creation_user,creation_ip,context_id');

create function lr_report__new (
	integer,
	integer,
	integer,
	integer,
	timestamptz,
	integer,
	varchar,
	integer
) returns integer as '
declare
	p_report_id		alias for $1;        	-- default null
    	p_template_id		alias for $2;
    	p_author_id	        alias for $3;
	p_package_id		alias for $4;
    	p_creation_date         alias for $5;        	-- default now()
    	p_creation_user         alias for $6;        	-- default null
    	p_creation_ip           alias for $7;		-- default null
    	p_context_id            alias for $8;		-- default null

    	v_report_id             lr_report.report_id%TYPE;
	v_author_group_id	integer;
begin

    	v_report_id := acs_object__new (
        	p_report_id,
        	''lr_report'',
        	p_creation_date,
        	p_creation_user,
        	p_creation_ip,
        	p_context_id,
		''#lab-report.lab_report#'',
		p_package_id
    	);

    	INSERT INTO lr_report (
       		report_id,
		template_id,
		author_id,
	        package_id
    	) VALUES (
        	v_report_id,
		p_template_id,
		p_author_id,
        	p_package_id
    	);

	-- Grant permission to authors on this object.
    	PERFORM acs_permission__grant_permission(
          	v_report_id,
          	p_author_id,
	        ''lab_report_author''
    	);

    	return v_report_id;

end;' language 'plpgsql';


select define_function_args('lr_section_content__new','content_id,report_id,section_id,content,author_id,package_id,creation_date;now,creation_user,creation_ip,context_id');

create function lr_section_content__new (
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
) returns integer as '
declare
	p_content_id		alias for $1;        	-- default null
    	p_report_id		alias for $2;
    	p_section_id	        alias for $3;
	p_content		alias for $4;
	p_author_id		alias for $5;
	p_package_id		alias for $6;
    	p_creation_date         alias for $7;        	-- default now()
    	p_creation_user         alias for $8;        	-- default null
    	p_creation_ip           alias for $9;		-- default null
    	p_context_id            alias for $10;		-- default null

    	v_content_id             lr_section_content.content_id%TYPE;
begin

    	v_content_id := acs_object__new (
        	p_content_id,
        	''lr_section_content'',
        	p_creation_date,
        	p_creation_user,
        	p_creation_ip,
        	p_context_id
    	);

    	INSERT INTO lr_section_content (
       		content_id,
		report_id,
		section_id,
		package_id,
	        content
    	) VALUES (
       		v_content_id,
		p_report_id,
		p_section_id,
		p_package_id,
	        p_content
    	);

	-- Grant permission to authors on this object.
    	PERFORM acs_permission__grant_permission(
          	v_content_id,
          	p_author_id,
	        ''lab_report_author''
    	);

    	return v_content_id;

end;' language 'plpgsql';


select define_function_args('lr_section_feedback__new','feedback_id,feedback_criteria_id,report_id,section_id,instructor_id,rating,comment,package_id,creation_date;now,creation_user,creation_ip,context_id');

create function lr_section_feedback__new (
	integer,
	integer,
	integer,
	integer,
	integer,
	varchar,
	text,
	integer,
	timestamptz,
	integer,
	varchar,
	integer
) returns integer as '
declare
	p_feedback_id		alias for $1;        	-- default null
	p_feedback_criteria_id  alias for $2;
    	p_report_id		alias for $3;
    	p_section_id	        alias for $4;
	p_instructor_id		alias for $5;
	p_rating		alias for $6;
	p_comment		alias for $7;
	p_package_id		alias for $8;
    	p_creation_date         alias for $9;        	-- default now()
    	p_creation_user         alias for $10;        	-- default null
    	p_creation_ip           alias for $11;		-- default null
    	p_context_id            alias for $12;		-- default null

    	v_feedback_id		lr_section_feedback.feedback_id%TYPE;
	v_inst_group_id		integer;
begin

    	v_feedback_id := acs_object__new (
        	p_feedback_id,
        	''lr_section_feedback'',
        	p_creation_date,
        	p_creation_user,
        	p_creation_ip,
        	p_context_id
    	);

    	INSERT INTO lr_section_feedback (
       		feedback_id,
		feedback_criteria_id,
		report_id,
		section_id,
		instructor_id,
		rating,
		comment,
		package_id
    	) VALUES (
       		v_feedback_id,
		p_feedback_criteria_id,
		p_report_id,
		p_section_id,
		p_instructor_id,
		p_rating,
		p_comment,
		p_package_id
    	);


    	SELECT group_id into v_inst_group_id
      	FROM lrc_groups
        WHERE magic_name = ''instructors'';

	-- Grant permission to lab instructors on this object.
    	PERFORM acs_permission__grant_permission(
          	v_feedback_id,
          	v_inst_group_id,
	        ''lab_report_central_read''
    	);

    	PERFORM acs_permission__grant_permission(
          	v_feedback_id,
          	v_inst_group_id,
	        ''lab_report_central_write''
    	);

    	PERFORM acs_permission__grant_permission(
          	v_feedback_id,
          	v_inst_group_id,
	        ''lab_report_central_admin''
    	);

    	return v_feedback_id;

end;' language 'plpgsql';


-- Register service contract implementations.
\i lab-report-sc-create.sql