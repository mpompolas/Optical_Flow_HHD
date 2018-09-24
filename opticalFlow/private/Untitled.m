% figure
% plot(Jflowc.de(100:412)./sum(aires))
% view_surface('Figure_1',FV.faces,FV.vertices);  
% hold on
first=zeros(1374,1);
last=zeros(1374,1);
bbb=zeros(1374,1);
ccc=zeros(1374,1);
ddd=zeros(1374,1);
largest=zeros(1374,1);
patchLength=zeros(1374,1);
for iiiiiii=1:1374
    patchLength(iiiiiii)=length(result{iiiiiii}.DE_normalised);
%     iiiiiii
[aaa I]=sort(result{iiiiiii}.DE_normalised);
area_Bigcluster=zeros(length(result{iiiiiii}.BigCluster),1);
for jj=1:length(result{iiiiiii}.BigCluster)
area_Bigcluster(jj)=sum(aires(result{iiiiiii}.BigCluster{jj}));
end
[Area II]=sort(area_Bigcluster);

largest(iiiiiii)=result{iiiiiii}.DE_normalised(II(end));
% hold on
% ans1=mean(FV.vertices(result{6}.BigCluster{1},:))
center=zeros(length(aaa),3);
for jj=1:length(aaa)
%     scatter(iiiiiii,aaa(end),'o')
% bbb(iiiiiii-99)=aaa(1);
% ccc(iiiiiii-99)=aaa(end);
center(jj,:)=mean(FV.vertices(result{iiiiiii}.BigCluster{jj},:));
end

% scatter3(center(II(end),1),center(II(end),2),center(II(end),3),'db','filled')
% hold on
dist=zeros(length(aaa)-1,1);
for kk=1:length(aaa)-1
    
    dist(kk)=sqrt((center(I(end),1)-center(I(kk),1))^2+(center(I(end),2)-center(I(kk),2))^2+(center(I(end),3)-center(I(kk),3))^2);

end
[distsort II]=sort(dist);
if isempty(II)
   first(iiiiiii)= aaa(end);
   last(iiiiiii)=aaa(end);
else
first(iiiiiii)=result{iiiiiii}.DE_normalised(I(II(end)));
last(iiiiiii)=aaa(end);
end
% aaaa(iiiiiii)=length(result{iiiiiii}.DE);


% if length(aaa)==1
% bbb(iiiiiii)=aaa(end); 
% ccc(iiiiiii)=aaa(end);
% else
bbb(iiiiiii)=aaa(end);
% ccc(iiiiiii)=aaa(end-1);
ddd(iiiiiii)=aaa(1);
end
% end
%  end

% for i=1:689
%     
%    if first(i)==0
%        first(i)=(first(i-1)+first(i+1))/2;
%    end
%    
% end
%        
       

% t = Jflowc.t(1):(Jflowc.t(2)-Jflowc.t(1)):Jflowc.t(end);    
%  spectrogram(patchLength,kaiser(256,5),220,512,fs,'yaxis')      
       

% v12=sum((Vv(FV.faces(:,1),:)+Vv(FV.faces(:,2),:)).^2,2)/4;
% v23=sum((Vv(FV.faces(:,2),:)+Vv(FV.faces(:,3),:)).^2,2)/4;
% v13=sum((Vv(FV.faces(:,1),:)+Vv(FV.faces(:,3),:)).^2,2)/4;
% DE_Vv=sum(aires.*(v12+v23+v13)); 
       
%               tang_scal_11=[tang_scal_11,sum(cross(grad_v{k},norm_tri).*cross(grad_v{j},norm_tri),2).*aires];
% 
%     end
%     termes_diag=[termes_diag,sum(cross(grad_v{k},norm_tri).^2,2).*aires]; 
%     B(nodes(s),1)=B(nodes(s),1)+sum(projectV.*cross(grad_v{s}(i,:),norm_tri(i,:))*aires(i),2);
% for i=1:687
% result688_1374{i}.BigCluster=result1_687{i}.BigCluster;
% result688_1374{i}.DE_normalised=result1_687{i}.DE_normalised;
% result688_1374{i}.DE=result1_687{i}.DE;
% end
NumberCluster=zeros(1374,1);
for i=1:1374
    
   NumberCluster(i,1)= length(result{i}.BigCluster{1});
end
