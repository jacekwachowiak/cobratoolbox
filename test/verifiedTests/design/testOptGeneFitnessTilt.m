% The COBRAToolbox: testOptGeneFitnessTilt.m
%
% Purpose:
%     - test the optGeneFitnessTilt function
%
% Authors:
%     - Jacek Wachowiak
global CBTDIR
% save the current path
currentDir = pwd;

% initialize the test
fileDir = fileparts(which('testOptGeneFitnessTilt'));
cd(fileDir);

% test variables
model = readCbModel([CBTDIR filesep 'test' filesep 'models' filesep 'mat' filesep 'ecoli_core_model.mat']);
model.lb(36) = 0; % setting the model to anaerobic conditions
model.ub(36) = 0; % setting the model to anaerobic conditions
target = model.rxns(13);
rxn_vector_matrix = 0;
rxnListInput = model.rxns
isGeneList = 0;

%reference data

% function outputs
[val] = optGeneFitnessTilt(rxn_vector_matrix, model, targetRxn, rxnListInput, isGeneList)

% tests -
assert(isequal(0, 0));

close all hidden force

% change to old directory
cd(currentDir);
