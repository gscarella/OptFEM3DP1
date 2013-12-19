function bench=benchMass3DP1(varargin)
% function benchMassP1()
%   Benchmark function for MassAssembling `P_1` functions in 3D
%
% See also:
%   #MassAssembling3DP1base, #MassAssembling3DP1OptV0, #MassAssembling3DP1OptV1, #MassAssembling3DP1OptV2
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
  p = inputParser; 
  
  if isOctave()
    p=p.addParamValue('LN', [20:10:60] , @isnumeric );
    p=p.parse(varargin{:});
  else % Matlab
    p.addParamValue('LN', [20:10:60], @isnumeric );
    p.parse(varargin{:});
  end
  k=1;
  for N=p.Results.LN  
    Th=CubeMesh(N);
    fprintf('---------------------------------------------------------\n')
    fprintf('BENCH (Mass Matrix Assembling) %d\n',k)
    fprintf(' Vertices number : %d - Tetrahedra number : %d\n',Th.nq,Th.nme)
    fprintf(' Matrix size   : %d\n',Th.nq)
    Lnq(k)=Th.nq;
    tic();
    Mb=MassAssembling3DP1base(Th.nq,Th.nme,Th.me,Th.volumes);
    T(k,1)=toc();
    Ldof(k)=length(Mb);
    fprintf('    CPU times base (ref) : %3.4f (s)\n',T(k,1))
    tic();
    M=MassAssembling3DP1OptV0(Th.nq,Th.nme,Th.me,Th.volumes);
    T(k,2)=toc();
    fprintf('    CPU times OptV0      : %3.4f (s) - Error = %e - Speed Up X%3.3f\n',T(k,2),norm(Mb-M,Inf),T(k,1)/T(k,2))
    tic();
    M=MassAssembling3DP1OptV1(Th.nq,Th.nme,Th.me,Th.volumes);
    T(k,3)=toc();
    fprintf('    CPU times OptV1      : %3.4f (s) - Error = %e - Speed Up X%3.3f\n',T(k,3),norm(Mb-M,Inf),T(k,1)/T(k,3))
    tic();
    M=MassAssembling3DP1OptV2(Th.nq,Th.nme,Th.me,Th.volumes);
    T(k,4)=toc();
    fprintf('    CPU times OptV2      : %3.4f (s) - Error = %e - Speed Up X%3.3f\n',T(k,4),norm(Mb-M,Inf),T(k,1)/T(k,4))
    k=k+1;
  end
  bench.T=T;
  bench.Lnq=Lnq;
  bench.Ldof=Ldof;
  bench.LN=p.Results.LN;  
  
