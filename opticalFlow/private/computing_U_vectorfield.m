[r c]=size(U);
DE_Vv_divergencefree=zeros(c,1);
DE_Vv_curlfree=zeros(c,1);
DE_Vv_total=zeros(c,1);
VertFaceConn=cell(size(FV.vertices,1),1);
for tt=1:size(FV.faces)
    for ind=FV.faces(tt,:);
        VertFaceConn{ind,1}=[VertFaceConn{ind,1};tt];
    end
end

Vv=zeros(size(VertFaceConn,1),3,c);
clear grad_X
for i=1:c
i
   grad_X=repmat(U(FV.faces(:,1),i),1,3).*grad_v{1}+repmat(U(FV.faces(:,2),i),1,3).*grad_v{2}+repmat(U(FV.faces(:,3),i),1,3).*grad_v{3};
  grad_X=cross(grad_X,norm_tri);


for ii=1:size(VertFaceConn,1)
Vv(ii,:,i)=(sum(grad_X(VertFaceConn{ii},:),1))*(eye(3)-(norm_tri(i,:)'*norm_tri(i,:))); %average +
end
clear grad_X
end
V1=Jflowc.V(:,:,i);
% temp=0;
% for jj=1:size(FV.vertices,1)
%     
%   if norm(Jflowc.V1(jj,:,i)) > 0
% V1(jj,:)=V1(jj,:)/norm(V1(jj,:));
%   end
%   
%     if norm(Vv(jj,:)) > 0
%     Vv(jj,:)=Vv(jj,:)/norm(Vv(jj,:));
%     end
%   
% end

Vv_nor=zeros(2562,3);
for i=1:2562
Vv_nor(i,:)=Vv(i,:)/norm(Vv(i,:));
end

% % Vv1=(V1-Vv);
for i=1:c
v12=sum((V1(FV.faces(:,1),:,i)+V1(FV.faces(:,2),:,i)-Vv(FV.faces(:,1),:,i)-Vv(FV.faces(:,2),:,i)).^2,2)/4;
v23=sum((V1(FV.faces(:,2),:,i)+V1(FV.faces(:,3),:,i)-Vv(FV.faces(:,2),:,i)-Vv(FV.faces(:,3),:,i)).^2,2)/4;
v13=sum((V1(FV.faces(:,1),:,i)+V1(FV.faces(:,3),:,i)-Vv(FV.faces(:,1),:,i)-Vv(FV.faces(:,3),:,i)).^2,2)/4;
DE_Vv_divergencefree(i)=sum(aires.*(v12+v23+v13));


v12=sum((Vv(FV.faces(:,1),:,i)+Vv(FV.faces(:,2),:,i)).^2,2)/4;
v23=sum((Vv(FV.faces(:,2),:,i)+Vv(FV.faces(:,3),:,i)).^2,2)/4;
v13=sum((Vv(FV.faces(:,1),:,i)+Vv(FV.faces(:,3),:,i)).^2,2)/4;
DE_Vv_curlfree(i)=sum(aires.*(v12+v23+v13));

v12=sum((V1(FV.faces(:,1),:,i)+V1(FV.faces(:,2),:,i)).^2,2)/4;
v23=sum((V1(FV.faces(:,2),:,i)+V1(FV.faces(:,3),:,i)).^2,2)/4;
v13=sum((V1(FV.faces(:,1),:,i)+V1(FV.faces(:,3),:,i)).^2,2)/4;
DE_Vv_total(i)=sum(aires.*(v12+v23+v13));
end

plot(DE_Vv_divergencefree)
figure
plot(DE_Vv_curlfree)
figure
plot(DE_Vv_total)
    
    
