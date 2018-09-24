function [V]=curl(X,FV,grad_v,normals)

grad_X=repmat(X(FV.faces(:,1)),1,3).*grad_v{1}+repmat(X(FV.faces(:,2)),1,3).*grad_v{2}+repmat(X(FV.faces(:,3)),1,3).*grad_v{3};
if nargin<4 %just compute the gradient of the scalar field X
    V=grad_X;
else %curl of the scalar field X
    V=cross(grad_X,normals);
end