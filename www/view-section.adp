<master src="resources/main-portal">
<property name="title">@title;noquote@</property>
<property name="context">@context;noquote@</property>
<property name="admin_options">[<a href="admin/">#lab-report.admin#</a>]</property>
<property name="header_stuff">
<link rel="stylesheet" type="text/css" href="/resources/lab-report/lab-report.css" media="all">
</property>


<div id="report-container">
  <table>
    <tr>
      <td class="nav">
        <div id="nav-container">
          <ul id="navlist">
            <li><a href="@overview_url@">#lab-report.overview#</a></li>
	    <multiple name="navs">
            <li>
              <if @section_id@ eq @navs.nav_section_id@>
              <a id="current" href="@navs.section_url@">
              </if>
              <else>
              <a href="@navs.section_url@">
              </else>
	      @navs.nav_section_name;noquote@</a></li>
	    </multiple>
          </ul>
        </div>
        <if @resources:rowcount@ gt 0>
	<div id="resources-container">
	  <ul id="resources-list">
	    <li class="header">#lab-report.resources#</li>
	    <multiple name="resources">
            <li><a href="@resources.resource_url@" target="_blank">@resources.resource_name;noquote@</a></li>
            </multiple>
	  </ul>
 	</div>
        </if>
      </td>
      <td class="content">
	<ul>
          <li class="description">
          <h3>#lab-report.description#</h3> @section_desc;noquote@
          </li>
          <li class="content">
          <h3>@section_name@</h3>

          <if @author_p@>
            <if @content_created_p@>
	    @content;noquote@
            <a class="edit button" href="@edit_url@">#lab-report.edit#</a><div class="spacer"></div>
            </if>
	    <else>
            <a class="edit button" href="@new_url@">#lab-report.new#</a><div class="spacer"></div>
            </else>
          </if>
          </li>
        </ul>
      </td>
    </tr>
  </table>
</div>
