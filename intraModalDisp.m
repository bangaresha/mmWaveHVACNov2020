function [channel, att, totPowerS, meanDelay, rmsDelay, pn_dB] = intraModalDisp(freq,fc_TE,fc_TM,c,m_TE,n_TE,m_TM,n_TM,k,WGlen,radius,Zo,R,eta,l,coWnTE,coWnTM)

[radresTE, radresTM, gammaTE, gammaTM] = radResCyl_multitone(m_TE,n_TE,m_TM,n_TM,radius,freq,fc_TE,fc_TM,c,k,R,eta,l,coWnTE,coWnTM);

radreacTE = imag(hilbert(radresTE));
radreacTM = imag(hilbert(radresTM));

for fi=1:length(freq)
    antresTE(fi) = sum(radresTE(fi,:));
    antresTM(fi) = sum(radresTM(fi,:));
    antreacTE(fi) = sum(radreacTE(fi,:));
    antreacTM(fi) = sum(radreacTM(fi,:));
    antimpTE(fi) = antresTE(fi) +1i*antreacTE(fi);
    antimpTM(fi) = antresTM(fi) +1i*antreacTM(fi);
    for n = 1:length(n_TE)
        TEmodeimp(fi,n)=radresTE(fi,n)+1i*radreacTE(fi,n);
    end
    for n = 1:length(n_TM)
        TMmodeimp(fi,n)=radresTM(fi,n)+1i*radreacTM(fi,n);
    end    
end
for fi=1:length(freq)
    TsTE = diag(exp(-1*gammaTE(fi,:)*WGlen));
    chTEmode = TEmodeimp(fi,:)*TsTE;
    TsTM = diag(exp(-1*gammaTM(fi,:)*WGlen));
    chTMmode = TMmodeimp(fi,:)*TsTM;
    totPowerS(fi) = 2*(sum(sum(TsTE)) + sum(sum(TsTM)));
    channel(fi) = ((2*Zo)/(abs(Zo + antimpTM(fi))^2))*...
        (sum(chTMmode));
%     channel(fi) = ((2*Zo)/(abs(antimpTM(fi) + Zo + antimpTE(fi))^2))*...
%         (sum(chTEmode)+sum(chTMmode));

    if isnan(channel(fi)) == 1
        channel(fi) = 0;
        att(fi) = 0;
    else
        att(fi) = 10*log10(abs(channel(fi)));
    end
end
%channelTime = ifft(channel,72000);
channelTime = ifft(channel,200000);

temp = 0;
for i = 1:length(channelTime)
    pn_dB(i) = (10*log10((abs(channelTime(i)))^2)) + 70;
    pn(i) = (abs((channelTime(i)))^2)*1E4;
    temp = temp + (pn(i))*i;
end
maxpn = max(pn_dB);
%peak1 = pn_dB(maxpn);
pndBtemp1=[];
delayTime=[];
for i = 1:length(pn_dB)
    pndBtemp = pn_dB(i) - maxpn;
    if pndBtemp >= -20
        pndBtemp1 = [pndBtemp1 pndBtemp];
        delayTime = [delayTime i];
    end
end
% delayax = 0.001:0.016:3200;
delayTime = delayTime*(3.2E-12)/200000;
meanDelay = sum(delayTime.*pndBtemp1)/sum(pndBtemp1);
meanDelaySq = sum(delayTime.*delayTime.*pndBtemp1)/sum(pndBtemp1);
rmsDelay = 200000*sqrt(meanDelaySq - meanDelay*meanDelay);
end

   


