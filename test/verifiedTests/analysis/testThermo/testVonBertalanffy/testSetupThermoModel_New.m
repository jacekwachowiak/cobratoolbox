% The COBRAToolbox: testSetupThermoModel.m
%
% Purpose:
%     - test the setupThermoModel function
%
% Authors:
%     - Jacek Wachowiak
global CBTDIR
% save the current path
currentDir = pwd;

% initialize the test
fileDir = fileparts(which('testSetupThermoModel_New'));
cd(fileDir);

% test variables
model = getDistributedModel('Recon3D_Dec2017.mat');
model.csense(1:size(model.S,1),1)='E';
model.metFormulas{strcmp(model.mets,'h[i]')}='H';
model.metFormulas(cellfun('isempty',model.metFormulas)) = {'R'};
if isfield(model,'metCharge')
  model.metCharges = double(model.metCharge);
  model=rmfield(model,'metCharge');
end
model.compartments = ['c'; 'e'; 'g'; 'l'; 'm'; 'n'; 'r'; 'x'; 'i'];

% reference data

% function outputs
model
model = setupThermoModel(model, 0.95);

% tests


% change to old directory
cd(currentDir);
