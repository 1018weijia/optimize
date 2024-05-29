clc;
clear;
%% 传入参数
syms x1 x2;
Target_func = 100*(x1^2 - x2)^2 + (x1 - 1)^2; % 目标函数
% Target_func2 = x1^2 + 25* x2^2 + 10;
Current_point = [0,0]; % 设置初始点

%% 调用信赖域方法
[x_opt,f_opt] = Trust_Region_Method(Target_func,Current_point,0.1,0.3,0.7,[x1 x2]);


disp("优化后的点：");
disp(double(x_opt));
disp("优化后的值：");
disp(double(f_opt));
