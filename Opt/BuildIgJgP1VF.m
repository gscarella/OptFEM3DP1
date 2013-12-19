function [Ig,Jg]=BuildIgJgP1VF(Num,me,nq)
% function [Ig,Jg]=BuildIgJgP1VF(Num,me,nq)
%   Build Ig and Jg arrays for vectors fields with numerotation <Num>.
%   See report.
%
% Parameters:
%  Num: 
%    - 0 global alternate numbering with local alternate numbering (classical method), 
%    - 1 global block numbering with local alternate numbering,
%    - 2 global alternate numbering with local block numbering,
%    - 3 global block numbering with local block numbering.
%  me: Connectivity array, 4-by-nme array.
%      me(jl,k) is the storage index of the jl-th  vertex
%      of the k-th tetrahedron in the array q of vertices coordinates,
%      jl in {1,..,4} and k in {1,...,nme}.
%  nq: total number of vertices of the 3D mesh,
%
% Return values:
%  Ig: 144-by-nme array
%  Jg: 144-by-nme array
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
switch Num
case 0
  GetI=@(me) [3*me(1,:)-2; 3*me(1,:)-1; 3*me(1,:); ...
              3*me(2,:)-2; 3*me(2,:)-1; 3*me(2,:); ...
              3*me(3,:)-2; 3*me(3,:)-1; 3*me(3,:); ...
              3*me(4,:)-2; 3*me(4,:)-1; 3*me(4,:)];
case 1
  GetI=@(me) [me(1,:); me(1,:)+nq; me(1,:)+2*nq; ...
              me(2,:); me(2,:)+nq; me(2,:)+2*nq; ...
              me(3,:); me(3,:)+nq; me(3,:)+2*nq; ...
              me(4,:); me(4,:)+nq; me(4,:)+2*nq];
case 2
  GetI=@(me) [3*me-2;3*me-1;3*me];  
case 3
  GetI=@(me) [me;me+nq;me+2*nq];
end
ii=[1:12]'*ones(1,12);
ii=ii(:);
jj=ones(12,1)*[1:12];
jj=jj(:);

I=GetI(me);

Ig=I(ii,:);
%Ig=Ig(:);
Jg=I(jj,:);
%Jg=Jg(:);
