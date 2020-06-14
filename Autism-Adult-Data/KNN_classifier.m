%% tamrin4

sample=test(:,1:13);
training=train(:,1:13);
group=train(:,14);
class=knnclassify(sample,training,group,2);
tp1=0;
tn1=0;
fn1=0;
fp1=0;
d=test(:,13)-class;
for n=1:135
if d(n,1)==0
if test(n,13)==0
tp1=tp1+1;
else
tn1=tn1+1;
end
elseif d(n,1)==1
fn1=fn1+1;
else
fp1=fp1+1;
end
end
sensitiviry1=100*(tp1/(tp1+fn1))
specificity1=100*(tn1/(tn1+fp1))
acc1=100*((tp1+tn1)/(tp1+tn1+fp1+fn1))



