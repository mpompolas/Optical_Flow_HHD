% % % Defining Grid
x = -1:0.1:1; y = -1:0.1:1;    
[xx,yy] = meshgrid(x,y);     
% vector Field
px = yy;
py = -xx;


% x = -2:.2:2; y = -1:.2:1;    
% [xx,yy] = meshgrid(x,y);     
% s = xx.*exp(-xx.^2-yy.^2);
% % figure(1);surf(x,y,s);shading interp;
% % rotate3d;
% % xlabel('x');ylabel('y');zlabel('s');
% % title('2-D space varying scalar field: s = x e^{-(x^2+y^2)}');
% [px,py] = gradient(s,.2,.2);


% x = 0:0.25:1.5; y = 0:0.25:1.5;
% [xx,yy] = meshgrid(x,y);     
% px=2*ones(size(xx)); py=zeros(size(xx));


x = -2:0.2:2; y = -2:0.2:2;    
[xx,yy] = meshgrid(x,y);     
px = xx./(xx.^2+yy.^2);
py = yy./(xx.^2+yy.^2);

figure
quiver(xx,yy,px,py);
axis tight
title('Original Motion Field')                    



[M,N] = size(xx);
mv=zeros(M,N,4);
mv(:,:,1)=xx;
mv(:,:,2)=yy;
mv(:,:,3)=px;
mv(:,:,4)=py;
dhhd(mv)


[curl_free_pot,div_free_pot]=potential_calculation(xx,yy,px,py);
temp=mean(mean([curl_free_pot div_free_pot]));
temp1=std(std([curl_free_pot div_free_pot]));





[zmax,imax,zmin,imin] = extrema2(curl_free_pot);
a=find(zmax <= temp+4*temp1);
imax(a)=[];
zmax(a)=[];
a=find(zmin >= temp-4*temp1);
imin(a)=[];
zmin(a)=[];

     hold on  
    plot3(xx(imax),yy(imax),zmax,'bo',xx(imin),yy(imin),zmin,'ro','LineWidth',10)

 plot3(FV.vertices(I(end),1),FV.vertices(I(end),2),FV.vertices(I(end),3),'ro',FV.vertices(I(end-1),1),FV.vertices(I(end-1),2),FV.vertices(I(end-1),3),'ro',FV.vertices(I(end-2),1),FV.vertices(I(end-2),2),FV.vertices(I(end-2),3),'ro','LineWidth',50)
[zmax,imax,zmin,imin] = extrema2(div_free_pot);
a=find(zmax <= temp+4*temp1);
imax(a)=[];
zmax(a)=[];
a=find(zmin >= temp-4*temp1);
imin(a)=[];
zmin(a)=[];

 plot3(xx(imax),yy(imax),zmax,'b+',xx(imin),yy(imin),zmin,'r+','LineWidth',10)
     hold off 
% [curl_free,div_free,har_rem]=dhhd(mv);

% [bxx,bxy]=gradient(curl_free(:,:,1),0.2,0.2);
% [byx,byy]=gradient(curl_free(:,:,2),0.2,0.2);
% 
% div_b=(bxx+byy);
% 
% figure;surf(x,y,div_b);shading interp;rotate3d;
% xlabel('x');ylabel('y');
% title('Divergence of 2-D vector field');


[X,Y] = meshgrid([-2:.25:2]);
Z = X.*exp(-X.^2-Y.^2);
[cs,h]=contour3(X,Y,Z,30);
clabel(cs,h)
surface(X,Y,Z,'EdgeColor',[.8 .8 .8],'FaceColor','none')
grid off
view(-15,25)
colormap cool
