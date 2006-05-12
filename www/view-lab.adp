<master src="resources/main-portal">
<property name="title">@title@</property>
<property name="context">@context@</property>
<property name="admin_options">[<a href="admin/">#lab-report.admin#</a>]</property>
<property name="header_stuff">
<link rel="stylesheet" type="text/css" href="/resources/lab-report/lab-report.css" media="all">
</property>

<div id="lr-report-list-container">

  <multiple name="report">
    <ul class="report">
      <li>
        <span class="label">@report.name@</span>
        <if @author_p@>
          <if @report.report_created_p@>
          <span class="options"><a class="button" href="@report.view_url@">#lab-report.view#</a></span>
          </if>
          <else>
          <span class="options"><a class="button" href="@report.new_url@">#lab-report.new#</a></span>
	  </else>
        </if>
        <div class="spacer"></div>
      </li>
    </ul>
  </multiple>

</div>
