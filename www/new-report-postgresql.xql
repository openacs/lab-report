<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="report_exists">
     <querytext>
       SELECT report_id
       FROM lr_report
       WHERE template_id = :template_id
       AND author_id = :author_id
       AND package_id = :package_id
     </querytext>
   </fullquery>

</queryset>
