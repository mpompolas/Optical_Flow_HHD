function [hs]=vizualisation(flowc,temps,OPTIONS)
% Vizualisation of 
sA=OPTIONS.seuilA;
if ~isfield(flowc,'F')
    tri=temps.faces;
    coord=temps.vertices;
    Mtt=max(abs(flowc(:,:)));
    seuilF=abs(flowc(:,:));
    seuilF(seuilF<sA)=0;
    [hf,hs,hl]=view_surface('Pred',tri,coord,seuilF);hold on
    %mytext=text(0,0.08,0,num2str(flowc.t(tt)));
    set(gcf,'Color',[1 1 1])
    view(-80,44)
    return
end

if length(temps)==1

else
    mov = avifile(OPTIONS.filename,'fps',15,'compression','Indeo3','quality',100);
end


%sF=OPTIONS.seuilF;
sV=OPTIONS.seuilV;
for tt=temps%600:1200;
    if exist('OPTIONS.M')
        Mtt=OPTIONS.M;
    else
        Mtt=max(abs(flowc.F(:,tt)));
    end
    seuilF=abs(flowc.F(:,tt));
    seuilF(seuilF<sA)=0;%0.2*Mtt;
    if ~(exist('hs'))
        [hf,hs,hl]=view_surface('lapin',flowc.faces,flowc.vertices,seuilF);hold on
        %fleche=quiver3(0,0,0,0,0,-0.001);
        view(-90,40)
        ylim([-0.06,0.06])
        %mytext=text(0,0.08,0,num2str(flowc.t(tt)));
        set(gcf,'Color',[1 1 1])

    else
%         vertxcolor = blend_anatomy_data(zeros(size(seuilF,1),1),seuilF);%Curvature
%         %vertxcolor=seuilF;
         set(hs,'FaceVertexCData',seuilF)
    end
    if isfield(OPTIONS,'Curvature')
        seuilF(end)=Mtt;
        vertxcolor = blend_anatomy_data(OPTIONS.Curvature,seuilF,NaN,0.6);
        %vertxcolor
        set(hs,'FaceVertexCData',vertxcolor)
    end
    %caxis([0 Mtt]) % marche pas !!??
    % methode roots
    
    if OPTIONS.fleche
        hold on
        norV(:,tt)=sum(flowc.V(:,:,tt).^2,2);
        maxf=max(norV(:,tt));
        indices=find(norV(:,tt)>sV*maxf);
        if isempty(indices)
            fleche=quiver3(0,0,0,0,0,-0.001);
        else
            %fleche=quiver3(flowc.coord(indices,1),flowc.coord(indices,2),flowc.coord(indices,3),flowc.V(indices,1,tt),flowc.V(indices,2,tt),flowc.V(indices,3,tt),1,'Color','g');
            coeff=1.8;%maxf/M;
            fleche=quiver3d(flowc.vertices(indices,1),flowc.vertices(indices,2),flowc.vertices(indices,3),flowc.V(indices,1,tt),flowc.V(indices,2,tt),flowc.V(indices,3,tt),[0 1 0],coeff);

        end
    end
    % Film
    %mov = avifile('D:\users\Experiences\Patrice\Studies\ALP_Catch.avi','fps',3,'compression','Indeo5','quality',100)
    ylim([-0.06,0.06])
    if length(temps)>1
%         if mod(tt,5)==0
%             delete(mytext)
%             mytext=text(0,0.05,-0.02,[num2str(1000*flowc.t(tt)) ' ms']);%mytext=text(0,0.03,0,[num2str(1000*flowc.t(tt)) ' ms']);%text(-0.1,-0.06,0,[num2str(1000*flowc.t(tt)) ' ms']);
%         end

        M = getframe(hf);
        mov = addframe(mov,M);
        pause(1)
        
        if ~exist('fleche')

        else
            delete(fleche)
        end

        
    end
    

end

if length(temps)>1
    mov = close(mov);
end