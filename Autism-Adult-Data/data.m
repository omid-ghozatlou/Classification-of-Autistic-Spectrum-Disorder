clear all
close all
[M, N, o] =  xlsread('datasets_38367_58429_Toddler Autism dataset July 2018.csv');
[m,n]=size(o);
d1=0;
d2=0;

% o = cell2dataset(o);
O=o(:,19);
O = O(2:end,1);
b = strcmp(O,'Yes');
% X = str2double( b(:,:) );
for k=1:m-1
       if (b(k,1) == 0)
%    if b(k,1)== 'No'
      d1=d1+1;
      class1(d1,1:12)=M(k,2:13);
      class1(d1,13)=1;
      class1(d1,14)=0;
   else
      d2=d2+1;
      class2(d2,1:12)=M(k,2:13);
      class2(d2,13)=0;
      class2(d2,14)=1;
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
test=[class1(fix(0.7*k1)+1:d1,:);class2(fix(0.7*k1)+1:d2,:)];
[m3,n3]=size(train);
d=randperm(m3);
train=train(d,:);
save D:\train.mat train
save D:\test.mat test
