%tangent circle
[hf,hs,hl]=view_surface('Bunny',FV.faces,FV.vertices);
hold on
theta=0:0.1:2*pi;
a=null(norm_coord(848,:));% taking null space of tangent to vertex vector

y=0.25*a(:,1)*cos(theta)+0.25*a(:,2)*sin(theta);
plot3(y(1,:)+FV.vertices(848,1),y(2,:)+FV.vertices(848,2),y(3,:)+FV.vertices(848,3))


plot3(y(1,:)+1,y(2,:)+1,y(3,:)+1)% if center is not origion add Cx to y1 Cy to y2 and C3 to y3
hold on
plot3(y(1,:)+9,y(2,:)+9,y(3,:)+7)% if center is not origion add Cx to y1 Cy to y2 and C3 to y3
plot3(y(1,:)+5,y(2,:)+5,y(3,:)+9)% if center is not origion add Cx to y1 Cy to y2 and C3 to y3
plot3(y(1,:)+5,y(2,:)+1,y(3,:)+3)% if center is not origion add Cx to y1 Cy to y2 and C3 to y3
plot3(y(1,:)+1,y(2,:)+1,y(3,:)+1)% if center is not origion add Cx to y1 Cy to y2 and C3 to y3