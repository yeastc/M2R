% generating our artificial data
X = 1:20;
Y = zeros(1,20);
for i =1:20
    Y(i) = poisspdf(X(i),6)+0.01*normrnd(0,1);
end
Y2 = poisspdf(X,6);

% calculating P(B) using our initial beta
init_beta = randi(10);
Old_Lhood = log(prod(normpdf(Y,Y2,.1)));
acc_betas = [];

for i = 1:5000
    new_beta = randi(10);
    Y_new = poisspdf(X,new_beta);
    New_Lhood = log(prod(normpdf(Y,Y_new,.1)));
    if New_Lhood - Old_Lhood > log(rand)
        acc_betas = [acc_betas new_beta];
    end
    Old_Lhood = New_Lhood; 
end    

histogram(acc_betas)