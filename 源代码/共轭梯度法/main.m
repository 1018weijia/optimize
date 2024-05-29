clc;
clear;
%% 传入参数
syms x1 x2;
Target_func = x1^2 + 4 * x2^2; % 待优化目标函数
Current_point = [1,1]; % 当前点
epsilon = 0.01; % 精度

%% 调用共轭梯度法求最小值
[value, point] = Conjugate_Gradient(Target_func,Current_point,epsilon);
disp("最优值为：")
disp(value);
disp("最优值所在点为");
disp(vpa(point));

