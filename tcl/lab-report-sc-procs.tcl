ad_library {
    Lab report search procs.

    @author Nick Carroll
    @creation-date 2006-05-21
    @cvs $Id$
}


namespace eval lab_report::sc::search {}

ad_proc lab_report::sc::search::datasource {
    object_id
} {
    @author Nick Carroll
} {
    db_1row select_details {}

    set content ""
    db_foreach select_content {} {
	append content [template::util::richtext::get_property \
			    html_value $content]
	append " "
    }

    db_0or1row select_datasource {} -column_array datasource
    set datasource(content) $content

    return [array get datasource]
}


ad_proc lab_report::sc::search::url {
    object_id
} {
    @author Nick Carroll
} {
    set report_id $object_id

    db_1row select_lab_id {}
    db_1row select_url {}
    
    set url "${url_stub}[export_vars -url -base view-report {report_id template_id lab_id}]"

    return $url
}


