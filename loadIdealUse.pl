#!/usr/bin/perl 

use lib '/usr/lib/perl5/lib/perl/5.8.4';

BEGIN {
    unshift @INC, '/usr/bin/ph/databases/posdb/lib';
}
use posdb;

$LOG = '/tmp/loadIdealUse.log';

$ENV{PATH} .= ":/usr/bin/ph";

#$year    = shift @ARGV;
#$period  = shift @ARGV;
#$week    = shift @ARGV;
#$wd      = shift @ARGV;
$t       = 1;
$date_id = shift @ARGV;

$YY      = substr( $date_id , 2, 2);
$YYYY    = substr( $date_id , 0, 4);
$MM      = substr( $date_id , 5, 2);
$DD      = substr( $date_id , 8, 2);

$dyps    = `/usr/bin/ph/dyps.s $YY$MM$DD`;
chomp( $dyps );

@data    = split( /\//, $dyps );

$year    = $data[0];
$period  = $data[1];
$week    = $data[2];

@dow = (5, 6, 0, 1, 2, 3, 4);

$q     = "SELECT extract(dow from timestamp '$YYYY-$MM-$DD')";
$q_exe = $dbh->prepare( $q ); 
$q_exe->execute( ); 
$dowP  = $q_exe->fetchrow( );

$dowInv   = $dow[$dowP];

#$period = "0" . $period if ( $period < 10 && length($period) < 2 );

open( FILELOG, ">$LOG" );
$log_date = qx/date '+%D-%X'/;
$log_date =~ s/\s//g;
print FILELOG "\nInicio... $log_date\n";
print FILELOG
  "ARGS: year:$year period:$period week:$week wd:$dowInv t:$t date_id:$date_id\n";
print FILELOG
"/usr/bin/ph/jinvtran -t $dowInv $year $period $week \| grep \| \| grep -v Item\n";
@array =
  `/usr/bin/ph/jinvtran -t $dowInv $year $period $week | grep "|" | grep -v Item`;
chomp(@array);
$qry_del =
  "delete from op_inv_ideal_use where turn_date = '$date_id' and turn_id = $t";
print FILELOG "Eliminando datos:$qry_del\n";
$qry_del_exe = $dbh->prepare($qry_del);
$qry_del_exe->execute();

%hash_inv = existProd();
print FILELOG "Cargando datos\n";
foreach $line (@array) {
    ( $c1, $inv_id, $ideal_use, $unit_cost, $misc ) = split( /\|/, $line );
    $inv_id    =~ s/\s//g;
    $ideal_use =~ s/\s//g;
    $unit_cost =~ s/\s//g;
    $misc      =~ s/\s//g;
    next if ( !defined( $hash_inv{$inv_id} ) );
    if ( $ideal_use != 0.00 ) {
        $qry_ins =
                 "INSERT INTO op_inv_ideal_use(inv_id,ideal_use,unit_cost,misc,turn_id,turn_date) VALUES ('$inv_id',$ideal_use,$unit_cost,$misc,'$t','$date_id')";
        $qry_exe = $dbh->prepare($qry_ins);

        if ( $qry_exe->execute() ) {
            print FILELOG "$qry_ins\n";
        }
        else {
            print FILELOG "ERROR $qry_ins\n";
        }
    }
}

sub existProd() {

#$qrysel = "select distinct inv_id from op_grl_cat_inventory where frecuency_id in (1,5)";
    $qrysel   = "select distinct inv_id from op_grl_cat_inventory";
    $get_data = $dbh->prepare($qrysel);
    $get_data->execute();
    while ( $rs = $get_data->fetchrow_hashref() ) {
        $inv_id_rs = $rs->{"inv_id"};
        $inv_id_rs =~ s/\s//g;
        $hash_id{$inv_id_rs} = $inv_id_rs;
    }
    return %hash_id;
}
$log_date = qx/date '+%D-%X'/;
$log_date =~ s/\s//g;
print FILELOG "Termino... $log_date\n";
close(FILELOG);
exit 0;
