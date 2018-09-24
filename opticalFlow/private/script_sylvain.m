%script Sylvain
open('globalDE.fig')
open('globalDE_sampleNumber.fig')
open('globalU.fig')
open('globalU_sampleNumber.fig')

%%
figure
plot(ImageGridTime,DE_Farthest_FromLargestDE_normalised)
grid minor
title('DE Farthest FromLargestDE')
figure
plot(ImageGridTime,LargestDE_normalised)
grid minor
title('Largest DE')
figure
plot(ImageGridTime,SmallestDE_normalised)
grid minor
title('Smallest DE')
% figure
% plot(Jflowc.t,Second_Largest_DE)
% grid minor
% title('Second Largest DE')
figure
plot(ImageGridTime,Largest_Patch_DE_normalised)
grid minor
title('Largest Patch DE')
%%
figure
plot(DE_Farthest_FromLargestDE)
title('DE_Farthest_FromLargestDE')
figure
plot(Second_Largest_DE)
title('Second_Largest_DE')
figure
plot(SmallestDE)
title('SmallestDE')
figure
plot(LargestDE)
title('LargestDE')



figure
plot(Jflowc.t,DE_Farthest_FromLargestDE_normalised)
grid minor
title('DE Farthest FromLargest DEnormalised')
figure
plot(Jflowc.t,LargestDE_normalised)
grid minor
title('Largest DE normalised')
figure
plot(Jflowc.t,SmallestDE_normalised)
grid minor
title('Smallest DEnormalised')
figure
plot(Jflowc.t,Second_Largest_DE_normalised)
grid minor
title('Second Largest DE normalised')
figure
plot(DE_Farthest_FromLargestDE_normalised)
grid minor
title('DE Farthest FromLargestDE normalised')
figure
plot(Second_Largest_DE_normalised)
grid minor
title('Second Largest_DE normalised')
figure
plot(SmallestDE_normalised)
grid minor
title('SmallestDE normalised')
figure
plot(LargestDE_normalised)
grid minor
title('LargestDE normalised')





%%
view_surface('Figure_1',FV.faces,FV.vertices, UU(:,740));
view_surface('Figure_2',FV.faces,FV.vertices, UU(:,789));
view_surface('Figure_3',FV.faces,FV.vertices, UU(:,991));
view_surface('Figure_4',FV.faces,FV.vertices, UU(:,1132));
view_surface('Figure_5',FV.faces,FV.vertices, UU(:,1189));
view_surface('Figure_6',FV.faces,FV.vertices, UU(:,1292));

view_surface('Figure_7',FV.faces,FV.vertices, ImageGridAmp(:,740));
view_surface('Figure_8',FV.faces,FV.vertices, ImageGridAmp(:,789));
view_surface('Figure_9',FV.faces,FV.vertices, ImageGridAmp(:,991));
view_surface('Figure_10',FV.faces,FV.vertices,ImageGridAmp(:,1132));
view_surface('Figure_11',FV.faces,FV.vertices,ImageGridAmp(:,1189));
view_surface('Figure_12',FV.faces,FV.vertices,ImageGridAmp(:,1292));


