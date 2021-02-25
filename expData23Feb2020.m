distance = [60, 80, 100, 120, 140, 160, 180, 200];

%% EVM 

evmNoObs_min = [-11, -7 -10, -6, -8, -10, -4, -9;-12, -8, -11, -5, -6, -10, -6, -10];
evmWiObs_min = [-10, -5, -4, 0, 0, -5, -3, -4; -11, -5, -4, -2, -6, -4, -5, -3];

evmNoObs_avg = [-9.1, -5.5, -8.4, -4.4, -4.3, -3.5, -8, -7.5;-9.6, -6.5, -9.2, -4.1, -4.7, -8.8, -5, -8.4];
evmWiObs_avg = [-8.2, -3.1, -1.0, 0, 0, -1.2, -1.1, -0.03; -9.1, -3.4, -1.2, -0.7, -0.9, -2.4, -2, -2.1];

figure
plot(distance,evmNoObs_avg(1,:),'b-o',distance,evmNoObs_avg(2,:),'r-*');
title('evm versus distance without obstruction');
legend('Tx','Rx');
figure
plot(distance,evmWiObs_avg(1,:),'b-o',distance,evmWiObs_avg(2,:),'r-*');
title('evm versus distance with obstruction');
legend('Tx','Rx');
figure
plot(distance,evmNoObs_avg(1,:),'b-o',distance,evmWiObs_avg(1,:),'r-*');
title('Tx evm versus distance');
legend('Without Obstruction','With Obstruction');
figure
plot(distance,evmNoObs_avg(2,:),'b-o',distance,evmWiObs_avg(2,:),'r-*');
title('Rx evm versus distance');
legend('Without Obstruction','With Obstruction');

%%

%% SNR
snrNoObs_max = [13, 9, 12, 7, 8, 10, 3, 10; 13, 10, 13, 5, 5, 12, 6, 12];
snrWiObs_max = [11, 5, 3, -4, -1, 4, 1, 1; 13, 6, 4, -1, 12, 3, 4, 2];

snrNoObs_avg = [10.8, 6.5, 9.8, 4.1, 3.2, 8.9, 2.1, 8.7; 11.7, 8.7, 11.3, 3.8, 4.0, 10.6, 4.9, 10.2];
snrWiObs_avg = [9.1, 2.4, -5.7, -9.7, -2.3, -2.4, -3.7, -3.9; 11.2, 1.3, -5.1, -4.8, -0.5, -1.2, -0.9, -1.7];

figure
plot(distance,snrNoObs_avg(1,:),'b-o',distance,snrNoObs_avg(2,:),'r-*');
title('snr versus distance without obstruction');
legend('Tx','Rx');
figure
plot(distance,snrWiObs_avg(1,:),'b-o',distance,snrWiObs_avg(2,:),'r-*');
title('snr versus distance with obstruction');
legend('Tx','Rx');
figure
plot(distance,snrNoObs_avg(1,:),'b-o',distance,snrWiObs_avg(1,:),'r-*');
title('Tx snr versus distance');
legend('Without Obstruction','With Obstruction');
figure
plot(distance,snrNoObs_avg(2,:),'b-o',distance,snrWiObs_avg(2,:),'r-*');
title('Rx snr versus distance');
legend('Without Obstruction','With Obstruction');

%%

%% RSSI
rssiNoObs_min = [-61, -74, -60, -75, -74, -65, -73, -65; -72, -75, -72, -73, -72, -74, -72, -65];
rssiWiObs_min = [-74, -76, -76, -77, -76, -76, -76, -75; -72, -77, -74, -76, -76, -76, -75, -76];

rssiNoObs_avg = [-56, -67.4, -59.1, -69.9, -70.7, -63.8, -71.4, -64.5; -57.2, -66.3, -59, -71.7, -71.5, -62.4, -70.7, -63.9];
rssiWiObs_avg = [-63, -71.2, -73.8, -75.2, -73.6, -73, -73.6, -73.9; -61.2, -73, -74.3, -74.4, -72.3, -73.6, -73.4, -73.6];

figure
plot(distance,rssiNoObs_avg(1,:),'b-o',distance,rssiNoObs_avg(2,:),'r-*');
title('rssi versus distance without obstruction');
legend('Tx','Rx');
figure
plot(distance,rssiWiObs_avg(1,:),'b-o',distance,rssiWiObs_avg(2,:),'r-*');
title('rssi versus distance with obstruction');
legend('Tx','Rx');
figure
plot(distance,rssiNoObs_avg(1,:),'b-o',distance,rssiWiObs_avg(1,:),'r-*');
title('Tx rssi versus distance');
legend('Without Obstruction','With Obstruction');
figure
plot(distance,rssiNoObs_avg(2,:),'b-o',distance,rssiWiObs_avg(2,:),'r-*');
title('Rx rssi versus distance');
legend('Without Obstruction','With Obstruction');
%%

%% RCPI
rcpiNoObs_min = [-62, -81, -77, -81, -78, -67, -76, -68; -78, -78, -78, -84, -75, -83, -75, -66];
rcpiWiObs_min = [-79, -84, -85, -85, -86, -86, -85, -83; -77, -85, -84, -82, -82, -83, -85, -82];

rcpiNoObs_avg = [-56.8, -69.5, -59.3, -72.3, -73.9, -65, -75, -66; -57.6, -68, -60.4, -74.5, -74.4, -62.5, -73.3, -64.5];
rcpiWiObs_avg = [-64, -74.3, -80.2, -83, -76.9, -77.7, -78.4, -78.1; -61.9, -75.5, -79.8, -78.8, -75.2, -77.1, -76.7, -77.1];

figure
plot(distance,rcpiNoObs_avg(1,:),'b-o',distance,rcpiNoObs_avg(2,:),'r-*');
title('rcpi versus distance without obstruction');
legend('Tx','Rx');
figure
plot(distance,rcpiWiObs_avg(1,:),'b-o',distance,rcpiWiObs_avg(2,:),'r-*');
title('rcpi versus distance with obstruction');
legend('Tx','Rx');
figure
plot(distance,rcpiNoObs_avg(1,:),'b-o',distance,rcpiWiObs_avg(1,:),'r-*');
title('Tx rcpi versus distance');
legend('Without Obstruction','With Obstruction');
figure
plot(distance,rcpiNoObs_avg(2,:),'b-o',distance,rcpiWiObs_avg(2,:),'r-*');
title('Rx rcpi versus distance');
legend('Without Obstruction','With Obstruction');
%%

%% data rate
dataNoObs_max = [560.36, 560.36, 560.36, 559.70, 560.03, 554, 560, 537; 560.36, 560.36, 560.03, 559.70, 559.70, 556.7, 559.7, 447];
dataWiObs_max = [558.7, 555.07, 517.7, 75.13, 75.13, 543, 498, 364; 560.36, 556.72, 520.36, 0, 99.95, 543, 410.9, 75];

% dataNoObs_avg = [543.4, 542, 541.6, 538.8, 539, 543, 498, 364; 483, 541.2, 540.7, 540, 540.5];
% dataWiObs_avg = [526.8, 330.6, 109, 42, 66.1; 525.4, 322.2, 72, 0, 0.27];

figure
plot(distance,dataNoObs_max(1,:),'b-o',distance,dataNoObs_max(2,:),'r-*');
title('data rate versus distance without obstruction');
legend('Tx','Rx');
figure
plot(distance,dataWiObs_max(1,:),'b-o',distance,dataWiObs_max(2,:),'r-*');
title('data rate versus distance with obstruction');
legend('Tx','Rx');
figure
plot(distance,dataNoObs_max(1,:),'b-o',distance,dataWiObs_max(1,:),'r-*');
title('Tx data rate versus distance');
legend('Without Obstruction','With Obstruction');
figure
plot(distance,dataNoObs_max(2,:),'b-o',distance,dataWiObs_max(2,:),'r-*');
title('Rx data rate versus distance');
legend('Without Obstruction','With Obstruction');
