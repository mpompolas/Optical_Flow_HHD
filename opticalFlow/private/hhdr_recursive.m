function [U A H Vcurl Vdiv index]=hhdr_recursive(Jflowc,recur,range)
% same as hhdr but H is now decompose recur times

%Initializing values
Time=Jflowc.t;
FV.vertices=Jflowc.vertices;
FV.faces=Jflowc.faces;

if nargin<3 
index=1:length(Time);
else
index=range;
end


U=zeros(length(FV.vertices),length(index));
A=zeros(length(FV.vertices),length(index));
Vcurl=zeros(length(FV.vertices),3,length(index));
Vdiv=zeros(length(FV.vertices),3,length(index));
H=zeros(length(FV.vertices),3,length(index));



[cont_grad_v,cont_grad_vb,grad_v,tangent_basis,tg_basis,aires,norm_tri,norm_coord,index1,index2]=matrices_contraintes_ter_divergence(FV.faces,FV.vertices,3);
[VertFaceConn,Pn1]=vertices_faces_connectivity(FV,norm_coord);

faces=FV.faces;
vertices=FV.vertices;
V=Jflowc.V;
clear Jflowc
clear FV


% h = waitbar(0,'Computing U,V and H');
st=index(1);
ofs=st-1;
% parpool
try
    poolobj = gcp('nocreate');
    if isempty(poolobj)
        parpool;
    end
catch
    disp (' ')
end
parfor ii=index(1):index(end)
%     waitbar((ii-(st-1))/length(index));
Ui=zeros(length(vertices),recur);
Ai=zeros(length(vertices),recur);
Vcurli=zeros(length(vertices),3,recur);
Vdivi=zeros(length(vertices),3,recur);
Hi=zeros(length(vertices),3,recur);
    for i=1:recur
        
       
        if i==1
            
            
            [Ui(:,i), Ai(:,i), Hi(:,:,i), Vcurli(:,:,i), Vdivi(:,:,i)]=hhdr(V(:,:,ii),1,0,cont_grad_v,cont_grad_vb,grad_v,aires,norm_tri,VertFaceConn,Pn1,faces,vertices);
        else
          
            
            [Ui(:,i), Ai(:,i), Hi(:,:,i), Vcurli(:,:,i), Vdivi(:,:,i)]=hhdr(Hi(:,:,i-1),1,0,cont_grad_v,cont_grad_vb,grad_v,aires,norm_tri,VertFaceConn,Pn1,faces,vertices); 
        end





    end %recur
U(:,ii-ofs)=sum(Ui,2);
A(:,ii-ofs)=sum(Ai,2);

Vcurl(:,:,ii-ofs)=sum(Vcurli,3);
Vdiv(:,:,ii-ofs)=sum(Vdivi,3);
H(:,:,ii-ofs)=Hi(:,:,recur);

end % index
% matlabpool close
% delete(h)



