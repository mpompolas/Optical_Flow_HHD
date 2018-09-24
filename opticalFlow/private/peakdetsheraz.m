function [mintabF]=peakdetsheraz(x)

len_x = length(x);
fltr=[1 1 1]/3;
x1=x(1); x2=x(len_x); 

	for jj=1:2,
	c=conv(fltr,x);
	x=c(2:len_x+1);
	x(1)=x1;  
        x(len_x)=x2; 
	end

[maxtab, mintab] = peakdet(x, 0.1);
mintabF=mintab(:,1);
