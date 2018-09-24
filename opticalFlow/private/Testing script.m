
FV = sphere_tri('ico',4,[],0);
[FieldV]=vector_field_sphere(FV,'theta');

% FieldV=Jflowc.V(:,:,2);
sFV2=FV;
[cont_grad_v,cont_grad_vb,grad_v,tangent_basis,tg_basis,aires,norm_tri,norm_coord,index1,index2]=matrices_contraintes_ter_divergence(sFV2.faces,sFV2.vertices,3);

B=zeros(length(sFV2.vertices),1);
B2=zeros(length(sFV2.vertices),1);
for i=1:size(sFV2.faces,1)
    % projection of flows.V(i,:,t) on the triangle i
    Pn=eye(3)-(norm_tri(i,:)'*norm_tri(i,:));
    nodes=sFV2.faces(i,:);
    V=mean(FieldV(nodes,:),1);
    projectV=V*Pn;
    for s=1:3
        % Just switch coments for A
        B(nodes(s),1)=B(nodes(s),1)+sum(projectV.*grad_v{s}(i,:)*aires(i),2);
        B2(nodes(s),1)=B2(nodes(s),1)+sum(projectV.*cross(grad_v{s}(i,:),norm_tri(i,:))*aires(i),2);
    end
end

[VertFaceConn,Pn]=vertices_faces_connectivity(sFV2,norm_coord);

U=(cont_grad_v)\B;
V=(cont_grad_vb)\B2;

Vc=curl(V,sFV2,grad_v,norm_tri);
Vd=curl(U,sFV2,grad_v);

%hq=quiver3(grav_tri(:,1),grav_tri(:,2),grav_tri(:,3),FieldV(:,1)-Vc(:,1)-Vd(:,1),FieldV(:,2)-Vc(:,2)-Vd(:,2),FieldV(:,3)-Vc(:,3)-Vd(:,3),10,'g')

Vcurl=tri2vert(Vc,VertFaceConn,Pn);
Vdiv=tri2vert(Vd,VertFaceConn,Pn);
H=FieldV-Vcurl-Vdiv;

[hf,hs]=view_surface('2',sFV2.faces,sFV2.vertices,U-mean(U))
hold on
hq=quiver3(sFV2.vertices(:,1),sFV2.vertices(:,2),sFV2.vertices(:,3),FieldV(:,1)-Vcurl(:,1)-Vdiv(:,1),FieldV(:,2)-Vcurl(:,2)-Vdiv(:,2),FieldV(:,3)-Vcurl(:,3)-Vdiv(:,3),1,'g')
hq=quiver3(sFV2.vertices(:,1),sFV2.vertices(:,2),sFV2.vertices(:,3),Vdiv(:,1),Vdiv(:,2),Vdiv(:,3),1,'r')
hq=quiver3(sFV2.vertices(:,1),sFV2.vertices(:,2),sFV2.vertices(:,3),FieldV(:,1),FieldV(:,2),FieldV(:,3),1,'b')