<master src="resources/main-portal">
<property name="title">@title;noquote@</property>
<property name="context">@context;noquote@</property>
<property name="header_stuff">
<link rel="stylesheet" type="text/css" href="/resources/lab-report/lab-report.css" media="all">
</property>

<h1>@template_name@ - @title@</h1>
<div id="report-container">
  <table>
    <tr>
      <td class="nav">
        <div id="nav-container">
          <ul id="navlist">
            <li><a href="@overview_url@">#lab-report.report_view#</a></li>
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
          <h3>#lab-report.instructions#</h3> @section_desc;noquote@
          </li>
          <li class="content">
          <h3>@section_name@</h3>

          <if @editable_p@>
          <if @author_p@>
            <if @content_created_p@>
	    @content;noquote@
            <a class="edit button" href="@edit_content_url@">#lab-report.edit#</a><div class="spacer"></div>
            </if>
	    <else>
            <a class="edit button" href="@new_url@">#lab-report.new#</a><div class="spacer"></div>
            </else>
          </if>
          </if>
          </li>
          <if @instructor_p@>
          <li class="comments">
            <h3>#lab-report.comments#</h3>
            @comment;noquote@
            <div class="add-comment"><a class="edit button" href="@comments_link@">#lab-report.edit#</a><div class="spacer"></div></div>
          </li>
          </if>
          <elseif @author_p@>
            <if @comment@ ne "">
            <li class="comments">
            <h3>#lab-report.comments#</h3>
            @comment;noquote@
            </if>
          </li>
          </elseif>
        </ul>
      </td>
      <if @content_created_p@>
      <if @feedback:rowcount@ gt 0>
      <td class="feedback">
        <ul>
          <li>
              <h3>#lab-report.feedback#</h3>
              <hr />
              <multiple name="feedback">
              <iframe src="@feedback.iframe_url@" width="150px" height="<if @instructor_p@>100px</if><else>70px</else>" marginwidth="0" marginheight="0" frameborder="0">
              Your browser does not support IFRAMES,
              please consider upgrading your browser.
              </iframe>
              <hr />
              </multiple>
          </li>
          <li>
            <if @instructor_p@><a href="@lab_return_url@" class="button">#lab-report.return_to_lab#</a></if>
          </li>
        </ul>
      </td>
      </if>
      </if>
    </tr>
  </table>
</div>
