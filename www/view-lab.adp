<master src="resources/main-portal">
<property name="title">@title@</property>
<property name="context">@context@</property>
<property name="header_stuff">
<link rel="stylesheet" type="text/css" href="/resources/lab-report/lab-report.css" media="all">
</property>

<div id="lr-report-list-container">

  <multiple name="report">
    <ul class="report">
      <li>
        <span class="label">@report.name@</span>
        <span class="dates">
          <if @report.now@ ge @report.start_date@ and @report.now@ le @report.end_date@>
            [#lab-report.submission_due_date#: @report.pretty_end_date@]
          </if>
          <elseif @report.now@ gt @report.end_date@>
            [#lab-report.closed#]
          </elseif>
          <else>
            [#lab-report.available_for_editing_from# @report.pretty_start_date@ #lab-report.to# @report.pretty_end_date@]
          </else>
        </span>
        <if @author_p@>
        <if @report.viewable_p@>
          <if @report.report_created_p@>
          <span class="options"><a class="button" href="@report.view_url@">#lab-report.view#</a></span>
          </if>
          <else>
          <span class="options"><a class="button" href="@report.new_url@">#lab-report.new#</a></span>
	  </else>
        </if>
        </if>
        <div class="spacer"></div>
      </li>
    </ul>
  </multiple>

</div>
