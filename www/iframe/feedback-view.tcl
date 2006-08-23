ad_page_contract {
    Page for viewing feedback for a specific lab report section.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-06-01
    @cvs-id $Id$
} {
    report_id:integer,notnull
    lab_id:integer,notnull
    template_id:integer,notnull
    section_id:integer,notnull
    feedback_criteria_id:integer,notnull
}

set page_title "[_ lab-report.section_feedback]"
set context [list [list . [_ lab-report.labs]] $page_title]
set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

# set defaults
set rating "none"

db_0or1row select_feedback {}

if { $rating eq "complete" } {
    set rating "Complete"
} elseif { $rating eq "needs_work"} {
    set rating "Needs Work"
} elseif { $rating eq "satisfactory" } {
    set rating "Satisfactory"
} else {
    set rating "None"
}

if { [info exists feedback_id] && $feedback_id ne "" } {
    set edit_url [export_vars -url -base feedback-ae {report_id lab_id template_id section_id feedback_criteria_id feedback_id}]
} else {
    set edit_url [export_vars -url -base feedback-ae {report_id lab_id template_id section_id feedback_criteria_id}]    
}

# Is the user an instructor?
set instructor_p [lab_report::instructor_p $user_id]

ad_return_template
