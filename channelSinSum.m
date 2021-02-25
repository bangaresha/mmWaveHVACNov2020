function [channelSinAbs, attSin] = channelSinSum(freq,WGlen,gammaTE,gammaTM,TEmodeimp,TMmodeimp)
a1 = 6.3E-4 ;
a2 = 2.4E-4;
a3 = 2.152E-4;
a4 = 8.855E-5;
for fi=1:length(freq)
    TsTE = diag(gammaTE(fi,:)*WGlen);
    TsTM = diag(gammaTM(fi,:)*WGlen);
    temp1 = ((sum(TEmodeimp(fi,:)*TsTE) + sum(TMmodeimp(fi,:)*TsTM)));
    abstemp1(fi) = abs(temp1); imgtemp1(fi) = angle(temp1);
    temp2 = (sum(TEmodeimp(fi,:)*(TsTE.^2)) + sum(TMmodeimp(fi,:)*(TsTM.^2)));
    abstemp2(fi) = abs(temp2); imgtemp2(fi) = angle(temp2);
    temp3 = (sum(TEmodeimp(fi,:)*(TsTE.^3)) + sum(TMmodeimp(fi,:)*(TsTM.^3)));
    abstemp3(fi) = abs(temp3); imgtemp3(fi) = angle(temp3);
    temp4 = (sum(TEmodeimp(fi,:)*(TsTE.^4)) + sum(TMmodeimp(fi,:)*(TsTM.^4)));
    abstemp4(fi) = abs(temp4); imgtemp4(fi) = angle(temp4);
end

b1 = sum(abstemp1); %*(2.5E-14)
phi1 = sum(imgtemp1); %-1*angle(temp1)*pi/(4.3*180);
b2 = sum(abstemp2);  %*(2E-16)
phi2 = sum(imgtemp2); %angle(temp2)*pi/(4.2*180);
b3 = sum(abstemp3);  %*(0.4E-17)
phi3 = sum(imgtemp3); %-10*angle(temp3)*pi/(3.75*180);
b4 = sum(abstemp4);   %*0.65E-20
phi4 = sum(imgtemp4);   %-5000*angle(temp4)*pi/(3.95*180);

for fi = 1:length(freq)
    channelSin(fi) = a1*sin(b1*freq(fi) + phi1) + ...
        a2*sin(b2*freq(fi) + phi2) + ...
        a3*sin(b3*freq(fi) + phi3) + a4*sin(b4*freq(fi) + phi4);
    channelSinAbs(fi) = abs((channelSin(fi))); %smoothdata
    if isnan(channelSin(fi)) == 1
        channelSin(fi) = 0;
        attSin(fi) = 0;
    else
        attSin(fi) = 10*log10(channelSinAbs(fi));
    end
end
end


   


