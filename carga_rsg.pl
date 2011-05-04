#!/usr/bin/perl 
##########################################################################################################
# Nombre Archivo  : carga_rsg.pl
# Compa�a        : Yum Brands Intl
# Autor           : Sandra Castro P. 
# Objetivo        : Carga los datos del archivo real-sistema_gerente.txt en la BD.
# Fecha Creacion  : 24/Oct/2005
# Inc/requires    :
# Modificaciones  :
# Fecha           Programador     Observaciones
##########################################################################################################
# Invcluyendo los paquetes que se utilizarán
use lib "/usr/bin/ph/databases/graphics/lib";
use gtConnect;

#Inicialización de valriables
$archivo_log="/usr/bin/ph/databases/graphics/log/carga_rsg.log";
$file_target="/usr/bin/ph/tables/real_sistema_gerente.txt";
$FILE="/usr/bin/ph/tables/real_sistema_gerente.txt";

if($ARGV[0] ne "") {
    chomp($ARGV[0]);
    $todayoformato=$ARGV[0];
    $yy = substr($todayoformato, 0, 2);
    $mm = substr($todayoformato, 2, 2);
    $dd = substr($todayoformato, 4, 6);
    $today = $yy."-".$mm."-".$dd;
} else {
    $today=qx/date '+%y-%m-%d'/;
    chop($today);
    $todayoformato=qx/date '+%y%m%d'/;
    chop($todayoformato);
}

$phpqdate = qx/\/usr\/bin\/ph\/sysshell.new SUS > \/dev\/null 2>&1; \/usr\/fms\/op\/bin\/phpqdate/;
$hace7dias=qx/\/usr\/bin\/ph\/sysshell.new SUS > \/dev\/null 2>&1; \/usr\/bin\/ph\/dant.s $today 7/;
chop($hace7dias);

# Sentencia para insertar en la tabla los valores
$InsertRSG=<<EOF;
	INSERT INTO op_gt_real_sist_mng  VALUES (?,?,?,?,?,?,?)
EOF
# Sentencia para actualizar los valores en la tabla
$UpdateRSG=<<EOF;
	UPDATE op_gt_real_sist_mng set ppt_real=?, ppt_sist=?, ppt_mng=?, trans_real=?, trans_sist=?, trans_mng=? where date_id=?
EOF

open(LOG,">$archivo_log") or die("No pude abrir $archivo_log: $!\n");
# Si la fecha de hoy es igual a la fecha de negocio entonces hay que regenerar la información de ventas en print1
if($todayoformato == $phpqdate){
	print LOG "Regenerando datos de la fecha de hoy $today\n";
	print ` /usr/bin/ph/sysshell.new SUS > /dev/null 2>&1; /usr/fms/op/bin/phzap phpqpr 01 1 3 | /usr/bin/compress - > /usr/fms/op/rpts/print1/$today.Z`;
	print `/usr/fms/op/bin/phzap chmod 0777 /usr/fms/op/rpts/print1/$today.Z`;
	print `/usr/bin/ph/txthistory/wrapgen.pl 0 > /dev/null`;
}

print LOG "- Determinando si la fecha de hoy existe en real_sistema_gerente.txt\n";
$reg_aux = qx/grep \"^$today\" $file_target/;
if($reg_aux eq ""){
	$flag_file=0;
}else{
	$flag_file=1;
}
print LOG "\t\tflag_file= $flag_file\n\n";
print LOG "- Calculamos los valores nuevos que debemos actualizar y/o insertar,\n";
$items_calculados=calcula_valores($today, $flag_file);
print LOG "\t\t$items_calculados\n\n";
print LOG "- Si flag_file es igual a cero, se insertan los valores nuevos en el archivo,\n  si no solo se actualizan\n";
# Sergio Cuellar Dec 30 2009
# Para evitar cambien pzas x trans
#opera_sobre_archivo($today, $flag_file, $items_calculados);

print LOG "*******************************************\n";
print LOG "- Leyendo archivo real_sistema_gerente.txt\n";
@regs = get_rsg_Data();

foreach $valor (@regs) {
	@datafields=split(/\|/,$valor);
	@ymd=split(/\-/,$datafields[0]);
	$date_id_ori=$datafields[0];
	$year="20$ymd[0]";
	$date_id="$year-$ymd[1]-$ymd[2]";
	$ppt_real=($datafields[1])?$datafields[1]:0;
	$ppt_sist=($datafields[2])?$datafields[2]:0;
	$ppt_gte=($datafields[3])?$datafields[3]:0;
	$cbz_real=$datafields[4];
	$cbz_sist=$datafields[5];
	$cbz_gte=$datafields[6];
	$trans_real = round(($ppt_real > 0)?$cbz_real*9/$ppt_real:0);
	$trans_sist = round(($ppt_sist > 0)?$cbz_sist*9/$ppt_sist:0);
	$trans_gte = round(($ppt_gte > 0)?$cbz_gte*9/$ppt_gte:0);
	$flagExistReg = existsReg($date_id);
	$diffdays = diffDays($date_id_ori, $hace7dias);
	
 	if($flagExistReg==1){
		if($diffdays<=0){
			$sth=$dbh->prepare($UpdateRSG);
			if($sth->execute($ppt_real,$ppt_sist, $ppt_gte,$trans_real, $trans_sist,$trans_gte,$date_id)){
				print LOG "- Actualizo registro: $date_id_ori\n";
			}else{
				print LOG " - Error al actualizar registro : $date_id_ori\n";
			}
		}
	}else{
			$sth=$dbh->prepare($InsertRSG);
			if ($sth->execute($date_id,$ppt_real,$ppt_sist, $ppt_gte,$trans_real, $trans_sist,$trans_gte)){
				print LOG "- Inserto registro  : $date_id_ori\n";
			}else{
				print LOG " - Error al insertar registro : $date_id_ori\n";
			}
	}
}
print LOG "*******************************************\n";
close(LOG);

sub get_rsg_Data {
   local @linea;
   $i=0;   #Contadores para los arreglos formados para insertar en cada tabla
   open(FILE) or die print "Error: no se encuentra $FILE\n";
   while ($line=<FILE>) {
        $linea[$i++] = "$line";
   }
   close(FILE);
   return(@linea);
}

sub existsReg {
   my $date_idt = shift @_;

   local $get_register = $dbh->prepare("SELECT COUNT(*) FROM op_gt_real_sist_mng WHERE date_id = ?");

   $get_register->execute($date_idt);
   if($get_register ->rows == 0){
      return (0);
   } else {
     $regs = $get_register->fetchrow();
      if ( $regs == 0 ) {
         return(0);
       } else {
         return(1);
       }
   }
}

sub diffDays {
	my $date_target = shift @_;
	my $hace1sem = shift @_;
	local $getDiffDays = $dbh->prepare("SELECT to_date(?,'yy-mm-dd')- to_date(?,'yy-mm-dd') as daysdiff");
	$getDiffDays->execute($hace1sem,$date_target);
	while( $regptr =  $getDiffDays->fetchrow_hashref() ){
			$daysdiff = $regptr->{"daysdiff"};
	}
	return($daysdiff);
}

sub calcula_valores{
	my $todayl = shift @_;
	my $flag_fileloc = shift @_;
	@ymdtoday=split(/\-/,$todayl);
	print `/usr/fms/op/bin/phzap chmod 0777 /tmp/pronostico.log`;
	$fecha_fms = @ymdtoday[1]."/".@ymdtoday[2]."/".@ymdtoday[0]; #mes/dia/anyo
	@output = qx/\/home\/httpd\/html\/php\/hpedidos\/loadFMS.s $fecha_fms $fecha_fms/;
	$ppt_real_c=qx/\/usr\/bin\/ph\/txthistory\/ppt-real.pl --fecha $todayl --nocache --calc/;
	$ppt_sist_c = qx/\/usr\/bin\/ph\/txthistory\/ppt-pron.pl --fecha $todayl --nocache --calc --natural/;
	if($flagfileloc == 0){
		$ppt_gte_c=$ppt_sist_c;
	}else{
		$ppt_gte_c = qx/\/usr\/bin\/ph\/txthistory\/ppt-gerente.pl --fecha $todayl/;
	}
	my $longitud = @output;
	for($i=0;$i<$longitud;$i++){
		@values=split(/\|/,$output[$i]);
		if($values[9] =~ /(Real)/){
			$trans_real = $values[4]+$values[8];
		}
		if($values[9] =~ /(Sistem)/){
			$trans_sist = $values[4]+$values[8];
		}
		if($values[9] =~ /(Gerente)/){
			$trans_gte = $values[4]+$values[8];
		}
	}
	$valores_calc="$ppt_real_c|$ppt_sist_c|$ppt_gte_c|$trans_real|$trans_sist|$trans_gte|";
	return($valores_calc);
}

sub opera_sobre_archivo{
	my $todaynew = shift @_;
	my $flag_fileloc = shift @_;
	my $reg_new_bd = shift @_;
	@reg_new_file=split(/\|/,$reg_new_bd);
	$cbz_real = $reg_new_file[0]*$reg_new_file[3]/9;
	$cbz_sist = $reg_new_file[1]*$reg_new_file[4]/9;
	$cbz_gte = $reg_new_file[2]*$reg_new_file[5]/9;
	$new_reg_file = "$reg_new_file[0]|$reg_new_file[1]|$reg_new_file[2]|$cbz_real|$cbz_sist|$cbz_gte|";
	if($flag_fileloc == 0){
		print LOG "         Se inserta el valor en el archivo $file_target\n";
		open(TARGET,">>$file_target") or die("No pude abrir: $file_target!\n");
		print TARGET "$todaynew|$new_reg_file";
		close(TARGET);
		print `cat $file_target| sort -r > /tmp/este.txt`;
	}else{
		print LOG "         Se actualiza el valor en el archivo $file_target\n";
		$file_temp = "/tmp/borrame.txt";
		$file_sf = qx/grep -v \"^$today\" $file_target > $file_temp/;
		open(ACT,">>$file_temp")or die("No pude abrir: $file_temp!\n");
		print ACT "$todaynew|$new_reg_file";
		close(ACT);
		print `cat $file_temp| sort -r > /tmp/este.txt`;
		print `rm $file_temp`;
	}
	print `/usr/fms/op/bin/phzap mv /tmp/este.txt $file_target`;
	print `/usr/fms/op/bin/phzap chmod 0666 $file_target`;
}
sub round {
    my($number) = shift;
    return int($number + .5);
}
1;
