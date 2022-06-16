clear all
close all
clc
tic
s0=ones(1,100);
s1=zeros(1,100);
Tb=1;
ts=1/100;
t=0:ts:Tb-ts;
x=s0;
Eb=sum(x.^2);
SNRdB=0:10;
N=1000000;

for s=0:10
    SNRdb=s
    SNR=10^(SNRdb/10);
    N0=Eb/SNR;
    error=0;
    sigma2n=N0/2;

    sigma=sqrt(sigma2n); 
    
    for k=1:N
        %bit=randint(1,1);
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
        a0=sum(r.*s0);
        a1=sum(r.*s1);
    
        %[bit a0 a1]

        %DETECTOR
        if a0>(Eb/2)
            bit_rec=0;
        elseif a0<(Eb/2)
            bit_rec=1;
        end

        if bit_rec~=bit
            error=error+1;
        end
    
    end
aux=error/N;
Pe(s+1)=aux;
end
toc
        
%TEORIOCA
SNRdbt=0:0.1:10;
SNRL=10.^(SNRdbt/10);
%ON-OFF
PeOnOff=FuncionQ(sqrt(SNRL/2));
%plot(SNRdbt,PeOnOff) %Lineal

%Para escala logaritmica
figure(1)
semilogy(SNRdbt,PeOnOff,'linewidth',1)
hold on
semilogy(SNRdB,Pe,'*-r')
legend('BER Teorica','BER Estimada')
xlabel('Eb/No (dB)') 
ylabel('BER')
title('Transmisión señal On-Off')
axis([0 10 10e-3 0.5])
grid