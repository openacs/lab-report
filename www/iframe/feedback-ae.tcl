ad_page_contract {
    Add/Edit feedback for a specific lab report section.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-06-01
    @cvs-id $Id$
} {
    report_id:integer,notnull
    lab_id:integer,notnull
    template_id:integer,notnull
    section_id:integer,notnull
    feedback_criteria_id:integer,notnull
    feedback_id:integer,optional
    {return_url "[export_vars -url -base feedback-view {report_id lab_id template_id section_id feedback_criteria_id}]"}
}

set page_title [_ lab-report.edit_feedback]
set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

if { ![lab_report::instructor_p $user_id] } {
    ad_returnredirect $return_url
}

set criteria_name [db_string select_criteria_name {} -default ""]

ad_form -name feedback -form {
    {feedback_id:key(acs_object_id_seq)}
    {report_id:text(hidden) {value $report_id}}
    {lab_id:text(hidden) {value $lab_id}}
    {template_id:text(hidden) {value $template_id}}
    {section_id:text(hidden) {value $section_id}}
    {feedback_criteria_id:text(hidden) {value $feedback_criteria_id}}
    {return_url:text(hidden) {value $return_url}}
    {criteria:text(inform)
	{label "[_ lab-report.criteria]"}
	{value "$criteria_name"}
	
    }
    {rating:text(select),optional
	{label "[_ lab-report.rating]" }
	{options {{"" none} {"Needs Work" needs_work} {Satisfactory satisfactory} {Complete complete}}}
    }
} -select_query {
       SELECT rating
	   FROM lr_section_feedback WHERE feedback_id = :feedback_id
} -new_data {

    set instructor_id $user_id

    db_transaction {
	set feedback_id [package_instantiate_object \
	    -var_list [list [list package_id $package_id] \
			   [list object_type lr_section_feedback] \
			   [list feedback_criteria_id $feedback_criteria_id] \
			   [list report_id $report_id] \
			   [list section_id $section_id] \
			   [list instructor_id $instructor_id] \
			   [list rating $rating]] \
	    -form_id feedback lr_section_feedback]
    }

} -edit_data {
    set modifying_user [ad_conn user_id]
    set modifying_ip [ad_conn peeraddr]

    db_dml feedback_update {}
    db_dml object_update {}
} -after_submit {
    ad_returnredirect $return_url
    ad_script_abort
}
