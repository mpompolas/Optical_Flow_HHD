function [grav_tri]=gravite(faces, vertices)

for tt=1:length(faces)
   T=faces(tt,:);
   A=vertices(T(1),:);
   B=vertices(T(2),:);
   C=vertices(T(3),:);
   grav_tri(tt,:)=A+((B-A)+(C-A))/3;
end