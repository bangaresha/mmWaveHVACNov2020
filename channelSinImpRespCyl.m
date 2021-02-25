function [channelSinAbs, attSin] = channelSinImpRespCyl(freq,fc_TE,fc_TM,c,m_TE,n_TE,m_TM,n_TM,k,WGlen,radius,Zo,R,eta,l,coWnTE,coWnTM)

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
a1 =       0.2409 ;
a2 =     0.08456;
a3 =     0.02172;
a4 =     0.02062;
for fi=1:length(freq)
     TsTE = diag(gammaTE(fi,:)*WGlen);
     TsTM = diag(gammaTM(fi,:)*WGlen);
     temp1 = ((sum(TEmodeimp(fi,:)*TsTE) + sum(TMmodeimp(fi,:)*TsTM)))*(2.5E-14);
     abstemp1(fi) = abs(temp1);
     imgtemp1(fi) = -1*angle(temp1)*pi/(4.3*180);
     temp2 = (sum(TEmodeimp(fi,:)*(TsTE.^2)) + sum(TMmodeimp(fi,:)*(TsTM.^2)))*(2E-16);
     abstemp2(fi) = abs(temp2);
     imgtemp2(fi) = angle(temp2)*pi/(4.2*180);
     temp3 = (sum(TEmodeimp(fi,:)*(TsTE.^3)) + sum(TMmodeimp(fi,:)*(TsTM.^3)))*(0.4E-17);
     abstemp3(fi) = abs(temp3);
     imgtemp3(fi) = -10*angle(temp3)*pi/(3.75*180);
     temp4 = (sum(TEmodeimp(fi,:)*(TsTE.^4)) + sum(TMmodeimp(fi,:)*(TsTM.^4)))*0.65E-20;
     abstemp4(fi) = abs(temp4);
     imgtemp4(fi) = -5000*angle(temp4)*pi/(3.95*180);
end
b1 = sum(abstemp1);     phi1 = sum(imgtemp1);
b2 = sum(abstemp2);     phi2 = sum(imgtemp2);
b3 = sum(abstemp3);     phi3 = sum(imgtemp3);
b4 = sum(abstemp4);     phi4 = sum(imgtemp4);

%      temp1 = ((sum(TEmodeimp(fi,:)*TsTE) + sum(TMmodeimp(fi,:)*TsTM))*180/pi)+7;
%      temp2 = (sum(TEmodeimp(fi,:)*(TsTE.^2)) + sum(TMmodeimp(fi,:)*(TsTM.^2)))*pi/18000;
%      temp3 = (sum(TEmodeimp(fi,:)*(TsTE.^3)) + sum(TMmodeimp(fi,:)*(TsTM.^3)))*pi/(180*0.473463E4);
%      temp4 = (sum(TEmodeimp(fi,:)*(TsTE.^4)) + sum(TMmodeimp(fi,:)*(TsTM.^4)))*pi/(180*2.94E6);
%      temp5 = (sum(TEmodeimp(fi,:)*(TsTE.^5)) + sum(TMmodeimp(fi,:)*(TsTM.^5)))*pi/(180*1E9);

%     channelSin(fi) = a1*sin(abs(temp1)) + a2*sin(abs(temp2)) + a3*sin(abs(temp3)) + ...
%         a4*sin(abs(temp4)) + a4*sin(temp5);
%      temp1 = sum(TEmodeimp(fi,:).*TsTE) + sum(TMmodeimp(fi,:).*TsTM);
%      temp2 = sum(TEmodeimp(fi,:).*(TsTE.^2)) + sum(TMmodeimp(fi,:).*(TsTM.^2));
%      temp3 = sum(TEmodeimp(fi,:).*(TsTE.^3)) + sum(TMmodeimp(fi,:).*(TsTM.^3));
%      temp4 = sum(TEmodeimp(fi,:).*(TsTE.^4)) + sum(TMmodeimp(fi,:).*(TsTM.^4));
%      temp5 = sum(TEmodeimp(fi,:).*(TsTE.^5)) + sum(TMmodeimp(fi,:).*(TsTM.^5));
%      temp6 = ((antimpTM(fi) + antimpTE(fi)) - temp1 + temp2/2 + temp3/6 + temp4/12 + temp5/60);
%     
%     channelSin(fi) = ((2*Zo)/(abs(antimpTM(fi) + Zo + antimpTE(fi))^2))*1E-11*...
%         ((antimpTM(fi) + antimpTE(fi)) - temp1 + temp2/2 + temp3/6 + temp4/12 + temp5/60);
 
for fi = 1:length(freq)
     channelSin(fi) = a1*sin(b1*freq(fi) + phi1) + ...
         a2*sin(b2*freq(fi) + phi2) + ...
         a3*sin(b3*freq(fi) + phi3) + a4*sin(b4*freq(fi) + phi4);
    
   channelSinAbs(fi) = abs((channelSin(fi))); %smoothdata
%     if channelSinAbs(fi) <= 0.1 || channelSinAbs(fi) >= 0.2
%         channelSinAbs(fi) = 0.15;
%     end
    if isnan(channelSin(fi)) == 1
        channelSin(fi) = 0;
        attSin(fi) = 0;
     else
        attSin(fi) = 10*log10(channelSinAbs(fi));
     end
end
end


   


