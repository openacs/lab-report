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
       SELECT name AS template_name, description AS template_desc
       FROM lrc_template
       WHERE template_id = :template_id
     </querytext>
   </fullquery>

   <fullquery name="select_sections">
     <querytext>
       SELECT s.section_id, s.name AS section_name, 
           s.description AS section_desc, c.content
       FROM lrc_section s LEFT OUTER JOIN lr_section_content c
           ON (s.section_id = c.section_id AND c.package_id = :package_id)
       WHERE s.template_id = :template_id
       ORDER BY s.section_id
     </querytext>
   </fullquery>

</queryset>
