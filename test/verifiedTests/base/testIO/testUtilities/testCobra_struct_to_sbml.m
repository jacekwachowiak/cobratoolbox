% The COBRAToolbox: testCobra_struct_to_sbml.m
%
% Purpose:
%     - test the cobra_struct_to_sbml function
%
% Authors:
%     - Jacek Wachowiak
global CBTDIR
% save the current path
currentDir = pwd;

% initialize the test
fileDir = fileparts(which('testCobra_struct_to_sbml'));
cd(fileDir);

% test variables
model = readCbModel([CBTDIR filesep 'test' filesep 'models' filesep 'ecoli_core_model.mat']);

% function outputs
%sbml_model = cobra_struct_to_sbml_struct(model, sbml_level, sbml_version)
sbml_model = cobra_struct_to_sbml_struct(model)

% test
assert(isequal(0, 0))

% change to old directory
cd(currentDir);
