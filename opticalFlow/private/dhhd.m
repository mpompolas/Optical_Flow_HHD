function [curl_free,div_free,har_rem]=dhhd(mv)
%% Rearrange the input vector field into its components
mv_x=mv(:,:,1); %x-Coordinates of grid
mv_y=mv(:,:,2); %y-Coordinates of grid
mv_u=mv(:,:,3); %x-component of vector
mv_v=mv(:,:,4); %y-component of vector
%% Plot original motion field
figure;
quiver(mv_x,mv_y,mv_u,mv_v);
axis tight
title('Original Motion Field')
%% generate the curl-free and divergence-free curl_free_potntial
%functions
[curl_free_pot,div_free_pot]=potential_calculation...
(mv_x,mv_y,mv_u,mv_v);
%% display the curl-free potential function E
figure;
meshc(mv_x,mv_y,curl_free_pot);
title('curl free potential function');
%% display the divergence-free potential function W
figure;
meshc(mv_x,mv_y,div_free_pot);
title('divergence free potential function');
%% generate the curl-free field
[uu_E,vv_E]=gradient(curl_free_pot);
%% display the curl-free field
figure;
quiver(mv_x,mv_y,uu_E,vv_E);
axis tight
title('Curl free component of the field');
%% Store curl free field
curl_free(:,:,1) = uu_E;
curl_free(:,:,2) = vv_E;
%% CODE FOR COLOURED PLOTS
figure;
surf(mv_x,mv_y,div_free_pot,'FaceColor','interp',...
'EdgeColor','none',...
'FaceLighting','phong')
axis tight
view(-50,30)
title('Divergence free potential');
%camlight left
hold_state = ishold;
hold on;
a = get(gca,'zlim');
zpos = a(1); % Always put contour below the plot.
%% Get D contour data
[cc,hh] = contour3(mv_x,mv_y,div_free_pot,7);
for i = 1:length(hh)
zz = get(hh(i),'Zdata');
set(hh(i),'Zdata',zpos*ones(size(zz)));
end
figure;
surf(mv_x,mv_y,curl_free_pot,'FaceColor','interp',...
'EdgeColor','none',...
'FaceLighting','phong')
axis tight
title('curl free potential')
view(-50,30)
camlight left
hold_state = ishold;
hold on;
a = get(gca,'zlim');
zpos = a(1); % Always put contour below the plot.
%% Get D contour data
[cc,hh] = contour3(mv_x,mv_y,curl_free_pot,7);
for i = 1:length(hh)
zz = get(hh(i),'Zdata');
set(hh(i),'Zdata',zpos*ones(size(zz)));
end
%% generate the divergence-free field
[tmp_u,tmp_v]=gradient(div_free_pot);
uu_W=tmp_v; vv_W=-tmp_u;
%% display the divergence-free field
figure;
quiver(mv_x,mv_y,uu_W,vv_W);% axis ij; axis([-box,box,-box,box]);
title('Divergence free component of the field');
axis tight
%% Store the divergence free field
div_free(:,:,1) = uu_W;
div_free(:,:,2) = vv_W;
%% calculate the magnitude field of the input motion field
mag0=sqrt(mv_u.^2+mv_v.^2);
%% find the largest magnitude of the input motion field
max_mag0=max(max(mag0));
%% add the curl-free field and the divergence-free field
U1=uu_E+uu_W; V1=vv_E+vv_W;
%% calculate the magnitude field of the added motion field
mag1=sqrt(U1.^2+V1.^2);
%% find the largest magnitude of the added motion field
max_mag1=max(max(mag1));
%% calculate the scaling factor, r in the thesis
ratio=max_mag0/max_mag1;
%% solve for the harmonic remainder
ru=mv_u-ratio*U1; rv=mv_v-ratio*V1;
%% display the harmonic remainder
figure;
quiver(mv_x,mv_y,ru,rv);
axis tight
title('Harmonic remainder');
%% Store harmonice remainder
har_rem(:,:,1) = ru;
har_rem(:,:,2) = rv;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [potE,potW]=potential_calculation(mv_x,mv_y,mv_u,mv_v)
%% potE: the curl-free potential function W
%% potW: the divergence-free potential funciton W
%% mv_x: horizontal coordinates of the grids
%% mv_y: vertical coordinates of the grids
%% mv_u: horizontal components of the input motion field
%% mv_v: vertical components of the input motion field
[M,N]=size(mv_x); S1=construct_S1(mv_x,mv_y); %
%% construct the element matrix S1
[sa,sb]=size(S1);
Sr=S1(2:sa,2:sb);
ISr=inv(Sr);
potE=zeros(M,N);
potW=zeros(M,N);
[B,C]=construct_BC(mv_x,mv_y,mv_u,mv_v);
%% construct the two vector B and C
Br=B(2:sa); Cr=C(2:sa); Er=ISr*Br;
%% solve for the (L-1)x1 vector Er
Wr=ISr*Cr;
%% solve for the (L-1)x1 vector Wr
E_pot=[0;Er];
%% reconstruct the Lx1 vector E
W_pot=[0;Wr];
%% reconstruct the Lx1 vector W
potE=reshape(E_pot,M,N);
%% re-organize the MxN potential surface E
potW=reshape(W_pot,M,N);
%% re-organize the MxN potential surface W
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function S1=construct_S1(mv_x,mv_y)
%% mv_x: horizontal coordinates of the grids
%% mv_y: vertical coordinates of the grids
%% S1: the element matrix S1
%% generate the Node Table
mesh=mesh_points(mv_x,mv_y);
%% generate the Grid Table
triangle=triangle_definition(mv_x,mv_y);
%% generate the Basis Gradient Table
gradphi=phi_gradient(triangle,mesh);
M=size(mesh,1); S1=zeros(M,M);
%% calculate the element matrix S1
for i=1:M
%% search for the neighboring triangles and neighboring
%% nodes of a reference node
[neighbor_triangle neighbor_point]=get_neighbor(i,triangle);
L=length(neighbor_triangle);
for k=1:L
t=neighbor_triangle(k);
tri=triangle(t,:);
order_in_triangle=find(tri==i);
del_phi01=gradphi(t,order_in_triangle,1);
del_phi02=gradphi(t,order_in_triangle,2);
for j=1:3 mm=tri(j);
del_phi11=gradphi(t,j,1);
del_phi12=gradphi(t,j,2);
S1(i,mm)=S1(i,mm)+del_phi01*del_phi11 + ...
del_phi02*del_phi12;
end;
end;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [B,C]=construct_BC(mv_x,mv_y,mv_u,mv_v)
%% mv_x: horizontal coordinates of the grids
%% mv_y: vertical coordinates of the grids
%% mv_u: horizontal component of the input motion field
%% mv_v: vertical component of the input motion field
%% B: vector B
%% C: vector C
%% generate the Node Table
mesh=mesh_points(mv_x,mv_y); %% generate the Grid Table
triangle=triangle_definition(mv_x,mv_y);
%% generate the Average Vector Table
%changed mv_x(1,2) mv_y(2,1)
delta_x=mv_x(1,2)-mv_x(1,1); delta_y=mv_y(2,1)-mv_y(1,1);
UV=triangle_uv(triangle,mesh,mv_x(1,1),mv_y(1,1),...
delta_x,delta_y,mv_u,mv_v);
%% generate the Basis Gradient Table
gradphi=phi_gradient(triangle,mesh);
M=size(mesh,1); B=zeros(M,1); C=zeros(M,1);
%% calculate the vectors B and C
for i=1:M
%% search for the neighboring triangles and neighboring nodes
%% of a reference node i
[neighbor_triangle neighbor_point]=get_neighbor(i,triangle);
L=length(neighbor_triangle);
for k=1:L
t=neighbor_triangle(k);
tri=triangle(t,:);
order_in_triangle=find(tri==i);
del_phi01=gradphi(t,order_in_triangle,1);
del_phi02=gradphi(t,order_in_triangle,2);
B(i)=B(i)+del_phi01*UV(t,1)+del_phi02*UV(t,2);
C(i)=C(i)-del_phi01*UV(t,2)+del_phi02*UV(t,1);
end;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function xy=mesh_points(mv_x,mv_y)
%% generate the Node Table
%% mv_x: horizontal coordinates of the grids
%% mv_y: vertical coordinates of the grids
%% xy: the coordinates of all nodes
sz=size(mv_x);
MN=prod(sz);
xx=reshape(mv_x,MN,1);
yy=reshape(mv_y,MN,1);
xy=zeros(MN,2);
for i=1:MN
xy(i,1)=mv_y(i);
xy(i,2)=mv_x(i);
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function triangles=triangle_definition(mv_x,mv_y)
%% generate the Grid Table, which defines the grid topology
%% mv_x: horizontal coordinates of the grids
%% mv_y: vertical coordinates of the grids
%% triangles: Nodes of all triangular meshes,
%% i.e., the grid topology
[M,N]=size(mv_x);
period=(M-1);
total_tri=2*period*(N-1);
triangles=zeros(total_tri,3);
for i=1:N-1
for j=1:period
k=(i-1)*period+j;
start=floor((k-1)/period)*M+mod(k-1,period)+1;
triangles(2*k-1,:)=[start,start+M+1,start+M];
triangles(2*k,:)=[start,start+1,start+M+1];
end;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function UV = ...
triangle_uv(triangle,mesh,start_x,start_y,delta_x,delta_y,uu,vv)
%% generate the Average Vector Table
%% triangle: the Grid Table
%% mesh: the Node Table
%% start_x: start coordinate in horizontal direction
%% start_y: start coordinate in vertical direction
%% delta_x: step in horizontal direction
%% delta_y: step in vertical direction
%% uu: horizontal component of the input motion field
%% vv: vertical component of the input motion field
%% UV: The resulted Average Vector Table
M=size(triangle,1); UV=zeros(M,2);
for i=1:M
loc1=mesh(triangle(i,1),:);
loc2=mesh(triangle(i,2),:);
loc3=mesh(triangle(i,3),:);
ind_y1=floor((loc1(1)-start_y)/delta_y)+1;
ind_x1=floor((loc1(2)-start_x)/delta_x)+1;
ind_y2=floor((loc2(1)-start_y)/delta_y)+1;
ind_x2=floor((loc2(2)-start_x)/delta_x)+1;
ind_y3=floor((loc3(1)-start_y)/delta_y)+1;
ind_x3=floor((loc3(2)-start_x)/delta_x)+1;
UV(i,1)=(uu(ind_y1,ind_x1)+uu(ind_y2,ind_x2)...
+uu(ind_y3,ind_x3))/3;
UV(i,2)=(vv(ind_y1,ind_x1)+vv(ind_y2,ind_x2)...
+vv(ind_y3,ind_x3))/3;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function gradphi=phi_gradient(triangle,mesh)
%% generate the Basis Gradient Table
%% triangle: the Grid Table
%% mesh: the Node Table
%% gradphi: the resulted Basis Gradient Table
M=size(triangle,1);
gradphi=zeros(M,3,2);
area2=get_area2(triangle(1,:),mesh);
%% calculate the 2*triangle_area
AB=zeros(3,2);
for i=1:M y0=mesh(triangle(i,1),1);
x0=mesh(triangle(i,1),2);
y1=mesh(triangle(i,2),1);
x1=mesh(triangle(i,2),2);
y2=mesh(triangle(i,3),1);
x2=mesh(triangle(i,3),2);
AB(1,1)=y1-y2;
AB(1,2)=x2-x1;
AB(2,1)=y2-y0;
AB(2,2)=x0-x2;
AB(3,1)=y0-y1;
AB(3,2)=x1-x0;
for j=1:3
for k=1:2
gradphi(i,j,k)=-AB(j,k);
end;
end;
end; gradphi=gradphi/area2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [neighbor_triangle,neighbor_point]= ...
get_neighbor(node,triangle)
%% get the neighboring triangles and neighboring nodes of a node
%% node: the reference node
%% triangle: the Grid Table
%% neighbor_triangle: the neighbor triangles of the reference node
%% neighbor_point: the neighbor points of the reference node
M=size(triangle,1);
neighbor_triangle=[];
for i=1:M
temp=triangle(i,:);
if find(temp==node)>0
neighbor_triangle=[neighbor_triangle i];
end;
end;
neighbor_point=[];
N=length(neighbor_triangle);
for i=1:N
temp=triangle(neighbor_triangle(i),:);
for j=1:3
if find(neighbor_point==temp(j))>0
continue;
else
neighbor_point=[neighbor_point temp(j)];
end;
end;
end;
neighbor_point=sort(neighbor_point);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function area2=get_area2(triangle,mesh)
%% calculate the 2*triangle_area of a triangle
%% triangle: the Grid Table
%% mesh: the Node Table
%% area2: the resulted 2*triangle_area
x0=mesh(triangle(1),1);
y0=mesh(triangle(1),2);
x1=mesh(triangle(2),1);
y1=mesh(triangle(2),2);
x2=mesh(triangle(3),1);
y2=mesh(triangle(3),2);
area2=abs((x1-x0)*(y2-y0)-(x2-x0)*(y1-y0));
