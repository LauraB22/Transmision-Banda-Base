clear all
close all
M = 4;               % Modulation order
k = log2(M)          % Bits per symbol
EbNoVec = (0:10);      % Eb/No values (dB)
numSymPerFrame = 100;   % Number of QAM symbols per frame
berEst = zeros(size(EbNoVec));
% Pm=1/sqrt(2*pi)sum((1-(1-FuncionQ)^(M-1)exp^(1/2)()))
for n = 1:length(EbNoVec)
    % Convert Eb/No to SNR
    snrdB = EbNoVec(n) + 10*log10(k);
    % Reset the error and bit counters
    numErrs = 0;
    numBits = 0;
    
    while numErrs < 200 && numBits < 1e7
     
        dataIn = randi([0 1],numSymPerFrame,k);
        dataSym = bi2de(dataIn);
        
        txSig = qammod(dataSym,M);
        
        % Pass through AWGN channel
        rxSig = awgn(txSig,snrdB,'measured');
        
        % Demodulate the noisy signal
        rxSym = qamdemod(rxSig,M);
        % Convert received symbols to bits
        dataOut = de2bi(rxSym,k);
        
        % Calculate the number of bit errors
        nErrors = biterr(dataIn,dataOut);
        
        % Increment the error and bit counters
        numErrs = numErrs + nErrors;
        numBits = numBits + numSymPerFrame*k;
    end
    
    % Estimate the BER
    berEst(n) = numErrs/numBits;
end


berTheory = berawgn(EbNoVec, 'qam',M);
semilogy(EbNoVec,berEst,'*-r')
hold on
semilogy(EbNoVec,berTheory, 'b')
grid
legend('BER Estimada','BER Teorica')
title('BER señales ortogonales multidimensionales')
xlabel('Eb/No (dB)')
ylabel('BER')

