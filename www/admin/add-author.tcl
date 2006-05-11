ad_page_contract {
    Index page.  Displays list of lab report templates available to student,
    as well as list of completed lab reports.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-04-17
    @cvs-id $Id$
} {
    {return_url "."}
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

permission::require_permission -party_id $user_id -object_id $package_id \
    -privilege admin

if { [lab_report::has_author -package_id $package_id] } {
    ad_returnredirect -message [_ lab-report.author_already_exists] $return_url
}

ad_form -name author -cancel_url $return_url -form {
    {return_url:text(hidden) {value $return_url}}
    {author_id:search
	{result_datatype integer}
	{label "[_ lab-report.author]"}
	{help_text "[_ lab-report.help_select_author]"}
	{options "[lab_report::get_users_options]"}
	{search_query {[db_map dbqd.lab-report.tcl.lab-report-procs.author_search]}}
    }
} -after_submit {
    # Add author_id as author for this package instance.
    lab_report::add_author -author_id $author_id -package_id $package_id

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
