clear;
% close all;
c=3*10^8;
radius=0.305/2;
%radius=0.127/2;
% freq = 2.40E9:0.3125E6:2.5E9;
freq = 59E9:4E6:60E9;

load('besDerZerMat.mat');
load('besZerMat.mat');

% for fi=1:length(freq)
%     n_TE1=[];
%     m_TE1=[];
%     fc_TE1=[];
%     coWnTE1=[];
%     for m=1:1001
%         for n=1:1000
%             tt = besDerZerMat(m,n);
%             fc_TE_temp=(c/(2*pi*radius))*besDerZerMat(m,n);
%             if fc_TE_temp <= freq(fi)
%                 n_TE1 = [n_TE1 n];
%                 m_TE1 = [m_TE1 m-1];
%                 fc_TE1 = [fc_TE1 fc_TE_temp];
%                 coWnTE1 = [coWnTE1 besDerZerMat(m,n)/radius];
%             end
%         end
%     end
%     n_TE = (n_TE1)';
%     m_TE = (m_TE1)';
%     fc_TE = (fc_TE1)'; 
%     coWnTE = (coWnTE1)'; 
% end

n_TE = 0;
m_TE = 0;
fc_TE = 0;
coWnTE = 0;
%vc = c*sqrt(1 - (fc_TE/60E9)^2);

fc_TM = (c/(2*pi*radius))*besZerMat(3,17);
m_TM = 3;
n_TM = 17;
coWnTM = besZerMat(3,17)/radius;

%vc = 0.12958E9;
%ta = 25/vc;

% for fi=1:length(freq)
%     n_TM1=[];
%     m_TM1=[];
%     fc_TM1=[];
%     coWnTM1=[];
%     for m=1:1001
%         for n=1:1000
%             fc_TM_temp=(c/(2*pi*radius))*besZerMat(m,n);
%             if fc_TM_temp <= freq(fi)
%                 n_TM1 = [n_TM1 n];
%                 m_TM1 = [m_TM1 m-1];
%                 fc_TM1 = [fc_TM1 fc_TM_temp];
%                 coWnTM1 = [coWnTM1 (besZerMat(m,n))/radius];
%             end
%         end
%     end
%     n_TM = (n_TM1)';
%     m_TM = (m_TM1)';
%     fc_TM = (fc_TM1)';
%     coWnTM = (coWnTM1)';
% end

% fc_TE = fc_TE';
% fc_TM = fc_TM';
% 
% m_TE = m_TE';
% n_TE = n_TE';
% 
% m_TM = m_TM';
% n_TM = n_TM';
% 
% coWnTE = coWnTE';
% coWnTM = coWnTM';

Zo=50;
eta = 377;
l = 0.035;
% l = 0.001;

sigma = 10^6;
mu = 4*pi*10^-7;
R = ((2*pi*freq*mu)./(2*sigma)).^0.5;
k = 2*pi*freq./c;
WGlen = 5;
channel = [];
pn_dB = [];
att = [];

for i = 1:length(WGlen)
    [channelT, attT, totPowerS, meanDelayT, rmsDelayT, pn_dBT] = intraModalDisp(freq,fc_TE,fc_TM,c,m_TE,n_TE,m_TM,n_TM,k,WGlen,radius,Zo,R,eta,l,coWnTE,coWnTM);
%     [channel, att, totPowerS] = intraModalMultipathDisp(freq,fc_TE,fc_TM,c,m_TE,n_TE,m_TM,n_TM,k,WGlenS(i),radius,Zo,R,eta,l,coWnTE,coWnTM);
   channel = [channel; channelT];
    att = [att; attT];
    meanDelay(i) = meanDelayT;
    rmsDelay(i) = rmsDelayT;
    pn_dB = [pn_dB; pn_dBT];
end
delayax = 0.001:0.016:3200;
pdf = pn_dB+30;

figure
plot(delayax, pdf);
title('PDF versus Time');
ylim([-40,0]);
xlim([0.001,600]);

figure
plot(WGlenS, rmsDelay);
title('RMS Delay versus Time');

figure
plot(WGlenS, rmstemp);
title('RMS Delay versus Time');

% cohBW = 1E9./(5*rmsDelay);

cohBWtemp = 1./(5*rmsDelay);

figure
plot(WGlenS, cohBWtemp);
title('Coherence BW versus Time');




