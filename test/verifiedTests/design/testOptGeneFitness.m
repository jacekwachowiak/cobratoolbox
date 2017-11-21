% The COBRAToolbox: testOptGeneFitness.m
%
% Purpose:
%     - test the optGeneFitness function
%
% Authors:
%     - Jacek Wachowiak
global CBTDIR
% save the current path
currentDir = pwd;

% initialize the test
fileDir = fileparts(which('testOptGeneFitness'));
cd(fileDir);

% test variables
model = readCbModel([CBTDIR filesep 'test' filesep 'models' filesep 'mat' filesep 'ecoli_core_model.mat']);
model.lb(36) = 0; % setting the model to anaerobic conditions
model.ub(36) = 0; % setting the model to anaerobic conditions
target = model.rxns(13);
rxn_vector_matrix = [1];
rxnListInput = model.rxns;
isGeneList = 0;

% function outputs
[val] = optGeneFitness(rxn_vector_matrix, model, targetRxn, rxnListInput, isGeneList)

% tests -
assert(isequal(0, 0));

close all hidden force

% change to old directory
cd(currentDir);
