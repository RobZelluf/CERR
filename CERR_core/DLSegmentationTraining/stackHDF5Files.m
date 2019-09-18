function outC = stackHDF5Files(outPath)
% stackHDF5Files.m
%
% Reads .H5 files with mask slices and returns 3D stacks
%
% AI 9/13/19
%--------------------------------------------------------------------------
%INPUTS:
% outPath       : Path to generated H5 files
% Note: Assumes output filenames are of the form: prefix_slice#
%------------------------------------------------------------------------
% RKP 9/18/2019 Updates for compatibility with testing pipeline

dirS = dir(fullfile(outPath,'outputH5','*.h5'));
fileNameC = {dirS.name};
ptListC = unique(strtok(fileNameC,'_'));
outC = cell(length(ptListC),1);

for p = 1:length(ptListC)
    
    %Get mask filenames for each pt
    matchIdxV = find(strcmp(strtok(fileNameC,'_'),ptListC{p}));
    
    %Stack files
    mask3M = [];
    for s = 1: length(matchIdxV)
        
        slcName = fullfile(outPath,'outputH5',fileNameC{s});
        idx = strfind(slcName,'_slice');
        slcNum = str2double(slcName(idx+7:end-3));        
        labelM = h5read(slcName,'/mask').';
        mask3M(:,:,slcNum) = labelM;

  
    end
    
    outC{p} = mask3M;
    
end

end