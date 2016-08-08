nmon

inittab
nmond:23456789:once:/administrador/shells/nmond.sh start > /dev/null 2>&1

crontab
0 0 * * * /administrador/shells/nmond.sh restart >/dev/null 2>&1
