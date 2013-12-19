function ElemStiffElasMatVec=BuildElemStiffElasMatFuncVec(Num)
% function ElemStiffElasMatVec=BuildElemStiffElasMatFuncVec(Num)
%   return handle of the function Elementary Stiffness Elasticity matrix
%   associated with local numbering <Num>.
%
% Parameters:
%  Num: 
%    0 global alternate numbering with local alternate numbering (classical method), 
%    1 global block numbering with local alternate numbering,
%    2 global alternate numbering with local block numbering,
%    3 global block numbering with local block numbering.
%
% Return values:
%  ElemStiffElasMatVec: handle function of parameters (q,me,volumes,lambda,mu)
%
% See also:
%  ElemStiffElasMatBaVecP1D0OptV0, ElemStiffElasMatBbVecP1D0
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
switch Num
case {0,1}
  ElemStiffElasMatVec=@(q,me,volumes,lambda,mu) ElemStiffElasMatBaVecP1D0OptV0(q,me,volumes,lambda,mu);
case {2,3}
  ElemStiffElasMatVec=@(q,me,volumes,lambda,mu) ElemStiffElasMatBbVecP1D0(q,me,volumes,lambda,mu);
end
