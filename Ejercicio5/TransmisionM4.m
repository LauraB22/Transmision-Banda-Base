%Para cuando M = 4

clear all
close all
clc

d=1;
A0=-3*d;
A1=-d;
A2=d; 
A3=3*d;
g = ones(1,100)/sqrt(100);

s0 = A0*g;
s1 = A1*g;
s2 = A2*g;%%g(t)
s3 = A3*g;


E0=sum(s0*s0');
E1=sum(s1*s1');
E2=sum(s2*s2');
E3=sum(s3*s3');
Eav = (E0+E1+E2+E3)/4;

N=1000000;
Pe=[];

%for dbn=1:11

for dbn=0:10
    error=0;
    SNRdb=dbn;
    snr=10^(SNRdb/10);
    snr_bit=2*snr;
    N0=Eav/snr_bit;
    sigma2=N0/2;
    sigma=sqrt(sigma2);


    for k=1:N
        bit=randi([0,3],1,1);

            if bit==0
                x=s0;
            elseif bit==1
                x=s1;
            elseif bit==2
                 x=s2;
            else 
                x=s3;
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

            if a<(-2*d)
                bit_rec=0;
            elseif (a>=-2*d & a<0)
                bit_rec=1;
            elseif (a>=0 & a<2*d)
                bit_rec=2;
            else
                bit_rec=3;
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
PeM4 = 3/2*FuncionQ(sqrt(4/5*SNRL));
semilogy(SNRdbt,PeM4,'B', 'LineWidth',1);
legend('BER Estimada','BER Teorica')
xlabel('Eav/No (dB)') 
ylabel('BER')
title('Transmision señal M-arias M=4')
grid   