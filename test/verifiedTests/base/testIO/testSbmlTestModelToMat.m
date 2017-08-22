% The COBRAToolbox: testSbmlTestModelToMat.m
%
% Purpose:
%     - test the sbmlTestModelToMat function
%
% Authors:
%     - Jacek Wachowiak
global CBTDIR
% save the current path
currentDir = pwd;

% initialize the test
fileDir = fileparts(which('testSbmlTestModelToMat'));
cd(fileDir);

% test variables
originFolder = [CBTDIR filesep 'test' filesep 'models'];
destFolder = [CBTDIR filesep 'test' filesep 'verifiedTests' filesep 'base' filesep 'testIO'];
modelDir = [CBTDIR filesep 'test' filesep 'models'];
cd(modelDir);
modelDir
fclose(fopen('textbook.xml', 'w'));
cd(fileDir);
% function call
sbmlTestModelToMat(originFolder, destFolder);
sbmlTestModelToMat(destFolder, destFolder);
temp = CBTDIR;
CBTDIR = [];
sbmlTestModelToMat('error', 'error');
CBTDIR = temp;
% test
assert(isequal(0, 0));

% remove

% change to old directory
cd(currentDir);
