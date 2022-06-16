%Para M=8

clear all
close all
clc

d=1;
A0 = -7*d;
A1 = -5*d;
A2 = -3*d; 
A3 = -d;
A4 = d;
A5 = 3*d;
A6 = 5*d;
A7 = 7*d;

g = ones(1,100)/sqrt(100);

s0 = A0*g;
s1 = A1*g;
s2 = A2*g;
s3 = A3*g;
s4 = A4*g;
s5 = A5*g;
s6 = A6*g;
s7 = A7*g;

E0=sum(s0*s0');
E1=sum(s1*s1');
E2=sum(s2*s2');
E3=sum(s3*s3');
E4=sum(s4*s4');
E5=sum(s5*s5');
E6=sum(s6*s6');
E7=sum(s7*s7');
Eav = (E0+E1+E2+E3+E4+E5+E6+E7)/8;

N=1000000;
Pe=[];

%for dbn=1:11

for dbn=0:10
    error=0;
    SNRdb=dbn;
    snr=10^(SNRdb/10);
    snr_bit=3*snr;
    N0=Eav/snr_bit;
    sigma2=N0/2;
    sigma=sqrt(sigma2);


    for k=1:N
        bit=randi([0,7],1,1);

            if bit==0
                x=s0;
            elseif bit==1
                x=s1;
            elseif bit==2
                 x=s2;
            elseif bit==3 
                x=s3;
            elseif bit==4
                x=s4;
            elseif bit==5
                x=s5;
            elseif bit==6
                x=s6;
            else
                x=s7;
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

            if a<(-6*d)
                bit_rec=0;
            elseif (a>=-6*d & a<-4*d)
                bit_rec=1;
            elseif (a>=-4*d & a<-2*d)
                bit_rec=2;
            elseif (a>=-2*d & a<0)
                bit_rec=3;
            elseif (a>=0 & a<2*d)
                bit_rec=4;
            elseif (a>=2*d & a<4*d)
                bit_rec=5;
            elseif (a>=4*d & a<6*d)
                bit_rec=6;
            else
                bit_rec=7;
            end
            
            if bit_rec~=bit
                error=error+1;
            end
    end
        Pe=[Pe (error/N)];
end
figure(3)
ber=0:10;
semilogy(ber,Pe,"*-r");
hold on 
%%Teórica
SNRdbt=0:0.1:10;
SNRL = 10.^(SNRdbt/10);
PeM8 = 7/4*FuncionQ(sqrt(2/7*SNRL));
semilogy(SNRdbt,PeM8,'B', 'LineWidth',1);
legend('BER Estimada','BER Teorica')
xlabel('Eav/No (dB)') 
ylabel('BER')
title('Transmision señal M-arias M=8')
grid   

