patient=readfis('patient.fis')
%% Part A. 

%% Part A. a)
% % get the step info for the plant for the fuzzy 
stepinfo(fuzzyD.Data(:,3), fuzzyD.Time, 0.8) %fuzzy
% riseTime = 26.7069, SettlingTime = 87.4958, Overshoot: 3.3571%
mse1 = immse(fuzzyD.Data(:,3),fuzzyD.Data(:,1)); % 0.0458
f_error = fuzzyD.Data(:,3) - fuzzyD.Data(:,1);
mae1 = mae(f_error); %0.0769

% get the step info for the plant for the PID
stepinfo(PIDD.Data(:,3), PIDD.Time, 0.8) %PID
% riseTime = 32.6947, SettlingTime = 61.2437, Overshot: 1.9993%
mse2 = immse(PIDD.Data(:,3),PIDD.Data(:,1)); %0.0365
p_error = PIDD.Data(:,3) - PIDD.Data(:,1);
mae2 = mae(p_error); %0.0698

%% Part A. b)
% % get the step info for the plant for the fuzzy 
stepinfo(fuzzyD.Data(:,3), fuzzyD.Time, 0.8) %fuzzy
% riseTime = 22.1578, SettlingTime = 42.2473, Overshoot: 0.5249%
mse3 = immse(fuzzyD.Data(:,3),fuzzyD.Data(:,1)); % 0.0433
f_error = fuzzyD.Data(:,3) - fuzzyD.Data(:,1); 
mae3 = mae(f_error); %0.0674

% % with disturbance:
% % riseTime = 22.1578, SettlingTime = 165.3946, Overshoot: 4.0702%
% % mse = 0.0433        mae = 0.0687

%% Part A. c)
% % % get the step info for the plant for the fuzzy 
stepinfo(fuzzyD.Data(:,3), fuzzyD.Time, 0.8) %fuzzy
% riseTime = 17.3052, SettlingTime = 30.6304, Overshoot: 0.1139%
mse4 = immse(fuzzyD.Data(:,3),fuzzyD.Data(:,1)); % 0.0280
f_error = fuzzyD.Data(:,1)- fuzzyD.Data(:,3);
mae4 = mae(f_error); %0.0460

% % with disturbance:
% % riseTime = 17.3052, SettlingTime = NaN, Overshoot: 4.9493%
% % mse = 0.0287        mae = 0.0638


%% Part A. d)
%2/3*size(fuzzyD.Data(:,3),1) % 206 is (2/3), total size = 309

split the data to training and checking sets
b = 206;
trdata1(:,1) = eD.Data(1:b);
trdata1(:,2) = erD.Data(1:b);
trdata1(:,3) = oD.Data(1:b);
tt1 = eD.Time(1:b);

ckdata1(:,1) = eD.Data(b+1:size(eD.Data,1));
ckdata1(:,2) = erD.Data(b+1:size(erD.Data,1));
ckdata1(:,3) = oD.Data(b+1:size(oD.Data,1));
ct1 = eD.Time(b+1:size(fuzzyD.Data,1));

% output set
dsap1 = oD.Data;
t1 = oD.Time;
%% Part A. d) (continue)

% input Mfs plots
figure, subplot(2,1,1)
plotmf(input_ad,'input',1)
title('Error MFs')
subplot(2,1,2)
plotmf(input_ad,'input',2)
title('Error Rate MFs')

% 3D surfac eplot
figure, gensurf(input_ad)
title('3D surface') 
showrule(input_ad)

% calculate the MAE
ty = evalfis(trdata1(:,1:2),input_ad);
cy = evalfis(ckdata1(:,1:2),input_ad);
t_error = ty - trdata1(:,3);
c_error = cy - ckdata1(:,3); 
maeT = mae(t_error) %1.3196e-04
maeC = mae(c_error) %2.3481e-05

Training and Checking plot
figure, hold on
plot(tt1, ty, 'g.')
plot(ct1, cy, 'r.')
plot(t1, dsap1, 'b')
legend('Training', 'Checking', 'Patient System Output')
xlabel('Time')
ylabel('Output')
title('Training & Checking Data Set')
grid on
hold off

%% Part B.

%% Part B. a)
load acs6123assignmentdata
%2/3*size(all_data_sets,1) %188 (2/3) // 94 (1/3)  282 (total)
c = 188;

%split data
trdata_ba = all_data_sets(1:c,:);
tt_ba = 1:c;

ckdata_ba = all_data_sets(c+1:size(all_data_sets,1),:);
ct_ba = c+1:size(all_data_sets,1);

t_ba = 1:size(all_data_sets,1);

% input 3 MFs - MF type: gbellmf 
% output - MF type: constant
% epochs - 2

%% Part B. a) continue (plots)

%input Mfs plots
figure, subplot(2,2,1)
plotmf(input_ba,'input',1)
title('Input 1 MFs')
subplot(2,2,2)
plotmf(input_ba,'input',2)
title('Input 2 MFs')
subplot(2,2,3)
plotmf(input_ba,'input',3)
title('Input 3 MFs')
subplot(2,2,4)
plotmf(input_ba,'input',4)
title('Input 4 MFs')

% 3D surface plot
figure,
opt = gensurfOptions;
subplot(2,3,1)
opt.InputIndex = [1 2];
gensurf(input_ba, opt) 
title('Input1 vs. Input2 vs. Output')
subplot(2,3,2)
opt.InputIndex = [1 3];
gensurf(input_ba, opt) 
title('Input1 vs. Input3 vs. Output')
subplot(2,3,3)
opt.InputIndex = [1 4];
gensurf(input_ba, opt) 
title('Input1 vs. Input4 vs. Output')
subplot(2,3,4)
opt.InputIndex = [2 3];
gensurf(input_ba, opt)
title('Input2 vs. Input3 vs. Output')
subplot(2,3,5)
opt.InputIndex = [2 4];
gensurf(input_ba, opt) 
title('Input2 vs. Input4 vs. Output')
subplot(2,3,6)
opt.InputIndex = [3 4];
gensurf(input_ba, opt) 
title('Input3 vs. Input4 vs. Output')

% rules
showrule(input_ba)

% calculate the MAE
ty_ba = evalfis(trdata_ba(:,1:4),input_ba);
cy_ba = evalfis(ckdata_ba(:,1:4),input_ba);
t_error_ba = ty_ba - trdata_ba(:,5);
c_error_ba = cy_ba - ckdata_ba(:,5); 
maeT_ba = mae(t_error_ba); %18.7162
maeC_ba = mae(c_error_ba); %28.5355

% Training and Checking plot
figure, hold on
plot(tt_ba, ty_ba, 'g.')
plot(ct_ba, cy_ba, 'r.')
plot(t_ba, all_data_sets(:,5), 'b')
legend('Training', 'Checking', 'Patient System Output')
xlabel('Time')
ylabel('Output')
title('Training & Checking Data Set')
grid on
hold off
%% Part B. b)
input_b = [0.15 0.22 1 0.011];
output_b = evalfis(input_b, input_ba); % 447.4415

%% Part B. c)
%2/3*size(all_data_sets,1) %188 // 94   282
d = 188;

trdata_bc = all_data_sets(1:d,:);
tt_bc = 1:d;

ckdata_bc = all_data_sets(d+1:size(all_data_sets,1),:);
ct_bc = d+1:size(all_data_sets,1);

t_bc = 1:size(all_data_sets,1);

% input 4 MFs - MF type: pimf
% output - MF type: linear
% epochs - 2

%% Part B. c) continue (plots)

%input Mfs plots
figure, subplot(2,2,1)
plotmf(input_bc,'input',1)
title('Input 1 MFs')
subplot(2,2,2)
plotmf(input_bc,'input',2)
title('Input 2 MFs')
subplot(2,2,3)
plotmf(input_bc,'input',3)
title('Input 3 MFs')
subplot(2,2,4)
plotmf(input_bc,'input',4)
title('Input 4 MFs')

% 3D surface plot
figure,
opt = gensurfOptions;
subplot(2,3,1)
opt.InputIndex = [1 2];
gensurf(input_bc, opt) 
title('Input1 vs. Input2 vs. Output')
subplot(2,3,2)
opt.InputIndex = [1 3];
gensurf(input_bc, opt) 
title('Input1 vs. Input3 vs. Output')
subplot(2,3,3)
opt.InputIndex = [1 4];
gensurf(input_bc, opt) 
title('Input1 vs. Input4 vs. Output')
subplot(2,3,4)
opt.InputIndex = [2 3];
gensurf(input_bc, opt)
title('Input2 vs. Input3 vs. Output')
subplot(2,3,5)
opt.InputIndex = [2 4];
gensurf(input_bc, opt) 
title('Input2 vs. Input4 vs. Output')
subplot(2,3,6)
opt.InputIndex = [3 4];
gensurf(input_bc, opt) 
title('Input3 vs. Input4 vs. Output')

% rules
showrule(input_bc)
% 
% calculate the MAE
ty_bc = evalfis(trdata_bc(:,1:4),input_bc);
cy_bc = evalfis(ckdata_bc(:,1:4),input_bc);
t_error_bc = ty_bc - trdata_bc(:,5);
c_error_bc = cy_bc - ckdata_bc(:,5); 
maeT_bc = mae(t_error_bc) %11.6948
maeC_bc = mae(c_error_bc) %57.0416

% Training and Checking plot
figure, hold on
plot(tt_bc, ty_bc, 'g.')
plot(ct_bc, cy_bc, 'r.')
plot(t_bc, all_data_sets(:,5), 'b')
legend('Training', 'Checking', 'Patient System Output')
xlabel('Time')
ylabel('Output')
title('Training & Checking Data Set')
grid on
hold off
%% Part B. d)
input_d = [0.06 0.28 0.4 0.012];
output_d = evalfis(input_d, input_bc) %499.9871

