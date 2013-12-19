function runBenchs(varargin)
% function runBenchs(varargin)
%   Run 3D benchs for Mass , Stiff, MassVF and StiffElas matrices in 3D.
%   For each assembly matrix, we compare computation times of corresponding functions 
%   for version 'base', 'OptV0', 'OptV1' and 'OptV2'.
%
% Optional parameters:
%   - 'save' : true for saving each bench in LaTeX files. 
%        (default false)
%   - 'directory' : name of the directory for saving LaTeX files.
%        (default 'latex')
%   - 'name' : base name of LaTeX files.
%        (default 'bench')
%   - 'LN' : List of N parameters for CubeMesh function.
%        (default [5:2:11])
%
% Example:
%     runBenchs('save',true,'name','benchMatlabR2012b','LN',5:3:20)
%
% See also:
%   benchMass3DP1, benchStiff3DP1, benchStiffElas3DP1, benchMassVF3DP1, InitOptFEM3D
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
close all

InitOptFEM3D();

p = inputParser;
  
if isOctave()
  p=p.addParamValue('save', false, @islogical );
  p=p.addParamValue('directory', 'latex' , @ischar );
  p=p.addParamValue('name', 'bench' , @ischar );
  p=p.addParamValue('LN', [5:2:11] , @isnumeric );
  p=p.parse(varargin{:});
else % Matlab
  p.addParamValue('save', false, @islogical );
  p.addParamValue('directory', 'latex' , @ischar );
  p.addParamValue('name', 'bench' , @ischar );
  p.addParamValue('LN', [5:2:11], @isnumeric );
  p.parse(varargin{:});
end
LN=p.Results.LN;
if p.Results.save
  [succes,message,messageid] = mkdir(p.Results.directory);
  if (~succes)
    error(message)
  end  
end
BenchMass3DP1=benchMass3DP1('LN',LN);
if p.Results.save
  % Build LaTeX tabular
  BenchToLatexTabular(BenchMass3DP1,[p.Results.directory,filesep,p.Results.name,'_Mass3DP1.tex']);
end

BenchStiff3DP1=benchStiff3DP1('LN',LN);
if p.Results.save
  % Build LaTeX tabular
  BenchToLatexTabular(BenchStiff3DP1,[p.Results.directory,filesep,p.Results.name,'_Stiff3DP1.tex']);
end

BenchMassVF3DP1=benchMassVF3DP1('LN',LN);
if p.Results.save
  % Build LaTeX tabular
  BenchToLatexTabular(BenchMassVF3DP1,[p.Results.directory,filesep,p.Results.name,'_MassVF3DP1.tex']);
end

BenchStiffElas3DP1=benchStiffElas3DP1('LN',LN);
if p.Results.save
  % Build LaTeX tabular
  BenchToLatexTabular(BenchStiffElas3DP1,[p.Results.directory,filesep,p.Results.name,'_StiffElas3DP1.tex']);
end
end

function BenchToLatexTabular(bench,LaTeXFilename)
  T=bench.T;
  Data=[bench.Ldof',T(:,1),T(:,1)./T(:,1),T(:,2),T(:,1)./T(:,2),T(:,3),T(:,1)./T(:,3),T(:,4),T(:,1)./T(:,4)];
  Header={'$n_{dof}$', 'base', 'OptV0', 'OptV1', 'OptV2'};
  DataFormat={'$%d$','\\begin{tabular}{c} %.3f (s)\\\\ \\texttt{x %.2f} \\end{tabular}', ...
                     '\\begin{tabular}{c} %.3f (s)\\\\ \\texttt{x %.2f} \\end{tabular}', ...
                     '\\begin{tabular}{c} %.3f (s)\\\\ \\texttt{x %.2f} \\end{tabular}', ...
                     '\\begin{tabular}{c} %.3f (s)\\\\ \\texttt{x %.2f} \\end{tabular}'};
  ColumnFormat= '|r||*{4}{c|}';
  RowFormat='\hline';
  RowHeaderFormat='\hline \hline';
  PrintDataInLatexTabular(Data,Header,DataFormat,ColumnFormat,RowFormat,RowHeaderFormat,LaTeXFilename)

end
