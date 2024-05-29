clc;
clear;
%% 参数传递
syms x1 x2;
% 待优化目标函数
Target_func = x1^2 + x2^2 - x1*x2 - 10*x1 -4*x2 + 60;
% 当前点
Current_Point = [0,1]';
% 精度
epsilon = 0.01;

%% 调用牛顿法迭代求解最优值
[Value, Point] = Newton(Target_func,Current_Point,epsilon);

disp("最小值为：");
disp(Value);
disp("当前点为：");
disp(Point);
