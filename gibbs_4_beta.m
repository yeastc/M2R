%generating data
X = linspace(0,1,10);
Y = zeros(1,10);
for i=1:10
    Y(i) = betapdf(X(i),2,5)+0.01*normrnd(0,1);
end

%selecting initial variables 
init_alphabeta = [2, 5];
new_alphabeta = [2, 5];

%initialising vector
acc_alphabetas = [];

% calculating initial likelihood
Y2 = betapdf(X,init_alphabeta(1),init_alphabeta(2));
Old_Lhood = sum(log(normpdf(Y,Y2,1)));

for i=1:5000
    new_alphabeta = [1.5+rand,new_alphabeta(2)];
    Y_new = betapdf(X,new_alphabeta(1),new_alphabeta(2));
    New_Lhood = sum(log(normpdf(Y,Y_new,0.1)));
    if New_Lhood - Old_Lhood > log(rand)
        acc_alphabetas = [acc_alphabetas; new_alphabeta];
        Old_Lhood = New_Lhood;
    end
    new_alphabeta = [new_alphabeta(1), 4.5+rand];
    Y_new = betapdf(X,new_alphabeta(1),new_alphabeta(2));
    New_Lhood = sum(log(normpdf(Y,Y_new,0.1)));
    if New_Lhood - Old_Lhood > log(rand)
        acc_alphabetas = [acc_alphabetas; new_alphabeta];
        Old_Lhood = New_Lhood; 
    end
end
hist3(acc_alphabetas)
