function [I_pred,M,R,A1,A2,A3]=calcul_advection2(I_true,flowc,iteration,tau,alpha)
% Main function for the advection equation.
%
% INPUTS 
% I_true(t,:)=I_0 : initial condition
% flowc : structure with fields .V (the vector field), .faces, .vertices
% iteration : number of time steps to be considered
% tau : time (ms) between two consecutive steps
% alpha : multiplicative coefficient for the field .V (usefull at the
% moment for avoding scaling problems)
%
% OUTPUTS
% I_pred : prediction through advection process
% M, R, A1, A2, A3 : matrices used in the FEM computation

%/---Script Authors---------------------\
%|                                      | 
%|   *** J.Lefèvre, PhD                 |  
%|   julien.lefevre@chups.jussieu.fr    |
%|                                      | 
%\--------------------------------------/

if prod(size(flowc.V))==3*size(flowc.vertices,1);
    % check if the field V is constant in time
    jflag=0;
    V=alpha*flowc.V;
else 
    jflag=1;
end

I_p=I_true;
for ii=1:iteration
    if jflag
        V=alpha*flowc.V(:,:,ii);
    end
    if ii==1
        % geometric properties and matrices for computation (depending from
        % V, so can be computed just once if jflag=0)
        [A1,A2,A3,grad_v,tangent_basis,aires,index1,index2,A2index1,A2index2,A3index1,A3index2]=...
            prepare_advection2(V,flowc.faces,flowc.vertices,tau);
        % it seems that 2*A3 is more time consuming than A3+A3
        M=A1+(A2+A2')+A3+A3;
        R=A1+(A2-A2')-A3;
    else
        if jflag 
            [A1,A2,A3]=...
                prepare_advection2(V,flowc.faces,flowc.vertices,tau,grad_v,tangent_basis,aires,index1,index2,A2index1,A2index2,A3index1,A3index2);
            M=A1+(A2+A2')+A3+A3;
            R=A1+(A2-A2')-A3;
        end
    end
    %     formula used with the first version of prepare_advection
    %     M=(1/tau)*A1+0.5*(A2+A2')+(tau/3)*A3;
    %     R=(1/tau)*A1+0.5*(A2-A2')-(tau/6)*A3;
    %     M*I_(t+1)-R*I_t=0

    % Prediction
    I_p=M\(R*I_p);
    I_pred(:,ii)=I_p;
end