% The COBRAToolbox: testXls2Model.m
%
% Purpose:
%     - tests the functionality of the xls2model function
%   	- check whether the toy model xlsx file can be loaded without error
%        if not: fail test
%
% Note:
%		    The addReaction function will produce output in one of its last lines.
%		    can not be helped since this is a useful functionality outside of testing
%
% Authors:
%     - CI integration: Laurent Heirendt

% save the current path
currentDir = pwd;

% initialize the test
fileDir = fileparts(which('testXls2Model'));
cd(fileDir);

% convert the model
model = xls2model('cobra_import_toy_model.xlsx');
% additional tests
% bad filename
x = 'wrongname'
try
    xls2model('wrong_name.xlsx');
catch ME
    assert(length(ME.message) > 0)
end
% bad sheets in xlsx file
x = 'badsheets'
try
    xls2model('cobra_import_toy_model_3.xlsx');
catch ME
    assert(length(ME.message) > 0)
end
% 10000
x = '10000'
xls2model('cobra_import_toy_model_4.xlsx');
% empty MetStrings
x = 'emptymetstrings'
try
    xls2model('cobra_import_toy_model_5.xlsx');
catch ME
    assert(length(ME.message) > 0)
end
% empty RxnHeader
x = 'requiredrxnheaders'
try
    xls2model('cobra_import_toy_model_6.xlsx');
catch ME
    assert(length(ME.message) > 0)
end
% empty MetHeader
x = 'requiredmetheaders'
try
    xls2model('cobra_import_toy_model_7.xlsx');
catch ME
    assert(length(ME.message) > 0)
end
% missing header - line 145
x = 'missingheader'
try
    xls2model('cobra_import_toy_model_8.xlsx');
catch ME
    assert(length(ME.message) > 0)
end

warning('off', 'all')
    output1 = function1(input1, input2');
    assert(length(lastwarn()) > 0)
warning('on', 'all')


% test the number of reactions
assert(length(model.rxns) == 8)

% test the number of metabolites
assert(length(model.mets) == 5)

% Compare with a second equivalent model, that does not have the cytosol
% localisation
model2 = xls2model('cobra_import_toy_model_2.xlsx');
assert(isequal(printRxnFormula(model2,model2.rxns),printRxnFormula(model,model2.rxns)));

% change the directory
cd(currentDir)
