% The COBRAToolbox: testTheoretMaxProd.m
%
% Purpose:
%     - test the theoretMaxProd function
%
% Authors:
%     - Jacek Wachowiak
global CBTDIR
% save the current path
currentDir = pwd;

% initialize the test
fileDir = fileparts(which('testTheoretMaxProd'));
cd(fileDir);

% test variables
model = readCbModel([CBTDIR filesep 'test' filesep 'models' filesep 'ecoli_core_model.mat']);

% function outputs
[ExRxns, MaxTheoOut] = theoretMaxProd(model, criterion, inputrxn, normalize, rxns)

% tests
assert(isequal(0, 0));

% change to old directory
cd(currentDir);
