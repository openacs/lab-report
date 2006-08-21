<master src="../resources/iframe-master">
<property name="title">@page_title;noquote@</property>
<property name="header_stuff">
<link rel="stylesheet" type="text/css" href="/resources/acs-templating/forms.css" media="all" />
<link rel="stylesheet" type="text/css" href="/resources/acs-templating/lists.css" media="all" />
<link rel="stylesheet" type="text/css" href="/resources/lab-report/iframe-master.css" media="all" />
<link rel="stylesheet" type="text/css" href="/resources/lab-report/lab-report.css" media="all" />
</property>


<div id="lr-feedback-container">
  <ul>
    <li class="title">@feedback_criteria_name@</li>
    <li><b>#lab-report.rating#:</b> @rating@</li>
    <li><b>#lab-report.comments#:</b> @comment;noquote@</li>
    <if @instructor_p@><li class="edit"><a class="button" href="@edit_url@">#lab-report.edit#</a><div class="spacer"></div></li></if>
  </ul>
</div>
