<master src="../resources/iframe-master">
<property name="title">@page_title;noquote@</property>
<property name="header_stuff">
<link rel="stylesheet" type="text/css" href="/resources/acs-templating/forms.css" media="all" />
<link rel="stylesheet" type="text/css" href="/resources/acs-templating/lists.css" media="all" />
<link rel="stylesheet" type="text/css" href="/resources/lab-report/iframe-master.css" media="all" />
<link rel="stylesheet" type="text/css" href="/resources/lab-report/lab-report.css" media="all" />
</property>


<div id="lr-feedback-description-container">
  <ul>
    <li class="title"><h1>@feedback_criteria_name@</h1></li>
    <li><h2>#lab-report.description#</h2> @description;noquote@</li>
  </ul>
</div>

<div id="close">
  <a class="button" href="#" onclick="window.close(this)">Close Window</a>
</div>