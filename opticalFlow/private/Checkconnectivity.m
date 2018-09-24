function Final1=Checkconnectivity(A,vertconn)


% Big clustering Algoritham

BigCluster=VertConn(seeddd);



for ii=1:length(BigCluster)

temp1=BigCluster{ii}

    for jj=1:length(BigCluster)
        
        if i==j
            continue
        end
        if ifIntercept(a,b)
            result1(i,j)=1;
        end
    end
    
end

































%dfsdfgsd
% L=length(A);
% result1=zeros(L,L);
% 
% for i=1:L
%    
%     a=vertconn{A(i)};
%     for j=1:L
%         
%         if i==j
%             continue
%         end
%         
%         b=vertconn{A(j)};
%         if ifIntercept(a,b)
%             result1(i,j)=1;
%         end
%        
% 
%     end
% end
% 
% flag_size=1;
% xxx=2;
% 
% while flag_size
% result=bwlabel(result1,4);
% if sum(sum(result))==0 
%     xxx=xxx-1;
% else
%     flag_size=0;
% end
% end
% matr=repmat(A',1,length(A));
% final=cell(1);
% temp=max(result);
% temp=sort(temp);
% T=temp(end);
% for k=1:T
% Final1{k}=unique(matr(find(result==k)))';
% end




% for k=1:T-1
%  if isempty(Final{k})
%      continue
%  end
%     for j=k+1:T
%  if isempty(Final{j})
%      continue
%  end
% 
%            a = mean(vertices(:,Final{k})',1);
%         b = mean(vertices(:,Final{j})',1);
%     ab=100*norm(a-b);
%     
% if ab < 1
% 
% if k==1
%      Final{1}=unique([Final{k} Final{j}]) ;
% else
%     Final{1}=unique([Final{k} Final{j}]) ;
%     Final{k}=[];
% end
% 
% Final{j}=[];
% k=1;
% break
%     end
%     end
% end
% 
% iii=0;
% for ii=1:length(Final)
%        if ~isempty(Final{ii})
%            iii=iii+1;
%         Final1{iii}=unique(Final{ii});
%         end    
% end

    



