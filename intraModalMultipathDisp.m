function [channel, att, totPowerS] = intraModalMultipathDisp(freq,fc_TE,fc_TM,c,m_TE,n_TE,m_TM,n_TM,k,WGlen,radius,Zo,R,eta,l,coWnTE,coWnTM)

[radresTE, radresTM, gammaTE, gammaTM] = radResCyl_multitone(m_TE,n_TE,m_TM,n_TM,radius,freq,fc_TE,fc_TM,c,k,R,eta,l,coWnTE,coWnTM);

radreacTE = imag(hilbert(radresTE));
radreacTM = imag(hilbert(radresTM));
L1=0.3;
L2=0.3;
refCoff1n=-0.9;
refCoff2n=-0.9;

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
    chTEmode = TEmodeimp(fi,:).*(1+refCoff1n*exp(-2*gammaTE(fi,:)*L1))...
        .*(1+refCoff2n*exp(-2*gammaTE(fi,:)*L2))./...
        (1-refCoff1n*refCoff2n*exp(-2*gammaTE(fi,:)*(WGlen+L1+L2)));
    
    TsTM = diag(exp(-1*gammaTM(fi,:)*WGlen));
    chTMmode = TMmodeimp(fi,:)*TsTM;
    totPowerS(fi) = 2*(sum(sum(TsTE)) + sum(sum(TsTM)));
    channel(fi) = ((2*Zo)/(abs(Zo + antimpTE(fi))^2))*...
        (sum(chTEmode));
%     channel(fi) = ((2*Zo)/(abs(antimpTM(fi) + Zo + antimpTE(fi))^2))*...
%         (sum(chTEmode)+sum(chTMmode));

    if isnan(channel(fi)) == 1
        channel(fi) = 0;
        att(fi) = 0;
    else
        att(fi) = 10*log10(abs(channel(fi)));
    end
end

channelTime = ifft(abs(channel),2000);
absChannel = abs(channel);

temp = 0;
for i = 1:length(channelTime)
    channel_dB(i) = 10*log10((abs(channelTime(i))));
    pn_dB(i) = (10*log10((abs(channelTime(i)))^2));
    pn(i) = (abs((channelTime(i)))^2)*1E7;
    temp = temp + (pn(i))*i;
end

denSum = sum(pn);
meanDelay = sqrt(temp/denSum);
temp2 = 0;
for i = 1:length(channelTime)
    temp2 = temp2 + (pn(i))*((i - meanDelay)^2);
end
rmsDelay = (abs(sqrt(temp2/denSum)))*3.5E-2;
% rmsDelay = ((abs(sqrt(temp2/denSum)))*1E-5)+(41E-9);

figure 
plot(1:length(pn_dB),pn_dB);
ylim([-40,0]);
end

   


