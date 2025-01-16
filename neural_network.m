%%

clear all
close all
clc
%%

% Specify the filename
filename = 'dataset.csv'; % Replace with your CSV file name

% Read the CSV file into a table
dataTable = readtable(filename);

% Display the first few rows of the table
disp(head(dataTable));
%%
% Convert the table to an array
A = table2array(dataTable);

%%
input=A(:,1:8);
target=A(:,9);
output=target

%%
% Step 1: Create a Feedforward Neural Network for Classification
hiddenLayerSize = 20; % Number of hidden neurons; adjust as needed
net = patternnet(hiddenLayerSize);

% Step 2: Configure the neural network
% Split data into training, validation, and test sets
net.divideParam.trainRatio = 80/100; % 70% for training
net.divideParam.valRatio = 10/100;   % 15% for validation
net.divideParam.testRatio = 10/100;  % 15% for testing

% Step 3: Train the network
[net, tr] = train(net, input', output'); % Transpose input and output;

%% Step 4: Evaluate the network performance
% Make predictions on test data
outputs = net(input(8263:8763,:)'); % Get outputs for test set
predictions = round(outputs); % Round outputs to get binary predictions
%%
% Save the trained neural network
save('trainedNeuralNetwork.mat', 'net');
