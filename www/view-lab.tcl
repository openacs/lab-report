ad_page_contract {
    Displays a list of reports to be completed for a specific lab.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-05-10
    @cvs-id $Id$
} {
    lab_id
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

set author_p [permission::permission_p -party_id $user_id \
		  -object_id $package_id \
		  -privilege "lab_report_author"]

# Otherwise retrieve list of lab reports for the designated author.
set author_id [lab_report::get_author_id -package_id $package_id]

db_1row lab_details {}

db_multirow -extend {view_url new_url report_created_p viewable_p} report select_reports {} {
    set view_url [export_vars -url -base view-report \
		      {lab_id template_id report_id}]
    set new_url [export_vars -url -base new-report {lab_id template_id}]

    set report_created_p 1
    if {$report_id == ""} {
	set report_created_p 0
    }

    # Is the report viewable?  Any date after the start date means the
    # student can view their report.
    set viewable_p 0
    if { $now > $start_date } {
	set viewable_p 1
    }
}

set title "$lab_name"
set context [list $title]

ad_return_template
