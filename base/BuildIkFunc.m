function GetI=BuildIkFunc(Num,nq)
% function GetI=BuildIkFunc(Num,nq)
%   Definition of the GetI function depending on the
%   global numbering of vector fields Num.
%   Used by AssemblingStiffElasP1 functions.
%   
% See report 
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
switch Num
case 0
  GetI=@(me,k) [3*me(1,k)-2,3*me(1,k)-1, 3*me(1,k), ...
                3*me(2,k)-2,3*me(2,k)-1, 3*me(2,k), ...
                3*me(3,k)-2,3*me(3,k)-1, 3*me(3,k), ...
                3*me(4,k)-2,3*me(4,k)-1, 3*me(4,k)];
case 1
  GetI=@(me,k) [me(1,k), me(1,k)+nq, me(1,k)+2*nq, ...
                me(2,k), me(2,k)+nq, me(2,k)+2*nq, ...
                me(3,k), me(3,k)+nq, me(3,k)+2*nq, ...
                me(4,k), me(4,k)+nq, me(4,k)+2*nq];
case 2
  GetI=@(me,k) [3*me(:,k)-2;3*me(:,k)-1;3*me(:,k)]';
case 3
  GetI=@(me,k) [me(:,k); me(:,k)+nq;me(:,k)+2*nq]';
end
