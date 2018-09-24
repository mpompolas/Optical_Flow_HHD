
% FV = sphere_tri('ico',4,[],0);
% [FieldV]=vector_field_sphere(FV,'phi');

% FieldV=Jflowc.V(:,:,2);
sFV2.vertices=Jflowc.vertices;
sFV2.faces=Jflowc.faces;
[cont_grad_v,cont_grad_vb,grad_v,tangent_basis,tg_basis,aires,norm_tri,norm_coord,index1,index2]=matrices_contraintes_ter_divergence(sFV2.faces,sFV2.vertices,3);

U=zeros(6232,375);
V=zeros(6232,375);
Vcurl=zeros(6232,3,375);
Vdiv=zeros(6232,3,375);
for ii=1:375
    ii
FieldV=Jflowc.V(:,:,ii);
B=zeros(length(sFV2.vertices),1);
B2=zeros(length(sFV2.vertices),1);
for i=1:size(sFV2.faces,1)
    % projection of flows.V(i,:,t) on the triangle i
    Pn=eye(3)-(norm_tri(i,:)'*norm_tri(i,:));
    nodes=sFV2.faces(i,:);
    VV=mean(FieldV(nodes,:),1);
    projectV=VV*Pn;
    for s=1:3
        % Just switch coments for A
        B(nodes(s),1)=B(nodes(s),1)+sum(projectV.*grad_v{s}(i,:)*aires(i),2);
        B2(nodes(s),1)=B2(nodes(s),1)+sum(projectV.*cross(grad_v{s}(i,:),norm_tri(i,:))*aires(i),2);
    end
end



U(:,ii)=(cont_grad_v)\B;
V(:,ii)=(cont_grad_vb)\B2;

Vc=curl(V(:,ii),sFV2,grad_v,norm_tri);
Vd=curl(U(:,ii),sFV2,grad_v);
clear VertFaceConn Pn
% [VertFaceConn,Pn]=vertices_faces_connectivity(sFV2,norm_coord);
%hq=quiver3(grav_tri(:,1),grav_tri(:,2),grav_tri(:,3),FieldV(:,1)-Vc(:,1)-Vd(:,1),FieldV(:,2)-Vc(:,2)-Vd(:,2),FieldV(:,3)-Vc(:,3)-Vd(:,3),10,'g')
[VertFaceConn,Pn]=vertices_faces_connectivity(sFV2,norm_coord);
Vcurl(:,:,ii)=tri2vert(Vc,VertFaceConn,Pn);
Vdiv(:,:,ii)=tri2vert(Vd,VertFaceConn,Pn);
clear VertFaceConn Pn
end

H=Jflowc.V-Vcurl-Vdiv;

% [hf,hs]=view_surface('2',sFV2.faces,sFV2.vertices,U-mean(U))
% hold on
% hq=quiver3(sFV2.vertices(:,1),sFV2.vertices(:,2),sFV2.vertices(:,3),FieldV(:,1)-Vcurl(:,1)-Vdiv(:,1),FieldV(:,2)-Vcurl(:,2)-Vdiv(:,2),FieldV(:,3)-Vcurl(:,3)-Vdiv(:,3),1,'g')
% hq=quiver3(sFV2.vertices(:,1),sFV2.vertices(:,2),sFV2.vertices(:,3),Vdiv(:,1),Vdiv(:,2),Vdiv(:,3),1,'r')
% hq=quiver3(sFV2.vertices(:,1),sFV2.vertices(:,2),sFV2.vertices(:,3),FieldV(:,1),FieldV(:,2),FieldV(:,3),10,'b')
cd C:\brainstorm\Toolbox
[Y,I] = max(norlig(H(:,:,30)));
cd('C:\Documents and Settings\khan\Bureau\backupdesktop\Julien\Functions')
plot3(FV.vertices(I,1),FV.vertices(I,2),FV.vertices(I,3),'bo','LineWidth',30)
INT=V;
Vec=Vcurl;
[hf,hs,hl]=view_surface('Bunny',FV.faces,FV.vertices);
hold on
for ii=10:65
    view_surface('Bunny',FV.faces,FV.vertices,I_pred(:,ii));
%     [Y,I1] = max((U(:,ii)));
%     [Y,I2] = min((U(:,ii)));
%     hq1=plot3(FV.vertices(I1,1),FV.vertices(I1,2),FV.vertices(I1,3),'bo','LineWidth',10);
%     hq2=plot3(FV.vertices(I2,1),FV.vertices(I2,2),FV.vertices(I2,3),'ro','LineWidth',10);
%     
%     [Y,I1] = max((V(:,ii)));
%     [Y,I2] = min((V(:,ii)));
%     hq3=plot3(FV.vertices(I1,1),FV.vertices(I1,2),FV.vertices(I1,3),'bo','LineWidth',10);
%     hq4=plot3(FV.vertices(I2,1),FV.vertices(I2,2),FV.vertices(I2,3),'ro','LineWidth',10);
    
%      hq=quiver3(FV.vertices(:,1),FV.vertices(:,2),FV.vertices(:,3),Vec(:,1,ii),Vec(:,2,ii),Vec(:,3,ii),'g')
% cd C:\brainstorm\Toolbox
[Y,I] = sort(norlig(H(:,:,ii)));
% cd('C:\Documents and Settings\khan\Bureau\backupdesktop\Julien\Functions')
cent=mean([FV.vertices(I(end),:); FV.vertices(I(end-1),:);FV.vertices(I(end-2),:) ]);
hq=plot3(cent(1),cent(2),cent(3),'b+','LineWidth',30);
   
pause(0.1)

delete(hq) 
%      delete(hq1)
%      delete(hq2)
%      delete(hq3)
%      delete(hq4)
end






figure
hist(norlig(H(:,:,30)),10)
title('H')
figure
hist(norlig(Jflowc.V(:,:,30)),10)
title('V')
figure
hist(norlig(Vcurl(:,:,30)),10)
title('Vcurl')(norlig(Jflowc.V(:,:,30)),10)
figure
hist(norlig(Vdiv(:,:,30)),10)
title('Vdiv')


theta=0:0.1:2*pi;

% INT=V;
Vec=Jflowc.V;
[hf,hs,hl]=view_surface('Bunny',sFV2.faces,sFV2.vertices);
hold on
% [hf,hs,hl]=view_surface('Bunny1',sFV2.faces,sFV2.vertices);
% hold on
for ii=125:200
    ii
%     abc=I_pred(:,ii);
% %     cba=norlig(H(:,:,ii));
% %     [Y I]=hist(abc);
% %     [Y1,I1] =hist(cba);
%      abc=abc>=I(end-4);
% %     cba=cba>=I1(end-3);
    
    view_surface('Bunny',sFV2.faces,sFV2.vertices,U(:,ii));
    hold on
%     [Y,I1] = max((U(:,ii)));
%     [Y,I2] = min((U(:,ii)));
%     hq1=plot3(FV.vertices(I1,1),FV.vertices(I1,2),FV.vertices(I1,3),'bo','LineWidth',10);
%     hq2=plot3(FV.vertices(I2,1),FV.vertices(I2,2),FV.vertices(I2,3),'ro','LineWidth',10);
%     
%     [Y,I1] = max((V(:,ii)));
%     [Y,I2] = min((V(:,ii)));
%     hq3=plot3(FV.vertices(I1,1),FV.vertices(I1,2),FV.vertices(I1,3),'bo','LineWidth',10);
%     hq4=plot3(FV.vertices(I2,1),FV.vertices(I2,2),FV.vertices(I2,3),'ro','LineWidth',10);
    
     hq=quiver3(sFV2.vertices(:,1),sFV2.vertices(:,2),sFV2.vertices(:,3),Vec(:,1,ii),Vec(:,2,ii),Vec(:,3,ii),3,'g');
% cd C:\brainstorm\Toolbox
% [Y,I] = sort(norlig(H(:,:,ii)))
% [Y1,I1] = sort(abs(I_pred(:,ii)))
% hq1=plot3(sFV2.vertices(I(end),1),sFV2.vertices(I(end),2),sFV2.vertices(I(end),3),'b.','LineWidth',1);
% hq2=plot3(sFV2.vertices(I1(end),1),sFV2.vertices(I1(end),2),sFV2.vertices(I1(end),3),'g.','LineWidth',1);
% clear Y Y1 I I1
% cd('C:\Documents and Settings\khan\Bureau\backupdesktop\Julien\Functions')
% a=null(norm_coord(I(end),:));% taking null space of tangent to vertex vector
% y=5*a(:,1)*cos(theta)+0.1*a(:,2)*sin(theta);
% % cent=mean([FV.vertices(I(end),:); FV.vertices(I(end-1),:);FV.vertices(I(end-2),:) ]);
% % hq=plot3(cent(1),cent(2),cent(3),'b+','LineWidth',30);
%    hq=plot3(y(1,:)+sFV2.vertices(I(end),1),y(2,:)+sFV2.vertices(I(end),2),y(3,:)+sFV2.vertices(I(end),3));
% view_surface('Bunny1',sFV2.faces,sFV2.vertices,cba);
pause

delete(hq) 
%      delete(hq1)
%      delete(hq2)
%      delete(hq3)
%      delete(hq4)
end