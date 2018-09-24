function BigCluster=connectivity(BigCluster)
i=0;
while i < length(BigCluster);
i=i+1;
    a=BigCluster{i};
 
    for j=1:length(BigCluster)
        
        if i==j
            continue
        end
        

        b=BigCluster{j};
        
OP=intersect(a,b);
if isempty(OP)
    result=0;
else
    result=1;
end
        
        if result
            BigCluster{i}=unique([BigCluster{i} BigCluster{j}]);
            BigCluster(j)=[];
            i=0;
            break;
        end
       

    end
end

% function result=ifIntercept(a,b)
% OP=intersect(a,b);
% if isempty(OP)
%     result=0;
% else
%     result=1;
% end


% result=bwlabel(result);
% matr=repmat(A',1,length(A));
% final=cell(1);
% temp=sort(result);
% T=temp(end);
% for k=1:T
% final{k}=unique(matr(find(result==k)));
% end


     
        