function [X]=heat_equation(X_0,faces,vertices,n,tau)
% Implements heat equation with finites elements method 
%
% INPUTS :
% X_0 : initial activity
% faces, vertices : triangles and nodes of the mesh
% n : number of steps for iterating
% tau : step of time in the temporal discretization
%
% OUTPUTS :
% X : activity from time 1 to time n
%
%/---Script Authors---------------------\
%|                                      | 
%|   *** J.Lefèvre, PhD                 |  
%|   julien.lefevre@chups.jussieu.fr    |
%|                                      | 
%\--------------------------------------/

[B,A,aires,index1,index2]=heat_matrices(faces,vertices,3);


% Implicit scheme
% A(X^(n+1)-X^n)/tau+B(X^(n+1))=0

Y=X_0;
M=A+tau*B;
for ii=1:n
    Y=A*Y;
   Y=M\Y;
    X(:,ii)= Y;
end

return

% With a differential equation :
% AX'+BX=0
% X(t)=exp(-A\Bt)X_0
% X=exp(-n*A\B)*X_0;

