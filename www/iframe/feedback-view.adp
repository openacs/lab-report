<master src="../resources/iframe-master">
<property name="title">@page_title;noquote@</property>
<property name="header_stuff">
<link rel="stylesheet" type="text/css" href="/resources/acs-templating/forms.css" media="all" />
<link rel="stylesheet" type="text/css" href="/resources/acs-templating/lists.css" media="all" />
<link rel="stylesheet" type="text/css" href="/resources/lab-report/iframe-master.css" media="all" />
<link rel="stylesheet" type="text/css" href="/resources/lab-report/lab-report.css" media="all" />
<link rel="stylesheet" type="text/css" href="/resources/lab-report/lab-report.css" media="all" />
<script language="javascript" type="text/javascript" src="/resources/lab-report/popup.js"></script>
</property>


<div id="lr-feedback-container">
  <ul>
    <li class="title">@feedback_criteria_name@</li>
    <li><b>#lab-report.rating#:</b> @rating@</li>
    <li class="edit">
    <if @instructor_p@><a class="button" href="@edit_url@">#lab-report.edit#</a></if>
    <if @user_is_author_p@>
    <if @needs_help_p@><if @url@ ne ""><a href="@url@" class="button" target="_blank">#lab-report.help#</a></if></if>
    </if>
    <if @description@ ne ""><a class="button" onclick="popup('@description_url@', '@feedback_criteria_name@');return false;" href="@description_url@" target="_blank">#lab-report.info#</a></if>
    </li>
  </ul>
</div>
