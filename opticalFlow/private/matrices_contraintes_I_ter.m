function [cont_grad_I,B]=matrices_contraintes_I_ter(tri,coord,grad_v,aires,tangent_basis,I,dIdt,dim,index1,index2);
% Computation of Fit to data matrices of the variationnal formulation
% INPUTS :
% tri :triangles
% coord : coordinates of each node
% grad_v : gradient of the basis functions
% aires : area of each triangle
% tangent_basis : basis of each tangent plane
% I : activity at time step t
% dIdt : I(t)-I(t-1)
% dim : 3
% index1, index2 : lists of nodes for function sparse
% OUTPUTS :
% cont_grad_I : fit to data matrix, SS (grad(I).w_k)(grad(I).w_k')
% B : fit to data vector, -2SS(dI/dt)(grad(I).v_k)


nbr_capt=size(coord,1); % Number of nodes
n=2*nbr_capt;

%% Gradient of intensity obtained through interpolation
grad_I=repmat(I(tri(:,1)),1,dim).*grad_v{1}+repmat(I(tri(:,2)),1,dim).*grad_v{2}+repmat(I(tri(:,3)),1,dim).*grad_v{3};

%% Projection of the gradient of I on the tangent space
P_grad_I=cell(1,3); % same structure as grad_v : size = nbr_tri,3 ;
for s=1:3
    for k=1:2
       P_grad_I{s}(:,k)=sum(grad_I.*tangent_basis{k,s},2);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Construction of B %%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% méthode Guillaume Obosinski

B=zeros(n,1); 
for k=1:2,
   for s=1:3,
   val=-1/12*aires.*(P_grad_I{s}(:,k)).*(dIdt(tri(:,s))+sum(dIdt(tri),2));
      B(tri(:,s)+(k-1)*nbr_capt)=B(tri(:,s)+(k-1)*nbr_capt)+val;
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Construction of cont_grad_I %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

scal_I_11=[];
scal_I_22=[];
scal_I_12=[];
scal_I_21=[];
scal_I_diag_11=[];
scal_I_diag_22=[];
scal_I_diag_12=[];

for k=1:3
    for j=k+1:3
        scal_I=P_grad_I{k}(:,1).*P_grad_I{j}(:,1).*aires;
        scal_I=scal_I/12;
        scal_I_11=[scal_I_11,scal_I]; 
        scal_I=P_grad_I{k}(:,2).*P_grad_I{j}(:,2).*aires;
        scal_I=scal_I/12;
        scal_I_22=[scal_I_22,scal_I]; 
        scal_I=P_grad_I{k}(:,1).*P_grad_I{j}(:,2).*aires;
        scal_I=scal_I/12;
        scal_I_12=[scal_I_12,scal_I]; 
        scal_I=P_grad_I{k}(:,2).*P_grad_I{j}(:,1).*aires;
        scal_I=scal_I/12;
        scal_I_21=[scal_I_21,scal_I];       
    end
    scal_I=P_grad_I{k}(:,1).*P_grad_I{k}(:,1).*aires;
    scal_I=scal_I/6;
    scal_I_diag_11=[scal_I_diag_11,scal_I];
    scal_I=P_grad_I{k}(:,2).*P_grad_I{k}(:,2).*aires;
    scal_I=scal_I/6;
    scal_I_diag_22=[scal_I_diag_22,scal_I];
    scal_I=P_grad_I{k}(:,1).*P_grad_I{k}(:,2).*aires;
    scal_I=scal_I/6;
    scal_I_diag_12=[scal_I_diag_12,scal_I];
end

S11=sparse(index1,index2,scal_I_11,nbr_capt,nbr_capt);
S22=sparse(index1,index2,scal_I_22,nbr_capt,nbr_capt);
S12=sparse(index1,index2,scal_I_12,nbr_capt,nbr_capt);
S21=sparse(index1,index2,scal_I_21,nbr_capt,nbr_capt);
S11=S11+S11';
S22=S22+S22';
S121=S12+S21';
S212=S121';

D11=sparse(tri,tri,scal_I_diag_11,nbr_capt,nbr_capt); 
D22=sparse(tri,tri,scal_I_diag_22,nbr_capt,nbr_capt);
D12=sparse(tri,tri,scal_I_diag_12,nbr_capt,nbr_capt);

cont_grad_I=[S11+D11 S121+D12;S212+D12 S22+D22];




