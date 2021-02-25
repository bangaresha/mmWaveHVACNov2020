clear;
tic
% close all;
c=3*10^8;
radius=0.305/2;
% radius=0.127/2;
freq = 2.40E9:0.3125E6:2.5E9;
% freq = 59E9:4E6:60E9;

load('besDerZerMat.mat');
load('besZerMat.mat');

for fi=1:length(freq)
    n_TE1=[];
    m_TE1=[];
    fc_TE1=[];
    coWnTE1=[];
    for m=1:1001
        for n=1:1000
            tt = besDerZerMat(m,n);
            fc_TE_temp=(c/(2*pi*radius))*besDerZerMat(m,n);
            if fc_TE_temp <= freq(fi)
                n_TE1 = [n_TE1 n];
                m_TE1 = [m_TE1 m-1];
                fc_TE1 = [fc_TE1 fc_TE_temp];
                coWnTE1 = [coWnTE1 besDerZerMat(m,n)/radius];
            end
        end
    end
    n_TE = (n_TE1)';
    m_TE = (m_TE1)';
    fc_TE = (fc_TE1)'; 
    coWnTE = (coWnTE1)'; 
end

for fi=1:length(freq)
    n_TM1=[];
    m_TM1=[];
    fc_TM1=[];
    coWnTM1=[];
    for m=1:1001
        for n=1:1000
            fc_TM_temp=(c/(2*pi*radius))*besZerMat(m,n);
            if fc_TM_temp <= freq(fi)
                n_TM1 = [n_TM1 n];
                m_TM1 = [m_TM1 m-1];
                fc_TM1 = [fc_TM1 fc_TM_temp];
                coWnTM1 = [coWnTM1 (besZerMat(m,n))/radius];
            end
        end
    end
    n_TM = (n_TM1)';
    m_TM = (m_TM1)';
    fc_TM = (fc_TM1)';
    coWnTM = (coWnTM1)';
end

fc_TE = fc_TE';
fc_TM = fc_TM';

m_TE = m_TE';
n_TE = n_TE';

m_TM = m_TM';
n_TM = n_TM';

coWnTE = coWnTE';
coWnTM = coWnTM';

Zo=50;
eta = 377;
l = 0.035;
% l = 0.001;

sigma = 10^6;
mu = 4*pi*10^-7;
R = ((2*pi*freq*mu)./(2*sigma)).^0.5;
k = 2*pi*freq./c;
% WGlenS = 1:1:10;
WGlenS = 8;
channel = [];
pn_dB = [];
att = [];
cdfp = [];
meanCDF = [];
varCDF = [];

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

for i = 1:length(WGlenS)
%     [channelT, attT, totPowerS, theta, meanDelayT, rmsDelayT, pn_dBT] = totalDisp(freq,fc_TE,fc_TM,c,m_TE,n_TE,m_TM,n_TM,k,WGlenS(i),radius,Zo,R,eta,l,coWnTE,coWnTM);
    [channelT, attT, totPowerS, theta,meanDelayT, rmsDelayT, pn_dBT] = interModalDisp2(antimpTE,antimpTM,gammaTE,gammaTM,TEmodeimp,TMmodeimp,freq,WGlenS(i),Zo);
    channel = [channel; channelT];
    att = [att; attT];
    meanDelay(i) = meanDelayT;
    rmsDelay(i) = rmsDelayT;
    pn_dB = [pn_dB; pn_dBT];
    attB = attT(attT ~= 0);
    meanCDF = [meanCDF mean(attB)];
    varCDF = [varCDF var(attB)];
end
cdfxx = -36:0.5:-31.5;
pd = fitdist(meanCDF','Normal');
figure
cdfplot(meanCDF)
hold on
cdfpT = cdf(pd,cdfxx);
plot(cdfxx,cdfpT);

figure
pdfPT = pdf(pd,cdfxx);
plot(cdfxx,pdfPT,'LineWidth',2)
    
cdfVarx = 1.75:0.25:4;
pdVar = fitdist(varCDF','Normal');
figure
cdfplot(varCDF)
hold on
cdfVarpT = cdf(pdVar,cdfVarx);
plot(cdfVarx,cdfVarpT);

chAtVsDis = acons.*exp(bcons.*WGlenS);
   
figure
plot(WGlenS,meanCDF);
hold on
plot(WGlenS,chAtVsDis);
    
    

delayax = 0.001:0.016:3200;
pdf = pn_dB+50;

figure
plot(delayax, pdf);
title('PDF versus Time');
% ylim([-45,0]);
% xlim([0.001,2000]);

% figure
% plot(delayax, [pdf(1:150000) -60*ones(1,50000)]);
% title('PDF versus Time');
% ylim([-45,0]);
% xlim([0.001,2000]);

figure
plot(WGlenS, rmsDelay);
title('RMS Delay versus Time');

% figure
% plot(refCoff1n, rmsTemp);
% title('RMS Delay versus Reflection Coefficient');


% figure
% plot(WGlenS, rmstemp);
% title('RMS Delay versus Time');

% cohBW = 1E9./(5*rmsDelay);

cohBWtemp = 1./(5*rmsDelay);

figure
plot(WGlenS, cohBWtemp);
title('Coherence BW versus Time');

%pd = fitdist(B','Normal');
% ecdf(B,'Bounds','on')
% hold off
%pd = makedist('Normal');
%x = -3:.1:0;
toc
