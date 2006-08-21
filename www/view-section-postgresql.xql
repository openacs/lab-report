<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="lab_details">
     <querytext>
       SELECT l.lab_id, l.name AS lab_name, l.instructor_id,
           to_char(l.start_date, 'YYYY') AS year
       FROM lrc_lab l, lrc_lab_student_map s
       WHERE s.lab_id = l.lab_id
       AND l.lab_id = :lab_id
       AND s.user_id = :author_id
     </querytext>
   </fullquery>

   <fullquery name="template_details">
     <querytext>
       SELECT t.name AS template_name
       FROM lrc_template t
       WHERE t.template_id = :template_id
     </querytext>
   </fullquery>

   <fullquery name="section_details">
     <querytext>
       SELECT name AS section_name, description AS section_desc
       FROM lrc_section
       WHERE section_id = :section_id
     </querytext>
   </fullquery>

   <fullquery name="select_resources">
     <querytext>
       SELECT name AS resource_name, url AS resource_url
       FROM lrc_resource
       WHERE section_id = :section_id
     </querytext>
   </fullquery>

   <fullquery name="select_feedback">
     <querytext>
       SELECT feedback_criteria_id, name AS feedback_criteria_name
       FROM lrc_feedback_criteria
       WHERE section_id = :section_id
     </querytext>
   </fullquery>

   <fullquery name="select_navs">
     <querytext>
       SELECT section_id AS nav_section_id, name AS nav_section_name
       FROM lrc_section
       WHERE template_id = :template_id
       ORDER BY section_id
     </querytext>
   </fullquery>

   <fullquery name="section_content_exists">
     <querytext>
       SELECT content_id
       FROM lr_section_content
       WHERE report_id = :report_id
       AND section_id = :section_id
       AND package_id = :package_id
     </querytext>
   </fullquery>

   <fullquery name="select_content">
     <querytext>
       SELECT content_id, content from lr_section_content
       WHERE report_id = :report_id
       AND section_id = :section_id
       AND package_id = :package_id
     </querytext>
   </fullquery>

</queryset>
