function [A1,A2,A3]=prepare_advection(V,tri,coord)
% Same function as prepare_advection2, matrices A1, A2, A3 are constant up to a constant 

%/---Script Authors---------------------\
%|                                      | 
%|   *** J.Lefèvre, PhD                 |  
%|   julien.lefevre@chups.jussieu.fr    |
%|                                      | 
%\--------------------------------------/

nc=size(coord,1); % number of vertices
nt=size(tri,1); % number of faces
[cont_grad_v,grad_v,tangent_basis,tg_basis,aires,norm_tri,norm_coord,index1,index2]=matrices_contraintes_ter(tri,coord,3);

% Projection of grad(wi)

P_grad_v_c=cell(1,3); 
for s=1:3
    for k=1:2
       P_grad_v_c{s}(:,k)=sum(grad_v{s}.*tangent_basis{k,s},2);
    end
    P_grad_v{s}=repmat(P_grad_v_c{s}(:,1),1,3).*tangent_basis{1,s}+repmat(P_grad_v_c{s}(:,2),1,3).*tangent_basis{2,s};
end

%flow.V(:,:,t)=repmat(X(1:flow.dim),[1,3]).*tg_basis(:,:,1)+repmat(X(flow.dim+1:2*flow.dim),[1,3]).*tg_basis(:,:,2);

% Local matrices

A1=ui_uj(nc,tri,aires,index1,index2);
A2=gu_i_v_uj(nc,nt,aires,tri,V,P_grad_v);
A3=gui_v_guj_v(nc,nt,aires,tri,V,P_grad_v);

function [A1]=ui_uj(nc,tri,aires,index1,index2) % matrice des SS u_iu_j dx
termes=repmat(aires/12,1,3);  
sympart=(sparse(index1,index2,termes,nc,nc));
A1=sparse(tri,tri,repmat(2*aires,1,3),nc,nc)+sympart+sympart'; 

function [A2]=gu_i_v_uj(nc,nt,aires,tri,V,P_grad_v) % matrice des SS (grad(u_i).v)u_j dx
A2=sparse(nc,nc);
for ii=1:nt
    triang=tri(ii,:);
    for s1=1:3
        for s2=1:3
            A2(triang(s1),triang(s2))=A2(triang(s1),triang(s2))+(aires(ii)/12)*dot(P_grad_v{s1}(ii,:),sum(V(triang,:),1)+V(triang(s2),:));
        end
    end
end

function [A3]=gui_v_guj_v(nc,nt,aires,tri,V,P_grad_v) % matrice des SS (grad(u_i).v)(grad(u_j).v) dx
A3=sparse(nc,nc);
for ii=1:nt
    triang=tri(ii,:);
    for s1=1:3
        for s2=1:3
            for a=1:3
                for b=1:3
                    A3(triang(s1),triang(s2))=A3(triang(s1),triang(s2))+...
                        ((a==b)/12+1/12)*aires(ii)*dot(P_grad_v{s1}(ii,:),V(triang(a),:))*...
                        dot(P_grad_v{s2}(ii,:),V(triang(b),:));
                end
            end
        end
    end
end

