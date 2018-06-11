syms s(t)
s(t)=999*1000/(999+(1000-999)*exp(0.5*999*t));
y=zeros(1,50);
r=linspace(0,10,50);
value_s=double(s(r));
for i=1:50
    y(1,i)=random('normal',value_s(1,i),50);
end
y2=999*1000./(999+(1000-999)*exp(r.*0.001*999));
scatter(r,y)
hold on 
plot(r,y2)
hold off

old_beta=rand(1);
lhood=log(prod(normpdf(y,y2,1500)));
acc_beta=[];
for i=1:200000
    new_beta=normrnd(old_beta,0.0001);
    Y_new=999*1000./(999+(1000-999)*exp(r.*new_beta*999));
    Y_old=999*1000./(999+(1000-999)*exp(r.*old_beta*999));
    New_lhood=log(prod(normpdf(y,Y_new,1500)));
    Old_lhood=log(prod(normpdf(y,Y_old,1500)));
    u=rand(1);
    if exp(New_lhood-Old_lhood)>u
        acc_beta=[acc_beta new_beta];
    elseif new_beta<0
            new_beta=rand(1);
            acc_beta=[acc_beta];
    end
    old_beta=new_beta;
end
disp(acc_beta)
histogram(acc_beta)
    
