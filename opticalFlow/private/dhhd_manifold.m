

% [filename, pathname] = uigetfile( ...
%     {'*.mat', 'All MAT-Files (*.mat)'; ...
%         '*.*','All Files (*.*)'}, ...
%     'Select Tessalation data');
% % If "Cancel" is selected then return
% if isequal([filename,pathname],[0,0])
%     return
%     % Otherwise construct the fullfilename and Check and load the file.
% else
%     File = fullfile(pathname,filename);
% end
% 
%     load(File);
%     % if the MAT-file is not valid, do not save the name
% 
% 
% 
% FV.faces=Faces{1};
% FV.vertices=Vertices{1}';
% [NFV,remove_vertices]=tessellation_redundancies(FV,1,1e-15);
% faces=NFV.faces;
% vertices=NFV.vertices;
% 
% [filename, pathname] = uigetfile( ...
%     {'*.mat', 'All MAT-Files (*.mat)'; ...
%         '*.*','All Files (*.*)'}, ...
%     'Select opticalFlow data');
% % If "Cancel" is selected then return
% if isequal([filename,pathname],[0,0])
%     return
%     % Otherwise construct the fullfilename and Check and load the file.
% else
%     File = fullfile(pathname,filename);
% end
% 
% load(File);

FV = sphere_tri('ico',4,[],0);
[FieldV]=vector_field_sphere(FV,'theta');

 result=cell(1); 
% faces=FV.faces;
% vertices=FV.vertices;
% TriConn = faces_connectivity(FV);
VertConn = vertices_connectivity(FV);
A=zeros(1494,70);
% [cont_grad_v,grad_v,tangent_basis,tg_basis,aires,norm_tri,norm_coord,index1,index2]=matrices_contraintes_ter_divergence(FV.faces,FV.vertices,3);
for iiiii=1:70
   iiiii
FieldV=Jflowc.V(:,:,iiiii);

B=zeros(length(FV.vertices),1);
for i=1:size(FV.faces,1)
        % projection of flows.V(i,:,t) on the triangle i
        Pn=eye(3)-(norm_tri(i,:)'*norm_tri(i,:));

        nodes=FV.faces(i,:);
        V=mean(FieldV(nodes,:),1);
        
        projectV=V*Pn;
        

for s=1:3
% B(nodes(s),1)=B(nodes(s),1)+sum(projectV.*grad_v{s}(i,:)*aires(i),2);
 B(nodes(s),1)=B(nodes(s),1)+sum(projectV.*cross(grad_v{s}(i,:),norm_tri(i,:))*aires(i),2);
end

end

% if all(B==0)
%     result{iiiii}.DE=0;
%     result{iiiii}.BigCluster=[];
%     continue
% end

%U(:,iiiii)=tikhonov(UU,SS,VV,B,0.2);
A(:,iiiii)=(cont_grad_v)\B;

end


%U=(cont_grad_v)\B;
a=sum(abs(U));
flowj.de=filter([1 1 1 1 1 1],1,flowj.de);

flowj.t=Jflowc.t;
flowj.de=y';

microstate_seg4(flowj,0.95,'old');

% view_surface('Figure_1',Faces,Vertices,J(:,2));
% view_surface('Figure_2',Faces,Vertices,J(:,3));
% view_surface('Figure_3',Faces,Vertices,J(:,4));
% view_surface('Figure_4',Faces,Vertices,J(:,5));
% % 
% view_surface('Figure_5',Faces,Vertices,(U(:,2)));
% view_surface('Figure_6',Faces,Vertices,(U(:,3)));
% view_surface('Figure_7',Faces,Vertices,(U(:,4)));
% view_surface('Figure_8',Faces,Vertices,(U(:,5)));
 U(10500:12015,iiiii)=0;
% % end
% % % 
% % view_surface('Figure_1',FV.faces,FV.vertices,U);
% % U=UU(:,iiiii);² &é"'(-²&
% % U3=U;
U(:,iiiii)=abs(U(:,iiiii));
% % hold on
% % quiver3(FV.vertices(:,1),FV.vertices(:,2),FV.vertices(:,3),FieldV(:,1).*1000,FieldV(:,2).*1000,FieldV(:,3).*1000,'g')
[N,ii] = hist(U(:,iiiii),10);
clear N
pthres1 = ii(6);
seeddd = find(U(:,iiiii)>=pthres1)';
% % view_surface('Figure_2',faces,vertices, U3);
% % U1=U;
% % U1(seeddd)=0;
% % U2=U-U1;
% % view_surface('Figure_3',faces,vertices, U2);
% 
BigCluster=cell(1);
for i=1:length(seeddd)
BigCluster{i}=VertConn{seeddd(i)};
end
BigCluster=connectivity(BigCluster);  
% % U22=U3;
% DE=zeros(length(BigCluster),1);
% DE_normalised=zeros(length(BigCluster),1);
% for i=1:length(BigCluster)
% % U22(BigCluster{i},1)=0;
% TriConn1 = TriConn(BigCluster{i});
% tri = unique([TriConn1{:}]);
% faces1=FV.faces(tri,:);
% v12=sum((FieldV(faces1(:,1),:)+FieldV(faces1(:,2),:)).^2,2)/4;
% v23=sum((FieldV(faces1(:,2),:)+FieldV(faces1(:,3),:)).^2,2)/4;
% v13=sum((FieldV(faces1(:,1),:)+FieldV(faces1(:,3),:)).^2,2)/4;
% DE_normalised(i)=sum(aires(tri).*(v12+v23+v13))/sum(aires(tri));
% DE(i)=sum(aires(tri).*(v12+v23+v13));
% end
% % U33=U3-U22;
% % view_surface('Figure_4',faces,vertices, U33);   
% result{iiiii}.DE=DE;
% result{iiiii}.DE_normalised=DE_normalised;
result{iiiii}.BigCluster=BigCluster;
% 
[hf,hs,hl]=view_surface('Bunny',FV.faces,FV.vertices);
hold on
for ii=1:70
    view_surface('Bunny',FV.faces,FV.vertices,U(:,ii));
     hq=quiver3(FV.vertices(:,1),FV.vertices(:,2),FV.vertices(:,3),UV(:,1,ii),UV(:,2,ii),UV(:,3,ii),'g')
    pause(0.1)
     delete(hq)
end

