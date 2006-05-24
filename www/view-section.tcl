ad_page_contract {
    Displays the contents for a specific lab report section.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-05-10
    @cvs-id $Id$
} {
    report_id
    lab_id
    template_id
    section_id
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

db_multirow -extend {section_url} navs select_navs {} {
    set section_url [export_vars -url \
			 -base view-section \
			 {report_id lab_id template_id \
			      {section_id $nav_section_id}}]
}

db_multirow resources select_resources {}

# Create some URLs
set new_url [export_vars -url -base new-section {report_id lab_id section_id template_id}]
set lab_url [export_vars -url -base view-lab {lab_id}]
set overview_url [export_vars -url \
		      -base view-report { report_id lab_id template_id }]

set content_created_p 0
if { [db_0or1row section_content_exists {}] } {
    set content_created_p 1

    db_1row select_content {}
    set edit_url [export_vars -url -base edit-section {report_id lab_id section_id template_id content_id}]

    set content [template::util::richtext::get_property html_value $content]

    # General comments
    set return_url [export_vars -url \
			-base "[ad_conn package_url]view-section" \
			{ report_id lab_id template_id section_id }]
    
    set gc_link [general_comments_create_link \
		     -object_name "$section_name" \
		     -link_attributes {class="button"} \
		     $content_id $return_url]
    set gc_comments [general_comments_get_comments \
			 $content_id $return_url]
}

# Title and context
set title "$section_name"
set context [list [list $lab_url $lab_name] \
		 [list $overview_url $template_name] $title]

ad_return_template
