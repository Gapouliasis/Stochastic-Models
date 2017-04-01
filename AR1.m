function STS=AR1(Tseries,ye,n)
mx=mean(Tseries);
sx=std(Tseries);
Csx=skewness(Tseries);
a=corr(Tseries(1:size(Tseries,1)-1),Tseries(2:size(Tseries,1)));
mv=(1-a)*mx;
sv=sx*sqrt(1-a^2);
Csv=Csx*sx^3*(1-a^3)/sv^3;
%Generalized Pareto Distribution 
syms x
K=vpasolve(2*(1+x)*sqrt(1-2*x)/(1-3*x)==Csv,x);
K=double(K);
sigma=sqrt(sv^2*(1-K)^2*(1-2*K));
theta=mv-sigma/(1-K);

STS=zeros(ye,n);
for i=1:n
    X=zeros(ye,1);
    v=gprnd(K,sigma,theta,ye,1);
    X(1)=v(1);
    for j=2:ye
        X(j)=a*X(j-1)+v(j);
    end
    STS(:,i)=max(X,0);
end
end