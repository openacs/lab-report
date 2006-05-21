<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="section_content_exists">
     <querytext>
       SELECT content_id
       FROM lr_section_content
       WHERE report_id = :report_id
       AND section_id = :section_id
       AND package_id = :package_id
     </querytext>
   </fullquery>

</queryset>
