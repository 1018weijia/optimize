function [x_optimization,f_optimization] = Trust_Region_Method(f,x0,r0,mu,eta,var_x,epsilon)
% Trust_Region_Method 信赖域方法
% 输入
    %   f：目标函数
    %   x0：初始点
    %   r0：初始信赖域半径
    %   mu：参数
    %   eta：参数
    %   var_x：变量
    %   epsilon：精度
% 输出
    %   x_optimization：目标函数取最小值时的自变量值
    %   f_optimization：目标函数的最小值

% 如果传入的参数个数为6，即未给出epsilon具体值，则默认为1e-6
if nargin == 6 
    epsilon = 1.0e-6;
end

% 转置
x0 = transpose(x0);
var_x = transpose(var_x);

% 初始化信赖域半径，迭代次数和初始点
rk = r0;
k = 0;
xk = x0;

% 初始化一个梯度，进入循环
grad_fxk = 1;

grad_fx = jacobian(f,var_x); % 求梯度
grad2_fx = jacobian(grad_fx,var_x); % 求hessian矩阵

% 当进度不符合要求时，继续循环
while norm(grad_fxk) > epsilon

    % 将当前点带入原函数，梯度函数，二阶梯度函数
    fxk = subs(f,var_x,xk);
    grad_fxk  = subs(grad_fx,var_x,xk);
    grad2_fxk = subs(grad2_fx,var_x,xk);  
    
    % 转换为double类型
    double_grad2_fxk = double(grad2_fxk);
    grad_fxk_T = transpose(grad_fxk); % 对梯度进行转置
    double_grad_fxk_T = double(grad_fxk_T);

    % 设置二次规划上下界
    lb = -rk*ones(length(var_x),1);
    ub = rk*ones(length(var_x),1);

    %   二次规划
    [y_star,phi_y_star]= quadprog(double_grad2_fxk,double_grad_fxk_T,[],[],[],[],lb,ub);

    %   计算rho
    fxk_y_star = subs(f,var_x,xk + y_star);
    % 注意分母中的0，原本应该是fxk，但是在上面的二次规划中没有加上常数fxk，
    % 只是添加了二次项和一次项的系数，也就是说，phi_y_star中也同样已经减去了fxk,
    % 所以这里直接用0减去即可
    rho = (fxk - fxk_y_star)/(0 - phi_y_star);
    
    % 判断是否需要缩减半径
    if rho <= mu
        rk_next = 0.5*rk;
        xk_next = xk;
    else
        rk_next = rk;
        xk_next = xk + y_star;
        if rho >= eta
            rk_next = 2*rk;
        end
    end
    % 迭代次数+1
    k = k + 1;
    % 更新半径和迭代点
    rk = rk_next;
    xk = xk_next;   
end

% 赋值
x_optimization = xk;
f_optimization = subs(f,var_x,x_optimization);
