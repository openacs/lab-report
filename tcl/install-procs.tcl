ad_library {

    Lab Report Install library
    
    Procedures that deal with installing, instantiating, mounting.

    @creation-date 2006-04-17
    @author Nick Carroll <ncarroll@ee.usyd.edu.au>
    @cvs-id $Id$
}


namespace eval lab_report::install {}

ad_proc -private lab_report::install::package_instantiate {
    -package_id:required
} {
    Package instantiation callback proc.
} {
    db_transaction {
	lab_report::install::create_author_group -package_id $package_id
    }
}

ad_proc -private lab_report::install::create_author_group {
    -package_id:required
} {
    Creates the author group for this package instance
} {
    set group_id [group::new -group_name [_ lab-report.author_group]]

    # Insert group_id and package_id.
    db_dml insert {}

    # Retrieve group_id for instructors.
    set instr_group_id [lab_report_central::instructor_group_id]

    # Give instructors permission to author this package.
    permission::grant -party_id $instr_group_id \
	-object_id $package_id \
	-privilege "lab_report_author"
}
