%输入x的值%
x = input('请输入x的值');
%分段执行%
if x == 10
    y = cos(x+1)+sqrt(x*x+1);
else
    y = x*sqrt(x+sqrt(x));
    
end
y
