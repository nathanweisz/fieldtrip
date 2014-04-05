function test_ft_datatype

% MEM 3gb
% WALLTIME 00:45:00

% TEST test_ft_datatype
% TEST ft_datatype ft_datatype_comp ft_datatype_mvar ft_datatype_source ft_datatype_dip ft_datatype_parcellation ft_datatype_spike ft_datatype_freq ft_datatype_raw ft_datatype_timelock ft_datatype_headmodel ft_datatype_segmentation ft_datatype_volume ft_datatype ft_datatype_sens

% the style of this test script is also used in test_ft_analysisprotocol and test_ft_datatype_source

dirlist = {
  '/home/common/matlab/fieldtrip/data/test/latest'
  '/home/common/matlab/fieldtrip/data/test/20111231'
  '/home/common/matlab/fieldtrip/data/test/20110630'
  '/home/common/matlab/fieldtrip/data/test/20101231'
  '/home/common/matlab/fieldtrip/data/test/20100630'
  '/home/common/matlab/fieldtrip/data/test/20091231'
  '/home/common/matlab/fieldtrip/data/test/20090630'
  '/home/common/matlab/fieldtrip/data/test/20081231'
  '/home/common/matlab/fieldtrip/data/test/20080630'
  '/home/common/matlab/fieldtrip/data/test/20071231'
  '/home/common/matlab/fieldtrip/data/test/20070630'
  '/home/common/matlab/fieldtrip/data/test/20061231'
  '/home/common/matlab/fieldtrip/data/test/20060630'
  '/home/common/matlab/fieldtrip/data/test/20051231'
  '/home/common/matlab/fieldtrip/data/test/20050630'
  '/home/common/matlab/fieldtrip/data/test/20040623'
  '/home/common/matlab/fieldtrip/data/test/20031128'
  };

for j=1:length(dirlist)
  filelist = hcp_filelist(dirlist{j});
  
  [dummy, dummy, x] = cellfun(@fileparts, filelist, 'uniformoutput', false);
  sel = strcmp(x, '.mat');
  filelist = filelist(sel);
  clear p f x
  
  for i=1:length(filelist)
    
    try
      fprintf('processing data structure %d from %d\n', i, length(filelist));
      var = loadvar(filelist{i});
      disp(var)
    catch
      % some of the mat files are corrupt, this should not spoil the test
      disp(lasterr);
      continue
    end
    
    type = 'unknown';
    
    if ~isempty(regexp(filelist{i}, '/raw/'))
      type = 'raw';
    elseif ~isempty(regexp(filelist{i}, '/comp/'))
      type = 'comp';
    elseif ~isempty(regexp(filelist{i}, '/timelock/'))
      type = 'timelock';
    elseif ~isempty(regexp(filelist{i}, '/freq/'))
      type = 'freq';
    elseif ~isempty(regexp(filelist{i}, '/source/'))
      type = 'source';
    elseif ~isempty(regexp(filelist{i}, '/volume/')) || ~isempty(regexp(filelist{i}, '/mri/'))
      type = 'volume';
    end
    
    switch type
      case 'raw'
        assert(ft_datatype(var, type), sprintf('%s did not contain %s data', filelist{i}, type));
      case 'comp'
        assert(ft_datatype(var, type), sprintf('%s did not contain %s data', filelist{i}, type));
        type = 'raw'; % comp data is a special type of raw data
        assert(ft_datatype(var, type), sprintf('%s did not contain %s data', filelist{i}, type));
      case 'timelock'
        assert(ft_datatype(var, type), sprintf('%s did not contain %s data', filelist{i}, type));
      case 'freq'
        assert(ft_datatype(var, type), sprintf('%s did not contain %s data', filelist{i}, type));
      case 'source'
        assert(ft_datatype(var, type), sprintf('%s did not contain %s data', filelist{i}, type));
      case 'volume'
        assert(ft_datatype(var, type), sprintf('%s did not contain %s data', filelist{i}, type));
      otherwise
        warning('not testing %s', filelist{i});
        % do nothing
    end % switch

  end % for filelist
end % for dirlist



