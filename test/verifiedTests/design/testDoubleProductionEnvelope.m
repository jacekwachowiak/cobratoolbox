% The COBRAToolbox: testDoubleProductionEnvelope.m
%
% Purpose:
%     - test the doubleProductionEnvelope function
%
% Authors:
%     - Jacek Wachowiak
global CBTDIR
% save the current path
currentDir = pwd;

% initialize the test
fileDir = fileparts(which('testDoubleProductionEnvelope'));
cd(fileDir);

% test variables
model = readCbModel([CBTDIR filesep 'test' filesep 'models' filesep 'mat' filesep 'ecoli_core_model.mat']);
model.lb(36) = 0; % setting the model to anaerobic conditions
model.ub(36) = 0; % setting the model to anaerobic conditions
biomassRxn = model.rxns(13);
target = model.rxns(13); % objective = biomass reaction
deletions = model.rxns(21);
deletions2 = model.genes(21);
targetreactionsBasic = {'EX_ac(e)','EX_for(e)','EX_ethoh(e)'};
prod1 = model.rxns(13);
prod2 = model.rxns(14);

%reference data
refData_x=(0:(0.2117/19):0.2117)';
refData_lowerbound = zeros(20, 1); % EX_ac(e)
refData_lowerbound(18) = 0.0736;
refData_lowerbound(19) = 3.9862;
refData_lowerbound(20) = 8.5036;
refData_upperBound = (10:(-1.4964/19):8.5036)';

% function outputs
[x1, x2, y] = doubleProductionEnvelope(model, deletions, prod1, prod2)
% tests
assert(isequal(0, 0));

close all hidden force

% change to old directory
cd(currentDir);
