% defining zombie model
function [ solution ] = Simple_Zombie_Model( total_pop , human_pop, beta, time )
solution = (human_pop*total_pop)./(human_pop+(total_pop-human_pop)*exp(beta*total_pop*time));
end
% generating our artificial data
X = 1:10;
Y = zeros(1,10);
for i =1:10
    Y(i) = Simple_Zombie_Model( 1000 , 999 , 0.001, X(i) )+100*normrnd(0,1);
end

% calculating P(B) using our initial beta
init_beta = 0.003*rand;
Y2 = Simple_Zombie_Model(1000,999,init_beta,X);
Old_Lhood = log(prod(normpdf(Y,Y2,500)));
acc_betas = [];

for i = 1:5000
    new_beta = 0.003*rand;
    Y_new = Simple_Zombie_Model(1000,999,new_beta,X);
    New_Lhood = log(prod(normpdf(Y,Y_new,500)))
    if New_Lhood - Old_Lhood > log(rand)
        acc_betas = [acc_betas new_beta];
        Old_Lhood = New_Lhood; 
    end
end    

histogram(acc_betas)