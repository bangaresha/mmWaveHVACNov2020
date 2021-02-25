c=3*10^8;
a = 6.7;
b = 4.9;
f=455*10^6;
lambda = 3*10^8/f;
k = 2*pi/lambda;
WG_len = 0:800;
n_TE_table = [];
m_TE_table = [];
n_TM_table = [];
m_TM_table = [];
fc_TE=[];
fc_TM=[];

for m=1:1000
    fc=(c/2)*sqrt((m/b)^2);
    if fc<=f
        m_TE_table = [m_TE_table m];
        n_TE_table = [n_TE_table 0];
        fc_TE=[fc_TE fc];
    end
end

for m=1:1000
    for n=1:1001
        fc=(c/2)*sqrt((m/a)^2+((n-1)/b)^2);
        if fc<=f
            n_TE_table = [n_TE_table n-1];
            m_TE_table = [m_TE_table m];
            fc_TE=[fc_TE fc];
        end
    end
end

for m=1:1000
    for n=1:1000
        fc=(c/2)*sqrt((m/a)^2+(n/b)^2);
        if fc<=f
            n_TM_table = [n_TM_table n];
            m_TM_table = [m_TM_table m];
            fc_TM =[fc_TM fc];
        end
    end
end

fc_TE = fc_TE';
fc_TM = fc_TM';

m_TE_table = m_TE_table';
n_TE_table = n_TE_table';

m_TM_table = m_TM_table';
n_TM_table = n_TM_table';
x0 = 0.1;
y0 = 0.1;
epsi = 7;
Et = 10;
for i = 1:length(WG_len)
    for p = 1:80
        if rem(m_TE_table(p),2) == 0
            phip = 0;
        else
            phip = pi/2;
        end
        if rem(n_TE_table(p),2) == 0
            phiq = 0;
        else
            phiq = pi/2;
        end
        x = 2*(m_TE_table(p))*a + ((-1)^(m_TE_table(p)))*x0;
        y = 2*(n_TE_table(p))*b + ((-1)^(n_TE_table(p)))*y0;
        A = (sin((((m_TE_table(p))*pi/(2*a))*x + phip)*180/pi))*...
            (sin((((n_TE_table(p))*pi/(2*b))*y + phiq)*180/pi))*...
            (sin((((m_TE_table(p))*pi/(2*a))*x0 + phip)*180/pi))*...
            (sin((((n_TE_table(p))*pi/(2*b))*y0 + phiq)*180/pi));
        alpha = ((1/b)*(((n_TE_table(p))*lambda/(4*b))^2)*(epsi/sqrt(epsi - 1)))+...
            ((1/a)*(((m_TE_table(p))*lambda/(4*a))^2)*(1/sqrt(epsi - 1)));
        beta = sqrt(k*k - (((m_TE_table(p))*pi/(2*a))^2) -...
            (((n_TE_table(p))*pi/(2*b))^2));
        ErVar(p) = (A*exp(-(alpha + 1i*beta)*WG_len(i))/beta);
    end
    Er(i) = (-1i*2*pi*Et/(a*b))*sum(ErVar);
    Pr(i) = 10*log((Er(i))^2);
end
plot(WG_len,Pr);


