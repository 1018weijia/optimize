function [Value,Point] = Newton(Target_func,Current_Point, epsilon)
%NEWTON 牛顿法最优化函数
% 输入
    % Target_func：待优化函数
    % Current_Point：当前点
    % epsilon：精度
% 输出
    % Value：最优值
    % Point：最优值所在点

syms x1 x2; % 声明变量，用于替换参数
% 计算梯度，判断是否满足条件
Gradient = grad(Target_func, Current_Point);

% 当梯度不满足条件时，继续循环，否则输出
while norm(Gradient) > epsilon
    % 调用函数计算hessian矩阵
    hessian_Matrix = Hessian(Target_func,Current_Point);

    % 更新当前点
    Current_Point = Current_Point + (- inv(hessian_Matrix)) * Gradient;

    % 再次计算梯度，用于条件判断
    Gradient = grad(Target_func, Current_Point);
end

% 赋值结果
Value = subs(Target_func,[x1,x2],Current_Point');
Point = Current_Point;

end

