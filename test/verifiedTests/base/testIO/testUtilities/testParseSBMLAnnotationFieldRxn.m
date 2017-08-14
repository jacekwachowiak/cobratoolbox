% The COBRAToolbox: testParseSBMLAnnotationFieldRxn.m
%
% Purpose:
%     - test the parseSBMLAnnotationFieldRxn function
%
% Authors:
%     - Jacek Wachowiak
global CBTDIR
% save the current path
currentDir = pwd;

% initialize the test
fileDir = fileparts(which('testParseSBMLAnnotationFieldRxn'));
cd(fileDir);

% test variables
cd ..
testModelXML = readCbModel('Ec_iJR904.xml');
cd testUtilities
% write the model as a .sbml file
writeCbModel(testModelXML, 'sbml', 'testModelSBML.sbml');
annotationField = 'testModelSBML.sbml'

% function outputs
[rxnEC, rxnReference] = parseSBMLAnnotationFieldRxn(annotationField);

% test

% change to old directory
cd(currentDir);
