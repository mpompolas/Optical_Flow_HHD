numb=40; % number of frames
motion=zeros(2,numb);
%generate random motion
for m=1:numb,
motion(1,m) = round(rand(1,1));
motion(2,m) = round(rand(1,1));
end
motionsum = cumsum(motion,2);
sigma=5; %standard deviation of smoothing mask
image1=ones(200,200);
image1(45:55, 30:70)=0;
image1(30:70,45:55)=0;
hmsk = 1/12*[-1 8 0 -8 1]; %derivative filters
vmsk = 1/12*[-1; 8; 0; -8; 1];
block=16+2;
mvs=zeros(2,numb);
smsk = fspecial('gaussian', ceil(3*sigma), sigma); %smoothing mask
points= getFeatures(image1, block-2,block-2,.6)
centroid = round(sum(points,2)/size(points,2)+block/2)
for m=1:numb,
image2=ones(200,200);
image2((45:55)+motionsum(1,m), (30:70)+motionsum(2,m))=0; %generate next frame
image2((30:70)+motionsum(1,m), (45:55)+motionsum(2,m))=0;
vs=zeros(2,size(points,2));
%iterate over all feature blocks and calculate motion vectors
for n=1:size(points,2),
if n <= size(points,2),
curr = image1(points(1,n)+(1:block)-1,points(2,n)+(1:block)-1);
next = image2(points(1,n)+(1:block)-1,points(2,n)+(1:block)-1);
%solve for gradients
smpic= conv2(.5*curr+.5*next, smsk, 'same'); % smooth sum of frames
xgrad = conv2(smpic, hmsk, 'valid');
xgrad =xgrad(3:(block-2),:);
ygrad = conv2(smpic, vmsk, 'valid');
ygrad =ygrad(:, 3:(block-2));
temp = sum(sum(xgrad.*ygrad));
A = [sum(sum(xgrad.*xgrad)) temp; temp sum(sum(ygrad.*ygrad))];
if min(eig(A)) > .01,
tg = conv2(next-curr,smsk,'same');
tg = tg(2:(block-3),2:(block-3));
B = sum([(tg(:).*xgrad(:))'; (tg(:).*ygrad(:))'],2);
% Solve for the velocity
v = A \ (-B);
vs(1,n) = 1*v(2);
vs(2,n) = 1*v(1);
%pointstest= getFeatures(image1, block-2,block-2,.6);
points(1,n) = points(1,n) + round(2*vs(1,n));
points(2,n) = points(2,n) + round(2*vs(2,n));
else
atemp = points(:,1:(size(points(:,2))-1));
points = atemp;
n=n-1;
end
end
end
image1=image2;
%store motion vectors
mvs(1,m) = round(sum(round(2*vs(1,:)))/size(vs,2));
mvs(2,m) = round(sum(round(2*vs(2,:)))/size(vs,2));
end
%plot estimated motion versus actual motion
subplot(2,1,1);
plot(motionsum(1,:), motionsum(2,:),'o');
subplot(2,1,2);
plot(cumsum(mvs(1,:)),cumsum(mvs(2,:)),'o');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%
%% generation of synthetic test sequences
%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
frame=0.3+0.5*rand(100,100);
x=zeros(7,7);
rcam_offset_x=30;
rcam_offset_y=20;
rcam_width=60;
rcam_height=60;

lcam_offset_x=10;
lcam_offset_y=20;
lcam_width=60;
lcam_height=60;
xold=50;
yold=50;
image=frame;
image(xold-4:xold+2,yold-4:yold+2)=x;
scene=zeros(100,100,200);
left_camera=ones(lcam_width,lcam_height,200);
right_camera=ones(rcam_width,rcam_height,200);
scene(:,:,1)=image;
left_camera(:,:,1)=rot90(image(lcam_offset_y:lcam_offset_y+lcam_height-1,lcam_offset_x:lcam_offset_x+lcam_width-1));
right_camera(:,:,1)=flipud(fliplr(rot90(image(rcam_offset_y:rcam_offset_y+rcam_height-1,rcam_offset_x:rcam_offset_x+rcam_width-1))));
%imshow(image)
k=1;
%% generate random motion for a box
for i=1:20
par=6*(rand(1,2)-0.5);
for j=1:10
image=frame;
xpos=round(xold+par(1));
ypos=round(yold+par(2));
if (xpos>20)&(xpos<80)&(ypos>20)&(ypos<80)
image(xpos-4:xpos+2,ypos-4:ypos+2)=x;
else
break;
end

xold=xpos;
yold=ypos;
scene(:,:,k)=image;
left_camera(:,:,k)=rot90(image(lcam_offset_y:lcam_offset_y+lcam_height-1,lcam_offset_x:lcam_offset_x+lcam_width-1));
right_camera(:,:,k)=flipud(fliplr(rot90(image(rcam_offset_y:rcam_offset_y+rcam_height-1,rcam_offset_x:rcam_offset_x+rcam_width-1))));
k=k+1;
%subplot(3,1,1)
imshow(image);
end
end
%%%%%
%Camera point correspondance detection
%%%%%%
clear all;
close all;
first_camera=zeros(240,320);
second_camera=zeros(240,320);
for i=1:10
tmp=aviread('video4',i);
tmp1=rgb2ntsc(double(tmp.cdata));
first_camera=first_camera+tmp1(:,:,1);
tmp=aviread('video5',i);
tmp1=rgb2ntsc(double(tmp.cdata));
second_camera=second_camera+tmp1(:,:,1);
end
first_camera=255*first_camera/max(first_camera(:));

second_camera=255*second_camera/max(second_camera(:));
subplot(2,1,1)
imshow(first_camera,[])
subplot(2,1,2)
imshow(second_camera,[])
[inx,iny]=ginput(8);
new_x=inx(2:2:8);
new_y=iny(2:2:8);
old_x=inx(1:2:8);
old_y=iny(1:2:8);
A=[old_x(1) old_y(1) 1 0 0 0 -1*old_x(1)*new_x(1) -1*old_y(1)*new_x(1);
0 0 0 old_x(1) old_y(1) 1 -1*old_x(1)*new_y(1) -1*old_y(1)*new_y(1);
old_x(2) old_y(2) 1 0 0 0 -1*old_x(2)*new_x(2) -1*old_y(2)*new_x(2);
0 0 0 old_x(2) old_y(2) 1 -1*old_x(2)*new_y(2) -1*old_y(2)*new_y(2);
old_x(3) old_y(3) 1 0 0 0 -1*old_x(3)*new_x(3) -1*old_y(3)*new_x(3);
0 0 0 old_x(3) old_y(3) 1 -1*old_x(3)*new_y(1) -1*old_y(3)*new_y(3);
old_x(4) old_y(4) 1 0 0 0 -1*old_x(4)*new_x(4) -1*old_y(4)*new_x(4);
0 0 0 old_x(4) old_y(4) 1 -1*old_x(4)*new_y(4) -1*old_y(4)*new_y(4);
];
parameters=pinv(A)*[new_x(1);new_y(1);new_x(2);new_y(2);new_x(3);new_y(3);new_
x(4);new_y(4);];
