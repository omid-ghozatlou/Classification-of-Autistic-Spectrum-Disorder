clear all
close all
load D:\train.mat 
[m,n]=size(train);
iu=train(:,1:12); %input matrix
ytf=train(:,13:14); %output matrix
[k,h]=size(ytf);
clear train  
N1=n-h;% number of inputs
N2=5;% number of first hidden layer
N3=5;% number of second hidden layer
N4=h;% number of outputs

%wf1=rand(N1,N2);
%wf2=rand(N2,N3);
%wf3=rand(N3,N4);

wf1=0.1*(rand(N1,N2)-0.5);
wf2=0.1*(rand(N2,N3)-0.5);
wf3=0.1*(rand(N3,N4)-0.5);

%wf1=0.01*(rand(N1,N2));
%wf2=0.01*(rand(N2,N3));
%wf3=0.01*(rand(N3,N4));

p=0;%Epoch counter
%load D:\programs\paper5\mfiles\Haberman\mlp2haber.mat
n=0.01;
[c2,c1]=size(iu);
      a=1.7159;
      b=2/3;
for p=(p+1):101     %Epoch counter
   p=p
   eav=0;
   for count=1:c2   % count shows the instance number
      yf2=iu(count,1:N1)*wf1;
      yf2=a*((1-exp(-2*b*yf2))./(1+exp(-2*b*yf2)));
      %%%%%%%%
      yf1=yf2*wf2;
      yf1=a*((1-exp(-2*b*yf1))./(1+exp(-2*b*yf1)));
      %%%%%%%%
      yfh(count,1:N4)=yf1*wf3;
      yfh(count,1:N4)=a*((1-exp(-2*b*yfh(count,1:N4)))./(1+exp(-2*b*yfh(count,1:N4))));
      %%%%%%%%
      e=ytf(count,1:N4)-yfh(count,1:N4);
      
      eav=eav+e.^2;
      %pause
      
   deltay=e*(b/a).*(yfh(count,1:N4)+a).*(a-yfh(count,1:N4)); %Local Gradient
   deltawf3=n*yf1'*deltay; %Delta wf3
   deltayf1=(b/a)*(yf1+a).*(a-yf1).*(deltay*wf3');%Local Gradients
   deltawf2=n*yf2'*deltayf1; %Delta wf2
   deltayf2=(b/a)*(yf2+a).*(a-yf2).*(deltayf1*wf2');%Local Gradient
   deltawf1=n*iu(count,1:N1)'*deltayf2; %Delta wf1
   wf1=wf1+deltawf1;
   wf2=wf2+deltawf2;
   wf3=wf3+deltawf3;
  end
  eav=eav/c2;    % Calculating Mean Square Error
 s(p,1:N4)=eav;  %This matrix store the error for each individual epochs
 'training mean square error for the total estimated output'
 averror=eav     %should be displayed
%averror=10000*eav
if rem(p,10)==0
   save D:\mlp2haber.mat wf1 wf2 wf3 s p iu ytf yfh N1 N2 N3 N4 n;
end
if eav<=1e-4
   break;
end
end
save D:\mlp2haber.mat wf1 wf2 wf3 s p iu ytf yfh N1 N2 N3 N4 n;   










