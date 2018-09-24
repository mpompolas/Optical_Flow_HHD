function [flows]=calcul_flot_ter_p(validloc,faces,vertices,intv,F,Time,dim,graphe,temps,lambda,Compindex,cont_grad_v,grad_v,tangent_basis,tg_basis,aires,norm_faces,norm_vertices,index1,index2)
% Step-by-step Computation of optical flows on a surface 
% INPUTS :
% - validloc : indices of MEG Channels
% - faces : List of triangles in the tesselation
% - vertices : Coordinates of nodes of the tesselation
% - intv : indices of temporal instants
% - F : activities
% - Time : temporal instants for computation
% - dim : for visualization, default : 3, projection on a sphere : 2
% - graphe : visualization of the flows at each step
% - temps : time elapsed at each step
% - lambda : regularizing parameters
% - Compindex : computes the Poincar� index on each triangle
% - MOVIE : name of a movie to be created
%
% OUTPUTS :
% flows : struct with fields :
% .F : Activities
% .V : Optical flow
% .lambda : Regularizing parameter
% .cmin : Min of activities
% .cmax : Max of activities
% .faces : Triangles of tesselation
% .vertices : Coordinates of tesselation
% .de : Displacement Energy
%%% Options
% .ind_dI : Constant term in variationnal formulation
% .rho : Fit to Data energy
% .eta : Regularization energy
% .index : Poincar� index

%/---Script Authors---------------------\
%|                                      | 
%|   *** J.Lef�vre, PhD                 |  
%|   julien.lefevre@chups.jussieu.fr    |
%|                                      |
%|   *** G.Obozinski                    |
%|   gobo@stat.Berkeley.edu             |
%|                                      |
%\--------------------------------------/

% if nargin==12
%     mov=avifile(MOVIE);
% end

%%% Initialization of handles for visualization

% if graphe
%     ptr.fleche=[];
%     ptr.surf=[];
%     ptr.tete=[];
% end

%%% Regularizing matrice and other geometrical quantities


if length(lambda)<=1
    M1=lambda*cont_grad_v;
end

if isempty(validloc)|max(validloc)>size(F,1) % for cortical activities or validloc specified
    try
        flows.F=F(:,intv);
    catch
        flows.F=F;
    end
else
    flows.F=F(validloc,intv);
end
clear F
flows.t=Time(intv);
flows.dur=size(flows.F,2);
flows.dim=size(vertices,1);
flows.vertices=vertices;
flows.faces=faces;

if length(lambda)>1 % For L-curve computation
    flows.rho=zeros(length(lambda),flows.dur);
    flows.eta=zeros(length(lambda),flows.dur);
    flows.de=zeros(length(lambda),flows.dur);
else
    flows.V=zeros(flows.dim,3,flows.dur);
    flows.de=zeros(flows.dur,1);
end

%%% Variables for visualization
% cmax=max(max(abs(flows.F)));
% cmin=-cmax;

%%% Projection Matrix on each triangle

% if Compindex
%     for i=1:size(faces,1)
%         % projection of flows.V(i,:,t) on the triangle i
%         Pn(:,:,i)=eye(3)-(norm_faces(i,:)'*norm_faces(i,:));
%     end
%     flows.index=sparse(size(flows.faces,1),flows.dur);
% end
% 
% if temps
%     if(temps),
%         hwait = waitbar(0,sprintf('Processing the Optical flow computation for %.0f steps of time',flows.dur));
%         drawnow
%     end
% end

%%% Iterations
for t=2:flows.dur
    
        %%% Fit to Data matrix
        tic
        [cont_grad_I,B]=matrices_contraintes_I_ter(faces,vertices,grad_v,aires,tangent_basis,flows.F(:,t),flows.F(:,t)-flows.F(:,t-1),dim,index1,index2);
        aa=toc;
        flows.t_gradI(t)=aa;
    if length(lambda)<=1
        tic
        M=cont_grad_I+M1;
        
        %%% System inversion
        
        X=M\B;
        aa=toc;
        flows.t_inv(t)=aa;
    else        
        for lamb=1:length(lambda)
            M=cont_grad_I+lambda(lamb)*cont_grad_v;
            X=M\B;
            flows.rho(lamb,t)= X'*cont_grad_I*X-2*B'*X;% fit to data
            flows.eta(lamb,t)= X'*cont_grad_v*X;% regularization
            v12=sum((X(faces(:,1),:)+X(faces(:,2),:)).^2,2)/4;
            v23=sum((X(faces(:,2),:)+X(faces(:,3),:)).^2,2)/4;
            v13=sum((X(faces(:,1),:)+X(faces(:,3),:)).^2,2)/4;
            flows.de(lamb,t)=sum(aires.*(v12+v23+v13));
        end
        dI=(flows.F(:,t)-flows.F(:,t-1));
        dI12=(dI(faces(:,1),:)+dI(faces(:,2))).^2;
        dI23=(dI(faces(:,2),:)+dI(faces(:,3))).^2;
        dI13=(dI(faces(:,1),:)+dI(faces(:,3))).^2;
        flows.int_dI(t)=sum(aires.*(dI12+dI23+dI13))/24;
    end
    
    if temps       
        if(~rem(t,max(1,round(flows.dur/10)))), 
         
         waitbar(t/flows.dur,hwait);
         drawnow 
        end
    end

    if length(lambda)<=1
        if dim==3
            % X are coordinates in tangent space
            flows.V(:,:,t)=repmat(X(1:flows.dim),[1,3]).*tg_basis(:,:,1)+repmat(X(flows.dim+1:2*flows.dim),[1,3]).*tg_basis(:,:,2);
        else
            flows.V(:,:,t)=[X(1:flows.dim),X(flows.dim+1:2*flows.dim),zeros(flows.dim,1)];
        end
        v12=sum((flows.V(faces(:,1),:,t)+flows.V(faces(:,2),:,t)).^2,2)/4;
        v23=sum((flows.V(faces(:,2),:,t)+flows.V(faces(:,3),:,t)).^2,2)/4;
        v13=sum((flows.V(faces(:,1),:,t)+flows.V(faces(:,3),:,t)).^2,2)/4;
        flows.de(t)=sum(aires.*(v12+v23+v13));
    end
end
    %%% Poincare Index of each triangle

%     if Compindex       
%         for ii=1:size(faces,1)
%             VF=(flows.V(faces(ii,:),:,t));
%             % projection of flows.V(i,:,t) on the triangle i
%             flows.index(ii,t)=index(Pn(:,:,ii)*VF');
%         end
%     end
%     
%     %%% Visualization
%     proj=3;
%     if proj==3
%         S=0.5;               % scaling of the arrows 
%         if graphe,
%             ptr=visu_surf(faces,vertices,flows.V(:,:,t),flows.F(:,t),S,cmin,cmax,ptr,'static',t);
%             if nargin==12
%                 drawnow
%                 M = getframe(gca);
%                 mov = addframe(mov,M);
%             end
%             
%         end
%     else
%         if graphe
%             ptr=visualisations_MEG_plan(flows.V(:,:,t),flows.F(:,t),vertices,cmin,cmax,ptr); 
%             if nargin==12
%                 delete(ptr.fleche)
%                 ptr.fleche=[];
%                 drawnow
%                 M = getframe(gca);
%                 mov = addframe(mov,M);
%             end
%            
%         end
%     end
%     drawnow
% end 

% flows.lambda=lambda;
% flows.cmin=cmin;
% flows.cmax=cmax;
if temps
    close(hwait);
end

% if nargin==12
%     mov=close(mov);
% end



