clear all
close all
clc
tic
s0=ones(1,100);
s1=[ones(1,50), -ones(1,50)];
Tb=1;
ts=1/100;
t=0:ts:Tb-ts;
x=s0;
Eb=sum(x.^2);
SNRdB=0:10;
N=1000000;

for k=0:10
    SNRdb=k
    SNR=10^(SNRdb/10);
    N0=Eb/SNR;
    error=0;
    sigma2n=N0/2;

    sigma=sqrt(sigma2n);  

    for s=1:N
    %bit=randint(1,1);
    bit=randi([0,1],1,1);
    
        if bit==0
            x=s0;
        else
            x=s1;
        end
    
        n=sigma*randn(1,100);

        r=x+n;  %Señal mas ruido
    
        %correlaciones
        a0=sum(r.*s0);
        a1=sum(r.*s1);
    
        %[bit a0 a1]

        %DETECTOR
        if a0>a1
            bit_rec=0;
        else
            bit_rec=1;
        end

        if bit_rec~=bit
            error=error+1;
        end
    
    end

    aux=error/N;
    BER(k+1)=aux;
end

toc
        
SNRdbt=0:1:10;
SNRL=10.^(SNRdbt/10);
PeOrto=FuncionQ(sqrt(SNRL));

figure(1)
semilogy(SNRdbt,PeOrto,'linewidth',1)
hold on
semilogy(SNRdB,BER,'*-r')
legend('BER Teorica','BER Estimada')
xlabel('Eb/No (dB)') 
ylabel('BER')
title('Transmision señal ortogonal')
% axis([0 10 0.0009 0.2])
grid