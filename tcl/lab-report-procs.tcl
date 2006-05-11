ad_library {

    Lab Report library

    @creation-date 2006-05-07
    @author Nick Carroll <ncarroll@ee.usyd.edu.au>
    @cvs-id $Id$
}


namespace eval lab_report {}


ad_proc -public lab_report::get_author_id {
    -package_id:required
} {
    Retrieves the author_id for the specified lab report package instance.

    @param package_id The package ID of a lab report instance.
    @return Returns the ID of the author for a specific lab report instance.
} {
    return [db_string select_author {}]
}

ad_proc -public lab_report::has_author {
    -package_id:required
} {
    Verifies that the specified instance of lab report has an author.

    @param package_id The package ID of a lab report instance.
    @return Returns 1 if there is an author for the package instance of
    lab report, otherwise 0 is returned.
} {
    return [db_0or1row select_author {}]
}


ad_proc -public lab_report::add_author {
    -author_id:required
    -package_id:required
} {
    Adds the user as an author to the specified lab report package instance.

    @param author_id The user ID of an author.
    @param package_id The package ID of a lab report instance.
} {
    db_dml add_author {}

    # Select author group.
    db_1row author_group {}

    # Add author to author group for this package.
    group::add_member -group_id $group_id -user_id $author_id

    # Give user author privileges.
    permission::grant -party_id $author_id \
        -object_id $package_id \
        -privilege "lab_report_author"
}


ad_proc -public lab_report::get_users_options {} {
    Retrieves an options list of users.
} {
    set users_list [db_list_of_lists users {}]
    set users_list [concat [list [list [_ lab-report.search] ":search:"]] \
			$users_list]
    
    return $users_list
}
