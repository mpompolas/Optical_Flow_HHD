function [cont_grad_v,cont_v,aires,index1,index2]=heat_matrices(tri,coord,dim);
% Computation of the regularizing part in the variationnal approach (SS grad(v_k)grad(v_k')) and
% other geometrical quantities.
% INPUTS :
% tri : triangles of the tesselation
% coord : coordinates of the tesselation
% dim : 3, scalp or cortical surface, 2 flat surface
%%%%%
% OUTPUTS :
% cont_grad_v : regularizing matrix
% grad_v : gradient of the basis functions in Finite Element Methods
% aires : area of the triangles
% index1, index2 :  lists of nodes for function sparse
%
%/---Script Authors---------------------\
%|                                      | 
%|   *** J.Lefèvre, PhD                 |  
%|   julien.lefevre@chups.jussieu.fr    |
%|                                      | 
%\--------------------------------------/


nbr_capt=size(coord,1); % Number of nodes

%% Geometric quantities

[grad_v,aires,norm_tri]=carac_tri(tri,coord,dim);
clear norm_tri

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Regularizing matrix SS grad(v_k)grad(v_k') %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
index1=[];   
index2=[];
termes_diag1=[];
termes_diag2=[];
mat1=[];
mat2=[];

for k=1:3, 
    for j=k+1:3
       index1=[index1,tri(:,k)];
       index2=[index2,tri(:,j)];
       mat1=[mat1,sum(grad_v{k}.*grad_v{j},2).*aires];
       mat2=[mat2,(1/12)*aires];
    end
    termes_diag1=[termes_diag1,sum(grad_v{k}.^2,2).*aires];
    termes_diag2=[termes_diag2,(1/6)*aires];
end

D1=sparse(tri,tri,termes_diag1,nbr_capt,nbr_capt);
D2=sparse(tri,tri,termes_diag2,nbr_capt,nbr_capt);

M1=sparse(index1,index2,mat1,nbr_capt,nbr_capt);
M2=sparse(index1,index2,mat2,nbr_capt,nbr_capt);
cont_grad_v=M1+M1'+D1;
cont_v=M2+M2'+D2;

