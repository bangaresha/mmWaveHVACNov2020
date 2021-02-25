function modePowerCoeffFunc = modePowerCoeff(n_TE,m_TE,n_TM,m_TM,a,b,f,fc)
eta = 377;
pi=3.14;
lambda = 3*10^8/f;
k=2*pi/lambda;
l= 0.0306;
d=0.01:0.01:0.39;
r_TE=0;
r_TM=0;
for di = 1:length(d)
    for n = 1:length(n_TE)
        D_TE_Sq = ((cos(m_TE(n)*l*180/b) - cos(k*l*180/pi))/...
            ((1 - ((m_TE(n)*pi)/(k*b))^2)*k))^2;
        g_TE_Sq = (n_TE(n)*pi/a)^2 + (m_TE(n)*pi/b)^2;
        beta_TE = sqrt(k^2 - g_TE_Sq);
        if n_TE(n)==0
            chi_n=1;
        else
            chi_n=2;
        end
        if m_TE(n)==0
            chi_m=1;
        else
            chi_m=2;
        end
        r_TE_temp = (eta*(pi^2)*D_TE_Sq*chi_n*chi_m*((sin(n_TE(n)*d(di)*180/a))^2)*...
            k*(n_TE(n)^2))/(2*beta_TE*b*g_TE_Sq*((sin(k*l*180/pi))^2)*(a^3));
        r_TE(n,di) = r_TE_temp;
    end
    
    for n = 1:length(n_TM)
        D_TM_Sq = ((cos(m_TM(n)*l*180/b) - cos(k*l*180/pi))/...
            ((1 - ((m_TM(n)*pi)/(k*b))^2)*k))^2;
        g_TM_Sq = (n_TM(n)*pi/a)^2 + (m_TM(n)*pi/b)^2;
        beta_TM = sqrt(k^2 - g_TM_Sq);
        if n_TM(n)==0
            chi_n=1;
        else
            chi_n=2;
        end
        if m_TM(n)==0
            chi_m=1;
        else
            chi_m=2;
        end
%         r_TM_temp = (eta*(pi^2)*(D_TM^2)*chi_n*chi_m*((sin(n_TM(n)*pi*d(di)/a))^2)*...
%             beta_TM*(m_TM(n)^2))/(2*beta_TM*a*(g_TM^2)*((sin(k*l))^2)*(b^3));
        r_TM_temp = (eta*(pi^2)*D_TM_Sq*chi_n*chi_m*((sin(n_TM(n)*d(di)*180/a))^2)*...
            beta_TM*(m_TM(n)^2))/(2*beta_TM*a*g_TM_Sq*((sin(k*l*180/pi))^2)*(b^3));
        r_TM(n,di) = r_TM_temp;
    end
radRes = [(r_TE(:,di))' (r_TM(:,di))'];
%n = count(n_TE) + count(n_TM);
p(di) = max(radRes)/sum(radRes);
end
plot(d,p);
ylim([0,1]);

