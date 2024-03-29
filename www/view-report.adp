<master src="resources/blank-portal">
<property name="title">@title;noquote@</property>
<property name="context">@context;noquote@</property>
<property name="header_stuff">
<link rel="stylesheet" type="text/css" href="/resources/lab-report/lab-report.css" media="all">
</property>
<property name="displayed_object_id">@report_id@</property>


<div id="report-container">
  <table>
    <tr>
      <td class="nav">
        <div id="nav-container">
          <ul id="navlist">
            <li><a id="current">#lab-report.report_view#</a></li>
	    <multiple name="sections">
            <li><a href="@sections.section_url@">@sections.section_name;noquote@</a></li>
	    </multiple>
          </ul>
        </div>
      </td>
      <td class="content">
	<ul>
          <li class="description">
          <h3>#lab-report.instructions#</h3> @template_desc;noquote@
          </li>
          <li class="content">
	  <multiple name="sections">
          <h3>@sections.section_name@</h3>
          @sections.content;noquote@
          </multiple>
          </li>
        </ul>
      </td>
    </tr>
  </table>
</div>
