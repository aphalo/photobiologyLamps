#!perl
eval 'exec c:\perl\5.00502\bin\MSWin32-x86/perl -S $0 ${1+"$@"}'
    if $running_under_some_shell;
			# this emulates #! processing on NIH machines.
			# (remove #! line above if indigestible)

eval '$'.$1.'$2;' while $ARGV[0] =~ /^([A-Za-z_0-9]+=)(.*)/ && shift;
			# process any FOO=bar switches

$, = ' ';		# set output field separator
$\ = "\n";		# set output record separator

$n = 0;

while (<>) {
    ($Fld1) = split(' ', $_, 9999);

    printf '%e   ', $Fld1;
    if ((++$n % 2) == 0) {
	print '';
    }
}
