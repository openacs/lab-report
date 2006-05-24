<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.4</version></rdbms>

    <fullquery name="lab_report::sc::search::datasource.select_details">
	<querytext>
	  SELECT template_id, package_id
	  FROM lr_report
	  WHERE report_id = :object_id
	</querytext>
    </fullquery>

    <fullquery name="lab_report::sc::search::datasource.select_content">
	<querytext>
	  SELECT c.content
          FROM lrc_section s LEFT OUTER JOIN lr_section_content c
              ON (s.section_id = c.section_id AND c.package_id = :package_id)
          WHERE s.template_id = :template_id
          ORDER BY s.section_id
	</querytext>
    </fullquery>

    <fullquery name="lab_report::sc::search::datasource.select_datasource">
	<querytext>
	SELECT r.report_id AS object_id,
	    t.name AS title,
            'text/html' as mime,
            '' as keywords,
            'text' as storage_type	    
	FROM lr_report r, lrc_template t
	WHERE r.report_id = :object_id
	AND r.template_id = t.template_id
	</querytext>
    </fullquery>

    <fullquery name="lab_report::sc::search::url.select_lab_id">
	<querytext>
	  SELECT l.lab_id
	  FROM lrc_lab_template_map l, lrc_lab_student_map s, lr_report r
	  WHERE r.report_id = :report_id
	  AND r.template_id = l.template_id
	  AND l.lab_id = s.lab_id
	  AND s.user_id = r.author_id
	</querytext>
    </fullquery>

    <fullquery name="lab_report::sc::search::url.select_url">
	<querytext>
         SELECT site_node__url (s.node_id) AS url_stub, r.template_id
	 FROM site_nodes s, lr_report r
	 WHERE r.report_id = :report_id
	 AND s.object_id = r.package_id	
	</querytext>
    </fullquery>

</queryset>
