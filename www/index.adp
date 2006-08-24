<master src="resources/main-portal">
<property name="title">@title@</property>
<property name="context">@context@</property>
<property name="header_stuff">
<link rel="stylesheet" type="text/css" href="/resources/lab-report/lab-report.css" media="all">
</property>

<div id="lr-lab-list-container">

  <multiple name="lab">
  <ul class="years">
    <li>@lab.year@</li>
    <ul class="report">
      <group column="year">
      <li>
        <span class="label">@lab.name@</span>
        <if @author_p@><span class="options"><a class="button" href="@lab.view_url@">#lab-report.view#</a></span></if>
        <div class="spacer"></div>
      </li>
      </group>
    </ul>
  </ul>
  </multiple>

</div>