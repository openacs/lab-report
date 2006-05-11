<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.4</version></rdbms>

    <fullquery name="lab_report::get_author_id.select_author">
      <querytext>
	SELECT author_id FROM lr_author WHERE package_id = :package_id
      </querytext>
    </fullquery>

    <fullquery name="lab_report::add_author.add_author">
      <querytext>
	INSERT INTO lr_author (author_id, package_id)
	VALUES (:author_id, :package_id)
      </querytext>
    </fullquery>

    <fullquery name="lab_report::add_author.author_group">
      <querytext>
	SELECT DISTINCT group_id
	FROM lr_author_group
	WHERE package_id = :package_id
      </querytext>
    </fullquery>

    <fullquery name="lab_report::has_author.select_author">
      <querytext>
	SELECT author_id from lr_author
	WHERE package_id = :package_id
	LIMIT 1
      </querytext>
    </fullquery>

    <fullquery name="author_search">
      <querytext>
	SELECT distinct u.first_names || ' ' || u.last_name || ' (' || u.email || ')' as name, u.user_id
	FROM cc_users u
	WHERE lower(coalesce(u.first_names || ' ', '')  ||
             coalesce(u.last_name || ' ', '') ||
             u.email || ' ' ||
             coalesce(u.screen_name, '')) like lower('%'||:value||'%')
        ORDER BY name
      </querytext>
    </fullquery>

    <fullquery name="lab_report::get_users_options.users">
      <querytext>
	SELECT distinct u.first_names || ' ' || u.last_name || ' (' || u.email || ')' as name, u.user_id
	FROM cc_users u
        ORDER BY name
      </querytext>
    </fullquery>

</queryset>
