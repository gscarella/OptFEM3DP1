function Mesh=GetMeshOpt(cFileName)
% function Mesh=GetMeshOpt(cFileName)
% Initialization of the Mesh structure from a FreeFEM++ mesh file
% % Optimized version
%
% Parameters:
%  cFileName: FreeFEM++ mesh file name (string)
%
% Return values:
%  Mesh: mesh structure
%
% Generated fields of Mesh:
%  nq: total number of vertices.
%  q: Array of vertices coordinates, 3-by-nq array.
%     q(il,j) is the il-th coordinate of the j-th vertex, il in {1,3}
%     and j in {1,...,nq}.
%  ql: Array of vertices labels, 1-by-nq array.
%  nme: total number of elements.
%  me: Connectivity array, 4-by-nme array.
%      me(jl,k) is the storage index of the jl-th  vertex
%      of the k-th triangle in the array q of vertices coordinates,
%      jl in {1,..,4} and k in {1,...,nme}.
%  mel: Array of elements labels, 1-by-nme array.
%  nbf: total number of boundary faces, also denoted by `\nbf`
%  bf: Connectivity array for boundary faces, 3-by-nbf array.
%      bf(il,l) is the storage index of the il-th  vertex
%      of the l-th boundary face in the array q of vertices coordinates,
%      il in {1,3} and l in {1,...,nbf}.
%  bfl: Array of boundary faces labels, 1-by-nbf array.
%  volumes: Array of volumes, 1-by-nme array. volumes(k) is the volume
%         of the k-th triangle.
%  abf: Array of faces areas, 1-by-nbf array. abf(j) is
%       the area of the j-th boundary face.
%
% Example:
%    Th=GetMesh('cube.mesh')
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details

%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
[fid,message]=fopen(cFileName,'r');
if ( fid == -1 )
    error([message,' : ',cFileName]);
end
for i=1:5
    tline = fgetl(fid);
end
if isOctave()
    nq=fscanf(fid,'%d',1);
    
    R=fscanf(fid,'%f %f %f %d',[4,nq]);
    q=R([1 2 3],:);
    ql=R(4,:);
    for i=1:3
        tline = fgetl(fid);
    end
    nme=fscanf(fid,'%d',1);
    R=fscanf(fid,'%d %d %d %d %d',[5,nme]);
    
    me=R([1:4],:);
    mel=R(5,:);
    for i=1:3
        tline = fgetl(fid);
    end
    nbf=fscanf(fid,'%d',1);
    R=fscanf(fid,'%d %d %d %d',[4,nbf]);
    
    bf=R([1 2 3],:);
    bfl=R(4,:);
else % Matlab
    nq=fscanf(fid,'%d',1);
    
    R=textscan(fid,'%f %f %f %d',nq);
    q=[R{1},R{2},R{3}]';
    ql=R{4}';
    
    for i=1:3
        tline = fgetl(fid);
    end
    nme=fscanf(fid,'%ld',1);
    
    R=textscan(fid,'%d %d %d %d %d',nme);
    me=[R{1},R{2},R{3},R{4}]';
    mel=R{5}';
    for i=1:3
        tline = fgetl(fid);
    end
    nbf=fscanf(fid,'%d',1);
    
    R=textscan(fid,'%d %d %d %d',nbf);
    bf=[R{1},R{2},R{3}]';
    bfl=R{4}';
end
fclose(fid);

Mesh=struct('q',q,'me',double(me),'ql',ql,'mel',double(mel),'bf',double(bf),'bfl',double(bfl), ...
    'nq',nq, ...
    'nme',nme, ...
    'nbf',nbf, ...
    'volumes',ComputeVolumesOpt(me,q),...
    'abf',FaceArea(bf,q));
