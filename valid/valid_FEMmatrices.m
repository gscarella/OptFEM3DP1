function Test=valid_FEMmatrices()
% automatic generation with sage
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
i=1;
Test(i).u=@(x,y,z) x + y + z;
Test(i).cu='x + y + z';
Test(i).v=@(x,y,z) x - y - z;
Test(i).cv='x - y - z';
Test(i).w=@(x,y,z) 2.*x + y - 3.*z;
Test(i).cw='2*x + y - 3*z';
Test(i).Mass=-0.8333333333333333;
Test(i).MassW=0.5000000000000000;
Test(i).Stiff=-1.000000000000000;
Test(i).degree=1;
i=2;
Test(i).u=@(x,y,z) 3.*x + 2.*y - z - 1;
Test(i).cu='3*x + 2*y - z - 1';
Test(i).v=@(x,y,z) 2.*x - 2.*y + 2.*z + 1;
Test(i).cv='2*x - 2*y + 2*z + 1';
Test(i).w=@(x,y,z) 2.*x - 5.*y - 3.*z;
Test(i).cw='2*x - 5*y - 3*z';
Test(i).Mass=2.000000000000000;
Test(i).MassW=-5.500000000000000;
Test(i).Stiff=0.0000000000000000;
Test(i).degree=1;
i=3;
Test(i).u=@(x,y,z) 3.*x.^2 - x.*y + 2.*y.^2 + y.*z - z.^2 - 3;
Test(i).cu='3*x^2 - x*y + 2*y^2 + y*z - z^2 - 3';
Test(i).v=@(x,y,z) 2.*x.^2 + x.*y - 3.*y.^2 - x.*z - y;
Test(i).cv='2*x^2 + x*y - 3*y^2 - x*z - y';
Test(i).w=@(x,y,z) x.*y + y.*z;
Test(i).cw='x*y + y*z';
Test(i).Mass=1.236111111111111;
Test(i).MassW=0.7134259259259259;
Test(i).Stiff=-1.916666666666667;
Test(i).degree=2;
i=4;
Test(i).u=@(x,y,z) 5.*x.^3 - z.^3 - x.*y + 2.*y.^2 + y.*z - 3;
Test(i).cu='5*x^3 - z^3 - x*y + 2*y^2 + y*z - 3';
Test(i).v=@(x,y,z) 2.*x.^2.*y + x.*y.*z - 3.*y.^2 - x.*z - y.*z;
Test(i).cv='2*x^2*y + x*y*z - 3*y^2 - x*z - y*z';
Test(i).w=@(x,y,z) x.*y.*z + x.*y - 2;
Test(i).cw='x*y*z + x*y - 2';
Test(i).Mass=1.220833333333333;
Test(i).MassW=-2.220205026455026;
Test(i).Stiff=-1.416666666666667;
Test(i).degree=3;
i=5;
Test(i).u=@(x,y,z) -x.*y.^2.*z + 2.*y.^2.*z.^2 - x.^3 - z.^3 + y.*z - 3;
Test(i).cu='-x*y^2*z + 2*y^2*z^2 - x^3 - z^3 + y*z - 3';
Test(i).v=@(x,y,z) x.^2.*y.*z + x.*y.*z.^2 - y.*z.^2 - 3.*y.^2 - x.*z;
Test(i).cv='x^2*y*z + x*y*z^2 - y*z^2 - 3*y^2 - x*z';
Test(i).w=@(x,y,z) x.*y.*z.^2 + x.*y.*z - 2;
Test(i).cw='x*y*z^2 + x*y*z - 2';
Test(i).Mass=3.646990740740741;
Test(i).MassW=-6.175414021164021;
Test(i).Stiff=-3.338888888888889;
Test(i).degree=4;
i=6;
Test(i).u=@(x,y,z) 4.*x.^5 - x.*y.^2.*z + 2.*y.^2.*z.^2 - z.^3 + y.*z - 3;
Test(i).cu='4*x^5 - x*y^2*z + 2*y^2*z^2 - z^3 + y*z - 3';
Test(i).v=@(x,y,z) x.^2.*y.*z.^2 + x.^2.*y.*z - 2.*x.*y.*z.^2 + y.*z.^2 - 3.*y.^2 - x.*z;
Test(i).cv='x^2*y*z^2 + x^2*y*z - 2*x*y*z^2 + y*z^2 - 3*y^2 - x*z';
Test(i).w=@(x,y,z) -2.*x.^2.*y.^3 + x.*y.*z.^2 + x.*y.*z;
Test(i).cw='-2*x^2*y^3 + x*y*z^2 + x*y*z';
Test(i).Mass=2.157953042328042;
Test(i).MassW=0.07763668430335097;
Test(i).Stiff=-3.102777777777778;
Test(i).degree=5;
i=7;
Test(i).u=@(x,y,z) cos(x - 2./3.*y + 4./3.*z - 2./3);
Test(i).cu='cos(x - 2/3*y + 4/3*z - 2/3)';
Test(i).v=@(x,y,z) x.*y + x.*z - z.^2;
Test(i).cv='x*y + x*z - z^2';
Test(i).w=@(x,y,z) cos(1./2.*x - 3./4.*y + 1./4.*z);
Test(i).cw='cos(1/2*x - 3/4*y + 1/4*z)';
Test(i).Mass=0.1437236424227304;
Test(i).MassW=0.1407206851537448;
Test(i).Stiff=0.1639024563527328;
Test(i).degree=-1;
