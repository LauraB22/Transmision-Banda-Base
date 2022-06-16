clear all
close all
clc


%Para M=2
d=1;
A0=-d;
A1= d;
g = ones(1,100)/sqrt(100);

s0 = A0*g;
s1 = A1*g;

E0=sum(s0*s0');
E1=sum(s1*s1');
Eav = (E0+E1)/2;

N=1000000;
Pe=[];

%for dbn=1:11

for dbn=0:10
    error=0;
    SNRdb=dbn;
    snr=10^(SNRdb/10);%relacion de energia por simbolo a ruido
    snr_bit=snr;
    N0=Eav/snr_bit;
    sigma2=N0/2;
    sigma=sqrt(sigma2);


    for k=1:N
        bit=randi([0,1],1,1);

            if bit==0
                x=s0;
            else
                x=s1;
            end

            %figure(1)
            %plot(t,x)
            %axis([0,Tb,-1.5 1.5])
            n=sigma*randn(1,100);

        %RECEPTOR
            r=x+n;  %Señal mas ruido

            %correlaciones
            a=r*g';

            %[bit a0 a1]

        %DETECTOR

            if a<0
                bit_rec=0;
            else
                bit_rec=1;
            end
            
            if bit_rec~=bit
                error=error+1;
            end
    end
        Pe=[Pe (error/N)];
end

ber=0:10;
semilogy(ber,Pe,"*-r");
hold on 
%%Teórica
SNRdbt=0:0.1:10;
SNRL = 10.^(SNRdbt/10);
PeM2 = FuncionQ(sqrt(2*SNRL));
semilogy(SNRdbt,PeM2,'B', 'LineWidth',1);
legend('BER Estimada','BER Teorica')
xlabel('Eav/No (dB)') 
ylabel('BER')
title('Transmision señal M-arias M=2')
grid 




