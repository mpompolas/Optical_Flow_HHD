% close all; clear;
% x = -2:.2:2; y = -1:.2:1;    
% [xx,yy] = meshgrid(x,y);     
% 
%  
% % Set graphics parameters.
% axis([-2 2 -2 2]);
% hold on
% 
% % Generate the movie.
% delt = 0.1;
% nframes = 24;
M = moviein(751);
for k = 624:1374, 
    % Coefficients
%     t = k*delt;
%     s = xx.*exp(-t.*xx.^2-t.*yy.^2);
%    [px,py] = gradient(s,.2,.2);
% % 
% % px = yy-t;
% % py = -xx;
% 
% [curl_free_pot,div_free_pot]=potential_calculation(xx,yy,px,py);
% temp=mean(mean([curl_free_pot div_free_pot]));
% temp1=std(std([curl_free_pot div_free_pot]));
% [zmax,imax,zmin,imin] = extrema2(curl_free_pot);
% a=find(zmax <= temp+4*temp1);
% imax(a)=[];
% zmax(a)=[];
% a=find(zmin >= temp-4*temp1);
% imin(a)=[];
% zmin(a)=[];
% 
% 
%    cla;
%    quiver(x,y,px,py,2);
%    axis tight
%    plot3(xx(imax),yy(imax),zmax,'go',xx(imin),yy(imin),zmin,'ro','LineWidth',10)
%    
%    [zmax,imax,zmin,imin] = extrema2(div_free_pot);
% a=find(zmax <= temp+10*temp1);
% imax(a)=[];
% zmax(a)=[];
% a=find(zmin >= temp-6*temp1);
% imin(a)=[];
% zmin(a)=[];

%  plot3(xx(imax),yy(imax),zmax,'y+',xx(imin),yy(imin),zmin,'m+','LineWidth',10)
    % Capture the frame
%     view_surface('MNE',FV.faces,FV.vertices,PARAM.F(:,k));
U1=abs(U(:,k));
view_surface('MNE',FV.faces,FV.vertices,U1);
    M(:,k-623) = getframe(gca);
   clf
 end;
hold off
movie2avi(M,'U2','fps',5)

