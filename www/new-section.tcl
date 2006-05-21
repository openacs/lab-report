ad_page_contract {
    Creates a new section if one doesn't exist for the template and author.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-05-10
    @cvs-id $Id$
} {
    report_id
    lab_id
    section_id
    template_id
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

permission::require_permission -party_id $user_id \
    -object_id $package_id \
    -privilege "lab_report_author"

# Otherwise retrieve list of lab reports for the designated author.
set author_id [lab_report::get_author_id -package_id $package_id]

# If content doesn't exist for the section, then instantiate a new
# section content object.
if { ![db_0or1row section_content_exists {}] } {
    set content_id [package_instantiate_object \
			-var_list [list [list report_id $report_id] \
				       [list section_id $section_id] \
				       [list package_id $package_id] \
				       [list author_id $author_id]] \
			lr_section_content]
}

# Redirect to edit-section page.
ad_returnredirect [export_vars -url \
		       -base edit-section \
		       {report_id lab_id section_id template_id content_id}]
