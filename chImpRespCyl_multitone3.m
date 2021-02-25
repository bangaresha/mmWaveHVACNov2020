function [channel, att, sigRssi,totPowerS] = chImpRespCyl_multitone3(freq,fc_TE,fc_TM,c,m_TE,n_TE,m_TM,n_TM,k,WGlen,radius,Zo,R,eta,l,coWnTE,coWnTM)

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
%     for n = 1:length(radresTE(fi,:))
    for n = 1:length(n_TE)
        TEmodeimp(fi,n)=radresTE(fi,n)+1i*radreacTE(fi,n);
    end
%     for n = 1:length(radresTM(fi,:))
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
%     channel(fi) = ((2*Zo)/(abs(antimpTM(fi) + Zo + antimpTE(fi))^2))*...
%         (sum(chTEmode));
    channel(fi) = ((2*Zo)/(abs(antimpTM(fi) + Zo + antimpTE(fi))^2))*...
        (sum(chTEmode)+sum(chTMmode));
    theta(fi) = angle(channel(fi));
    if isnan(channel(fi)) == 1
        channel(fi) = 0;
        att(fi) = 0;
        sigRssi(fi) = 0;
    else
        att(fi) = 10*log10(abs(channel(fi)));
        sigRssi(fi) = att(fi) - 25; %21
    end
    
end

[channelSinAbs, attSin] = channelSinSum(freq,WGlen,gammaTE,gammaTM,TEmodeimp,TMmodeimp);

figure
plot(freq,att,'r-*', freq, attSin, 'k-*');
title('Attenuation versus frequency');

figure
plot(freq,abs(channel),'r-*', freq, channelSinAbs, 'k-*');
title('channel versus frequency');


tempA = [];
for fi = 1:length(freq)
    for k = 0:length(channel)
        if (fi - k) > 0
            tempA = [tempA (channel(fi))*conj(channel(fi - k))];
        end
    end
    Atto(fi) = sum(tempA);
end
autocor = (abs(xcorr(channel,channel))).*(1E9/2.5);

% autoFreq = -100.3126:0.3126:100;
autoFreq = -1000:4:1000;

% figure
% plot(freq,theta);
% title('Channel Phase versus frequency');
% 
% figure
% plot(autoFreq,autocor);
% title('Autocorrelation versus frequency');

% figure
% plot(freq,sigRssi);
% title('RSSI versus frequency');
% 
end

   


