clear all;
clc;
%输入数据%
a = input('请输入a的值');
b = input('请输入b的值');
c = input('c=?');
%程序暂停，其中的参数应该是s数%
pause();
d = b*b-4*a*c;
x = [(-b+sqrt(d))/(2*a),(-b-sqrt(d))/(2*a)];
%输出数据%
disp(['x1=',num2str(x(1)),',x2=',num2str(x(2))]);