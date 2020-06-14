%% Test


close all
clear all
load D:\train2.mat 
clear iu ytf yfh
load D:\test2.mat
inp=test2;
[m,n]=size(inp);
iu=inp(:,1:12);
ytf=inp(:,13:14);
[k,h]=size(ytf);
clear test
[c2,c1]=size(iu);
a=1.716
b=2/3;
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
end
eav=eav/c2;
averror=eav
for n=1:c2
[m,k]=max(yfh(n,:));
Yfh(n,:)=zeros(1,2);
Yfh(n,k)=1;
end
TP1=0;
TN1=0;
FP1=0;
FN1=0;
d=ytf-yfh;
for n=1:c2
if sum(abs(d(n,:))==0)
if ytf(n,1)==1
TP1=TP1+1;
else
TN1=TN1+1;
end
elseif d(n,1)>0
FN1=FN1+1;
else
FP1=FP1+1;
end
end
SENSITIVITY1=100*(TP1/(TP1+FN1))
SPECIFICITY1=100*(TN1/(TN1+FP1))
ACC1=100*((TP1+TN1)/(TP1+TN1+FP1+FN1))



