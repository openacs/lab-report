<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="select_feedback">
     <querytext>
       SELECT c.name AS feedback_criteria_name, sf.feedback_id,
           sf.rating, sf.comment
       FROM lrc_feedback_criteria c LEFT OUTER JOIN lr_section_feedback sf
           ON (c.feedback_criteria_id = sf.feedback_criteria_id
               AND sf.report_id = :report_id)
       WHERE c.section_id = :section_id
           AND c.feedback_criteria_id = :feedback_criteria_id
     </querytext>
   </fullquery>

</queryset>
