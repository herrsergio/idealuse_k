#!/bin/bash

TOMCAT="/usr/local/tomcat/webapps/ROOT"

PLANNING="/usr/local/tomcat/webapps/ROOT/Planning"

if [ ! -d $PLANNING ]; then
    mkdir $PLANNING
fi

tar xvjf /tmp/idealuseKFC.tar.bz2 -C /tmp

/bin/mv /tmp/Inventory.class $TOMCAT/WEB-INF/classes/jinvtran/inventory/Inventory.class
chown root.root $TOMCAT/WEB-INF/classes/jinvtran/inventory/Inventory.class
chmod 644 $TOMCAT/WEB-INF/classes/jinvtran/inventory/Inventory.class

/bin/mv /tmp/InventoryApp.class $TOMCAT/WEB-INF/classes/jinvtran/inventory/app/InventoryApp.class
chown root.root $TOMCAT/WEB-INF/classes/jinvtran/inventory/app/InventoryApp.class
chmod 644 $TOMCAT/WEB-INF/classes/jinvtran/inventory/app/InventoryApp.class

rsync -avz /tmp/Planning/ $PLANNING/
chown -R root.root $PLANNING

/bin/rm -rf /tmp/Planning
/bin/rm -rf /tmp/idealuseKFC.tar.bz2

/bin/mv /tmp/carga_rsg.pl /usr/bin/ph/databases/graphics/bin/carga_rsg.pl
chown admin.sus /usr/bin/ph/databases/graphics/bin/carga_rsg.pl
chmod 755 /usr/bin/ph/databases/graphics/bin/carga_rsg.pl

psql -U postgres -d dbeyum < /tmp/create_idealuse_table.sql

/bin/rm /tmp/create_idealuse_table.sql

/bin/mv /tmp/execpostgres.s /usr/bin/ph/execpostgres.s
chown admin.sus /usr/bin/ph/execpostgres.s
chmod 755 /usr/bin/ph/execpostgres.s

/bin/mv /tmp/loadIdealUse.pl /usr/bin/ph/databases/posdb/bin/loadIdealUse.pl
chmod 755 /usr/bin/ph/databases/posdb/bin/loadIdealUse.pl
chown admin.sus /usr/bin/ph/databases/posdb/bin/loadIdealUse.pl

if [ ! -f $TOMCAT/SQL/ss_cat_menu_option_kfc.sql.`date +%d%m%y` ]; then
    /bin/cp $TOMCAT/SQL/ss_cat_menu_option_kfc.sql $TOMCAT/SQL/ss_cat_menu_option_kfc.sql.`date +%d%m%y`
fi
/bin/mv /tmp/ss_cat_menu_option_kfc.sql $TOMCAT/SQL/ss_cat_menu_option_kfc.sql

psql -U postgres -d dbeyum < $TOMCAT/SQL/ss_cat_menu_option_kfc.sql

sum -r $PLANNING/IdealUse/Proc/*    >> /tmp/uiKFC.sum
sum -r $PLANNING/IdealUse/Rpt/*     >> /tmp/uiKFC.sum
sum -r $PLANNING/IdealUse/Scripts/* >> /tmp/uiKFC.sum

chmod +x  /tmp/populate_ideal_use.sh

nohup /tmp/populate_ideal_use.sh >/dev/null 2>&1 &
