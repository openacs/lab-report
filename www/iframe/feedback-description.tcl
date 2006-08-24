ad_page_contract {
    Page for viewing a feedback description for a specific lab report section.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-06-01
    @cvs-id $Id$
} {
    report_id:integer,notnull
    lab_id:integer,notnull
    template_id:integer,notnull
    section_id:integer,notnull
    feedback_criteria_id:integer,notnull
}

set page_title "[_ lab-report.section_feedback]"
set context [list [list . [_ lab-report.labs]] $page_title]
set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

# set defaults
set description ""

db_0or1row select_description {}

set description [template::util::richtext::get_property \
		     html_value $description]

ad_return_template
