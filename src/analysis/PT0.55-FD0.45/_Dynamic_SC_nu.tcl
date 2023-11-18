#-------------------------------------------------------------------------------
# Analysis of a steel multistorey Eccentrically Braced Frame with Self-centering Links
# Units: KN, m, sec
#-------------------------------------------------------------------------------

wipe;
model BasicBuilder -ndm 2 -ndf 3

source _Profiles.tcl
source _Materials.tcl
source _WFSection.tcl

#NODES
node 1 0 0
node 2 6 0
node 3 0 3.5
node 4 6 3.5
node 5 0 6.7
node 6 6 6.7
node 7 0 9.9
node 8 6 9.9
node 9 0 13.10
node 10 6 13.10

#LINK'S NODES
node 11 2.45 3.5
node 12 3.55 3.5
node 13 2.5 6.7
node 14 3.5 6.7
node 15 2.55 9.9
node 16 3.45 9.9
node 17 2.7 13.10
node 18 3.3 13.10

#LEANING COLUMN'S NODES
node 19 7 0
node 20 7 3.5
node 21 7 6.7
node 22 7 9.9
node 23 7 13.10

#ZERO LENGTH LINK'S NODES
node 1005 3.0 3.5
node 1006 3.0 3.5
node 2005 3.0 6.7
node 2006 3.0 6.7
node 3005 3.0 9.9
node 3006 3.0 9.9
node 4005 3.0 13.10
node 4006 3.0 13.10

#PANEL ZONE'S NODES
#Beam bottom
node 3001 0 3.32;
node 5001 0 6.54;
node 7001 0 9.76;
node 9001 0 13.01;
node 4001 6 3.32;
node 6001 6 6.54;
node 8001 6 9.76;
node 10001 6 13.01;

#Beam top
node 3003 0 3.68;
node 5003 0 6.86;
node 7003 0 10.040000000000001;
node 4003 6 3.68;
node 6003 6 6.86;
node 8003 6 10.040000000000001;

#Column rigth
node 3002 0.16 3.5
node 5002 0.16 6.7
node 7002 0.14 9.9
node 9002 0.14 13.10

#Column left
node 4004 5.84 3.5
node 6004 5.84 6.7
node 8004 5.86 9.9
node 10004 5.86 13.10

#CONSTRAINTS
fix 1 1 1 0
fix 2 1 1 0
fix 19 1 1 0

#CONSTRAINTS ZERO LENGTH LINK
equalDOF 1005 1006 1;
equalDOF 1005 1006 3;
equalDOF 2005 2006 1;
equalDOF 2005 2006 3;
equalDOF 3005 3006 1;
equalDOF 3005 3006 3;
equalDOF 4005 4006 1;
equalDOF 4005 4006 3;

#STOREY CONSTRAINTS
equalDOF 3 4 1;
equalDOF 5 6 1;
equalDOF 7 8 1;
equalDOF 9 10 1;

#COLUMN SECTIONS
WFSection     13  $S275   0.32   0.0115   0.3  0.0205  8   4
section Aggregator 23 4 Vy -section 13
WFSection     14  $S275   0.32   0.0115   0.3  0.0205  8   4
section Aggregator 24 4 Vy -section 14
WFSection     15  $S275   0.28   0.0105   0.28  0.018  8   4
section Aggregator 25 5 Vy -section 15
WFSection     16  $S275   0.28   0.0105   0.28  0.018  8   4
section Aggregator 26 5 Vy -section 16

#BEAM SECTIONS
WFSection     43  $S275   0.36   0.0125   0.3  0.0225  8   4
section Aggregator 53 10 Vy -section 43
WFSection     44  $S275   0.32   0.0115   0.3  0.0205  8   4
section Aggregator 54 4 Vy -section 44
WFSection     45  $S275   0.28   0.0105   0.28  0.018  8   4
section Aggregator 55 5 Vy -section 45
WFSection     46  $S275   0.2   0.009   0.2  0.015  8   4
section Aggregator 56 12 Vy -section 46

#DIAGONAL SECTIONS
WFSection     73  $S275   0.270   0.018   0.248  0.032  8   4
section     Aggregator   83   13 Vy  -section 73;
WFSection     74  $S275   0.240   0.0155   0.226  0.026  8   4
section     Aggregator   84   6 Vy  -section 74;
WFSection     75  $S275   0.220   0.015   0.206  0.025  8   4
section     Aggregator   85   7 Vy  -section 75;
WFSection     76  $S275   0.200   0.0145   0.186  0.024  8   4
section     Aggregator   86   8 Vy  -section 76;

set    PDTrans  1; 
set    LNTrans  2;
set    nI6      4;
geomTransf PDelta $PDTrans; 
geomTransf Linear $LNTrans; 

#COLUMN FRAME ELEMENTS
element nonlinearBeamColumn   1   1 3001 4    23  $PDTrans
element nonlinearBeamColumn   2   2 4001 4    23  $PDTrans
element nonlinearBeamColumn   3   3003 5001 4    24  $PDTrans
element nonlinearBeamColumn   4   4003 6001 4    24  $PDTrans
element nonlinearBeamColumn   5   5003 7001 4    25  $PDTrans
element nonlinearBeamColumn   6   6003 8001 4    25  $PDTrans
element nonlinearBeamColumn   7   7003 9001 4    26  $PDTrans
element nonlinearBeamColumn   8   8003 10001 4    26  $PDTrans

#LEANING COLUMN FRAME ELEMENTS
element elasticBeamColumn 9 19 20 0.07808 210000000 0.0005696 $PDTrans
element elasticBeamColumn 10 20 21 0.07808 210000000 0.0005696 $PDTrans
element elasticBeamColumn 11 21 22 0.07808 210000000 0.0005696 $PDTrans
element elasticBeamColumn 12 22 23 0.07808 210000000 0.0005696 $PDTrans

#BEAMS FRAME ELEMENTS
element nonlinearBeamColumn 13   3002 11 4    53  $LNTrans;
element nonlinearBeamColumn 14   11 1005 4    53  $PDTrans;
element nonlinearBeamColumn 15   1006 12 4    53  $PDTrans;
element nonlinearBeamColumn 16   12 4004 4    53  $LNTrans;
element nonlinearBeamColumn 17   5002 13 4    54  $LNTrans;
element nonlinearBeamColumn 18   13 2005 4    54  $PDTrans;
element nonlinearBeamColumn 19   2006 14 4    54  $PDTrans;
element nonlinearBeamColumn 20   14 6004 4    54  $LNTrans;
element nonlinearBeamColumn 21   7002 15 4    55  $LNTrans;
element nonlinearBeamColumn 22   15 3005 4    55  $PDTrans;
element nonlinearBeamColumn 23   3006 16 4    55  $PDTrans;
element nonlinearBeamColumn 24   16 8004 4    55  $LNTrans;
element nonlinearBeamColumn 25   9002 17 4    56  $LNTrans;
element nonlinearBeamColumn 26   17 4005 4    56  $PDTrans;
element nonlinearBeamColumn 27   4006 18 4    56  $PDTrans;
element nonlinearBeamColumn 28   18 10004 4    56  $LNTrans;

#TRUSS ELEMENTS
element truss  29 4 20 18.06 $SRigid
element truss  30 6 21 18.06 $SRigid
element truss  31 8 22 18.06 $SRigid
element truss  32 10 23 18.06 $SRigid

#DIAGONAL FRAME ELEMENTS
element nonlinearBeamColumn 33   1 11 4    83  $LNTrans;
element nonlinearBeamColumn 34   2 12 4    83  $LNTrans;
element nonlinearBeamColumn 35   3 13 4    84  $LNTrans;
element nonlinearBeamColumn 36   4 14 4    84  $LNTrans;
element nonlinearBeamColumn 37   5 15 4    85  $LNTrans;
element nonlinearBeamColumn 38   6 16 4    85  $LNTrans;
element nonlinearBeamColumn 39   7 17 4    86  $LNTrans;
element nonlinearBeamColumn 40   8 18 4    86  $LNTrans;

#VERTICAL PANEL ZONE FRAME ELEMENT
element elasticBeamColumn  41 3001 3 0.01613 [expr $E0*1000] 0.0003082 $LNTrans
element elasticBeamColumn  42 4001 4 0.01613 [expr $E0*1000] 0.0003082 $LNTrans
element elasticBeamColumn  43 5001 5 0.01613 [expr $E0*1000] 0.0003082 $LNTrans
element elasticBeamColumn  44 6001 6 0.01613 [expr $E0*1000] 0.0003082 $LNTrans
element elasticBeamColumn  45 7001 7 0.01613 [expr $E0*1000] 0.0003082 $LNTrans
element elasticBeamColumn  46 8001 8 0.01613 [expr $E0*1000] 0.0003082 $LNTrans
element elasticBeamColumn  47 9001 9 0.01613 [expr $E0*1000] 0.0003082 $LNTrans
element elasticBeamColumn  48 10001 10 0.01613 [expr $E0*1000] 0.0003082 $LNTrans

element elasticBeamColumn  49 3 3003 0.01613 [expr $E0*1000] 0.0003082 $LNTrans
element elasticBeamColumn  50 4 4003 0.01613 [expr $E0*1000] 0.0003082 $LNTrans
element elasticBeamColumn  51 5 5003 0.01613 [expr $E0*1000] 0.0003082 $LNTrans
element elasticBeamColumn  52 6 6003 0.01613 [expr $E0*1000] 0.0003082 $LNTrans
element elasticBeamColumn  53 7 7003 0.01613 [expr $E0*1000] 0.0003082 $LNTrans
element elasticBeamColumn  54 8 8003 0.01613 [expr $E0*1000] 0.0003082 $LNTrans


#HORIZONTAL PANEL ZONE FRAME ELEMENT
element elasticBeamColumn  55 3 3002 0.01613 [expr $E0*1000] 0.0003082 $LNTrans
element elasticBeamColumn  56 4 4004 0.01613 [expr $E0*1000] 0.0003082 $LNTrans
element elasticBeamColumn  57 5 5002 0.01613 [expr $E0*1000] 0.0003082 $LNTrans
element elasticBeamColumn  58 6 6004 0.01613 [expr $E0*1000] 0.0003082 $LNTrans
element elasticBeamColumn  59 7 7002 0.01613 [expr $E0*1000] 0.0003082 $LNTrans
element elasticBeamColumn  60 8 8004 0.01613 [expr $E0*1000] 0.0003082 $LNTrans
element elasticBeamColumn  61 9 9002 0.01613 [expr $E0*1000] 0.0003082 $LNTrans
element elasticBeamColumn  62 10 10004 0.01613 [expr $E0*1000] 0.0003082 $LNTrans

#ZERO-LENGTH LINK
element zeroLength  63   1005 1006 -mat 40 -dir 2;
element zeroLength  64   2005 2006 -mat 41 -dir 2;
element zeroLength  65   3005 3006 -mat 42 -dir 2;
element zeroLength  66   4005 4006 -mat 43 -dir 2;

#MASSES
mass     3      78.05     0     0;
mass     4      78.05     0     0;
mass     5      78.05     0     0;
mass     6      78.05     0     0;
mass     7      78.05     0     0;
mass     8      78.05     0     0;
mass     9      77.2      0     0;
mass     10     77.2      0     0;


set  LinearDefault  "Linear  -factor  +1.0E+00" 
initialize 

#POINT LOADS
pattern Plain 1 $LinearDefault {
load 3 0 -103.8 0; 
load 4 0 -103.8 0; 
load 5 0 -103.8 0; 
load 6 0 -103.8 0; 
load 7 0 -103.8 0; 
load 8 0 -103.8 0; 
load 9 0 -103.8 0; 
load 10 0 -103.8 0;
}

pattern Plain 2 $LinearDefault {
load 20 0 -1265 0; 
load 21 0 -1265 0; 
load 22 0 -1265 0; 
load 23 0 -1265 0; 
}

pattern Plain 3 $LinearDefault {
eleLoad -ele 13 14 15 16 -type -beamUniform -17.3; 
eleLoad -ele 17 18 19 20 -type -beamUniform -17.3; 
eleLoad -ele 21 22 23 24 -type -beamUniform -17.3; 
eleLoad -ele 25 26 27 28 -type -beamUniform -15.3; 
}

#===============================================================================
# PushOver Analysis only for gravity loads: Analysys Option "StaticDefault" 

constraints  Plain 
test  NormDispIncr    +1.000000E-006   100      6        2;        # default type of norm (n=2) 
integrator  LoadControl  +0.1 
algorithm  Newton 
numberer  RCM 
system  ProfileSPD 
analysis  Static 
analyze     10
# ===============================================================================
# Reset for next analysis case 
# loadConst <-time $pseudoTime>

loadConst   -time 0.0
remove recorders; 
wipeAnalysis; 

recorder display "Displaced shape" 20 20 800 800 -wipe

prp     300. 200. 1;
vup     0 1 0;
vpn     0 0 1;
display 1 5 10;

# ==============================================================================
##### DYNAMIC ANALYSIS ---------------------------------------------------
# ==============================================================================

# Define time series 
# TimeSeries "TimeSeries01":              dt        filePath                       cFactor  
set           TimeSeries01  "Series      -dt $dt   -filePath  Analysis_$n/acc_$n.txt   -factor  1"  

# Define load pattern 
# Same acceleration input at all nodes restrained in specified direction 
# LoadPattern "th":              $patternTag    $dir          $TimeSeries 
pattern  UniformExcitation       4              1     -accel  $TimeSeries01 

# ===============================================================================
# Definition of the recorders
# file mkdir "Recorders_DYNAMIC_SC-EBF_5x4"

recorder  Node     -file  "Analysis_$n/Displacement_nu.out"                     -time -node 4 6 8 10 -dof  1    disp
#recorder  Node     -file  "Analysis_$n/Base_Reactions_nu.out"                   -node 1 2 19 -dof  1  reaction  

# Beams
#recorder  Element  -file  "Analysis_$n/Beams_Global_forces_nu.out"              -ele  13  16  17  20  21  24  25  28 force
#recorder  Element  -file  "Analysis_$n/Beams_Global_Deformation_Sec_1_nu.out"   -ele  13  16  17  20  21  24  25  28 section 1 deformation
#recorder  Element  -file  "Analysis_$n/Beams_Global_Deformation_Sec_4_nu.out"   -ele  13  16  17  20  21  24  25  28 section $nI6 deformation

# Link
#recorder  Element  -file  "Analysis_$n/Links_Global_forces_nu.out"              -ele  63  64  65  66 -dof 2 force
#recorder  Element  -file  "Analysis_$n/Links_Deformations_nu.out"               -ele  63  64  65  66 deformation

# Columns
#recorder  Element  -file  "Analysis_$n/Column_Deformation_Sec_1_nu.out"         -ele  1  2  3  4  5  6  7  8  section  1  deformation
#recorder  Element  -file  "Analysis_$n/Column_Deformation_Sec_4_nu.out"         -ele  1  2  3  4  5  6  7  8  section  $nI6  deformation
#recorder  Element  -file  "Analysis_$n/Column_Global_forces_nu.out"             -ele  1  2  3  4  5  6  7  8  force

# Diagonals
#recorder  Element  -file  "Analysis_$n/Diagonal_Deformation_Sec_1_nu.out"       -ele  33  34  35  36  37  38  39  40 section  1  deformation
#recorder  Element  -file  "Analysis_$n/Diagonal_Deformation_Sec_4_nu.out"       -ele  33  34  35  36  37  38  39  40 section  $nI6  deformation
#recorder  Element  -file  "Analysis_$n/Diagonal_Global_forces_nu.out"           -ele  33  34  35  36  37  38  39  40 force

#recorder  Element  -file  "Analysis_$n/LeaningColumn_nu.out"                    -ele 9 10 11 12 -dof 1 force
# ==============================================================================

# Define analysis options (Transient)

# Definition of the tolerance and of the maximum number of iteration
set Tol 0.00000001
set maxIter 20
constraints  Transformation 
test   EnergyIncr     $Tol    $maxIter   
integrator   Newmark  +5.000000E-001  +2.500000E-001
rayleigh  $aR                      $bR    +0.000000E+000  +0.000000E+000 (whenever you have MDOF systems)
algorithm Newton 
numberer  RCM 
system  BandGeneral
analysis  Transient 

set begin [clock clicks -milliseconds]      
set t 0
set finalt [expr $numstep*$dt]
set DtAnalysis [expr $dt]
 
set div 1;
set divmax 2048;

set ok [analyze   $numstep   $DtAnalysis];
set t [getTime];
puts "$ok $t"
   while {$t < $finalt} {
	   if {$ok != 0} {
	   set div [expr $div*2];
	   set DtAnalysis [expr $dt/$div];
	     if {$div > $divmax} {
            break
        }        
    set ok [analyze 1    $DtAnalysis];			
	   }
		if {$ok==0 && $div>1} {
		set div [expr $div/2];
		set DtAnalysis [expr $dt/$div];		
		}
		set ok [analyze   1   $DtAnalysis];
		 puts "$t $DtAnalysis" 
		 puts "$div" 
		 puts "$ok $t $DtAnalysis"
		 set t  [expr $t+ $DtAnalysis];
		 }
   

set endt [clock clicks -milliseconds]
set totaltime [expr ($endt-$begin)]
set totaltimem [expr ($endt-$begin)/60000.0]

# ===============================================================================
# Print a message to indicate if analysis succesfull or not
if {$ok == 0} {
   puts "################################################"
   puts " Analysis       completed SUCCESSFULLY";

   puts "Time in hours: [expr $totaltimem/60.]"
   puts "################################################"
} else {
   puts "################################################"
   puts "Analysis        FAILED";  

   puts "Time in hours: [expr $totaltimem/60.]"  
   puts "################################################"
}

# ===============================================================================
# Final clean up 
wipe 
