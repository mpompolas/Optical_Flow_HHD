function [U A H Vcurl Vdiv index]=hhdr(V,range,verbose,cont_grad_v,cont_grad_vb,grad_v,aires,norm_tri,VertFaceConn,Pn1,faces,vertices)

%Routine to calculate U, V and H component of the vector field
% Jflowc contain all the information including optical flow
% range contain Time period on which decomposition required e.g.
% range=500:700
% U,V,H are the component of HHD of a vector field


%% Extracting information from Jflowc and initialization
% Time=Jflowc.t;
FV.vertices=vertices;
FV.faces=faces;
clear faces vertices
if nargin<2 
index=1:length(Time);
else
index=range;
end


U=zeros(length(FV.vertices),length(index));
A=zeros(length(FV.vertices),length(index));
Vcurl=zeros(length(FV.vertices),3,length(index));
Vdiv=zeros(length(FV.vertices),3,length(index));
H=zeros(length(FV.vertices),3,length(index));
%% Calculating some geometrical properties
% [cont_grad_v,cont_grad_vb,grad_v,tangent_basis,tg_basis,aires,norm_tri,norm_coord,index1,index2]=matrices_contraintes_ter_divergence(FV.faces,FV.vertices,3);
% [VertFaceConn,Pn1]=vertices_faces_connectivity(FV,norm_coord);

%% calculating U, V and H
if verbose==1
h = waitbar(0,'Computing U,V and H');
end

for ii=index
    if verbose==1
waitbar((ii-(index(1)-1))/length(index));
    end
FieldV=V(:,:,ii);

B=zeros(length(FV.vertices),1);
B2=zeros(length(FV.vertices),1);


for i=1:size(FV.faces,1)
    % projection of flows.V(i,:,t) on the triangle i
    Pn=eye(3)-(norm_tri(i,:)'*norm_tri(i,:));
    nodes=FV.faces(i,:);
    VV=mean(FieldV(nodes,:),1);
    projectV=VV*Pn;
    
    for s=1:3
        B(nodes(s),1)=B(nodes(s),1)+sum(projectV.*grad_v{s}(i,:)*aires(i),2);
        B2(nodes(s),1)=B2(nodes(s),1)+sum(projectV.*cross(grad_v{s}(i,:),norm_tri(i,:))*aires(i),2);
    end
    
    
end


% U(:,ii-(index(1)-1))=(cont_grad_v)\B;
% A(:,ii-(index(1)-1))=(cont_grad_vb)\B2; %Edited by Sheraz on 16 dec 2008

% U(:,ii-(index(1)-1))=pinv(full(cont_grad_v))*B;
% V(:,ii-(index(1)-1))=pinv(full(cont_grad_vb))*B2;
 U(:,ii-(index(1)-1))=lsqr(cont_grad_v,B,1e-20,10000);
A(:,ii-(index(1)-1))=lsqr(cont_grad_vb,B2,1e-20,10000);

Vd=curl(U(:,ii-(index(1)-1)),FV,grad_v);
Vc=curl(A(:,ii-(index(1)-1)),FV,grad_v,norm_tri);

Vcurl(:,:,ii-(index(1)-1))=tri2vert(Vc,VertFaceConn,Pn1);
Vdiv(:,:,ii-(index(1)-1))=tri2vert(Vd,VertFaceConn,Pn1);

H(:,:,ii-(index(1)-1))=V(:,:,ii)-Vcurl(:,:,ii-(index(1)-1))-Vdiv(:,:,ii-(index(1)-1));

end % for
if verbose==1
delete(h)
end
