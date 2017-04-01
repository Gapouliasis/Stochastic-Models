function STS=SMA(Tseries,ye,n,H)
na=2*ye;
j=-na/2:na/2;
j=transpose(j);
aj=sqrt((2-2*H)*var(Tseries))/(3-2*H)*(abs(j+1).^(H+0.5)+abs(j-1).^(H+0.5)-2*abs(j).^(H+0.5));
mx=mean(Tseries);
vx=var(Tseries);
Csx=skewness(Tseries);
mv=mx/sum(aj);
sv=sqrt(vx/sum(aj.^2));
Csv=Csx*vx^(3/2)/(sum(aj.^3));

%Generalized Pareto Distribution 
syms x
K=vpasolve(2*(1+x)*sqrt(1-2*x)/(1-3*x)==Csv,x);
K=double(K);
sigma=sqrt(sv^2*(1-K)^2*(1-2*K));
theta=mv-sigma/(1-K);


STS=zeros(ye,n); %Synthetic Time Series
for j=1:n
    v=gprnd(K,sigma,theta,ye+na+1,1);
    for i=1:ye
        STS(i,j)=sum(aj.*v(i:i+na));
    end
end
STS=max(STS,0);
end