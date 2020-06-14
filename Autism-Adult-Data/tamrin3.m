
%% train
close all
load D:\train2.mat
[m,n]=size(train2);
iu=train2(:,1:12);
ytf=train2(:,13:14);
[k,h]=size(ytf);
w=rand(1,12);
p=0;
sigmainv=rand(1,12);
for l=1:12;
    t(1,l)=sum(train2(:,l)/260);
end
for p=1:100 %epochs
    p=p
    for i=1:m
    f=0;
    g=exp(-sigmainv(1:12).*(train2(i,1:12)-t(1:12))*(train2(i,1:12)-t(1:12))');
        for j=1:12
        f=f+(w(1,j)*g);
        f=f;
        yfh(i,1:2)=f;
        e=ytf(i,1:2)-yfh(i,1:2);
        dew=e*g;
        det=e*(g*(1/sum((abs(train2(i,1:12)-t(1:12))))));
        des=e*(g*(train2(i,1:12)-t(1:12))*(train2(i,1:12)-t(1:12))');
        end
    dew=sum(dew);
    det=2*w(1,1:12).*sum(des);
    e=1/2*(sum(e(1,1:2)).^2)
    w(1,1:12)=w(1,1:12)-dew;
    t(1,1:12)=t(1,1:12)-det;
    sigmainv(1,1:12)=sigmainv(1,1:12)-max(des);
    i=i+1;
    end
        if e<1e-4
        break;
        end
end





%% test 
load D:\test2.mat
close all
inp=test2;
[m,n]=size(inp);
iu=inp(:,1:12);
ytf=inp(:,13:14);
[k,h]=size(ytf);
[c2,c1]=size(iu);
f=0;
for i=1:m
    f=0
    g=exp(-sigmainv(1:12).*(test2(i,1:12)-t(1:12))*(test2(i,1:12)-t(1:12))');
    for j=1:12
    f=f+(w(1,j)*g);
    end
    f=f;
    yfh(i,1:2)=f;
    e=ytf(i,1:2)-yfh(i,1:2);
    dew=e*g;
    det=e*(g*(1/sum((abs(test2(i,1:12)-t(1:12))))));
    des=e*(g*(test2(i,1:12)-t(1:12))*(test2(i,1:12)-t(1:12))');
    end
    for n=1:c2
    if yfh(n,1)>1
    yfh(n,1)=1;
    else
    yfh(n,1)=0;
    end
end
tp1=0;
tn1=0;
fp1=0;
fn1=0;
d=ytf(:,1)-yfh(:,1);
for n=1:c2
    if abs(d(n,1))==0
         if ytf(n,1)==1
            tp1=tp1+1;
         elseif ytf(n,1)==0
           tn1=tn1+1;
         end
    elseif d(n,1)==1
        fn1=fn1+1;
    else
        fp1=fp1+1;
    end
end
sensitivity1=100*(tp1/(tp1+fn1))
specificity1=100*(tn1/(tn1+fp1))
acc1=100*((tp1+tn1)/(tp1+tn1+fp1+fn1))


