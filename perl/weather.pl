#!/bin/perl
$city		= "shenzhen";
$timeout	= "01:00:00";
$file_name	= "report_weather";
$ext_name	= "rpt";
chomp($today	= `date +%F`);
$raw_today	= `date -d$today +%s`;
$timeout	= `date -d"$timeout" +%s` - $raw_today;
chomp($time_now	= `date +%T`);
chomp($raw_now	= `date --date=\"$today $time_now\" +%s`);
chomp($old_report = `find -maxdepth 1 -name \"${file_name}*\" | head -n 1`);
# print("now: $today $time_now \($raw_now\) timeout:$timeout\n");
if( -f $old_report )
{
	$old_report =~ /\D*(.*)_(\d+)-(\d+)-(\d+).*/;
	$date_old = "$1";
	$time_old = "$2:$3:$4";
	chomp($raw_old = `date --date="$date_old $time_old" +%s`);
	$passed = $raw_now - $raw_old;
	# print("old: $date_old $time_old \($raw_old\) passed:$passed\n");
}

if( (!$passed) || ($passed >= $timeout) )
{
	$update_weather = "curl -s wttr.in/$city";
	chomp($now_stamp= `date --date="\@$raw_now" +"%Y-%m-%d_%H-%M-%S"` );
	$new_report	= "${file_name}.$now_stamp.${ext_name}";
	# print("$old_report needs update to $new_report\n");
	if( -f $old_report )
	{
		system("rm $old_report");
	}
	system("$update_weather > $new_report");
	system("cat $new_report | head -n 7");
}
