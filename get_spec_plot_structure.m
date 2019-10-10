%% Code authored by Seth Allen Cazzell
% cazzell.lbi@gmail.com

% This is a function that returns a data structure organizing speciation data as a fraction of a given component.

%% Please reference
% "Expanding the stoichiometric window for metal cross-linked gel assembly using competition" PNAS, Cazzell (2019)
% when appropriate.

%% Copyright 2019 Seth Allen Cazzell All rights reserved. Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
% 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
% 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

%%
function [spec_plot] = get_spec_plot_structure(row_index,speciation,species_input_model)

species_names = species_input_model.spec_names;
model = species_input_model.Model;
model_row = model(row_index,:);

% Get the species that contain the component you are interested in
number_of_species = 1;
for species_number = 1:length(model_row)
    if model_row(species_number) > 0.1
        species_index(number_of_species) = species_number;
        number_of_species = number_of_species + 1;
    end
end

species_names = species_names(species_index);

% For each experimentally relevant titration, organize speciation data
metal_plot_index = 1;
for current_titration_index = speciation.critical_titration.indices
    spec_plot.metal_conc(metal_plot_index).pH = speciation.pH;
    %spec_plot.metal_conc(metal_plot_index).v_added = speciation.v_added;
    %spec_plot.metal_conc(metal_plot_index).norm_v_added = speciation.norm_v_added;
    spec_plot.metal_conc(metal_plot_index).species_names = species_names;
	if row_index == 3 
		spec_plot.metal_conc(metal_plot_index).species = speciation.metal_concentration(current_titration_index).fraction.ligand(:,species_index);
	end
	if row_index == 2
		spec_plot.metal_conc(metal_plot_index).species = speciation.metal_concentration(current_titration_index).fraction.metal(:,species_index);
	end
    %spec_plot.metal_conc(metal_plot_index).species = speciation.metal_concentration(current_titration_index).fraction_row(row_index).frac(:,species_index);
    %spec_plot.metal_conc(metal_plot_index).check_sum = sum(spec_plot.metal_conc(metal_plot_index).species,2);
    metal_plot_index = metal_plot_index + 1;
end

end

