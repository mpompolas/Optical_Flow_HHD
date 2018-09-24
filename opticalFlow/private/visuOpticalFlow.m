function visuOpticalFlow(start,end1,Jflowc,U,V,vec,MINorUorV)
if MINorUorV==1
[hf,hs,hl]=view_surface('Surface',Jflowc.faces,Jflowc.vertices,U(:,start));
elseif MINorUorV==2
[hf,hs,hl]=view_surface('Surface',Jflowc.faces,Jflowc.vertices,Jflowc.F(:,start+2));
elseif MINorUorV==3
[hf,hs,hl]=view_surface('Surface',Jflowc.faces,Jflowc.vertices,V(:,start));
end
% cx=[-max(max(abs(U(:,start:end1)))) max(max(abs(U(:,start:end1))))];
% set(gca,'clim',cx)

for i=start:1:end1
   if MINorUorV==1 
    set(hs,'FaceVertexCData',U(:,i))
   elseif MINorUorV==2
    set(hs,'FaceVertexCData',Jflowc.F(:,i+2))
   elseif MINorUorV==3
    set(hs,'FaceVertexCData',V(:,i))
   end
hold on
hq=quiver3(Jflowc.vertices(:,1),Jflowc.vertices(:,2),Jflowc.vertices(:,3),vec(:,1,i),vec(:,2,i),vec(:,3,i),3,'g'); 
% Time=ImageGridTime(i+79)*1000
i
pause
delete(hq)

end




