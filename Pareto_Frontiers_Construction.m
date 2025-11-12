%% Pareto Frontiers Construction 
clear; clc; close all;

%% 
main_folder = 'C:\Users\Federica de Trizio\PycharmProjects\TETREES\';

result_names = { ...

};

%colorList = lines(length(result_names)); 

colorList = {
    '#1f77b4',  % blu
    '#ff7f0e',  % arancio
    '#2ca02c',  % verde
    '#d62728',  % rosso
    '#9467bd',  % viola
    '#8c564b',  % marrone
    '#e377c2',  % rosa
    '#7f7f7f',  % grigio
    '#bcbd22',  % giallo-verde oliva
    '#17becf',  % azzurro
    '#aec7e8',  % blu chiaro
    '#ffbb78',  % arancio chiaro
    '#98df8a',  % verde chiaro
    '#ff9896',  % rosso salmone
    '#c5b0d5'   % lilla chiaro
};


% Variables to limit the axis
all_KPI = [];
all_KVI = [];

figure('Color','w');
hold on; grid on; box on;

legend_entries = {};

% Loop on every folder in result names
for i = 1:length(result_names)
    folder_name = result_names{i};
    folder_path = fullfile(main_folder, folder_name);

    % Pareto file
    pareto_file = fullfile(folder_path, 'pareto_solutions.csv');

    if exist(pareto_file, 'file')
        data = readtable(pareto_file);

        % Check columns
        if all(ismember({'KPI_Totale','KVI_Totale'}, data.Properties.VariableNames))
            KPI_Totale = data.KPI_Totale;
            KVI_Totale = data.KVI_Totale;

            % Update min/max for axis limitation
            all_KPI = [all_KPI; KPI_Totale];
            all_KVI = [all_KVI; KVI_Totale];

            % Plot
            plot(KPI_Totale, KVI_Totale, 'o-', ...
                'LineWidth', 4, ...
                'MarkerSize', 10, ...
                'Color', colorList{i}, ...
                'DisplayName', strrep(folder_name, '_', ' '));
            
            % Aggiunge legenda leggibile
            legend_entries{end+1} = strrep(folder_name, '_', ' ');
        end
    else
        disp(['Pareto file not found: ' pareto_file]); 
    end
end
%                % 'Color', colorList(i,:), ...


xlabel('Network quality performance');
ylabel('Network social and ethical value');
%title('Pareto Fronts for Different Configurations');
grid on;
set(gca, 'FontSize', 26, 'GridAlpha', 0.3, 'FontName', 'Times New Roman');
%legend({'N = 130', 'N = 125', 'N = 120', 'N = 115', 'N = 110', 'N = 105', 'N = 100', 'N = 95', 'N = 90', 'N = 85', 'N = 80', 'N = 75', 'N = 70', 'N = 65', 'N = 60'}, 'Location', 'northeastoutside');
legend({'Baseline', 'Fast', 'Strong Branching', 'Cut-and-Solve', 'Sub-Optimal', 'Balanced'}, 'Location', 'northeastoutside')

if ~isempty(all_KPI)
    xlim([min(all_KPI)-0.05*range(all_KPI), max(all_KPI)+0.05*range(all_KPI)]);
end
if ~isempty(all_KVI)
    ylim([min(all_KVI)-0.05*range(all_KVI), max(all_KVI)+0.05*range(all_KVI)]);
end

% Zoom

ax_main = gca;

% Zoom-out 
xlim(ax_main, [min(all_KPI)-0.2*range(all_KPI), max(all_KPI)+0.2*range(all_KPI)]);
ylim(ax_main, [min(all_KVI)-0.2*range(all_KVI), max(all_KVI)+0.2*range(all_KVI)]);

% Axis limitations of the plot (subject to change)
zoom_x = [190 225];
zoom_y = [9e5 9.5e5];

% New axis for the zoom
ax_inset = axes('Position',[0.15 0.15 0.25 0.25]); % [x y width height]
hold(ax_inset, 'on');
box(ax_inset, 'on');
grid(ax_inset, 'on');

%lines_main = findobj(ax_main,'Type','Line');
lines_main = flipud(findobj(ax_main,'Type','Line'));

% Replot the previous curves here
for i = 1:length(lines_main)
    plot(ax_inset, lines_main(i).XData, lines_main(i).YData, ...
        'LineStyle', lines_main(i).LineStyle, ...
        'Marker', lines_main(i).Marker, ...
        'Color', lines_main(i).Color, ...
        'LineWidth', lines_main(i).LineWidth, ...
        'MarkerSize', lines_main(i).MarkerSize);
end

% Set axis lim for the zoomed part
xlim(ax_inset, zoom_x);
ylim(ax_inset, zoom_y);

% Set zoom style
set(ax_inset, 'FontSize', 12, 'FontName', 'Times New Roman', ...
    'Box', 'on', 'Layer', 'top');

axes(ax_inset);


% Export the file
exportgraphics(gcf, fullfile(main_folder, 'pareto_fronts_all_zoom.eps'), ...
    'ContentType', 'vector', 'BackgroundColor', 'none');


fprintf('\n SAVED PLOT \n');
