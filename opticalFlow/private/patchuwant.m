function [iverts]=patchuwant(FV,ploc,AREAS)

tess.faces=FV.faces;
tess.vertices=FV.vertices;
A = tri_area(tess.faces,tess.vertices.*1e3);
   vertconn=FV.VertConn; 
grow_patch = 1;
         tmp = 0;
         
         while grow_patch
            tmp = tmp+1;
            if tmp == 1
               iverts = ploc;
            else
               iverts = [iverts,patch_swell(iverts,vertconn)];
            end
            kk = 0;
            for k = iverts
               kk = kk+1;
                            [i,j] = find(tess.faces-k == 0);
               tri{kk}= i';
            end
            if isempty(tri{1})
               tria = [];
            else
               tria = unique([tri{:}]);
            end
            o_area = sum(A(tria)); % in cm2
            
            if o_area > AREAS
                o_area
               grow_patch = 0;
            end
          end
          end