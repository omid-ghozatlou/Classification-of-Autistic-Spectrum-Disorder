%% Train
load D:\train2.mat 
[m,n]=size(train2);
iu=train2(:,1:12);
ytf=train2(:,13:14);
[k,h]=size(ytf);
clear train2
N1=n-h;
N2=5;
N3=5;
N4=5;
N5=h;
wf1=0.1*(rand(N1,N2)-0.5);
wf2=0.1*(rand(N2,N3)-0.5);
wf3=0.1*(rand(N3,N4)-0.5);
wf4=0.1*(rand(N4,N5)-0.5);
p=0;
n=0.01;
[c2,c1]=size(iu);
a=1.7159;
b=2/3;
for p=(p+1):1001
p=p
eav=0;
for count=1:c2
    yf3=iu(count,1:N1)*wf1;
    yf3=a*((1-exp(-2*b*yf3))./(1+exp(-2*b*yf3)));
    yf2=yf3*wf3;
    yf2=iu(count,1:N1)*wf1;
    yf2=a*((1-exp(-2*b*yf2))./(1+exp(-2*b*yf2)));
    yf1=yf2*wf2;
    yf1=a*((1-exp(-2*b*yf1))./(1+exp(-2*b*yf1)));
    yfh(count,1:N5)=yf1*wf4;
    yfh(count,1:N5)=a*((1-exp(-2*b*yfh(count,1:N5)))./(1+exp(-2*b*yfh(count,1:N5))));
    e=ytf(count,1:N5)-yfh(count,1:N5);
    eav=eav+e.^2;
    deltay=e*(b/a).*(yfh(count,1:N5)+a).*(a-yfh(count,1:N5));
    deltawf4=n*yf1'*deltay;
    deltayf1=(b/a)*(yf1+a).*(a-yf1).*(deltay*wf4');
    deltawf2=n*yf2'*deltayf1;
    deltayf2=(b/a)*(yf2+a).*(a-yf2).*(deltayf1*wf2');
    deltawf3=n*yf3'*deltayf2;
    deltayf3=(b/a)*(yf3+a).*(a-yf3).*(deltayf2*wf3);
    deltawf1=n*iu(count,1:N1)'*deltayf2;
    wf1=wf1+deltawf1;
    wf2=wf2+deltawf2;
    wf3=wf3+deltawf3;
    wf4=wf4+deltawf4;
end
eav=eav/c2;
s(p,1:N5)=eav
if rem(p,10)==0
    save D:\train2.mat wf1 wf2 wf3 wf4 s p iu ytf yfh N1 N2 N3 N4 N5 n;
end
if eav<=1e-4
break;
end
end
save D:\train2.mat wf1 wf2 wf3 wf4 s p iu ytf yfh N1 N2 N3 N4 N5 n;
