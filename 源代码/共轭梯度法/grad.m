function gradient = grad(func,X)
%GRAD 求解函数梯度
syms x1 x2;
Grad_x1 = diff(func, x1); % 对x1, x2求偏导
Grad_x2 = diff(func, x2);

Grad_func = [Grad_x1, Grad_x2]; % 组合
gradient = subs(Grad_func, [x1, x2], [X(1), X(2)]); % 求出在X点的梯度值
end

