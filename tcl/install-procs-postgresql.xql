<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.4</version></rdbms>

    <fullquery name="lab_report::install::create_author_group.insert">
      <querytext>
      INSERT INTO lr_author_group (group_id, package_id)
      VALUES (:group_id, :package_id)  
      </querytext>
    </fullquery>

</queryset>
