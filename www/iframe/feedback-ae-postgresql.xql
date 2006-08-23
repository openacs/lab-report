<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="select_criteria_name">
     <querytext>
       SELECT name FROM lrc_feedback_criteria
       WHERE feedback_criteria_id = :feedback_criteria_id
     </querytext>
   </fullquery>

   <fullquery name="feedback_update">
     <querytext>
       UPDATE lr_section_feedback
           SET rating = :rating
	   WHERE feedback_id = :feedback_id
     </querytext>
   </fullquery>

   <fullquery name="object_update">
     <querytext>
       UPDATE acs_objects
           SET modifying_user = :modifying_user,
	   modifying_ip = :modifying_ip,
	   package_id = :package_id
	   WHERE object_id = :feedback_id
     </querytext>
   </fullquery>

</queryset>
