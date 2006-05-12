ad_page_contract {
    Creates a new report if one doesn't exist for the template and author.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-05-10
    @cvs-id $Id$
} {
    lab_id
    template_id
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

permission::require_permission -party_id $user_id \
    -object_id $package_id \
    -privilege "lab_report_author"

# Otherwise retrieve list of lab reports for the designated author.
set author_id [lab_report::get_author_id -package_id $package_id]

if { ![db_0or1row report_exists {}] } {
    set report_id [package_instantiate_object \
		       -var_list [list [list package_id $package_id] \
				      [list template_id $template_id] \
				      [list author_id $author_id]] \
		       lr_report]
}

# Redirect to view-report page.
ad_returnredirect [export_vars -url \
		       -base view-report {report_id lab_id template_id}]
