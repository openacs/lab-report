function popup(url, title)
{
	var width = 250;
	var height = 300;
	var x_pos = 0;
	var y_pos = 0;
	x_pos = 300;
	y_pos = 200;
	var popup_param = "dependent=yes,width=" + width + ",height=" + height + ",screenX="+x_pos +",screenY=" + y_pos+",left="+x_pos+",top="+y_pos+",titlebar=yes";
	window.open(url, title, popup_param);
}
