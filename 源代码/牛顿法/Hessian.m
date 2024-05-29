function hessian = Hessian(func, X)
% HESSIAN_MATRIX 求解函数的Hessian矩阵
% 输入
    % func：原函数
    % X：要求二阶导数的点
% 输出
    % hessian：函数在该点的hessian矩阵
    
    syms x1 x2;
    
    % 对x1, x2求一阶偏导数
    Grad_x1 = diff(func, x1);
    Grad_x2 = diff(func, x2);
    
    % 对x1, x2求二阶偏导数
    Hess_x1x1 = diff(Grad_x1, x1);
    Hess_x1x2 = diff(Grad_x1, x2);
    Hess_x2x1 = diff(Grad_x2, x1);
    Hess_x2x2 = diff(Grad_x2, x2);
    
    % 组合成Hessian矩阵
    Hessian_func = [Hess_x1x1, Hess_x1x2; Hess_x2x1, Hess_x2x2];
    
    % 求出在X点的Hessian矩阵值
    hessian = subs(Hessian_func, [x1, x2], [X(1), X(2)]);
end
