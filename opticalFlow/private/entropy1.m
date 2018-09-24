function H = entropy1(x)
% Entropy as a function of probabilities in a vector.
x = sort(x(:)); len = length(x);
y = find([ x(1)-1; x] ~= [x; x(len)+1 ]);
p = diff(y)/len;
H = -sum(p.*log(p)/log(2)); 