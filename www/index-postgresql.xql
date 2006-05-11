<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="select_labs">
     <querytext>
       SELECT l.lab_id, l.name, l.instructor_id,
           to_char(l.start_date, 'YYYY') AS year
       FROM lrc_lab l, lrc_lab_student_map s
       WHERE s.lab_id = l.lab_id
       AND s.user_id = :author_id
       ORDER BY l.start_date DESC, l.name ASC
     </querytext>
   </fullquery>

</queryset>
