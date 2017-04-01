function STS=PARSMAF(Tseries,ye,n,H)
mx=mean(Tseries);
sx=std(Tseries);
m3x=skewness(Tseries).*sx.^3;
%SMA coefficients
na=2*ye;
j=-ye:ye;
j=transpose(j);
aj=sqrt((2-2*H))/(3-2*H)*(abs(j+1).^(H+0.5)+abs(j-1).^(H+0.5)-2*abs(j).^(H+0.5));
%PAR(1) coefficients 
sqa=sum(aj.^2);
s3a=sum(aj.^3);
Aj=zeros(12,1);
dj=zeros(12,1);
for i=1:12
    dj(i)=var(Tseries(:,i))/sqa;
end
len=size(Tseries,1);
hj=zeros(12,1);
c=cov(Tseries(2:len,1),Tseries(1:len-1,12));
hj(1)=c(1,2)/sqa;
for i=2:12
    c=cov(Tseries(:,i),Tseries(:,i-1));
    hj(i)=c(1,2)/sqa;
end
Aj(1)=hj(1)/dj(12);
for i=2:12
    Aj(i)=hj(i)/dj(i-1);
end
Bj=zeros(12,1);
Bj(1)=sqrt(dj(1)-Aj(1)^2*dj(12));
for i=2:12
    Bj(i)=sqrt(dj(i)-Aj(i)^2*dj(i-1));
end
mv=zeros(1,12);
ksvj=zeros(1,12);
kswj=zeros(1,12);
for i=1:12
    kswj(i)=m3x(i)/s3a;
end
ksvj(1)=(kswj(1)-Aj(1)^3*kswj(12))/Bj(1)^3;
for i=2:12
    ksvj(i)=(kswj(i)-Aj(i)^3*kswj(i-1))/Bj(i)^3;
end
%Generalized Pareto Distribution 
syms x
K=zeros(1,12);
for i=1:12
    K(i)=vpasolve(2*(1+x)*sqrt(1-2*x)/(1-3*x)==ksvj(i),x);
end
K=double(K);
sigma=sqrt((1-K).^2.*(1-2*K));
theta=mv-sigma./(1-K);
K=repmat(K,3*ye,1);
sigma=repmat(sigma,3*ye,1);
theta=repmat(theta,3*ye,1);

STS=zeros(12*ye,n);
for i=1:n
    v=gprnd(K,sigma,theta,3*ye,12);
    %v=normrnd(mv,1,ye,12);
    X=zeros(ye,12);
    W=zeros(3*ye,12); 
    W(1,1)=v(1,1);
    for m=2:12
        W(1,m)=Aj(m)*W(1,m-1)+Bj(m)*v(1,m);
    end
    for y=2:3*ye
        W(y,1)=Aj(1)*W(y-1,12)+Bj(1)*v(y,1);
        for m=2:12
             W(y,m)=Aj(m)*W(y,m-1)+Bj(m)*v(y,m);  
        end
    end
    for y=1:ye
        for m=1:12
            X(y,m)=sum(aj.*W(y:y+na,m))+mx(m);
        end
    end
    X=transpose(X);
    STS(:,i)=reshape(X,12*ye,1);
end
X=transpose(X);
STS=max(STS,0);
end