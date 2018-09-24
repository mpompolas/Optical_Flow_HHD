
function [indx]=index(VF)
% Compute the index of a vector field VF along a curve (whose it is not
% necessary to give the coordinates !!)
% VF has dimension 2*nbr vectors

theta=myangle(VF);
theta=[theta,theta(1)];
difftheta=diffangle(theta(2:end),theta(1:end-1));
indx=sum(difftheta)/(2*pi);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% gives the good angle of a vector (between 0 and 2pi)

function [theta]=myangle(v) 
normv=sqrt(sum(v.^2,1));
c=v(1,:)./normv;
s=v(2,:)./normv;
theta=zeros(1,size(v,2));

for ii=1:size(v,2)
    ang=acos(c(ii));
    if s(ii)>=0
        theta(ii)=ang;
    else
        theta(ii)=-ang+2*pi;
    end
end
% theta(s>=0)=acos(c(s>=0));
% theta(s<0)=-acos(c(s<0))+2*pi;

% difference of two angles (result between -pi and pi

function [theta]=diffangle(theta2,theta1)
theta=theta2-theta1;
for ii=1:length(theta)
    ang=theta(ii);
    if ang<-pi
        theta(ii)=ang+2*pi;
    else
        if ang>pi
            theta(ii)=ang-2*pi;
        end
    end
end
% theta(theta<-pi)=theta(theta<-pi)+2*pi;
% theta(theta>pi)=theta(theta>pi)-2*pi;


return
%%% "Statistique" des points critiques %%% 

%tic
Nsimu=40000;
intv=[100:50:2000];
N=length(intv);
stat_glob=zeros(3,Nsimu);
temps=zeros(N,1);
%stat_index=zeros(1,N);
for j=1:N
    t1=cputime;
    for i=1:intv(j)
        %tirer aléatoirement un vecteur de norme 1 dans le plan = tirer
        %aléatoirement un angle
        theta=2*pi*rand(1,3);
        stat_index(i)=index([cos(theta);sin(theta)]);
    end
    temps(j)=cputime-t1;
    % stat_glob(1,j)=length(find(abs(stat_index-1)<1e-10));
    % stat_glob(2,j)=length(find(abs(stat_index+1)<1e-10));
    % stat_glob(3,j)=length(find(abs(stat_index)<1e-10));
end
%toc

indices={'+1','-1','0'}
for i=1:3
    echan=stat_glob(i,:);
    m=min(echan);
    M=max(echan);
    figure
    hist(echan,m:M);
    xlim([m M])
    title(['Loi Indice = ',indices{i},' Moyenne ',num2str(mean(echan)*100/N),' Ecart Type ',num2str(std(echan)*100/N)]) 
end

x=[0 1 0];
y=[1 0 0];
theta=2*pi*rand(1,3);
V=[cos(theta);sin(theta)];
quiver(x,y,V(1,:),V(2,:));

%%%% vieux délire %%%%



VFc=[VF,VF(:,1)]; % closed curve
diffVF=diff(VFc')';
costheta=sum((VF-diffVF).*VFc(:,2:end),1); % cosinus of angle between v_i and v_(i+1)
for i=1:size(VF,2)
    sintheta(1,i)= det([VF(:,i),VFc(:,i+1)]);
end
cotantheta= costheta./sintheta;
normVFc=sqrt(sum(VFc.^2,1));
angle1=-normVFc(1:end-1).*cotantheta./normVFc(2:end);
indx=sum(myatan(angle1)-myatan(cotantheta),2)/(2*pi);