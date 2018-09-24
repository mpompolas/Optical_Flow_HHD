FV = sphere_tri('ico',4,[],0);

[FieldV]=vector_field_sphere(FV,'theta');

view_surface('lapin',FV.faces,FV.vertices,U)
hold on
quiver3(FV.vertices(:,1),FV.vertices(:,2),FV.vertices(:,3),H(:,1),H(:,2),H(:,3),'g')

a.V=FieldV;
a.vertices=FV.vertices;
a.faces=FV.faces;
a.t=1;
[U A H Vcurl Vdiv index]=hhdr_recursive(a,1 ,1:1);