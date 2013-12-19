function bench=benchStiff3DP1(varargin)
% function benchStiffP1()
%   Benchmark function for StiffAssembling `P_1` functions.
%
% Usage
%   bench=benchStiff3DP1('LN',[5:5:20]);
%   bench=benchStiff3DP1('LN',[5:5:20],'version',{'OptV1','OptV2'});
%   bench=benchStiff3DP1('LN',[5:5:20],'version',{'OptV1','OptV2'},'mesh','./mesh/cube');
% See also:
%   #StiffAssemblingP1base, #StiffAssemblingP1OptV0, #StiffAssemblingP1OptV1, #StiffAssemblingP1OptV2
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
  p = inputParser; 
  
  if isOctave()
    p=p.addParamValue('LN', [20:10:60] , @isnumeric );
    p=p.addParamValue('version', {'base','OptV0','OptV1','OptV2'} , @iscell );
    p=p.addParamValue('mesh','',@ischar);
    p=p.parse(varargin{:});
  else % Matlab
    p.addParamValue('LN', [20:10:60], @isnumeric );
    p.addParamValue('version', {'base','OptV0','OptV1','OptV2'}, @iscell );
    p.addParamValue('mesh','',@ischar);
    p.parse(varargin{:});
  end
  k=1;
  version=p.Results.version;
  nv=length(version);
  if isempty(p.Results.mesh)
    GenMesh=@(N) CubeMesh(N);
    printMesh=@(N) sprintf('CubeMesh(%d)',N);
    meshdesc='CubeMesh(<N>)';
  else
    GenMesh=@(N) GetMeshOpt(sprintf('%s-%d.mesh',p.Results.mesh,N));
    printMesh=@(N) sprintf('GetMeshOpt(''%s-%d.mesh'')',p.Results.mesh,N);
    meshdesc=sprintf('GetMeshOpt(''%s-<N>.mesh'')',p.Results.mesh);
  end
  for N=p.Results.LN  
    Th=GenMesh(N);
    fprintf('---------------------------------------------------------\n')
    fprintf('BENCH (Stiffness Matrix Assembling) %d\n',k)
    fprintf(' Mesh generation with : %s\n',printMesh(N));
    fprintf(' Vertices number : %d - Tetrahedra number : %d\n',Th.nq,Th.nme)
    
    Lnq(k)=Th.nq;
    eval(sprintf('Assembling=@(nq,nme,q,me,volumes) StiffAssembling3DP1%s(nq,nme,q,me,volumes);',version{1}));
    tic();
    Mb=Assembling(Th.nq,Th.nme,Th.q,Th.me,Th.volumes);
    T(k,1)=toc();
    fprintf(' Matrix size   : %d\n',length(Mb))
    Ldof(k)=length(Mb);
    fprintf('    CPU times %5s (ref) : %3.4f (s)\n',version{1},T(k,1))
    for v=2:nv
      eval(sprintf('Assembling=@(nq,nme,q,me,volumes) StiffAssembling3DP1%s(nq,nme,q,me,volumes);',version{v}));  
      tic();
      M=Assembling(Th.nq,Th.nme,Th.q,Th.me,Th.volumes);
      T(k,v)=toc();
      fprintf('    CPU times %5s       : %3.4f (s) - Error = %e - Speed Up X%3.3f\n',version{v},T(k,v),norm(Mb-M,Inf),T(k,1)/T(k,v))
    end
    k=k+1;
  end
  
  bench.T=T;
  bench.Lnq=Lnq;
  bench.Ldof=Ldof;
  bench.LN=p.Results.LN;
  bench.version=version;
  bench.meshdesc=meshdesc;
  
