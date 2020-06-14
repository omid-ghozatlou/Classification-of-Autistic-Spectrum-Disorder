clear all
close all
load D:\mlp2haber.mat
clear iu ytf yfh
load D:\test.mat 
inp=test;
[m,n]=size(inp);
iu=inp(:,1:12);
ytf=inp(:,13:14);
[k,h]=size(ytf);
clear test  
[c2,c1]=size(iu);
      a=1.716;
      b=2/3;
      eav=0;
  for count=1:c2
      yf2=iu(count,1:N1)*wf1;
      yf2=a*((1-exp(-2*b*yf2))./(1+exp(-2*b*yf2)));
      yf1=yf2*wf2;
      yf1=a*((1-exp(-2*b*yf1))./(1+exp(-2*b*yf1)));
      yfh(count,1:N4)=yf1*wf3;
      yfh(count,1:N4)=a*((1-exp(-2*b*yfh(count,1:N4)))./(1+exp(-2*b*yfh(count,1:N4))));
      e=ytf(count,1:N4)-yfh(count,1:N4);
      eav=eav+e.^2;

  end
  eav=eav/c2;
 'testing mean square error for the total estimated output'
 averror=eav   %should be displayed
%pause
for n=1:c2
    [m,k]=max(yfh(n,:));
    yfh(n,:)=zeros(1,2);
    yfh(n,k)=1;
end
%pause
TP1=0;
TN1=0;
FP1=0;
FN1=0;
d=ytf-yfh;
%pause
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

    
    

      