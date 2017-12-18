% The COBRAToolbox: testThermoConstrainFluxBounds.m
%
% Purpose:
%     - test the thermoConstrainFluxBounds function
%
% Authors:
%     - Jacek Wachowiak
global CBTDIR
% save the current path
currentDir = pwd;

% initialize the test
fileDir = fileparts(which('testThermoConstrainFluxBounds'));
cd(fileDir);

[status,result] = system('babel'); %if run without initVonBertalanffy it is needed to fix the path
if status ~= 0
    setenv('LD_LIBRARY_PATH',['/usr/lib/x86_64-linux-gnu:' getenv('LD_LIBRARY_PATH')]);
end

% test variables
model = getDistributedModel('Recon3D_Dec2017.mat');

model.csense(1:size(model.S,1),1)='E';
model.metFormulas{strcmp(model.mets,'h[i]')}='H';
model.metFormulas(cellfun('isempty',model.metFormulas)) = {'R'};
if isfield(model,'metCharge')
  model.metCharges = double(model.metCharge);
  model=rmfield(model,'metCharge');
end
model.T = 310.15;
model.compartments = ['c'; 'e'; 'g'; 'l'; 'm'; 'n'; 'r'; 'x'; 'i'];
model.metCompartments = getCompartment(model.mets);
model.ph = [7.2; 7.4; 6.35; 5.5; 8; 7.2; 7.2; 7; 7.2];
model.is = 0.15*ones(length(model.compartments),1);
model.chi = [0; 30; 0; 19; -155; 0; 0; -2.303*8.3144621e-3*model.T*(model.ph(model.compartments == 'x') - model.ph(model.compartments == 'c'))/(96485.3365e-6); 0];
basePath='~/work/sbgCloud';
molfileDir = [basePath '/data/molFilesDatabases/explicitHMol'];
% reference data

% function outputs
confidenceLevel = 0.95;
DrGt0_Uncertainty_Cutoff = 20;
[modelThermo, directions] = thermoConstrainFluxBounds(model, confidenceLevel, DrGt0_Uncertainty_Cutoff)

% tests

% change to old directory
cd(currentDir);
