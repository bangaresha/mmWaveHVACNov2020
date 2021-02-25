function [channel2] = chImpRespSinu(freq,channel)

%channelMean = sum(channel)/length(freq);
%Amp = max(abs(channel));

fun = @(x,freq) x(1)*sin(x(2)*freq + x(3)) + x(4)*sin(x(5)*freq + x(6)) + ...
    x(7)*sin(x(8)*freq + x(9)) + x(10)*sin(x(11)*freq + x(12));

%f0 = 1E-9; phi0 = 0.1;
x0 = [0.00058,3.6E-9,1.721,0.0002414,6.233E-9,4.597,0.0001767,4.385E-8,6.417,0.0001,1.888E-8,.6835];
% x0 = [0.0005529,0.6626,1.704,0.0001732,1.343,-1.388,0.0001849,12.2,1.453,3.926e-05,5.969,...
%     -0.4814,-2.171e-05,2.867,1.907];
options = optimoptions('lsqcurvefit','StepTolerance',1E-12,'MaxFunctionEvaluations',1E5,'MaxIterations',1E3);
lb = [];
ub = [];
x = lsqcurvefit(fun,x0,freq,abs(channel),lb,ub,options);
channel2 = x(1)*sin(x(2)*freq + x(3)) + x(4)*sin(x(5)*freq + x(6)) + ...
    x(7)*sin(x(8)*freq + x(9)) + x(10)*sin(x(11)*freq + x(12));
%channel2 = Amp*sin(x(1)*(freq + x(2))) + channelMean;
figure
plot(freq,abs(channel),'r-*',freq,abs(channel2),'k-*')

end

   


