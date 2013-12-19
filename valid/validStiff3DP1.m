function validStiff3DP1()
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details

Th=CubeMesh(3);
%M=MassAssembling3DP1base(Th.nq,Th.nme,Th.me,Th.volumes);

 disp('-----------------------------------------')
  disp('  Test 1: Matrices errors and CPU times  ')
  disp('-----------------------------------------')
  tic();
  Mbase=StiffAssembling3DP1base(Th.nq,Th.nme,Th.q,Th.me,Th.volumes);
  T(1)=toc();
  tic();
    MOptV0=StiffAssembling3DP1OptV0(Th.nq,Th.nme,Th.q,Th.me,Th.volumes);
  T(2)=toc();
  Test1.error(1)=norm(Mbase-MOptV0,Inf);
  Test1.name{1}='StiffAssembling3DP1OptV0';
  fprintf('    Error P1base vs OptV0 : %e\n',Test1.error(1))
  tic();
  MOptV1=StiffAssembling3DP1OptV1(Th.nq,Th.nme,Th.q,Th.me,Th.volumes);
  T(3)=toc();
  Test1.error(2)=norm(Mbase-MOptV1,Inf);
  Test1.name{2}='StiffAssembling3DP1OptV1';
  fprintf('    Error P1base vs OptV1 : %e\n',Test1.error(2))
  tic();
  MOptV2=StiffAssembling3DP1OptV2(Th.nq,Th.nme,Th.q,Th.me,Th.volumes);
  T(4)=toc();
  Test1.error(3)=norm(Mbase-MOptV2,Inf);
  Test1.name{3}='StiffAssembling3DP1OptV2';
  fprintf('    Error P1base vs OptV2 : %e\n',Test1.error(3))

  fprintf('    CPU times base (ref) : %3.4f (s)\n',T(1))
  fprintf('    CPU times OptV0       : %3.4f (s) - Speed Up X%3.3f\n',T(2),T(1)/T(2))
  fprintf('    CPU times OptV1       : %3.4f (s) - Speed Up X%3.3f\n',T(3),T(1)/T(3))
  fprintf('    CPU times OptV2       : %3.4f (s) - Speed Up X%3.3f\n',T(4),T(1)/T(4))
  checkTest1(Test1) 
  
% TEST 2
  disp('-----------------------------------------------------------')
  disp('  Test 2: Validations by integration on [0,1]x[0,1]x[0,1]  ')
  disp('-----------------------------------------------------------')
  Test=valid_FEMmatrices();
  M=Mbase;
  for kk=1:length(Test)
    U=Test(kk).u(Th.q(1,:),Th.q(2,:),Th.q(3,:));
    V=Test(kk).v(Th.q(1,:),Th.q(2,:),Th.q(3,:));
    Test(kk).error=abs(Test(kk).Stiff-U*M*V');
    fprintf('    function %d : u(x,y,z)=%s, v(x,y,z)=%s,\n           -> Mass error=%e\n',kk,Test(kk).cu,Test(kk).cv,Test(kk).error);
  end
  checkTest2(Test)

% TEST 3
  disp('--------------------------------')
  disp('  Test 3: Validations by order  ')
  disp('--------------------------------')
  n=length(Test);
  u=Test(n).u;
  v=Test(n).v;
  ExSol=Test(n).Stiff;
  fprintf('    functions %d : u(x,y,z)=%s, v(x,y,z)=%s,\n',n, ...
          Test(n).cu,Test(n).cv);
  fprintf('    Integral of dot(grad u(x,y,z),grad v(x,y,z)) over unit cube : %.16f\n',ExSol);
  C=4;
  %C=5;
  N=10;
  for k=1:N  
    Th=CubeMesh(5+k*C);
    fprintf('(%d/%d)    Matrix size : %d\n',k,N,Th.nq);
    h(k)=GetMaxLengthEdges(Th.q,Th.me);
    tic();
    M=StiffAssembling3DP1OptV2(Th.nq,Th.nme,Th.q,Th.me,Th.volumes);
    TT(k)=toc();
    U=u(Th.q(1,:),Th.q(2,:),Th.q(3,:));
    V=v(Th.q(1,:),Th.q(2,:),Th.q(3,:));
    Error(k)=abs(ExSol-U*M*V');
    fprintf('      StiffAssembling3DP1OptV2 CPU times : %3.3f(s)\n',TT(k));
    fprintf('      Error                           : %e\n',Error(k));
  end

  loglog(h,Error,'+-r',h,h*1.1*Error(1)/h(1),'-sm',h,1.1*Error(1)*(h/h(1)).^2,'-db')
  legend('Error','O(h)','O(h^2)')
  xlabel('h')
  title('Test 3 : Stiff Matrix')
  checkTest3(h,Error)
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
      if (Test(k).error>1e-14)
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
  if abs(P(1)-2)<2.e-2
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

