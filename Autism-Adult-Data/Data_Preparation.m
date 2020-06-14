close all
clear all
[a, N, o] =  xlsread('datasets_38367_58429_Toddler Autism dataset July 2018.csv');
[m,n]=size(a);
mau=max(abs(a));
for k=1:m
a(k,1:12)=a(k,1:12)./mau(1,1:12);
end
O=o(:,19);
O = O(2:end,1);
b = strcmp(O,'Yes');
d1=0;
d2=0;
for k=1:m-1
if (b(k,1) == 0)
    d1=d1+1;
class1(d1,1:12)=a(k,1:12);
class1(d1,13)=0;
class1(d1,14)=1;
else 
d2=d2+1;
class2(d2,1:12)=a(k,1:12);
class2(d2,13)=1;
class2(d2,14)=0;
end
end
d=randperm(d1);
d=d';
class1=class1(d,:);
d=randperm(d2);
d=d';
class2=class2(d,:);
[k1,k2]=min([d1 d2]);
train=[class1(1:fix(0.7*k1),:);class2(1:fix(0.7*k1),:)];
test2=[class1(fix(0.7*k1)+1:d1,:);class2(fix(0.7*k1)+1:d2,:)];
[m3,n3]=size(train);
d=randperm(m3);
train2=train(d,:);
save D:\train2.mat train2
save D:\test2.mat test2














