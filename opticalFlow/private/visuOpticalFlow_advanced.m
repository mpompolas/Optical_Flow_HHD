function [M]=visuOpticalFlow_advanced(first,last,Faces,Vertices,ScalarField,VectorField,Faces1,Vertices1,offset,norm_vertices)


close all
if nargin > 6
view_surface('test',Faces1,Vertices1,zeros(size(Vertices1,2),1));
hold on
end
if nargin > 8
Vertices=Vertices-norm_vertices.*offset;
end
hs=patch('vertices',Vertices,'faces',Faces,'FaceVertexCdata',ScalarField(:,1),'facecolor','interp','edgecolor','none');
% [hf,hs,hl]=view_surface('test',Faces,Vertices,ScalarField(:,1));
set(gca,'clim',[min(min(ScalarField(:,first:last))) max(max(ScalarField(:,first:last)))])
set(hs,'FaceAlpha',0.77)
axis off tight vis3d
set(hs,'AmbientStrength',.7);
set(hs,'DiffuseStrength',.3);
set(hs,'SpecularStrength',0);
set(hs,'SpecularColorReflectance',0);


rotate3d

colorbar
% set(gcf,'position',[2000 1000 1000 1000])
% camorbit(100,-90)

clear M
for i=first:last
delete(hs)
hs=patch('vertices',Vertices,'faces',Faces,'FaceVertexCdata',ScalarField(:,i),'facecolor','interp','edgecolor','none');
set(gca,'clim',[min(min(ScalarField(:,first:last))) max(max(ScalarField(:,first:last)))])
set(hs,'FaceAlpha',0.77)
axis off tight vis3d
set(hs,'AmbientStrength',.7);
set(hs,'DiffuseStrength',.3);
set(hs,'SpecularStrength',0);
set(hs,'SpecularColorReflectance',0);
colorbar
hold on
hq=quiver3(Vertices(:,1),Vertices(:,2),Vertices(:,3),VectorField(:,1,i),VectorField(:,2,i),VectorField(:,3,i),1.5,'k'); 

% M(i-(first-1)) = getframe(gcf);
title(num2str(i))
% i

delete(hq)
end


    

