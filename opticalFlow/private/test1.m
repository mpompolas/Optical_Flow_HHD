


load('rabbit.mat')

VertConn = vertices_connectivity(FV,0);
[curvature_sigmoid,curvature]=curvature_cortex(FV,VertConn,1,0);
[curvature_sigmoid,scurvature]=curvature_cortex(smoothedFV,VertConn,1,0);
smoothedFV=smooth_cortex(FV,VertConn,0.9,50);
m=23784;
[neigh,Vneigh]=neighbours(m,FV,10,scurvature>0);
view_surface('MNE',FV.faces,FV.vertices,Vneigh(:,1))

indices=find(FV.vertices(:,1)>0.01 & FV.vertices(:,1)<0.05 & FV.vertices(:,2)>0);
[PFV,Pcurvature]=convert_patch(indices,FV,curvature);