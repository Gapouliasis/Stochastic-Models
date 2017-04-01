function STS=PAR1(Tseries,ye,n)
mx=mean(Tseries);
sx=std(Tseries);
m3x=skewness(Tseries).*sx.^3;
%PAR(1) coefficients 
As=zeros(12,1);
len=size(Tseries,1);
c=cov(Tseries(2:len,1),Tseries(1:len-1,12));
As(1)=c(1,2)/var(Tseries(:,12));
for i=2:12
    c=cov(Tseries(:,i),Tseries(:,i-1));
    As(i)=c(1,2)/var(Tseries(:,i-1));
end
Bs=zeros(12,1);
Bs(1)=sqrt(var(Tseries(:,1))-As(1)^2*var(Tseries(:,12)));
for i=2:12
    Bs(i)=sqrt(var(Tseries(:,i))-As(i)^2*var(Tseries(:,i-1)));
end
mv=zeros(1,12);
mv(1)=(mx(1)-As(1)*mx(12))/Bs(1);
for i=2:12
    mv(i)=(mx(i)-As(i)*mx(i-1))/Bs(i);
end

Csv=zeros(1,12);
Csv(1)=(m3x(1)-As(1)^3*m3x(12))/Bs(1)^3;
for i=2:12
    Csv(i)=(m3x(i)-As(i)^3*m3x(i-1))/Bs(i)^3;
end
%Generalized Pareto Distribution 
syms x
K=zeros(1,12);
for i=1:12
    K(i)=vpasolve(2*(1+x)*sqrt(1-2*x)/(1-3*x)==Csv(i),x);
end
K=double(K);
sigma=sqrt((1-K).^2.*(1-2*K));
theta=mv-sigma./(1-K);
K=repmat(K,ye,1);
sigma=repmat(sigma,ye,1);
theta=repmat(theta,ye,1);

STS=zeros(12*ye,n);
for i=1:n
    v=gprnd(K,sigma,theta,ye,12);
    %v=normrnd(mv,1,ye,12);
    temp=zeros(ye,12); 
    temp(1,1)=mx(1);
    for m=2:12
        temp(1,m)=As(m)*temp(1,m-1)+Bs(m)*v(1,m);
    end
    for y=2:ye
        temp(y,1)=As(1)*temp(y-1,12)+Bs(1)*v(y,1);
        for m=2:12
             temp(y,m)=As(m)*temp(y,m-1)+Bs(m)*v(y,m);  
        end
    end
    temp=transpose(temp);
    STS(:,i)=reshape(temp,12*ye,1);
end
STS=max(STS,0);