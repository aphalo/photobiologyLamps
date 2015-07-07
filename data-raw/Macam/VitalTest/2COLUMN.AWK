BEGIN{n=0}
{
printf("%e   ", $1)
if ((++n % 2) == 0) print ""
}
