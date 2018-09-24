function [ptr]=visu_surf(faces,vertices,flowVt,Ft,S,cmin,cmax,ptr,type,ang,LW)
% Visualization of optical flow on a surface (scalp without projection), cortex...
% INPUTS :
% faces : triangles
% vertices : coordinates of each node
% flowVt : vector field to visualize
% Ft : activity
% S : scaling parameter
% cmin : min of F
% cmax : max of F
% ptr : handle for vector field visualization
% type : static or moving angle of view
% ang : angle
% LW : width of arrows
% OUTPUTS :
% ptr : modified handle

if nargin<11
    LW=0.5;
end

if isempty(ptr.surf)
    [hf,hs,hl] = view_surface('topo',faces,vertices,[]); 
    set(hf,'Color',[1 1 1],'Position',[10 100 1000 700])
    axis equal
    axis off
    caxis([cmin, cmax]);
    ptr.surf=hs;
    switch type
        case 'rotate'
            view(100*ang/180,20)
        case 'static'
            view(-50,-15)  % (-80,20) occipital, (0,90)from top
    end
end

set(ptr.surf,'FaceVertexCData',Ft)
seuil_b=0.1;
norV=sqrt(sum(flowVt.^2,2));
maxf=max(norV);
indices=find(norV>seuil_b*maxf);
hold on
delete(ptr.fleche)
if S~=0
    ptr.fleche=quiver3d(vertices(indices,1),vertices(indices,2),vertices(indices,3),...
        flowVt(indices,1),flowVt(indices,2),flowVt(indices,3),[0 1 0],S);
else
    flowVt(indices,:) = diag(1./norlig(flowVt(indices,:)))*flowVt(indices,:);
    ptr.fleche=quiver3d(vertices(indices,1),vertices(indices,2),vertices(indices,3),...
        flowVt(indices,1),flowVt(indices,2),flowVt(indices,3),[0 1 0],S);
end
set(ptr.fleche,'LineWidth',LW);
hold off
return

% % Tests du 03/04/2007 pour améliorer la visu
% MNI=load('D:\users\Experiences\Patrice\subjects\alp\MNI_braincereb_small_tess_CTF.mat');
% FV.vertices=MNI.Vertices{1}';
% FV.faces=MNI.Faces{1};
% [NFV,remove_vertices]=tessellation_redundancies(FV,1,1e-10);
% kept_vertices=setxor(remove_vertices,1:size(FV.vertices,1))';
% 
% load('D:\users\Experiences\Patrice\Studies\alp\catch-alp-good-f.ds\catch-alp-good-f_results_trial_1_MNE_MEG_1737_MNI.mat')
% PARAM.SAVE=0;
% PARAM.t1=0;
% PARAM.t2=0.5;
% PARAM.VERBOSE=0;
% PARAM.hornschunk=0.1;
% PARAM.Time=ImageGridTime;
% PARAM.FV=NFV;
% PARAM.F=double(ImageGridAmp(kept_vertices,:));
% PARAM.GRAPHE=1;
% flowc=J_analysis_cortex(filename,PARAM);