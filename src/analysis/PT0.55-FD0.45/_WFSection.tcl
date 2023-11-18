#-------------------------------------------------------------------------------
# Analysis of a steel multistorey Eccentrically Braced Frame with Self-centering Links
# Units: KN, m, sec
#-------------------------------------------------------------------------------

# Wsection.tcl: tcl procedure for creating a wide flange steel fiber section
# written: Choung-Yeol Seo
# date: 09/06

proc WFSection { secID matID d tw bf tf nfdw nftf } {
  # input parameters
  # secID - section ID number
  # matID - material ID number 
  # d  = nominal depth
  # tw = web thickness
  # bf = flange width
  # tf = flange thickness
  # nfdw = number of fibers along web depth 
  # nftf = number of fibers along flange thickness
  # tff  = thickness of the flange fiber
  # twf  = thickness of the web fiber
   
  set dw  [expr $d - 2. * $tf]
  set tff [expr $tf/$nftf]
  set twf [expr $dw/$nfdw]
  
  set Awf [expr $twf*$tw]
  set Aff [expr $tff*$bf]

  #                             
  section fiberSec  $secID  {
     for {set i 0} {$i < $nfdw} {incr i 1} {
         #                   yLoc          zLoc  A    matID 
         fiber [expr $dw/2.-$twf*($i+0.5)]  0.0  $Awf  $matID
     }
     for {set i 0} {$i < $nftf} {incr i 1} {
         #                   yLoc          zLoc  A    matID
         fiber [expr  $d/2.-$tff*($i+0.5)] 0.0  $Aff  $matID
         fiber [expr -$d/2.+$tff*($i+0.5)] 0.0  $Aff  $matID
     }
  }
}