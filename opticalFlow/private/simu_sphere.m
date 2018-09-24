function [I,traj,dist]=simu_sphere(FV,m1,m2,k,tstep)
    
if length(m1)==1
    Om1=FV.vertices(m1,:);
else
    Om1=m1;
end
if length(m2)==1
    Om2=FV.vertices(m2,:);
else
    Om2=m2;
end

angle12=acos(dot(Om1,Om2));
Om1_orth=cross(cross(Om1,Om2),Om1);
Om1_orth=Om1_orth/norm(Om1_orth);
n=size(FV.vertices,1);
I=sparse(n,tstep);

for tt=1:tstep
    %1) trajectory
    angle_t=angle12*tt/tstep;
    OM=cos(angle_t)*Om1+sin(angle_t)*Om1_orth;
    traj(tt,:)=OM;

    %2) distance
    dist=dist_on_sphere(FV,OM,1:n);
    I(:,tt)=plateau((1/(2*k))*dist+0.5);
end

return

% Film -> fonction make_movie

hs=patch(FV,'EdgeColor','none','FaceColor',[0.8 0.8 0.8])
set(hs,'FaceColor','interp')
ptr.fleche=[];

for tt=1:50
%     set(hs,'FaceVertexCdata',flowc.F(:,tt))
        set(hs,'FaceVertexCdata',I(:,tt))
    hold on
    %ptr.fleche=quiver3(FV.vertices(:,1),FV.vertices(:,2),FV.vertices(:,3),flowc.V(:,1,tt),flowc.V(:,2,tt),flowc.V(:,3,tt),'g');
  
   
    pause(0.1)  
    %delete(ptr.fleche) 
end

theta=2*pi*rand(1,1);
init_point=[cos(theta)/sqrt(2),sin(theta)/sqrt(2),1/sqrt(2)];
end_point=[0 0 1];%
FV=gen_sphere2(pi/10,60);
[I,traj,dist]=simu_sphere(FV,init_point,end_point,0.4,50);

VertConn= vertices_connectivity(FV);
[curvature_sigmoid,Curvature] = curvature_cortex(FV,VertConn,.1,0);
curvatureThreshold=0.05;
Curvature( Curvature < curvatureThreshold) = 100;

PARAM.F=I(:,1:50);
PARAM.FV=FV;
PARAM.Time=[1:50];
PARAM.hornschunk=0.1;
flowc=J_analysis_cortex('blabla',PARAM);

[hf,hs,hl]=view_surface('toto',FV.faces,FV.vertices)
hold on
phim=pi/10;
phi=[-pi/2+phim:pi/100:pi/2-phim];

for theta=[-pi/2:pi/4:pi/2]
coord=[cos(theta)*sin(phi);sin(theta)*sin(phi);cos(phi)];
plot3d(coord','Color',[0 0 0],'LineWidth',1)
end

theta=[0:pi/100:2*pi];
for phi=phim:pi/10:pi/2-phim
 coord=[cos(theta)*sin(phi);sin(theta)*sin(phi);repmat(cos(phi),1,length(theta))];
plot3d(coord','Color',[0 0 0],'LineWidth',1)   
end

set(hs,'FaceColor',[0.8 0.8 0.8])
set(hs,'FaceColor','interp')
ptr.fleche=[];
ptr.fleche2=[];


for tt=2:50
    %     set(hs,'FaceVertexCdata',flowc.F(:,tt))
    vertxcolor=I(:,tt);
    vertxcolor = blend_anatomy_data(Curvature,I(:,tt));
    set(hs,'FaceVertexCdata',vertxcolor)
    hold on
    
    flowVt=0.5*flowc.V(:,:,tt);
    norV=sum(flowVt.^2,2);
    maxf=max(norV);
    indices=find(norV>0.3*maxf);
    
    ptr.fleche=quiver3(FV.vertices(indices,1),FV.vertices(indices,2),FV.vertices(indices,3),flowVt(indices,1),flowVt(indices,2),flowVt(indices,3),1,'g');
    
    % True displacement
    Vtrue=traj(tt,:)-traj(tt-1,:);
    suppI=find(I(:,tt));
    pVtrue=[];
    for k=1:length(suppI)
        pVtrue(k,:)=parallel_transport(Vtrue,traj(tt,:),flowc.coord(suppI(k),:));
    end
    
    ptr.fleche2=quiver3(FV.vertices(suppI,1),FV.vertices(suppI,2),FV.vertices(suppI,3),pVtrue(:,1),pVtrue(:,2),pVtrue(:,3),1,'r');
    pause(0.1)
    delete(ptr.fleche)
    delete(ptr.fleche2)
end