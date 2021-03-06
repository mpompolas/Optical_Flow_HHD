function [ord,thres2b,stablestate,stable_borders,diffMm]=microstate_seg4(flowj,seuil,type)

if nargin==1
    seuil=0.95;
end

Time=flowj.t;
[m,tstim]=min(abs(Time));

baseline=[1:tstim];gpowerflow_noise=sqrt(flowj.de(baseline,:))';
gpowerflow_signal=sqrt(flowj.de(tstim+1:end,:))';
%11med_sign=median(gpowerflow_signal);


% Parameters on noise
[vM,indM]=lmax(gpowerflow_noise,1);
[vm,indm]=lmin(gpowerflow_noise,1);

ordm=[indm;vm;ones(1,length(vm))];
ordM=[indM;vM;2*ones(1,length(vM))];
ord=sortrows([ordm ordM]'); 

diffMm=abs(diff(ord(:,2)));
%thres2=max(diffMm); 
%% ou  
sdiffMm=sort(diffMm);
% ind=find(sdiffMm>seuil*max(diffMm));
% thres2b=sdiffMm(ind(1));
thres2b=mean(sdiffMm)+seuil*std(diffMm);
%Signal
[vm,indm]=lmin(gpowerflow_signal,3);


nstate=1;
currstate=1; %-1 for transition state
stablestate=[indm;zeros(1,length(indm))];
stablestate(2,1)=nstate;


for ii=1:length(indm)-1
    if type=='old'
        M=max(gpowerflow_signal(indm(ii):indm(ii+1)));
        di1=gpowerflow_signal(indm(ii));
        di2=gpowerflow_signal(indm(ii+1));
        if di1>di2
            if M-di1>thres2b
                nstate=nstate+1;
                currstate=nstate;
                stablestate(2,ii+1)=currstate;
            else
                if (M-di2>thres2b) & (currstate==-1)
                    nstate=nstate+1;
                    currstate=nstate;
                    stablestate(2,ii+1)=currstate;
                else
                    stablestate(2,ii+1)=currstate;
                end
            end
        else
            if M-di2>thres2b
                if currstate==-1
                    stablestate(2,ii+1)=currstate;
                else
                    nstate=nstate+1;
                    currstate=nstate;
                    stablestate(2,ii+1)=currstate;
                end
            else
                if M-di1>thres2b
                    currstate=-1;
                    stablestate(2,ii+1)=currstate;
                else
                    stablestate(2,ii+1)=currstate;
                end
            end
        end


    else
        M=max(gpowerflow_signal(indm(ii):indm(ii+1)));
        di1=gpowerflow_signal(indm(ii));
        di2=gpowerflow_signal(indm(ii+1));
        if currstate==-1
            if (M-di2)<thres2b
                currstate=-1;
                stablestate(2,ii+1)=currstate;
            else
                nstate=nstate+1;
                currstate=nstate;
                stablestate(2,ii+1)=currstate;
            end
        else
            if (M-di1)<thres2b
                stablestate(2,ii+1)=currstate;
            else
                if (M-di2)<thres2b
                    currstate=-1;
                    stablestate(2,ii+1)=currstate;
                else
                    nstate=nstate+1;
                    currstate=nstate;
                    stablestate(2,ii+1)=currstate;
                end
            end
        end
    end
end
good_indices=find(stablestate(2,:)~=-1);
% for ii=1:length(indm)-1
%     M=max(gpowerflow_signal(indm(ii):indm(ii+1)));
%     if max(M-gpowerflow_signal(indm(ii)),abs(M-gpowerflow_signal(indm(ii+1))))<thres2b
%         stablestate(2,ii+1)=nstate;
%     else
%         if 

%         nstate=nstate+1;
%         stablestate(2,ii+1)=nstate;
%     end
% end

% stable_borders % N*2 : (i,1) debut stable, (i+1,2) fin stable
stablestate=stablestate(:,good_indices);
%return
[tm,tMsup]=intermediate_values(gpowerflow_signal,indm(1),thres2b+gpowerflow_signal(indm(1)));
% stable_borders(1,1)=tm;
% stable_borders(1,2)=0;
bord=1;
ns=1;
for ii=1:length(stablestate)-1
     % number of stable state
    if stablestate(2,ii)==stablestate(2,ii+1)
        if bord %bord==1 when i-1 and i
            [tm,tMsup]=intermediate_values(gpowerflow_signal,stablestate(1,ii),thres2b+gpowerflow_signal(stablestate(1,ii)));
            stable_borders(ns,1)=tm;
            bord=0;
        else
        end
    else
        if bord
            [tm,tMsup]=intermediate_values(gpowerflow_signal,stablestate(1,ii),thres2b+gpowerflow_signal(stablestate(1,ii)));
            stable_borders(ns,1)=tm;
        else
        end
        [tm,tMsup]=intermediate_values(gpowerflow_signal,stablestate(1,ii),thres2b+gpowerflow_signal(stablestate(1,ii)));
        stable_borders(ns,2)=tMsup;
        ns=ns+1;
        bord=1;
    end %stablestate(2,ii) 
    
end

ii=ii+1;
[tm,tMsup]=intermediate_values(gpowerflow_signal,stablestate(1,ii),thres2b+gpowerflow_signal(stablestate(1,ii)));
if stablestate(2,ii)==stablestate(2,ii-1)
    stable_borders(ns,2)=tMsup;
else
    stable_borders(ns,1)=tm;
    stable_borders(ns,2)=tMsup;
end

if stable_borders(1,1)>1
    stable_borders=[1 1;stable_borders];
end
if stable_borders(end,2)<length(gpowerflow_signal)
    stable_borders=[stable_borders;length(gpowerflow_signal) length(gpowerflow_signal)];
end
%%%%%%%%%
% GRAPHE
law=sort(gpowerflow_noise);
ind=find(law>0.95*max(law));
thres=law(ind(1));

M=max(gpowerflow_signal);
GRAPH=1;

if GRAPH
figure
de=plot(flowj.t,sqrt(flowj.de),'MarkerFaceColor','k','LineWidth',3,'Color',[0 0 0]);
set(gcf,'Color','w','Position', [37 244 1190 613])
hold on
%line(repmat([Time(1) ; Time(end)],1,100),repmat(thres,2,1),'Color',[0 0 0],'LineWidth',1.5);
ys=[0 0 thres thres];
yus=[thres thres M M];
ys=[0 0 M M];
yus=[0 0 M M];
% ys=[0 0 M M]; 
% yus=[0 0 M M]; 
if 1
    cstable=[0.45 0.45 0.45];%[0.15 0.15 0.15];
    cunstable=[0.9 0.9 0.9];[0.45 0.45 0.45];
    astable=0.4;
    aunstable=0.2;
else
cstable=[0 0 1];
cunstable=[1 0 0];
astable=0.4;
aunstable=0.2;
end

for ii=1:size(stable_borders,1)-1
    try
%     thres1=gpowerflow_signal(stable_borders(ii,:));
%     thres2=[gpowerflow_signal(stable_borders(ii,2)),gpowerflow_signal(stable_borders(ii+1,2))];
%     ys=[0 0 thres1(1) thres1(2)];
%     yus=[thres2(1) thres2(2) M M];

h1=area(Time(stable_borders(ii,1)+tstim-1:stable_borders(ii,2)+tstim-1),gpowerflow_signal(stable_borders(ii,1):stable_borders(ii,2))...
    ,'FaceColor',cstable);%,'FaceAlpha',astable); 

X=Time(stable_borders(ii,2)+tstim-1:stable_borders(ii+1,1)+tstim-1);
Y=[gpowerflow_signal(stable_borders(ii,2):stable_borders(ii+1,1))];%;M*ones(1,length(X))];
h2=area(X,Y','FaceColor',cunstable,'BaseValue',M);%,'FaceAlpha',aunstable); 

%     h1=patch([Time(stable_borders(ii,1)+tstim-1) Time(stable_borders(ii,2)+tstim-1)...
%         Time(stable_borders(ii,2)+tstim-1) Time(stable_borders(ii,1)+tstim-1) ],ys,cstable,'FaceColor',cstable,'FaceAlpha',astable);
%     h2=patch([Time(stable_borders(ii,2)+tstim-1) Time(stable_borders(ii+1,1)+tstim-1)...
%         Time(stable_borders(ii+1,1)+tstim-1) Time(stable_borders(ii,2)+tstim-1) ],yus,cunstable,'FaceColor',cunstable,'FaceAlpha',aunstable);
    catch
    end
end
ii=ii+1;
h1=area(Time(stable_borders(ii,1)+tstim-1:stable_borders(ii,2)+tstim-1),gpowerflow_signal(stable_borders(ii,1):stable_borders(ii,2))...
    ,'FaceColor',cstable);
% thres1=gpowerflow_signal(stable_borders(ii,:));
% ys=[0 0 thres1(1) thres1(2)];
    %patch([Time(stable_borders(ii,1)+tstim-1) Time(stable_borders(ii,2)+tstim-1)...
        %Time(stable_borders(ii,2)+tstim-1) Time(stable_borders(ii,1)+tstim-1) ],ys,cstable,'FaceColor',cstable,'FaceAlpha',0.2);

xlabel('Time (s)','FontSize',20)
ylabel('U','FontSize',20)
xlim([Time(1) Time(end)])%xlim([Time(tstim) Time(end)])
set(gca,'FontSize',20)
[m,ind]=max(gpowerflow_noise);
if 1
    carrow=[0 0 0];
else
    carrow='r';
end
q1=quiver(Time(ind),m/2-thres2b/2,0,1.5*thres2b/2,'-v','MarkerSize',5,'LineWidth',2,'Color',carrow);
q2=quiver(Time(ind),m/2+thres2b/2,0,-1.5*thres2b/2,'-^','MarkerSize',5,'LineWidth',2,'Color',carrow);
%qglob=copyobj([q1 q2],gca);
[legend_h,object_h,plot_h,text_strings]=legend([h1,h2,de],{'Stable State','Transition State','U'},'Location','NorthWest');
legend('boxoff');
%set(object_h(4),'FaceAlpha',astable);
%set(object_h(5),'FaceAlpha',aunstable);

% quiver(Time(ind),m/2-thres2b/2,0,1.5*thres2b/2,'MarkerSize',6,'LineWidth',2,'Color',carrow)
% quiver(Time(ind),m/2+thres2b/2,0,-1.5*thres2b/2,'MarkerSize',6,'LineWidth',2,'Color',carrow)
end
axis([-0.1 0.25 0 M])
%%%%%%%%%%%


return
%%%%
% TRUC OVER MEGA RELOU NAZE
[vM,indM]=lmax(gpowerflow_signal,3);
[vm,indm]=lmin(gpowerflow_signal,3);

ordm=[indm;vm;ones(1,length(vm))];
ordM=[indM;vM;2*ones(1,length(vM))];
ord=sortrows([ordm ordM]'); 


x0=ord(1,1);
y0=sqrt(flowj.de(x0+tstim-1));
%x1=x0;
Mm=ord(1,3); % mM=1 min, mM=2, max
i1=find(ind>=stable_borders(:,1)); 
try
i1=i1(end);
catch
    i1=[];
end

i2=find(ind>=stable_borders(:,2));
try    
i2=i2(end);
catch
    i2=[];
end
if Mm==1
    if i1<i2 % ii is a local minimum in transition state
    else
        %y0=y1;
        y1=sqrt(flowj.de(x0+tstim-1))+thres2b;
    end
else
    if i1>i2 %ii is a local maximum in stable state
    else
        %y0=y1;
        y1=sqrt(flowj.de(x0+tstim-1))-thres2b;
    end
end

for ii=1:length(ord)-1
    ind=ord(ii,1);
    indp=ord(ii+1,1);
    Mm=ord(ii,3); % mM=1 min, mM=2, max
    i1=find(ind>=stable_borders(:,1));
    try
        i1=i1(end);
    catch
        i1=[];
    end
    i2=find(ind>=stable_borders(:,2));
    try
        i2=i2(end);
    catch
        i2=[]
    end

    line([Time(ind+tstim-1) Time(ind+tstim-1)],[y0 y1],'Color',[0 0 0],'LineWidth',2,'LineStyle','--')
    line([Time(ind+tstim-1) Time(indp+tstim-1)],[y1 y1],'Color',[0 0 0],'LineWidth',2,'LineStyle','--')

    %x0=indp;
    %x1=x0;
    if Mm==1
        if i1<i2 % ii is a local minimum in transition state
        else
            y0=y1;
            y1=sqrt(flowj.de(ind+tstim-1))+thres2b;
        end
    else
        if i1>i2 %ii is a local maximum in stable state
        else
            y0=y1;
            y1=sqrt(flowj.de(ind+tstim-1))-thres2b;
        end
    end

    %     if Mm==1 & (i1<i2)
    %         x0=indp;
    %         x1=x0;
    %     else
    %         x0=indp;
    %         x1=x0;
    %         if Mm==2
    %             y0=y1;
    %             y1=sqrt(flowj.de(x0+tstim-1))-thres2b;
    %         else
    %             y0=y1;
    %             y1=sqrt(flowj.de(x0+tstim-1))+thres2b;
    %         end
    %     end

    %     if mM==1 & (i1<i2)
    %         y1=yo+thres2b;
    %     else
    %         if mM==2
    %             y1=sqrt(flowj.de(x0+tstim-1))-thres2b;
    %         end
    %     end
    %     %eps=-2*mM+3;
    %     %Time(stable_borders(ii,1)+tstim-1)
    %     line([Time(x0+tstim-1) Time(x0+tstim-1)],[y0 y1])
    %     line([Time(x0+tstim-1) Time(indp+tstim-1)],[y1 y1])
    %     x0=indp;
    %     if mM==1 & (i1<i2)
    %     else
    %         y0=sqrt(flowj.de(x0+tstim-1));
    %     end
end


function [tm,tM]=intermediate_values(curve,ind,thres)
% Find the nearest indices before and after ind such that curve==thres
tm=ind;
tM=ind;
while curve(tm)<thres & tm>1
    tm=tm-1;
end

while curve(tM)<thres & tM<length(curve)
    tM=tM+1;
end



return

% SNR=std(gpowerflow_signal)/std(gpowerflow_noise);
% law=gpowerflow_noise;
% %law=law/max(law);
% law=sort(law);
% ind=find(law>seuil*max(law));
% if nargin<3
%     thres=law(ind(1));
% end
%     
% stable_state=find(gpowerflow_signal<=thres);
% unstable_state=find(gpowerflow_signal>thres);
% 
% dstable=diff(stable_state)-1;
% trans1=find(dstable);
% %trans1=[1,trans,intv2-tstim+1];
% 
% dunstable=diff(unstable_state)-1;
% trans2=find(dunstable);
% 
% ord1=[stable_state(trans1) stable_state(end);ones(1,length(trans1)+1)];
% ord2=[unstable_state(trans2) unstable_state(end);2*ones(1,length(trans2)+1)];
% 
% ord=sortrows([ord1 ord2]');
% 
% first=[stable_state(1) unstable_state(1);1 2]';
% last=[stable_state(end) unstable_state(end);1 2]';
% 
% [m,v]=min(first);
% [M,V]=max(last);
% 
% ord=[first(v(1),:); ord ; last(V(1),:)];
% 
% 
% flowj.thres=thres;
% figure
% plot(flowj.t,sqrt(flowj.de),'MarkerFaceColor','k','LineWidth',2)
% set(gcf,'Color','w')
% hold on
% line(repmat([Time(1) ; Time(end)],1,100),repmat(thres,2,1),'Color','r');
% 
% M=max(gpowerflow_signal);
% 
% for ii=1:length(ord)-1
%     state1=ord(ii,2);
%     state2=ord(ii+1,2);
%     state=(state1-1)+ (state2-1)*10;
%     switch state
%         case 0 %[1 1]
%             y=[0 0 thres thres];
%             c=[0 0 1];
%         case 10 %[1 2]
%             y=[thres thres M M];
%             c=[1 0 0];
%         case 1 %[2 1]
%             y=[0 0 thres thres];
%             c=[0 0 1];
%         case 11 %[2 2]
%             y=[thres thres M M];
%             c=[1 0 0];
%     end
%     patch([Time(ord(ii,1)+tstim-1) Time(ord(ii+1,1)+tstim-1)...
%         Time(ord(ii+1,1)+tstim-1) Time(ord(ii,1)+tstim-1) ],y,c,'FaceColor',c,'FaceAlpha',0.2)
% end
% xlabel('Time (ms)')
% ylabel('DE (a.u.)')
% xlim([Time(tstim) Time(end)])