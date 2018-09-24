function [cont_grad_v,cont_grad_vb,grad_v,tangent_basis,tg_basis,aires,norm_tri,norm_coord,index1,index2]=matrices_contraintes_ter_divergence(tri,coord,dim);

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
% tangent_basis : basis of the tangent plane at a node of the surface
% (nodes are listed according to the tesselation)
% tg_basis : basis of the tangent plane at a node
% aires : area of the triangles
% norm_tri : normal of each triangle
% norm_coord : normal at each node
% index1, index2 : 

%/---Script Authors---------------------\
%|                                      | 
%|   *** J.Lefèvre, PhD                 |  
%|   julien.lefevre@chups.jussieu.fr    |
%|                                      | 
%\--------------------------------------/

nbr_capt=size(coord,1); % Number of nodes

%% Geometric quantities

[grad_v,aires,norm_tri]=carac_tri(tri,coord,dim);
norm_coord=carac_coord(tri,coord,norm_tri); 

%% basis of the tangent plane

[tg_basis]=ortho_basis(norm_coord,'uniform');

tangent_basis=cell(2,3); % quite the same structure as grad_v, 2=number of basis vector, 3=nodes of each triangulation 

tangent_basis{1,1}=tg_basis(tri(:,1),:,1);
tangent_basis{1,2}=tg_basis(tri(:,2),:,1);
tangent_basis{1,3}=tg_basis(tri(:,3),:,1);

tangent_basis{2,1}=tg_basis(tri(:,1),:,2);
tangent_basis{2,2}=tg_basis(tri(:,2),:,2);
tangent_basis{2,3}=tg_basis(tri(:,3),:,2);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Regularizing matrix SS grad(v_k)grad(v_k') %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
index1=[];   
index2=[];
termes_diag=[];
termes_diag_b=[];
tang_scal_11=[];
tang_scal_11_b=[];

for k=1:3, 
    for j=k+1:3
       index1=[index1,tri(:,k)];
       index2=[index2,tri(:,j)];
       
       % Just switch coments for A
      tang_scal_11=[tang_scal_11,sum(grad_v{k}.*grad_v{j},2).*aires];
      tang_scal_11_b=[tang_scal_11_b,sum(cross(grad_v{k},norm_tri).*cross(grad_v{j},norm_tri),2).*aires];

    end
           % Just switch coments for A
     termes_diag=[termes_diag,sum(grad_v{k}.^2,2).*aires]; 
     termes_diag_b=[termes_diag_b,sum(cross(grad_v{k},norm_tri).^2,2).*aires];
end

D=sparse(tri,tri,termes_diag,nbr_capt,nbr_capt);
Db=sparse(tri,tri,termes_diag_b,nbr_capt,nbr_capt);

E11=sparse(index1,index2,tang_scal_11,nbr_capt,nbr_capt);
E11=E11+E11'+D;
cont_grad_v=E11;

E11b=sparse(index1,index2,tang_scal_11_b,nbr_capt,nbr_capt);
E11b=E11b+E11b'+Db;
cont_grad_vb=E11b;



