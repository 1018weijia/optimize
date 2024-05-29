function [Value, Point] = Conjugate_Gradient(Target_func,Current_point,epsilon)
% STEEPEST_DESCENT 共轭梯度法
% 输入：
    % Target_func：待优化目标函数
    % Current_point：当前迭代点
    % epsilon：精度
% 输出：
    % Value：最优值
    % Point：最优的迭代点
   


% 首先调用梯度函数对当前点进行梯度求值
Gradient = grad(Target_func,Current_point);

% 判断梯度是否达到精度要求，是则进行第一步计算，否则直接退出
% 共轭梯度法第一步与最速下降法相同
if norm(Gradient) > epsilon 
    alpha = sym('alpha'); % 设置步长变量，用于求解最优步长
    syms x1 x2; % 用于识别和替换变量x1,x2
    
    % 调用求梯度函数，求在当前点的梯度大小
    Gradient = grad(Target_func,Current_point); 

    Neg_Gradient = - Gradient; % 求出负梯度

    % 以alpha为参数，构造出新的点
    x_new = Current_point + alpha * Neg_Gradient; 

    % 另外设置一个关于alpha的函数，求最优的alpha
    alpha_func= subs(Target_func,[x1, x2],x_new);

    grad_alpha_func = diff(alpha_func,alpha); % 求关于步长的导数
    best_alpha = solve(grad_alpha_func,alpha); % 求出极值

    % 更新，得到新的迭代点
    Current_point = Current_point + best_alpha * Neg_Gradient; 
end

% 初始化P值，表示搜索方向
p = [0,0];
p_next = [0,0];
% 初始化一个beta值，表示相邻两个迭代点之间的梯度比值
beta = 0;
% 初始化一个梯度，用于计算beta值
Gradient_next = Gradient; 
% 开始进入循环
while norm(Gradient_next) > epsilon
    alpha = sym('alpha'); % 设置步长变量，用于求解最优步长
    syms x1 x2; % 用于识别和替换变量x1,x2
    
    % 调用求梯度函数，求在当前点的梯度大小
    Gradient_next = grad(Target_func,Current_point); 

    % 计算beta
    beta = norm(Gradient_next)^2 / norm(Gradient)^2;
    % 算完后就把Gradient给替换成Gradient_next,下次迭代
    Gradient = Gradient_next;

    p_next = - Gradient_next + beta * p;
    % 算完后就把p给替换成p_next，下次迭代
    p = p_next;

    % 以alpha为参数，构造出新的点
    x_new = Current_point + alpha * p_next; 

    % 另外设置一个关于alpha的函数，求最优的alpha
    alpha_func= subs(Target_func,[x1, x2],x_new);

    grad_alpha_func = diff(alpha_func,alpha); % 求关于步长的导数
    best_alpha = solve(grad_alpha_func,alpha); % 求出极值

    % 更新，得到新的迭代点
    Current_point = Current_point + best_alpha * p_next; 
end

Value = vpa(subs(Target_func,[x1, x2],Current_point)); % 求出最值
Point = vpa(Current_point); % 给出当前点，vpa用于表示小数
end