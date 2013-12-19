function M=MassAssembling3DP1base(nq,nme,me,volumes)
% function M=MassAssembling3DP1base(nq,nme,me,volumes)
%   Assembly of the Mass Matrix using P1-Lagrange finite elements in 3D
%   - Basic version (see report).
%
% Parameters:
%  nq: total number of vertices of the 3D mesh,
%  nme: total number of elements.
%  me: Connectivity array, 4-by-nme array.
%      me(jl,k) is the storage index of the jl-th  vertex
%      of the k-th tetrahedron in the array q of vertices coordinates,
%      jl in {1,..,4} and k in {1,...,nme}.
%  volumes: Array of volumes, 1-by-nme array. volumes(k) is the volume
%         of the k-th tetrahedron.
%
% Return values:
%  M: Global mass matrix, nq-by-nq sparse matrix.
%
% Example:
%    Th=CubeMesh(10);
%    M=MassAssembling3DP1base(Th.nq,Th.nme,Th.me,Th.volumes);
%
% See also:
%   ElemMassMat3DP1D0
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
M=sparse(nq,nq);
for k=1:nme
    E=ElemMassMat3DP1D0(volumes(k));
    for il=1:4
        i=me(il,k);
        for jl=1:4
            j=me(jl,k);
            M(i,j)=M(i,j)+E(il,jl);
        end
    end
end
