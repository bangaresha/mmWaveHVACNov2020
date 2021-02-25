distance = [1, 2, 3, 4, 5, 6, 7, 8, 9];

evm = [-9, -9, -9, -8, -7.5, -7, -6, -5, -4];
snr = [12, 12, 11, 8, 7, 7, 6, 5, 5];
rssi = [-54, -58, -60, -62, -67, -67, -68, -69, -69];
rcpi = [-55, -59, -61, -62, -68, -69, -70, -72, -72];
bitrate = [1010, 995, 980, 964, 560, 560, 559, 551, 548];

figure
plot(distance,evm,'r-*');
title('EVM versus distance');

figure
plot(distance,snr,'b-o');
title('SNR versus distance');

figure
plot(distance,rssi,'k-*');
title('RSSI versus distance');

figure
plot(distance,bitrate,'r-o');
title('Bit Rate versus distance');

