close all
clear all

SNRdb=0:0.1:10;
SNR=10.^(SNRdb/10);

%Para M=2 
PeM2 = FuncionQ(sqrt(2*SNR));
%Para M=4
PeM4 = 3/2*FuncionQ(sqrt(4/5*SNR));
%Para M=8
PeM8 = 7/4*FuncionQ(sqrt(2/7*SNR));
%Para M=16
PeM16 = 15/8*FuncionQ(sqrt(8/85*SNR));

semilogy(SNRdb,PeM2,'r', LineWidth=1)
hold on 
semilogy(SNRdb,PeM4, 'm', LineWidth=1)
hold on
semilogy(SNRdb,PeM8, 'g', LineWidth=1)
hold on 
semilogy(SNRdb,PeM16, 'c', LineWidth=1)
legend('M-arias M=2','M-arias M=4', 'M-arias M=8', 'M-arias M=16')
xlabel('Eb/No (dB)') 
ylabel('BER')
title('Comparacion de transmisión de señales ')

grid


