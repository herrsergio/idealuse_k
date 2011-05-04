## exec_postgres.s
##
## Tiene los scripts de postgres para su ejecucion en el fin de dia
## Recibe como parametro no._1 la fecha de negocio en formato yymmdd
##
FECHANEGOCIO=$1
echo "$0 is running con fecha de negocio $FECHANEGOCIO ..."
/usr/local/tomcat/webapps/ROOT/Inventory/PurchaseOrder/Scripts/DepuraDB.pl
/usr/bin/ph/databases/graphics/bin/carga_rsg.pl
/usr/bin/ph/databases/posdb/bin/loadIdealUse.pl 20${FECHANEGOCIO:0:2}-${FECHANEGOCIO:2:2}-${FECHANEGOCIO:4:5}
/usr/bin/ph/databases/posdb/bin/populate.pl
exit 0
