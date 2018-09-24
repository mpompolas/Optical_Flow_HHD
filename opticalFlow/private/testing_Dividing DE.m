



function [Pn]=PN_calc(FV)
Pn=zeros(length(FV.faces),3,3);
for i=1:size(FV.faces,1)
    Pn(i,:,:)=eye(3)-(norm_tri(i,:)'*norm_tri(i,:)); 
end
% 
% [cont_grad_v,grad_v,tangent_basis,tg_basis,aires,norm_tri,norm_coord,index1,index2]=matrices_contraintes_ter_divergence(FV.faces,FV.vertices,3);
% 
% 
% 
% function [V]=curl(X,FV,grad_v,normals)
% 
% grad_X=repmat(X(FV.faces(:,1),740),1,3).*grad_v{1}+repmat(X(FV.faces(:,2),740),1,3).*grad_v{2}+repmat(X(FV.faces(:,3),740),1,3).*grad_v{3};
% if nargin<4 %just compute the gradient of the scalar field X
%     V=grad_X;
% else %curl of the scalar field X
%     V=cross(grad_X,norm_tri);
% end
% 
% 
% function [Vv]=tri2vert(Vt,VertFaceConn,Pn)
% 
for ii=1:size(VertFaceConn,1)
    Vv(ii,:)=(sum(Vt(VertFaceConn{ii},:),1))*(eye(3)-(norm_tri(i,:)'*norm_tri(i,:))); %average +
%  projection 
end
% 
% 
% function [VertFaceConn]=vertices_faces_connectivity(FV)
% 
VertFaceConn=cell(size(FV.vertices,1),1);
for tt=1:size(FV.faces)
    for ind=FV.faces(tt,:);
        VertFaceConn{ind,1}=[VertFaceConn{ind,1};tt];
    end
end