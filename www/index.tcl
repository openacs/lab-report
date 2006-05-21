ad_page_contract {
    Index page.  Displays list of lab report templates available to student,
    as well as list of completed lab reports.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-04-17
    @cvs-id $Id$
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

# Check if this package has an author.  If not, then redirect admin user
# to page for adding an author from a list of users.
if { ![lab_report::has_author -package_id $package_id] } {
    # If the user is an administrator, then user can add author.  Otherwise
    # display notice that administrator is required to add an author.
    if { [permission::permission_p -party_id $user_id -object_id $package_id \
	      -privilege admin] } {
	set return_url "../."
	ad_returnredirect [export_vars -url -base "admin/add-author" {return_url}]
	ad_script_abort
    } else {
	ad_returnredirect "need-author"
	ad_script_abort
    }
}

# Otherwise retrieve list of lab reports for the designated author.
set author_id [lab_report::get_author_id -package_id $package_id]
db_multirow -extend {view_url} lab select_labs {} {
    set view_url [export_vars -url -base view-lab {lab_id}]
}

set author_p [permission::permission_p -party_id $user_id \
		  -object_id $package_id \
		  -privilege "lab_report_author"]

set title [_ lab-report.labs]
set context ""

ad_return_template
