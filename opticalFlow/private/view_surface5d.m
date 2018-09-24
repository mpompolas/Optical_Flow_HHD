function view_surface5d(faces, vertices, IntensityData, Transperency)


[cont_grad_v,cont_grad_vb,grad_v,tangent_basis,tg_basis,aires,norm_tri,norm_coord,index1,index2]=matrices_contraintes_ter_divergence(faces,vertices,3);
clear cont_grad_v cont_grad_vb grad_v tangent_basis tg_basis aires norm_tri index1 index2


view_surface('Cortex',faces,vertices);
hold on

for ii=1:10:size(IntensityData,2);
ii
vertices=vertices-norm_coord.*0.001;
view_surface('Cortex',faces,vertices,IntensityData(:,ii));

end
alpha(Transperency)

