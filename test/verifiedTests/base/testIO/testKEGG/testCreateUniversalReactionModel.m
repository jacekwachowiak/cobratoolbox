% The COBRAToolbox: testCreateUniversalReactionModel.m
%
% Purpose:
%     - test the createUniversalReactionModel function
%
% Authors:
%     - Jacek Wachowiak
global CBTDIR
% save the current path
currentDir = pwd;

% initialize the test
fileDir = fileparts(which('testCreateUniversalReactionModel'));
cd(fileDir);

% test variables

% function outputs
KEGG = createUniversalReactionModel()

% test
assert(isequal(0, 0));

% change to old directory
cd(currentDir);
