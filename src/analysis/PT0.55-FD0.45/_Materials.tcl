#-------------------------------------------------------------------------------
# Analysis of a steel multistorey Eccentrically Braced Frame with Self-centering Links
# Units: KN, m, sec
#-------------------------------------------------------------------------------

#MATERIALS
set S355        1;
set S275        2;
set SRigid      3; 
set E0        210000000;
set nu        0.3;
set G         [expr $E0/(2+2*$nu)];
set p         0.002; 
set FyS355    355000;
set FyS275    275000;
uniaxialMaterial Steel01 $S355 $FyS355 $E0 $p;
uniaxialMaterial Steel01 $S275 $FyS275 $E0 $p;
uniaxialMaterial Elastic $SRigid [expr $E0*1000];


set shear320B 4;
set shear280B 5;
set shear220M 6;
set shear200M 7;
set shear180M 8;
set shear160M 9;
set shear360B 10;
set shear180B 11;
set shear200B 12;
set shear240M 13;;

uniaxialMaterial Elastic $shear320B [expr $G*$As320B];
uniaxialMaterial Elastic $shear280B [expr $G*$As280B];
uniaxialMaterial Elastic $shear220M [expr $G*$As220M];
uniaxialMaterial Elastic $shear200M [expr $G*$As200M];
uniaxialMaterial Elastic $shear180M [expr $G*$As180M];
uniaxialMaterial Elastic $shear160M [expr $G*$As160M];
uniaxialMaterial Elastic $shear360B [expr $G*$As360B];
uniaxialMaterial Elastic $shear180B [expr $G*$As180B];
uniaxialMaterial Elastic $shear200B [expr $G*$As200B];
uniaxialMaterial Elastic $shear240M [expr $G*$As240M];

set SClink1       40; 
set SClink2       41; 
set SClink3       42; 
set SClink4       43; 

#omega<1.50
#uniaxialMaterial SelfCentering $matTag $k1 $k2 $sigAct $beta
uniaxialMaterial SelfCentering $SClink1  2E6 $k2_s1   $sigAct_s1    $beta_s1
uniaxialMaterial SelfCentering $SClink2  2E6 $k2_s2   $sigAct_s2    $beta_s2
uniaxialMaterial SelfCentering $SClink3  2E6 $k2_s3   $sigAct_s3    $beta_s3
uniaxialMaterial SelfCentering $SClink4  2E6 $k2_s4   $sigAct_s4    $beta_s4

