function Climacogram(Tseries)
nk=round(length(Tseries)/10);
k=1:nk;
sk=zeros(nk,1);
for i=1:nk
    e=fix(length(Tseries)/i);
    temp=zeros(e,1);
    for j=1:e
        temp(j)=mean(Tseries((j-1)*i+1:j*i));
    end
    sk(i)=std(temp);
end
lnk=transpose(log(k));
lnsk=log(sk);
f=fit(lnk,lnsk,'poly1');
coeffvals = coeffvalues(f);
H=1-abs(coeffvals(1));
figure(1)
plot(lnk,lnsk,'.')
hold on
plot(lnk,f(lnk),'g')
a=num2str(H);
text(lnk(2),f(lnk(2)),a);
end