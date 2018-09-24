function [U, S, V] = fastsvds(varargin)
% fastsvds performs the singular value decomposition more quickly than
% matlab's built in function.  
%
% [U S V] = fastsvds(A, k, sigma, opts)
%
% see svds for a description of the parameters.
%

A = varargin{1};
[m,n] = size(A);
p = min(m,n);

if nargin < 2
   k = min(p,6);
else
   k = varargin{2};
end

if nargin < 3
   bk = min(p,k);
   if isreal(A)
       bsigma = 'LA';
   else
       bsigma = 'LR';
   end
else
   sigma = varargin{3};
   if sigma == 0 % compute a few extra eigenvalues to be safe
      bk = 2 * min(p,k);
   else
      bk = k;
   end
   if strcmp(sigma,'L')
       if isreal(A)
           bsigma = 'LA';
       else
           bsigma = 'LR';
       end
   elseif isa(sigma,'double')
      bsigma = sigma;
      if ~isreal(bsigma)
          error('Sigma must be real');
      end
   else
      error('Third argument must be a scalar or the string ''L''')
   end   
end

if isreal(A)
       boptions.isreal = 1;
   else
       boptions.isreal = 0;
   end
boptions.issym = 1;

if nargin < 4
   % norm(B*W-W*D,1) / norm(B,1) <= tol / sqrt(2)
   % => norm(A*V-U*S,1) / norm(A,1) <= tol
   boptions.tol = 1e-10 / sqrt(2);
   boptions.disp = 0;
   
else
   options = varargin{4};
   if isstruct(options)
      if isfield(options,'tol')
         boptions.tol = options.tol / sqrt(2);
      else
         boptions.tol = 1e-10 / sqrt(2);
      end
      if isfield(options,'maxit')
         boptions.maxit = options.maxit;
      end
      if isfield(options,'disp')
         boptions.disp = options.disp;
      else
         boptions.disp = 0;
      end
   else
      error('Fourth argument must be a structure of options.')
   end   
end

if (m > n)
    % this means we want to find the right singular vectors first
    % [V D] = eigs(A'*A)
    %f = inline('global AFASTSVDMATRIX; AFASTSVDMATRIX''*(AFASTSVDMATRIX*v)', 'v');
    [V D] = eigs(@multiply_mtm, n, bk, bsigma, boptions, A);
    [dummy, perm] = sort(-diag(D));
    S = diag(sqrt(diag(D(perm, perm))));
    V = V(:, perm);
    Sinv = diag(1./sqrt(diag(D)));
    U = (A*V)*Sinv;
else
    % find the left singular vectors first
    % [U D] = eigs(A*A')
    %f = inline('global AFASTSVDMATRIX; A*(A''*v)', 'v');
    [U D] = eigs(@multiply_mmt, m, bk, bsigma, boptions, A);
    [dummy, perm] = sort(-diag(D));
    S = diag(sqrt(diag(D(perm, perm))));
    U = U(:, perm);
    Sinv = diag(1./sqrt(diag(D)));
    V = Sinv*(U'*A);
    V = V';
end;

if nargout <= 1
   U = diag(S);
end

%clear global AFASTSVDMATRIX;

function mtmv = multiply_mtm(v, A)
mtmv = A'*(A*v);
%global AFASTSVDMATRIX;
%mtmv = AFASTSVDMATRIX'*(AFASTSVDMATRIX*v);

function mmtv = multiply_mmt(v, A)
mmtv = A*(A'*v);
%global AFASTSVDMATRIX;
%mmtv = AFASTSVDMATRIX*(AFASTSVDMATRIX'*v);