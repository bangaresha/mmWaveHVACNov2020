function [channelSB, attSB, sigRssiSB,totPowerB] = chImpRespStrBend2(freq,WGlen,Zo,Rb,phiB,radresTES,radresTMS,gammaTES,gammaTMS,radresTEB,radresTMB,gammaTEB,gammaTMB)

radreacTES = imag(hilbert(radresTES));
radreacTMS = imag(hilbert(radresTMS));

radreacTEB = imag(hilbert(radresTEB));
radreacTMB = imag(hilbert(radresTMB));

for fi=1:length(freq)
    antresTE(fi) = sum(radresTES(fi,:));
    antresTM(fi) = sum(radresTMS(fi,:));
    antreacTE(fi) = sum(radreacTES(fi,:));
    antreacTM(fi) = sum(radreacTMS(fi,:));
    antimpTE(fi) = antresTE(fi) +1i*antreacTE(fi);
    antimpTM(fi) = antresTM(fi) +1i*antreacTM(fi);
    
    for n = 1:length(radresTES(fi,:))
        TEmodeimp(fi,n)=radresTES(fi,n) + 1i*radreacTES(fi,n);
    end
    
    for n = 1:length(radresTMS(fi,:))
        TMmodeimp(fi,n)=radresTMS(fi,n) + 1i*radreacTMS(fi,n);
    end
    
    TsTE = diag(exp(-1*gammaTES(fi,:)*WGlen));
    TbTE = diag(exp(-1*gammaTEB(fi,:)*Rb*phiB));
    chTEmodeSB = TEmodeimp(fi,:)*TsTE*TbTE*TsTE;
    chTEmodeSBTemp(:,fi) = TEmodeimp(fi,:)*TsTE*TbTE*TsTE;
    chTEmodeS = TEmodeimp(fi,:)*TsTE*TsTE;
    
    TsTM = diag(exp(-1*gammaTMS(fi,:)*WGlen));
    TbTM = diag(exp(-1*gammaTMB(fi,n)*Rb*phiB));
    chTMmodeSB = TMmodeimp(fi,:)*TsTM*TbTM*TsTM;
    chTMmodeSBTemp(:,fi) = TMmodeimp(fi,:)*TsTM*TbTM*TsTM;
    chTMmodeS = TMmodeimp(fi,:)*TsTM*TsTM;
    
    totPowerB(fi) = sum(sum(TsTE*TbTE*TsTE)) + sum(sum(TsTE*TbTE*TsTE));
    
    channelSB(fi) = ((2*Zo)/(abs(antimpTM(fi)+Zo+antimpTE(fi))^2))*...
        (sum(chTEmodeSB)+sum(chTMmodeSB));
    if isnan(channelSB(fi)) == 1
        channelSB(fi) = 0;
    end
    attSB(fi) = 10*log10(abs(channelSB(fi)));
    sigRssiSB(fi) = attSB(fi) - 14;
    
    channelS(fi) = ((2*Zo)/(abs(antimpTM(fi)+Zo+antimpTE(fi))^2))*...
        (sum(chTEmodeS)+sum(chTMmodeS));
    if isnan(channelS(fi)) == 1
        channelS(fi) = 0;
    end
    attS(fi) = 10*log10(abs(channelS(fi)));
    sigRssiS(fi) = attS(fi) - 14;
end
if phiB == 0
    channelSB = channelS;
    attSB = attS;
    sigRssiSB = sigRssiS;
end
end

   


