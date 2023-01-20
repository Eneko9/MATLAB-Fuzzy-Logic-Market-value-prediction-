warning('off','fuzzy:general:warnDeprecation_Newfis') 
warning('off','fuzzy:general:warnDeprecation_Addvar')
warning('off','fuzzy:general:warnDeprecation_Addmf')
warning('off','fuzzy:general:warnDeprecation_Evalfis')

clc

% initial FIS
%a = newfis('Striker market value');

% MoM defuzzification method
%a=newfis('Washing Machine', 'mamdani', 'min', 'max', 'min', 'max', 'mom');

% LoM defuzzification method
a=newfis('Washing Machine', 'mamdani', 'min', 'max', 'min', 'max', 'lom');

% SoM defuzzification method
%a=newfis('Washing Machine', 'mamdani', 'min', 'max', 'min', 'max', 'som');

% INPUT 1 - Age of the striker
a=addvar(a,'input','Striker age', [15 45])

a = addmf(a, 'input', 1, 'Youngster','trapmf',  [0 0 15 21]);
a = addmf(a, 'input', 1, 'Average','trapmf',  [18 22 27.5 32]);
a = addmf(a, 'input', 1, 'Old','trapmf',  [29 33 34 36]);
a = addmf(a, 'input', 1, 'Very old','trapmf',  [34 38 45 45]);

% INPUT 2 - Goals generated 
a = addvar(a, 'input', 'Goals generated per 90 mins', [0 2]);

a = addmf(a, 'input', 2, 'Low', 'trapmf', [0 0 0.15 0.28]);
a = addmf(a, 'input', 2, 'Normal', 'trimf', [0.22 0.38 0.64]);
a = addmf(a, 'input', 2, 'High', 'trimf', [0.57 0.75 1]);
a = addmf(a, 'input', 2, 'Very high', 'trapmf', [0.9 1.2 2 2]);

% INPUT 3 - Remaining years of contract
a = addvar(a, 'input', 'Contract years', [0 10]);

a = addmf(a, 'input', 3, 'Almost finished', 'trapmf', [0 0 0.5 1]);
a = addmf(a, 'input', 3, 'Normal', 'trimf', [0.75 2.5 4]);
a = addmf(a, 'input', 3, 'Long term contract', 'trapmf', [3.75 5 10 10]);

% OUTPUT 1 - Striker market value
a = addvar(a,'output', 'Striker value (millions)', [0 150]);

a = addmf(a, 'output', 1, 'Cheap', 'trapmf', [0 0 8 15]);
a = addmf(a, 'output', 1, 'Average', 'trapmf', [12 18 28 34]);
a = addmf(a, 'output', 1, 'Expensive', 'trapmf', [31 46 56 71]);
a = addmf(a, 'output', 1, 'Very expensive', 'trapmf', [68 88 150 150]);


%THE RULEBASE

%very old players
rule1 = [4 0 0 1 1 1];

%low performance players
rule2 = [0 1 0 1 1 1];

%normal performance
rule3 = [2 2 2 2 1 1];
rule4 = [2 2 1 1 1 1];
rule5 = [2 2 3 2 1 1];

rule6 = [3 2 0 1 1 1];

rule7 = [1 2 0 1 1 1];

%high performance
rule8 = [2 3 2 3 1 1];
rule9 = [2 3 1 2 1 1];
rule10 = [2 3 3 3 1 1];

rule11 = [3 3 0 2 1 1];

rule12 = [1 3 1 1 1 1];
rule13 = [1 3 2 2 1 1];
rule14 = [1 3 3 2 1 1];

%very high performance

rule15 = [2 4 2 4 1 1];
rule16 = [2 4 1 3 1 1];
rule17 = [2 4 3 4 1 1];

rule18 = [3 4 0 3 1 1];

rule19 = [1 4 1 2 1 1];
rule20 = [1 4 2 3 1 1];
rule21 = [1 4 3 3 1 1];


ruleList = [rule1; rule2; rule3; rule4; rule5; rule6; rule7; rule8; rule9; rule10;...
    rule11; rule12; rule13; rule14; rule15; rule16; rule17; rule18;rule19;rule20;rule21];

showrule(a)

a = addRule(a, ruleList)

% A varaible to hold the excel file
%data = ('MarketValueRealData2.xlsx');

% Read in the values and store the in testData
%testData = xlsread(data);

% A for loop to process the data and output the results
%for i=1:size(testData,1)-1
 %       output = evalfis([testData(i, 1), testData(i, 2), testData(i, 3) ], a);
  %      fprintf('%d) In(1): %.2f, In(2) %.2f, In(3) %.2f => Out: %.2f \n\n',i,testData(i, 1),testData(i, 2),testData(i, 3), output);  
   %     xlswrite('MarketValueRealData2.xlsx', output, 1, sprintf('G%d',i+1));
%end
ruleview(a)

showrule(a)

figure(1)
subplot(3,1,1), plotmf(a, 'input', 1);
subplot(3,1,2), plotmf(a, 'input', 2);
subplot(3,1,3), plotmf(a, 'input', 3);

figure(2)
subplot(2,1,1), plotmf(a, 'output', 1);
