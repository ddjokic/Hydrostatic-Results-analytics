#!/usr/bin/env octave -q
# hydrostatic results analytics
# units metrics
# D. Djokic, 24-Mar-2013

# draft, moulded = T [m]
# draft below keel =Tk[m]
# calculates only drafts - can be extended further

filename=input("Text Filename with data: ", 's');

# reading data from CSV file - edit to suit data range

T=dlmread(filename, ',', 'A3:A151');
Tk=dlmread(filename, ',', 'B3:B151');
VOLMLD=dlmread(filename, ',', 'C3:C151');
DISPSW=dlmread(filename, ',', 'D3:D151');
LCB=dlmread(filename, ',', 'E3:E151');
TCB=dlmread(filename, ',', 'F3:F151');
VCB=dlmread(filename, ',', 'G3:G151');
LCF=dlmread(filename, ',', 'H3:H151');
WLA=dlmread(filename, ',', 'I3:I151');
TPC=dlmread(filename, ',', 'J3:J151');
KML=dlmread(filename, ',', 'K3:K151');
KMT=dlmread(filename, ',', 'L3:L151');

# graph of displacement depending on Tk
plot(Tk, DISPSW);
xlabel('Tk [m]');
ylabel('DISPSW [t]');
title('BassDrill Beta - DISPSW(Tk)');
print('BDB-displacement.dxf', '-ddxf');
print('BDB-displacement.png', '-dpng');

# launching case - draft below 7.8m ('hump' on curve)

Tk1=dlmread(filename, ',','B3:B44');
DISPSW1=dlmread(filename, ',', 'D3:D44');
plot(Tk1, DISPSW1);
xlabel('Tk [m]');
ylabel('DISPSW [t]');
title('BassDrill Beta - DISPSW(Tk)-Launching');
print('BDB-displacementL.dxf', '-ddxf');
print('BDB-displacementL.png', '-dpng');

# fitting curve - 1st degree
p=polyfit(Tk1, DISPSW1, 1);

# assembling curve & calculating weight on launching, based on draft
draft=input('Input launching draft [m]: ');
displ=p(1)*draft+p(2)