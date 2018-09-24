function [points, val] = getFeatures(image, sizem, sizen, thresh);
% Extract good tracking features with minimum eigenvalue greater
% than thresh and window size sizem by sizen, a la Tomasi and Kanade.
hmsk = [-.5 0 .5];
vmsk = [-.5; 0; .5];
points=[];
val=[];
sizem=sizem+2;
sizen=sizen+2;
sigma = sqrt(sizem*sizen)/4;
smsk = fspecial('gaussian', ceil(6*sigma), sigma);
for m = 1:4:(size(image,1)-sizem+1),
for n = 1:4:(size(image,2)-sizen+1),
curr = image(m:(m+sizem-1),n:(n+sizen-1));
xgrad = conv2(curr, hmsk, 'valid');
xgrad =xgrad(2:(sizem-1),:);
ygrad = conv2(curr, vmsk, 'valid');
ygrad =ygrad(:, 2:(sizen-1));
temp = sum(sum(xgrad.*ygrad));
mat=[sum(sum(xgrad.*xgrad)) temp; temp sum(sum(ygrad.*ygrad))];
minlamb=min(eig(mat));
if minlamb > (.5*thresh*max(image(:))^2*sqrt(sizem*sizen))
vect = [m;n];
points = [points vect];
val = [val minlamb];
end
end
end