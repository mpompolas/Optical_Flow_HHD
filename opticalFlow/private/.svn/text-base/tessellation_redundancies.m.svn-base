function [NFV,remove_vertices]=tessellation_redundancies(FV,VERBOSE,tol)
% function [NFV,remove_vertices]=tessellation_redundancies(FV,VERBOSE,tol)
%
% Check in a tesselation if there are some identical faces with opposite 
% orientations and remove the bad_oriented one. Moreover it removes
% isolated triangles and some other pathological configurations.
% -------------------------------------------------------------------------
% INPUTS :
% - FV is a structure with fields : faces (the triangle listing) vertices 
% (the coordinates of each node of the tesselation)
% - tol (default 10^-10) takes into account the fact that redundant faces can have
% coordinates very near but slightly different.
% OUTPUTS :
% NFV is the new structure

% J.Lefèvre
if nargin==2
    tol=10^-10 % Triangles can be "near" redundant, their normals differ in norm from less than 10^-10 
end

[areas,crossprod]=tessellation_properties(FV.faces,FV.vertices);

sort_crossprod=sortrows(abs([crossprod,(1:size(crossprod,1))']));
diff_sort_crossprod=diff(sort_crossprod);
indices=find(diff_sort_crossprod(:,1)<tol&diff_sort_crossprod(:,2)<tol&diff_sort_crossprod(:,3)<tol);
indices_tri1=sort_crossprod(indices,4); % indices of redundant triangles (same coordinates, two different orientations)
indices_tri2=sort_crossprod(indices+1,4);

TriConn = faces_connectivity(FV,VERBOSE);
FacesNeigh=faces_neighbours(FV,TriConn,VERBOSE);

% For each suspected face we compute the mean of normals of neighbouring faces

orientation=zeros(length(indices_tri1),2);
scal=zeros(length(indices_tri1),2);
remove_faces=[];
remove_vertices=[];

% We remove faces whose normal is not in the same direction as their
% neighbouring faces

for i=1:length(indices_tri1)
    neighbours=setxor(FacesNeigh{indices_tri1(i)},indices_tri2(i));
    if isempty(neighbours) % Isolated faces
        remove_faces=[remove_faces,indices_tri1(i),indices_tri2(i)];
        remove_vertices=[remove_vertices,FV.faces(indices_tri1(i),:)];
    else
        normal_mean=mean(crossprod(neighbours,:).*repmat(areas(neighbours),1,3),1);
        norm_i=crossprod(indices_tri1(i),:);
        scal(i,1)=normal_mean*norm_i'/(norm(normal_mean));

        if scal(i,1)>0
            remove_faces=[remove_faces,indices_tri2(i)];
            %remove_vertices=[remove_vertices,FV.faces(indices_tri2(i),:)];
            scal(i,2)=indices_tri2(i);
        else
            if scal(i,1)<0
                remove_faces=[remove_faces,indices_tri1(i)];
                %remove_vertices=[remove_vertices,FV.faces(indices_tri1(i),:)];
                scal(i,2)=indices_tri1(i);
            else
                remove_faces=[remove_faces,indices_tri1(i),indices_tri2(i)];
                remove_vertices=[remove_vertices,FV.faces(indices_tri1(i),:)];
            end
        end
    end
end

kept_faces=setxor(remove_faces,1:size(FV.faces,1));
kept_vertices=setxor(remove_vertices,1:size(FV.vertices,1));
kept_vertices=sort(kept_vertices);


NFV.faces=FV.faces(kept_faces,:);
NFV.vertices=FV.vertices(kept_vertices,:);

% As the number of vertices has decreased, we have to decrease the indices in
% FV.faces
remove_vertices=unique(sort(remove_vertices));
for i=1:prod(size(NFV.faces))
    ind=find(remove_vertices<NFV.faces(i));
    if isempty(ind)
    else
        NFV.faces(i)=NFV.faces(i)-length(ind);%(end);
    end
end


%--------------------------------------------------------------------------

function FacesNeigh=faces_neighbours(FV,TriConn,VERBOSE);
% FACES_NEIGHBOURS - Generate the connection of faces to a face

nf=size(FV.faces,1);

FacesNeigh=cell(nf,1);

if(VERBOSE),
   % disp(sprintf('Processing %.0f faces',nf))
   hwait = waitbar(0,sprintf('Processing the Faces Neighbourhood for %.0f faces',nf));
   drawnow %flush the display
end

for i=1:nf
    
    if(VERBOSE)
      if(~rem(i,max(1,round(nf/10)))), % ten updates
         % fprintf(' %.0f',iv);
         waitbar(i/nf,hwait);
         drawnow %flush the display         
      end
   end
    neighbours=[];
    for k=1:3
        neighbours=[neighbours,TriConn{FV.faces(i,k)}];
    end
    neighbours=sort(neighbours);
    neighbours=unique(neighbours);
    neighbours=setxor(neighbours,i);
    FacesNeigh{i}=neighbours;
end

close(hwait);

% -------------------------------------------------------------------------

function [areas,normals]=tessellation_properties(tri,coord);

% Sides of each triangle
u=coord(tri(:,2),:)-coord(tri(:,1),:);
v=coord(tri(:,3),:)-coord(tri(:,2),:);
w=coord(tri(:,1),:)-coord(tri(:,3),:);

normals=cross(w,u);
normals=normals./repmat(sqrt(sum(normals.^2,2)),1,3);
normals(isnan(normals))=0;

for ii=1:size(tri,1)
    areas(ii,1)=abs(det([normals(ii,:);w(ii,:);u(ii,:)]))/2;
end






