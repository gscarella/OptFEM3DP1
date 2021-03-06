function validMassVF3DP1(Num)
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details

  disp('*******************************************')
  disp('*   MassVF 3D Assembling P1 validations   *')
  disp('*******************************************')
  switch Num
  case 0
    s=sprintf('Global alternate numbering / local alternate numbering');
  case 1
    s=sprintf('Global block numbering / local alternate numbering');
  case 2
    s=sprintf('Global alternate numbering / local block numbering');
  case 3
    s=sprintf('Global block numbering / local block numbering');
  otherwise
    error('invalid Num value')
  end
  fprintf('  Numbering Choice : %s\n',s);
  
  
  
  Th=CubeMesh(10);

% TEST 1
  disp('----------------------------------StiffElasAssemblingP1OptV2-------')
  disp('  Test 1: Matrices errors and CPU times  ')
  fprintf('     Matrix size : %d\n',3*Th.nq);
  disp('-----------------------------------------')
  tic();
  Mbase=MassVFAssembling3DP1base(Th.nq,Th.nme,Th.me,Th.volumes,Num);
  T(1)=toc();
  tic();
  MOptV0=MassVFAssembling3DP1OptV0(Th.nq,Th.nme,Th.me,Th.volumes,Num);
  T(2)=toc();
  Test1.error(1)=norm(Mbase-MOptV0,Inf);
  Test1.name{1}='MassVFAssembling3DP1OptV0';
  fprintf('    Error P1base vs OptV0 : %e\n',Test1.error(1))
  tic();
  MOptV1=MassVFAssembling3DP1OptV1(Th.nq,Th.nme,Th.me,Th.volumes,Num);
  T(3)=toc();
  Test1.error(2)=norm(Mbase-MOptV1,Inf);
  Test1.name{2}='MassVFAssembling3DP1OptV1';
  fprintf('    Error P1base vs OptV1 : %e\n',Test1.error(2))
  tic();
  MOptV2=MassVFAssembling3DP1OptV2(Th.nq,Th.nme,Th.me,Th.volumes,Num);
  T(4)=toc();
  Test1.error(3)=norm(Mbase-MOptV2,Inf);
  Test1.name{3}='MassVFAssembling3DP1OptV2';
  fprintf('    Error P1base vs OptV2 : %e\n',Test1.error(3))
  MOptV3=MassVFAssembling3DP1OptV3(Th.nq,Th.nme,Th.me,Th.volumes,Num);
  T(5)=toc();
  Test1.error(4)=norm(Mbase-MOptV3,Inf);
  Test1.name{4}='MassVFAssembling3DP1OptV3';
  fprintf('    Error P1base vs OptV3 : %e\n',Test1.error(4))

  fprintf('    CPU times base (ref) : %3.4f (s)\n',T(1))
  fprintf('    CPU times OptV0       : %3.4f (s) - Speed Up X%3.3f\n',T(2),T(1)/T(2))
  fprintf('    CPU times OptV1       : %3.4f (s) - Speed Up X%3.3f\n',T(3),T(1)/T(3))
  fprintf('    CPU times OptV2       : %3.4f (s) - Speed Up X%3.3f\n',T(4),T(1)/T(4))
  fprintf('    CPU times OptV3       : %3.4f (s) - Speed Up X%3.3f\n',T(5),T(1)/T(5))
  checkTest1(Test1)

  


% TEST 2
  disp('-----------------------------------------------------------')
  disp('  Test 2: Validations by integration on [0,1]x[0,1]x[0,1]  ')
  disp('-----------------------------------------------------------')
  Test=valid_MECA();
  qf=Th.q;
  for kk=1:length(Test)
    KK=MassVFAssembling3DP1OptV2(Th.nq,Th.nme,Th.me,Th.volumes,Num);
    u=Test(kk).u;
    v=Test(kk).v;
    switch Num
    case {0,2}
      U=[u{1}(qf(1,:),qf(2,:),qf(3,:));u{2}(qf(1,:),qf(2,:),qf(3,:));u{3}(qf(1,:),qf(2,:),qf(3,:))];
      U=U(:);
      V=[v{1}(qf(1,:),qf(2,:),qf(3,:));v{2}(qf(1,:),qf(2,:),qf(3,:));v{3}(qf(1,:),qf(2,:),qf(3,:))];
      V=V(:);
    case {1,3}
      U=[u{1}(qf(1,:),qf(2,:),qf(3,:)) u{2}(qf(1,:),qf(2,:)) u{3}(qf(1,:),qf(2,:),qf(3,:))]';
      V=[v{1}(qf(1,:),qf(2,:),qf(3,:)) v{2}(qf(1,:),qf(2,:),qf(3,:)) v{3}(qf(1,:),qf(2,:),qf(3,:))]';
    end
    %whos
    Test(kk).error=abs(Test(kk).Mass-U'*KK*V);
    fprintf('    functions %d : u(x,y,z)=(%s,%s,%s), v(x,y,z)=(%s,%s,%s),\n           -> MassVF error=%e\n', ...
            kk,Test(kk).cu{1},Test(kk).cu{2},Test(kk).cu{3},Test(kk).cv{1},Test(kk).cv{2},Test(kk).cv{3},Test(kk).error);
  end
  checkTest2(Test)
 
% TEST 3
  disp('--------------------------------')
  disp('  Test 3: Validations by order  ')
  disp('--------------------------------')
  n=length(Test);
  u=Test(n).u;
  v=Test(n).v;
  ExSol=Test(n).Mass;
  fprintf('    functions %d : u(x,y,z)=(%s,%s,%s), v(x,y,z)=(%s,%s,%s),\n',n, ...
          Test(n).cu{1},Test(n).cu{2},Test(n).cu{3}, ...
          Test(n).cv{1},Test(n).cv{2},Test(n).cv{3});
  fprintf('    Integral of dot(u(x,y,z),v(x,y,z)) over unit cube : %.16f\n',ExSol);
  N=10;
  for k=1:N  
    Th=CubeMesh(5*k+5);
    qf=Th.q;
    fprintf('(%d/%d)    Matrix size : %d\n',k,N,Th.nq);
    h(k)=GetMaxLengthEdges(Th.q,Th.me);
    tic();
    M=MassVFAssembling3DP1OptV2(Th.nq,Th.nme,Th.me,Th.volumes,Num);
    TT(k)=toc();
    switch Num
    case {0,2}
      U=[u{1}(qf(1,:),qf(2,:),qf(3,:));u{2}(qf(1,:),qf(2,:),qf(3,:));u{3}(qf(1,:),qf(2,:),qf(3,:))];
      U=U(:);
      V=[v{1}(qf(1,:),qf(2,:),qf(3,:));v{2}(qf(1,:),qf(2,:),qf(3,:));v{3}(qf(1,:),qf(2,:),qf(3,:))];
      V=V(:);
    case {1,3}
      U=[u{1}(qf(1,:),qf(2,:),qf(3,:)) u{2}(qf(1,:),qf(2,:)) u{3}(qf(1,:),qf(2,:),qf(3,:))]';
      V=[v{1}(qf(1,:),qf(2,:),qf(3,:)) v{2}(qf(1,:),qf(2,:),qf(3,:)) v{3}(qf(1,:),qf(2,:),qf(3,:))]';
    end
    Error(k)=abs(ExSol-U'*M*V);
    fprintf('      MassVFAssembling3DP1OptV2 CPU times : %3.3f(s)\n',TT(k));
    fprintf('      Error                               : %e\n',Error(k));
  end

  loglog(h,Error,'+-r',h,h*1.1*Error(1)/h(1),'-sm',h,1.1*Error(1)*(h/h(1)).^2,'-db')
  legend('Error','O(h)','O(h^2)')
  xlabel('h')
  title(sprintf('Test 3 : 3D MassVF Matrix (Num=%d)',Num))
  checkTest3(h,Error)
  
  %figure(3)
  %spy(M)
  %title(sprintf('Matrix sparsity for %s numbering',s))
end

function checkTest1(Test)
  I=find(Test.error>1e-14);
  if isempty(I)
    disp('------------------------')
    disp('  Test 1 (results): OK')
    disp('------------------------')
  else
    disp('----------------------------')
    disp('  Test 1 (results): FAILED')
    disp('----------------------------')
  end
end

function checkTest2(Test)
  N=length(Test);
  cntFalse=0;
  for k=1:N
    if (ismember(Test(k).degree,[0 1]))
      if (Test(k).error>1e-12)
        cntFalse=cntFalse+1;
      end
    end
  end
  if (cntFalse==0)
    disp('------------------------')
    disp('  Test 2 (results): OK')
    disp('------------------------')
  else
    disp('----------------------------')
    disp('  Test 2 (results): FAILED')
    disp('----------------------------')
  end
end

function checkTest3(h,error)
  % order 2
  P=polyfit(log(h),log(error),1);
  if abs(P(1)-2)<5e-2
    disp('------------------------')
    disp('  Test 3 (results): OK')
    fprintf('    -> found numerical order %f. Must be 2\n',P(1))
    disp('------------------------')
  else
    disp('----------------------------')
    disp('  Test 3 (results): FAILED')
    fprintf('    -> found numerical order %f. Must be 2\n',P(1))
    disp('----------------------------')
  end
end
