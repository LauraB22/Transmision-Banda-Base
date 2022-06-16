%Para M=16

clear all
close all
clc

d=1;
A0 = -15*d;
A1 = -13*d;
A2 = -11*d;
A3 = -9*d;
A4 = -7*d;
A5 = -5*d;
A6 = -3*d; 
A7 = -d;
A8 =  d;
A9 =  3*d;
A10 = 5*d;
A11 = 7*d;
A12 = 9*d;
A13 = 11*d;
A14 = 13*d;
A15 = 15*d;

g = ones(1,100)/sqrt(100);

s0 = A0*g;
s1 = A1*g;
s2 = A2*g;
s3 = A3*g;
s4 = A4*g;
s5 = A5*g;
s6 = A6*g;
s7 = A7*g;
s8 = A8*g;
s9 = A9*g;
s10 = A10*g;
s11 = A11*g;
s12 = A12*g;
s13 = A13*g;
s14 = A14*g;
s15 = A15*g;

E0=sum(s0*s0');
E1=sum(s1*s1');
E2=sum(s2*s2');
E3=sum(s3*s3');
E4=sum(s4*s4');
E5=sum(s5*s5');
E6=sum(s6*s6');
E7=sum(s7*s7');
E8=sum(s8*s8');
E9=sum(s9*s9');
E10=sum(s10*s10');
E11=sum(s11*s11');
E12=sum(s12*s12');
E13=sum(s13*s13');
E14=sum(s14*s14');
E15=sum(s15*s15');

Eav = (E0+E1+E2+E3+E4+E5+E6+E7+E8+E9+E10+E11+E12+E13+E14+E15)/16;

N=1000000;
Pe=[];

%for dbn=1:11

for dbn=0:10
    error=0;
    SNRdb=dbn;
    snr=10^(SNRdb/10);
    snr_bit=4*snr;
    N0=Eav/snr_bit;
    sigma2=N0/2;
    sigma=sqrt(sigma2);


    for k=1:N
        bit=randi([0,15],1,1);

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
            elseif bit==7
                x=s7;
            elseif bit==8
                x=s8;
            elseif bit==9
                x=s9;
            elseif bit==10
                x=s10;
            elseif bit==11
                x=s11;
            elseif bit==12
                x=s12;
            elseif bit==13
                x=s13;
            elseif bit==14
                x=s14;
            else
                x=s15;
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

            if a<(-14*d)
                bit_rec=0;
            elseif (a>=-14*d & a<-12*d)
                bit_rec=1;
            elseif (a>=-12*d & a<-10*d)
                bit_rec=2;
            elseif (a>=-10*d & a<-8*d)
                bit_rec=3;
            elseif (a>=-8*d & a<-6*d)
                bit_rec=4;
            elseif (a>=-6*d & a<-4*d)
                bit_rec=5;
            elseif (a>=-4*d & a<-2*d)
                bit_rec=6;
            elseif (a>=-2*d & a<0)
                bit_rec=7;
            elseif (a>=0 & a<2*d)
                bit_rec=8;
            elseif (a>=2*d & a<4*d)
                bit_rec=9;
            elseif (a>=4*d & a<6*d)
                bit_rec=10;
            elseif (a>=6*d & a<8*d)
                bit_rec=11;
            elseif (a>=8*d & a<10*d)
                bit_rec=12;
            elseif (a>=10*d & a<12*d)
                bit_rec=13;
            elseif (a>=12*d & a<14*d)
                bit_rec=14;
            else
                bit_rec=15;
            end
            
            if bit_rec~=bit
                error=error+1;
            end
    end
        Pe=[Pe (error/N)];
end
figure(4)
ber=0:10;
semilogy(ber,Pe,"*-r");
hold on 
%%Teórica
SNRdbt=0:0.1:10;
SNRL = 10.^(SNRdbt/10);
PeM16 = 15/8*FuncionQ(sqrt(8/85*SNRL));
semilogy(SNRdbt,PeM16,'B', 'LineWidth',1);
legend('BER Estimada','BER Teorica')
xlabel('Eav/No (dB)') 
ylabel('BER')
title('Transmision señal M-arias M=16')
grid  
