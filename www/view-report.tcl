ad_page_contract {
    Displays a list of reports to be completed for a specific lab.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-05-10
    @cvs-id $Id$
} {
    report_id
    lab_id
    template_id
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
set template_desc [template::util::richtext::get_property \
		       html_value $template_desc]

db_multirow -extend {section_url} sections select_sections {} {
    set section_url [export_vars -url \
			 -base view-section {report_id lab_id template_id section_id}]
    set content [template::util::richtext::get_property html_value $content]
}

set lab_url [export_vars -url -base view-lab {lab_id}]

# General comments
set return_url [export_vars -url \
		    -base "[ad_conn package_url]view-report" \
		    { lab_id template_id report_id }]

set gc_link [general_comments_create_link -link_attributes {class="button"} \
		 $report_id $return_url]
set gc_comments [general_comments_get_comments $report_id $return_url]

# Title and context
set title "$template_name"
set context [list [list $lab_url $lab_name] $title]

ad_return_template
