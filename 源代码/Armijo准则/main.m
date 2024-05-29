clc;
clear;
%% 参数传递
xk=[2, 2]'; % 迭代点
dk=[-1,-1]'; % 下降方向

%% 调用Armijo函数
[alpha, newxk, newfk] = armijo(xk,dk);

disp("可接受步长");
disp(alpha);
disp("更新后的点");
disp(newxk);
disp("原函数值：");
disp(fun(xk));
disp("更新后的函数值");
disp(newfk);

