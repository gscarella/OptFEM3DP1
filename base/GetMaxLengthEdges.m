function h=GetMaxLengthEdges(q,me)
% function h=GetMaxLengthEdges(q,me)
%   Computation of the maximal value of edge lengths
%   
% Parameters:
%  q: Array of vertices coordinates, `2\times\nq` array (double). <br/>
%  `{\q}(\il,j)` is the
%  `\il`-th coordinate of the `j`-th vertex, `\il\in\{1,2\}` and
%  `j\in\ENS{1}{\nq}`
%  me: Connectivity array, `3\times\nme` array ('int32'). <br/>
%  `\me(\jl,k)` is the storage index of the
%  `\jl`-th  vertex of the `k`-th triangle in the array `\q` of vertices coordinates, `\jl\in\{1,2,3\}` and
%       `k\in{\ENS{1}{\nme}}`.
% 
% Return values:
%  h: maximal length of an edge in the mesh
%
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
L{1}=q(:,me(1,:))-q(:,me(2,:));
L{2}=q(:,me(1,:))-q(:,me(3,:));
L{3}=q(:,me(1,:))-q(:,me(4,:));
L{4}=q(:,me(2,:))-q(:,me(3,:));
L{5}=q(:,me(2,:))-q(:,me(4,:));
L{6}=q(:,me(3,:))-q(:,me(4,:));

h=max(sum(L{1}.^2,1));
for i=2:6
  h=max(h,max(sum(L{i}.^2,1)));
end

h=sqrt(h);

