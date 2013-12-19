function PrintDataInLatexTabular(Data,Header,DataFormat,ColumnFormat,RowFormat,RowHeaderFormat,LaTeXFilename)
% DataFormat={'$%d$','$%d$','%.3f','%.3f','%.3f'}
% ColumnFormat='|r|r||*{3}{c|}'
% RowFormat='\hline';
% RowHeaderFormat='\hline \hline';
% Header={'$N$','$n_q$','Matlab','Octave','FreeFEM++'}
% Data array
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details

  [nR,nCG]=size(Data);
  nC=length(Header);
  if isempty(LaTeXFilename)
    fid=1;
  else
  fid=fopen(LaTeXFilename,'w');
   if (fid == -1)
    error(['Cannot open file ',LaTeXFilename]);
   end
  end
fprintf(fid,'%%\\documentclass[]{article}\n%%\\begin{document}\n');


  fprintf(fid,'\\begin{tabular}{%s}\n',ColumnFormat);
  fprintf(fid,'  %s \n',RowFormat);
  
  % Header
  FFormat=DataFormat{1};
  for i=1:nC-1
    fprintf(fid,'  %s &',Header{i});
    FFormat=sprintf('%s & %s',FFormat,DataFormat{i+1});
  end
  fprintf(fid,'  %s ',Header{nC});
  fprintf(fid,' \\\\ %s\n',RowHeaderFormat);
  
  for i=1:nR
    fprintf(fid,FFormat,Data(i,:));
    fprintf(fid,'\\\\ %s\n',RowFormat);
  end
  
  fprintf(fid,'\\end{tabular}\n');
fprintf(fid,'%%\\end{document}');
  if (fid ~=1)
    fclose(fid);
    fprintf(' -> %s\n',LaTeXFilename);
  end
end
