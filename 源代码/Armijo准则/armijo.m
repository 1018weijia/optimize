function [alpha, newxk, newfk] =armijo(xk,dk)
% ARMIJO 实现Armijo算法，非精确搜索可接受步长
% 输入
    % xk：当前点
    % dk：下降方向
% 输出
    % alpha：可接受步长
    % newxk：更新的点
    % newfk：更新的值


beta=0.5;  
sigma=0.1; % 题目中给出的roh
gamma = 0.5;
m=0; 
mmax=100;
while (m<=mmax)
    if(fun(xk+beta*gamma^m*dk)<=fun(xk)+sigma*beta*gamma^m*gfun(xk)'*dk)
        mk=m;  
        break;
    end
    m=m+1;
end
alpha = beta*gamma^mk; % 可接受步长
newxk = xk+alpha*dk; % 迭代后的新点
newfk = fun(newxk); % 新步长下的函数值

