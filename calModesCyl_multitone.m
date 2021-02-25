clear;
close all;
c=3*10^8;
% radius=0.305/2;
radius=0.127/2;
% freq = 2.40E9:0.3125E6:2.5E9;
%freq = 2.40E9:0.8E7:2.5E9;
freq = 59.4E9:1E7:60.4E9;
omega = 2*pi*freq;

load('besDerZerMat5k.mat');
load('besZerMat5k.mat');

% for i=1:1000
%     besZerMat2(i,:) = besselzero(i,1000);
%     besDerZerMat2(i,:) = BessDerivZerosBisect2(i,1:1000,10^-3);
%     besDerZerMat0(i,:) = BessDerivZerosBisect2(0,i,10^-3);
% end
% besZerMat0 = besselzero(0,1000);
% besZerMat = [besZerMat0' besZerMat2]';
% besDerZerMat = [besDerZerMat0'; besDerZerMat2];

% for i=1:5000
%     besZerMat2(i,:) = besselzero(i,5000);
%     besDerZerMat2(i,:) = BessDerivZerosBisect2(i,1:5000,10^-3);
%     besDerZerMat0(i,:) = BessDerivZerosBisect2(0,i,10^-3);
% end
% besZerMat0 = besselzero(0,5000);
% besZerMat = [besZerMat0' besZerMat2]';
% besDerZerMat = [besDerZerMat0'; besDerZerMat2];

for fi=1:length(freq)
    n_TE=[];
    m_TE=[];
    fc_TE=[];
    coWnTE=[];
    for m=1:5001
        for n=1:5000
            tt = besDerZerMat(m,n);
            fc_TE_temp=(c/(2*pi*radius))*besDerZerMat(m,n);
            if fc_TE_temp <= freq(fi)
                n_TE = [n_TE n];
                m_TE = [m_TE m-1];
                fc_TE = [fc_TE fc_TE_temp];
                coWnTE = [coWnTE besDerZerMat(m,n)/radius];
            end
        end
    end
%     n_TE = (n_TE1)';
%     m_TE = (m_TE1)';
%     fc_TE = (fc_TE1)'; 
%     coWnTE = (coWnTE1)'; 
end

for fi=1:length(freq)
    n_TM=[];
    m_TM=[];
    fc_TM=[];
    coWnTM=[];
    for m=1:5001
        for n=1:5000
            fc_TM_temp=(c/(2*pi*radius))*besZerMat(m,n);
            if fc_TM_temp <= freq(fi)
                n_TM = [n_TM n];
                m_TM = [m_TM m-1];
                fc_TM = [fc_TM fc_TM_temp];
                coWnTM = [coWnTM (besZerMat(m,n))/radius];
            end
        end
    end
%     n_TM = (n_TM1)';
%     m_TM = (m_TM1)';
%     fc_TM = (fc_TM1)';
%     coWnTM = (coWnTM1)';
end

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
% l = 0.0306;
l = 0.001;
sigma = 10^6;
mu = 4*pi*10^-7;
R = ((2*pi*freq*mu)./(2*sigma)).^0.5;
k = 2*pi*freq./c;
% WGlenS = 6.1;
% 
% for i = 1:length(WGlenS)
%     [channel, attS, sigRssiS,totPowerS] = chImpRespCyl_multitone3(freq,fc_TE,fc_TM,c,m_TE,n_TE,m_TM,n_TM,k,WGlenS(i),radius,Zo,R,eta,l,coWnTE,coWnTM);
%     %[channelSin, attSin] = channelSinImpRespCyl(freq,fc_TE,fc_TM,c,m_TE,n_TE,m_TM,n_TM,k,WGlenS,radius,Zo,R,eta,l,coWnTE,coWnTM);
%     %channel2 = chImpRespSinu(freq,channel);
% end
% channelAbs = abs(channel);
% 
% figure
% plot(freq,attS,'r-*',freq,attSin,'k-*');
% % plot(freq,attS,'r-*',freq,quantizenumeric(attSin,1,16,13,'fix'),'k-*');
% title('Attenuation versus frequency');
% 
% figure
% plot(freq,channelAbs,'r-*',freq,channelSin,'k-*');
% title('Channel versus frequency');

% figure
% subplot(4,1,1);
% plot(freq,Rssi60(1,:))
% subplot(4,1,2); 
% plot(freq,Rssi60(2,:))
% subplot(4,1,3); 
% plot(freq,Rssi60(3,:))
% subplot(4,1,4); 
% plot(freq,Rssi60(4,:))

% WGlenB=3.05;
% Rb = 0.45;
phiB = [45 90 0 180];
% phiB = 135;
kn = 4;
%kn = 2;
WGlenB=4;
Rb = 0.05;
attT = [];
sigRssiT = [];
[radresTES, radresTMS, gammaTES, gammaTMS] = radResCyl_multitone(m_TE,n_TE,m_TM,n_TM,radius,freq,fc_TE,fc_TM,c,k,R,eta,l,coWnTE,coWnTM);

[radresTEB, radresTMB, gammaTEB, gammaTMB] = radResBend(m_TE,n_TE,m_TM,n_TM,radius,freq,c,k,R,eta,l,coWnTE,coWnTM,Rb);

for i = 1:length(phiB)
    [channel, att, sigRssi,totPowerB] = chImpRespStrBend2(freq,WGlenB,Zo,Rb,phiB(i),radresTES,radresTMS,gammaTES,gammaTMS,radresTEB,radresTMB,gammaTEB,gammaTMB);
    attT = [attT; att];
    sigRssiT = [sigRssiT; sigRssi];
end

figure
plot(freq,sigRssiT(1,:),'k-*',freq,sigRssiT(2,:),'r-o',freq,sigRssiT(3,:),'b-d',freq,sigRssiT(4,:),'g-s');
title('RSSI versus frequency Bend');

figure
plot(freq,attT(1,:),'k-*',freq,attT(2,:),'r-o',freq,attT(3,:),'b-d',freq,attT(4,:),'g-s');
title('Attenuation versus frequency');

% snr = 0:5:30;
% % bw = 1E8;
% bw = 1E9;
% seProb = 10E-5;
% % fgap = 0.3125E6;
% fgap = 4E6;

%errorStats = powerDelayProf(channel);
%rate = rateCalcCyl16QAM(bw,snr,real(channel),seProb,kn,fgap);

% figure
% plot(freq,log(totPowerS),'*-',freq,log(totPowerB),'o-');
% title('total modal power versus freq');
% 
% figure
% plot(freq,log(totPowerS-totPowerB));
% title('total modal power versus freq2');

%rate = rateCalcCylBpsk(bw,snr,channel,seProb,fgap);
