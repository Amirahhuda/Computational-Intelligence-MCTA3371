function heartAttackRiskAppWithFuzzyNN()
    % Load the trained fuzzy neural network model
    model = load('trainedNeuralNetwork.mat'); % Replace with your file
    neuralNet = model.net; % Update to match the variable in your .mat file

    % Main Figure
    fig = uifigure('Name', 'Heart Attack Risk Prediction', 'Color', [1 0.85 0.85], 'Position', [500, 300, 400, 300]);

    % Title Label
    uilabel(fig, 'Text', 'Heart Attack Risk Prediction', ...
        'FontSize', 18, 'FontWeight', 'bold', ...
        'HorizontalAlignment', 'center', ...
        'Position', [50, 220, 300, 40], 'BackgroundColor', [1 0.7 0.7]);

    % Start Button
    uibutton(fig, 'Text', 'Start', ...
        'FontSize', 14, 'FontWeight', 'bold', ...
        'Position', [150, 120, 100, 40], ...
        'ButtonPushedFcn', @(btn, event) gatherInputs());

    % Result Label
    resultLabel = uilabel(fig, 'Text', 'Risk Level: -', ...
        'FontSize', 14, 'FontWeight', 'bold', ...
        'HorizontalAlignment', 'center', ...
        'Position', [50, 50, 300, 40], 'BackgroundColor', [1 0.7 0.7]);

    % Function to Gather Inputs Using Popups
    function gatherInputs()
        % Define Input Prompts and Default Values
        prompts = {'Enter your age (years):', ...
                   'Enter cholesterol (mg/dL):', ...
                   'Enter resting heart rate (bpm):', ...
                   'Do you smoke? (Yes/No):', ...
                   'Do you drink alcohol? (Yes/No):', ...
                   'Do you have diabetes? (Yes/No):', ...
                   'Do you have previous heart problems? (Yes/No):', ...
                   'Enter your stress level (1-10):'};
        defaultValues = {'', '', '', 'No', 'No', 'No', 'No', '5'};
        
        % Display Input Dialog
        inputs = inputdlg(prompts, 'Heart Attack Risk Inputs', [1, 50], defaultValues);
        
        % Validate User Input
        if isempty(inputs)
            uialert(fig, 'No inputs were provided!', 'Error');
            return;
        end
        
        % Parse Inputs
        try
            age = str2double(inputs{1});
            cholesterol = str2double(inputs{2});
            heartRate = str2double(inputs{3});
            smoking = strcmpi(inputs{4}, 'Yes');
            alcoholic = strcmpi(inputs{5}, 'Yes');
            diabetes = strcmpi(inputs{6}, 'Yes');
            previousHeartProblem = strcmpi(inputs{7}, 'Yes');
            stressLevel = str2double(inputs{8});
            
            if isnan(age) || isnan(cholesterol) || isnan(heartRate) || isnan(stressLevel)
                error('Invalid numeric input.');
            end
            
        catch
            uialert(fig, 'Invalid input provided. Please try again.', 'Error');
            return;
        end
        
        % Prepare inputs for neural network
        inputFeatures = [age, cholesterol, heartRate, smoking, alcoholic, diabetes, previousHeartProblem, stressLevel];
        
        % Normalize inputs (if your model requires normalization)
        % Add normalization logic here if needed.
        
        % Predict risk using the fuzzy neural network
        riskPrediction = neuralNet(inputFeatures'); % Pass inputs as a column vector
        
        % Interpret the prediction
        if riskPrediction > 0.5 % Assuming output > 0.5 indicates high risk
            resultLabel.Text = 'Risk Level: HIGH';
            resultLabel.BackgroundColor = [1 0.6 0.6];
        else
            resultLabel.Text = 'Risk Level: LOW';
            resultLabel.BackgroundColor = [0.6 1 0.6];
        end
    end
end
