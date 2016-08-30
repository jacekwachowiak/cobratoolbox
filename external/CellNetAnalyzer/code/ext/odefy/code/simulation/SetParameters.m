% SETPARAMETERS  Change dynamic parameters of a given parameter set.
%
%   CHANGED=SETPARAMETERS(SIMSTRUCT,SPECIES1,SPECIES2,PARAMETER,VALUE) 
%   changes the influence of SPECIES2 in the equation of SPECIES1 with 
%   respect to parameter PARAMETER to VALUE. The function takes a
%   simulation structure SIMSTRUCT and returns a changed simulation
%   structure CHANGED.
%
%   CHANGED=SETPARAMETERS(PARAMS,MODEL,SPECIES1,...) - Instead of passing a
%   simulation structure one can also specify a parameters matrix and the
%   corresponding Odefy model directly.
%
%   Parameter explanations:
% 
%      SPECIES1  - String name of species or cell array of strings for the 
%                  regulated species, i.e. the species whose equation 
%                  parameters are changed. Can also be set to [], refering 
%                  to all species of the model.
%
%      SPECIES2  - String name of species or cell array of strings for the
%                  regulating species. Can also be set to [], refering to
%                  all species of the model.
%
%      PARAMETER - Name of the parameter to be changed. Can be 'n', 'k' or
%                  'tau'. Note that for the latter option, SPECIES2 is 
%                  ignored.
%
%      VALUE     - The value to which the parameter is set.
%            
%
%   Examples:
%
%      Update threshold of b on a in simulation structure 'simstruct'
%        simstruct = SetParameters(simstruct, 'a', 'b', 'k', 0.9);
%
%      Set all influence thresholds (outgoing edges) of b to 0.9
%        simstruct = SetParameters(simstruct, [], 'b', 'k', 0.9); 
%
%      Set all ingoing influence thresholds of 'a' to 0.9
%        simstruct = SetParameters(simstruct, 'a', [], 'k', 0.9); 
% 
%      Set all n parameters in the system to 4
%        simstruct = SetParameters(simstruct, [], [], 'n', 4); 
%
%      Set tau of a and b to 10, directly work in a parameter matrix (which 
%      can e.g. be generated by the DefaultParameters function)
%        params = SetParameters(params, model, {'a','b'}, [], 'tau', 10);

%   Odefy - Copyright (c) CMB, IBIS, Helmholtz Zentrum Muenchen
%   Free for non-commerical use, for more information: see LICENSE.txt
%   http://cmb.helmholtz-muenchen.de/odefy
%
function out = SetParameters( varargin )

% validate input parameters
if nargin==5
    simstruct = varargin{1};
    if (~IsSimulationStructure(simstruct))
        error('First parameter must be a simulation structure');
    end
    model=simstruct.model;
    params=simstruct.params;
    species1 = varargin{2};
    species2 = varargin{3};
    parameter = varargin{4};
    value = varargin{5};
elseif nargin==6
    params = varargin{1};
    model = varargin{2};
    if (~IsOdefyModel(model))
        error('Second parameter must be an Odefy model');
    end
    species1 = varargin{3};
    species2 = varargin{4};
    parameter = varargin{5};
    value = varargin{6};
else
    error('Functions takes 5 or 6 input arguments');
end

% validate parameter and value
switch (parameter)
    case 'tau'
        if value<=0
            error('Tau must have a positive value.');
        end
    case 'k'
        if value<=0 || value >=1
            error('k must be between 0 and 1, exclusively.');
        end
    case 'n'
        if value < 1 || rem(value,1)~=0
            error('n must be a positive integer');
        end
    otherwise
        error('Parameter must be one of ''tau'', ''n'', ''k''');
        
end

if ~iscell(species1)
    species1 = {species1};
end

if ~iscell(species2)
    species2 = {species2};
end

% Check if value is positive
if (~isscalar(value) || value <= 0)
    error('value must be greater than zero');
end

% Check if parameter is valid
if (~ischar(parameter))
    error('Argument parameter must be one of "tau", "n" or "k"');
end

% Get indices of species1
if numel(species1{1}) == 0
    species1 = model.species;
end
species1_index = GetSpeciesIndexFromName(species1, model.species)';
if numel(find(species1_index==0,1,'first'))
    error('Species %s is not part of the model', species1{find(species1_index==0,1,'first')});
end
% Get indices of species2
if numel(species2{1}) == 0
    species2 = model.species;
end
species2_index = GetSpeciesIndexFromName(species2, model.species)';
if numel(find(species2_index==0,1,'first'))
    error('Species %s is not part of the model', species2{find(species2_index==0,1,'first')});
end

% iterate over all equations (species1)
for s1=species1_index
    % iterate over all regulators (specie2)
    for s2=species2_index

        % Check if species2 is part of the expression of species1
        if (strcmp(parameter, 'n') || strcmp(parameter, 'k'))
            species1_inspecies = model.tables(species1_index).inspecies;
            species2_inspecies_index = find(species1_inspecies == species2_index);
        end

        switch (parameter)
            case 'tau'
                params(s1, 1) = value;
            case 'n'
                if numel(species2_inspecies_index)
                    params(s1, species2_inspecies_index*2) = value;
                end
            case 'k'
                if numel(species2_inspecies_index)
                    params(s1, species2_inspecies_index*2+1) = value;
                end          
        end

    end
end

if nargin==5
    out=simstruct;
    out.params=params;
else
    out=params;
end

end
