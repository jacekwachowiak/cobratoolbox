% The COBRAToolbox: testMultiProductionEnvelopeInorg.m
%
% Purpose:
%     - test the multiProductionEnvelopeInorg function
%
% Authors:
%     - Jacek Wachowiak
global CBTDIR
% save the current path
currentDir = pwd;

% initialize the test
fileDir = fileparts(which('testMultiProductionEnvelopeInorg'));
cd(fileDir);

% test variables
model = readCbModel([CBTDIR filesep 'test' filesep 'models' filesep 'ecoli_core_model.mat']);
biomassRxn = model.rxns(1);
target = model.rxns(2);
deletions = model.rxns(3);
deletions2 = model.genes(3);

% function outputs
[biomassValues, targetValues] = multiProductionEnvelopeInorg(model);
[biomassValues, targetValues] = multiProductionEnvelopeInorg(model, deletions, biomassRxn);
%gene not reaction removal
[biomassValues2, targetValues2] = multiProductionEnvelopeInorg(model, deletions2, biomassRxn, 1, 20, 1);

% tests
assert(isequal(size(biomassValues), size(zeros(20,1))));
assert(isequal(((biomassValues - biomassValues2) < 0.01), ones(20,1)));
assert(isequal(size(targetValues), size(zeros(20,26))));

pause(3);
close all hidden force

% change to old directory
cd(currentDir);
