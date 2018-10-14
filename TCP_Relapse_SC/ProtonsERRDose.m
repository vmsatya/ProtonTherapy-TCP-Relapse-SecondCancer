clc;
clear all;
close all;

Dose = 0:1:50;
K = 30;
lambda = 0.4;
N =  10^6;
r = 0.76;
gammapropor = 0.185;

%------LET = 1

for iii = 1:length(Dose)
    LET = 1;
    alpha = 0.12;   %alpha value taken from Proton LET plot
    D = Dose(iii);
    d = D/K;    
    gamma = gammapropor*0.1307*LET*d*10^(-5); % Number that is a function of d
    gammatemp(iii) = gamma;    
    S = exp(-alpha*d);
    P = exp(-gamma); % since gamma is a function of d, we remove d in this term
    nminus(1) = N;
    nn(1)=N;
    nn(2)=S*P*N;
    m(2) = 0;
    T = 1;    
    for k = 1:K
        k;
        nplus(k) = S*P*nminus(k);
        nn(2*k+1)=nplus(k);
        
        nminus(k+1) = N/(1-exp(-lambda*T)*(1-(N/nplus(k))));
        nn(2*k+2)=nminus(k+1);
        
        m(2*k+1) = S*(m(2*k)+(1-P)*nminus(k));
        mm(2*k+2)=m(2*k+1);
        
        m(2*(k+1)) = m(2*k+1)*((nminus(k+1)/nplus(k))^(r));
        mm(2*k+1)=m(2*k+2);
    end    
    M(iii) = mm(2*K+2)*((N/nplus(K))^(r));
    ERR(iii) = 1.2 * M(iii);
end
hold on
figure(1)
plot(Dose,ERR,'blue')

%------LET = 2

for iii = 1:length(Dose)
    LET = 2;
    alpha = 0.14;   %alpha value taken from Proton LET plot
    D = Dose(iii);
    d = D/K;
    gamma = gammapropor*0.1307*LET*d*10^(-5); % Number that is a function of d
    gammatemp(iii) = gamma;
    S = exp(-alpha*d);
    P = exp(-gamma); % since gamma is a function of d, we remove d in this term
    nminus(1) = N;
    nn(1)=N;
    nn(2)=S*P*N;
    m(2) = 0;
    T = 1;
    for k = 1:K
        k;
        nplus(k) = S*P*nminus(k);
        nn(2*k+1)=nplus(k);       
        nminus(k+1) = N/(1-exp(-lambda*T)*(1-(N/nplus(k))));
        nn(2*k+2)=nminus(k+1);
        m(2*k+1) = S*(m(2*k)+(1-P)*nminus(k));
        mm(2*k+2)=m(2*k+1);
        m(2*(k+1)) = m(2*k+1)*((nminus(k+1)/nplus(k))^(r));
        mm(2*k+1)=m(2*k+2);
    end
    M(iii) = mm(2*K+2)*((N/nplus(K))^(r));
    ERR(iii) = 1.2 * M(iii);
end
plot(Dose,ERR,'r')

%------LET = 3

for iii = 1:length(Dose)
    LET = 3;  
    alpha = 0.16;   %alpha value taken from Proton LET plot
    D = Dose(iii);
    d = D/K;
    gamma = gammapropor*0.1307*LET*d*10^(-5); % Number that is a function of d
    gammatemp(iii) = gamma;
    S = exp(-alpha*d);
    P = exp(-gamma); % since gamma is a function of d, we remove d in this term
    nminus(1) = N;
    nn(1)=N;
    nn(2)=S*P*N;
    m(2) = 0;
    T = 1;
    for k = 1:K
        k;
        nplus(k) = S*P*nminus(k);
        nn(2*k+1)=nplus(k);     
        nminus(k+1) = N/(1-exp(-lambda*T)*(1-(N/nplus(k))));
        nn(2*k+2)=nminus(k+1);
        m(2*k+1) = S*(m(2*k)+(1-P)*nminus(k));
        mm(2*k+2)=m(2*k+1);
        m(2*(k+1)) = m(2*k+1)*((nminus(k+1)/nplus(k))^(r));
        mm(2*k+1)=m(2*k+2);
    end
    M(iii) = mm(2*K+2)*((N/nplus(K))^(r));
    ERR(iii) = 1.2 * M(iii);
end
plot(Dose,ERR,'green')
hold off

