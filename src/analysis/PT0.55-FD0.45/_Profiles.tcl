#-------------------------------------------------------------------------------
# Analysis of a steel multistorey Eccentrically Braced Frame with Self-centering Links
# Units: KN, m, sec
#-------------------------------------------------------------------------------

##################### IPE ################################################
# BEAMS-IPE600
set d600   0.6;
set tw600  0.012;
set bf600  0.22;
set tf600  0.019;
set r600   0.024;
set A600   0.0156;
set I600   0.00092080;
set As600  [expr $A600-2*$bf600*$tf600+($tw600+2*$r600)*$tf600];

# BEAMS-IPE550
set d550   0.55;
set tw550  0.0111;
set bf550  0.21;
set tf550  0.0172;
set r550   0.024;
set A550   0.01344;
set I550   0.0006712;
set As550  [expr $A550-2*$bf550*$tf550+($tw550+2*$r550)*$tf550];

# BEAMS-IPE500
set d500   0.5;
set tw500  0.0102;
set bf500  0.2;
set tf500  0.016;
set r500   0.021;
set A500   0.01155;
set I500   0.000482;
set As500  [expr $A500-2*$bf500*$tf500+($tw500+2*$r500)*$tf500];

##################### HE M ################################################
# COLUMNS-HE650M
set d650M   0.668;
set tw650M  0.021;
set bf650M  0.305;
set tf650M  0.04;
set r650M   0.027;
set A650M   0.03737;
set I650M   0.002817;
set As650M  [expr $A650M-2*$bf650M*$tf650M+($tw650M+2*$r650M)*$tf650M];

# COLUMNS-HE600M
set d600M   0.620;
set tw600M  0.021;
set bf600M  0.305;
set tf600M  0.04;
set r600M   0.027;
set A600M   0.03637;
set I600M   0.002374;
set As600M  [expr $A600M-2*$bf600M*$tf600M+($tw600M+2*$r600M)*$tf600M];

# COLUMNS-HE550M
set d550M   0.572;
set tw550M  0.021;
set bf550M  0.306;
set tf550M  0.04;
set r550M   0.027;
set A550M   0.03544;
set I550M   0.00198;
set As550M  [expr $A550M-2*$bf550M*$tf550M+($tw550M+2*$r550M)*$tf550M];

# COLUMNS-HE500M
set d500M   0.524;
set tw500M  0.021;
set bf500M  0.306;
set tf500M  0.04;
set r500M   0.027;
set A500M   0.03443;
set I500M   0.001619;
set As500M  [expr $A500M-2*$bf500M*$tf500M+($tw500M+2*$r500M)*$tf500M];

# COLUMNS-HE450M
set d450M   0.478;
set tw450M  0.021;
set bf450M  0.307;
set tf450M  0.04;
set r450M   0.027;
set A450M   0.03354;
set I450M   0.001315;
set As450M  [expr $A450M-2*$bf450M*$tf450M+($tw450M+2*$r450M)*$tf450M];

# COLUMNS-HE400M
set d400M   0.432;
set tw400M  0.021;
set bf400M  0.307;
set tf400M  0.04;
set r400M   0.027;
set A400M   0.03258;
set I400M   0.001041;
set As400M  [expr $A400M-2*$bf400M*$tf400M+($tw400M+2*$r400M)*$tf400M];

# COLUMNS-HE360M
set d360M   0.395;
set tw360M  0.021;
set bf360M  0.308;
set tf360M  0.04;
set r360M   0.027;
set A360M   0.03188;
set I360M   0.00084870;
set As360M  [expr $A360M-2*$bf360M*$tf360M+($tw360M+2*$r360M)*$tf360M];

# COLUMNS-HE340M
set d340M   0.377;
set tw340M  0.021;
set bf340M  0.309;
set tf340M  0.04;
set r340M   0.027;
set A340M   0.03158;
set I340M   0.00076370;
set As340M  [expr $A340M-2*$bf340M*$tf340M+($tw340M+2*$r340M)*$tf340M];

# COLUMNS-HE320M
set d320M   0.359;
set tw320M  0.021;
set bf320M  0.309;
set tf320M  0.04;
set r320M   0.027;
set A320M   0.0312;
set I320M   0.00068130;
set As320M  [expr $A320M-2*$bf320M*$tf320M+($tw320M+2*$r320M)*$tf320M];

# COLUMNS-HE260M
set d260M   0.290;
set tw260M  0.018;
set bf260M  0.260;
set tf260M  0.0325;
set r260M   0.024;
set A260M   0.02196;
set I260M   0.00031310;
set As260M  [expr $A260M-2*$bf260M*$tf260M+($tw260M+2*$r260M)*$tf260M];

# COLUMNS-HE240M
set d240M   0.270;
set tw240M  0.018;
set bf240M  0.248;
set tf240M  0.032;
set r240M   0.021;
set A240M   0.01996;
set I240M   0.00024290;
set As240M  [expr $A240M-2*$bf240M*$tf240M+($tw240M+2*$r240M)*$tf240M];

# COLUMNS-HE220M
set d220M   0.240;
set tw220M  0.0155;
set bf220M  0.226;
set tf220M  0.026;
set r220M   0.018;
set A220M   0.01494;
set I220M   0.00014600;
set As220M  [expr $A220M-2*$bf220M*$tf220M+($tw220M+2*$r220M)*$tf220M];

# COLUMNS-HE200M
set d200M   0.220;
set tw200M  0.015;
set bf200M  0.206;
set tf200M  0.025;
set r200M   0.018;
set A200M   0.01313;
set I200M   0.00010640;
set As200M  [expr $A200M-2*$bf200M*$tf200M+($tw200M+2*$r200M)*$tf200M];

# COLUMNS-HE180M###################CAMBIADO
set d180M   0.200;
set tw180M  0.0145;
set bf180M  0.186;
set tf180M  0.024;
set r180M   0.015;
set A180M   0.0113;
set I180M   0.00007483;
set As180M  [expr $A180M-2*$bf180M*$tf180M+($tw180M+2*$r180M)*$tf180M];

# COLUMNS-HE160M
set d160M   0.180;
set tw160M  0.014;
set bf160M  0.166;
set tf160M  0.023;
set r160M   0.015;
set A160M   0.009705;
set I160M   0.00005098;
set As160M  [expr $A160M-2*$bf160M*$tf160M+($tw160M+2*$r160M)*$tf160M];

##################### HE B ################################################

# COLUMNS-HE700B#################CAMBIADO
set d700B   0.7;
set tw700B  0.017;
set bf700B  0.3;
set tf700B  0.032;
set r700B   0.027;
set A700B   0.0306;
set I700B   0.002567;
set As700B  [expr $A700B-2*$bf700B*$tf700B+($tw700B+2*$r700B)*$tf700B];

# COLUMNS-HE600B
set d600B   0.6;
set tw600B  0.0155;
set bf600B  0.3;
set tf600B  0.03;
set r600B   0.027;
set A600B   0.027;
set I600B   0.00171;
set As600B  [expr $A600B-2*$bf600B*$tf600B+($tw600B+2*$r600B)*$tf600B];

# COLUMNS-HE500B
set d500B   0.5;
set tw500B  0.0145;
set bf500B  0.3;
set tf500B  0.028;
set r500B   0.027;
set A500B   0.02386;
set I500B   0.001072;
set As500B  [expr $A500B-2*$bf500B*$tf500B+($tw500B+2*$r500B)*$tf500B];

# COLUMNS-HE400B#######################CAMBIADO
set d400B   0.4;
set tw400B  0.014;
set bf400B  0.3;
set tf400B  0.024;
set r400B   0.027;
set A400B   0.0198;
set I400B   0.0005768;
set As400B  [expr $A400B-2*$bf400B*$tf400B+($tw400B+2*$r400B)*$tf400B];

# COLUMN - HE360B
set d360B   0.36;
set tw360B  0.0125;
set bf360B  0.3;
set tf360B  0.0225;
set r360B   0.027;
set A360B   0.01806;
set I360B   0.0004319;
set As360B  [expr $A360B-2*$bf360B*$tf360B+($tw360B+2*$r360B)*$tf360B];

# COLUMN - HE340B########################CAMBIADO
set d340B   0.34;
set tw340B  0.012;
set bf340B  0.3;
set tf340B  0.022;
set r340B   0.027;
set A340B   0.0171;
set I340B   0.0003666;
set As340B  [expr $A340B-2*$bf340B*$tf340B+($tw340B+2*$r340B)*$tf340B];

# COLUMN - HE320B
set d320B   0.32;
set tw320B  0.0115;
set bf320B  0.3;
set tf320B  0.0205;
set r320B   0.027;
set A320B   0.01613;
set I320B   0.0003082;
set As320B  [expr $A320B-2*$bf320B*$tf320B+($tw320B+2*$r320B)*$tf320B];

# COLUMN - HE300B####################CAMBIADO
set d300B   0.30;
set tw300B  0.011;
set bf300B  0.3;
set tf300B  0.019;
set r300B   0.027;
set A300B   0.0149;
set I300B   0.0002517
set As300B  [expr $A300B-2*$bf300B*$tf300B+($tw300B+2*$r300B)*$tf300B];

# COLUMN - HE280B
set d280B   0.28;
set tw280B  0.0105;
set bf280B  0.28;
set tf280B  0.018;
set r280B   0.024;
set A280B   0.01314;
set I280B   0.00019270
set As280B  [expr $A280B-2*$bf280B*$tf280B+($tw280B+2*$r280B)*$tf280B];

#COLUMN-HE240B
set d240B   0.240;
set tw240B  0.010;
set bf240B  0.240;
set tf240B  0.017;
set r240B   0.021;
set A240B   0.0106;
set I240B   0.00011260;
set As240B  [expr $A240B-2*$bf240B*$tf240B+($tw240B+2*$r240B)*$tf240B];

#COLUMN-HE220B
set d220B   0.220;
set tw220B  0.0095;
set bf220B  0.22;
set tf220B  0.016;
set r220B   0.018;
set A220B   0.009104;
set I220B   0.00008091;
set As220B  [expr $A220B-2*$bf220B*$tf220B+($tw220B+2*$r220B)*$tf220B];

#COLUMN-HE200B
set d200B   0.2;
set tw200B  0.009;
set bf200B  0.2;
set tf200B  0.015;
set r200B   0.018;
set A200B   0.007808;
set I200B   0.00005696;
set As200B  [expr $A200B-2*$bf200B*$tf200B+($tw200B+2*$r200B)*$tf200B];

#COLUMN-HE180B
set d180B   0.18;
set tw180B  0.0085;
set bf180B  0.18;
set tf180B  0.014;
set r180B   0.015;
set A180B   0.006525;
set I180B   0.00003831;
set As180B  [expr $A180B-2*$bf180B*$tf180B+($tw180B+2*$r180B)*$tf180B];

#COLUMN-HE160B################CAMBIADO
set d160B   0.16;
set tw160B  0.008;
set bf160B  0.16;
set tf160B  0.013;
set r160B   0.015;
set A160B   0.0054;
set I160B   0.00002492;
set As160B  [expr $A160B-2*$bf160B*$tf160B+($tw160B+2*$r160B)*$tf160B];




