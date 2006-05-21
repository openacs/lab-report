ad_page_contract {
    Displays the contents for a specific lab report section.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-05-10
    @cvs-id $Id$
} {
    report_id:integer
    lab_id:integer
    template_id:integer
    section_id:integer
    content_id:integer,optional
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

set author_p [permission::permission_p -party_id $user_id \
		  -object_id $package_id \
		  -privilege "lab_report_author"]

# Otherwise retrieve list of lab reports for the designated author.
set author_id [lab_report::get_author_id -package_id $package_id]

# Retrieve lab details.
db_1row lab_details {}

# Retrieve template details.
db_1row template_details {}

# Retrieve section details.
db_1row section_details {}
set section_desc [template::util::richtext::get_property \
		      html_value $section_desc]


# Create some URLs
set edit_url [export_vars -url -base edit-section {lab_id section_id}]
set lab_url [export_vars -url -base view-lab {lab_id}]
set overview_url [export_vars -url \
		      -base view-report { report_id lab_id template_id }]

set title "$section_name"
set context [list [list $lab_url $lab_name] \
		 [list $overview_url $template_name] $title]

set return_url [export_vars -url -base view-section {report_id lab_id template_id section_id}]

ad_form -name section -cancel_url $return_url -form {
    {content_id:key(acs_object_id_seq)}
    {report_id:integer(hidden) {value $report_id}}
    {lab_id:integer(hidden) {value $lab_id}}
    {template_id:integer(hidden) {value $template_id}}
    {section_id:integer(hidden) {value $section_id}}
    {author_id:integer(hidden) {value $author_id}}
    {content:richtext(richtext),optional
	{label "[_ lab-report.content]"}
	{help_text "[_ lab-report.help_enter_section_content]"}
	{html {cols 48 rows 20}}
        {nospell}
    }
} -select_query {
    SELECT content FROM lr_section_content WHERE content_id = :content_id
    AND package_id = :package_id
} -edit_data {
    set modifying_user [ad_conn user_id]
    set modifying_ip [ad_conn peeraddr]

    db_dml section_update {}
    db_dml object_update {}
} -after_submit {
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
