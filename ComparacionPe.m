close all
clear all

SNRdb=0:0.1:10;
SNR=10.^(SNRdb/10);

%Ortogonales
PeOrt=FuncionQ(sqrt(SNR));
%On-Off
PeOnOff=FuncionQ(sqrt(SNR/2));
%Antipolales
PeAnti=FuncionQ(sqrt(2*SNR));

semilogy(SNRdb,PeOrt,'r', LineWidth=1)
hold on 
semilogy(SNRdb,PeOnOff, 'm', LineWidth=1)
hold on
semilogy(SNRdb,PeAnti, 'g', LineWidth=1)
legend('Ortogonales','On-Off', 'Antipodales')
xlabel('Eb/No (dB)') 
ylabel('BER')
title('Comparacion de transmisión de señales ')
grid


