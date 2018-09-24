function result=ifIntercept1(a,b)
OP=intersect(a,b);
if isempty(OP)
    result=0;
else
    result=1;
end

