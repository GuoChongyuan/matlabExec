%for语句
%for语句的格式为：
%for 循环变量 =表达式1：表达式2：表达式3
%   循环体语句
%end
%其中表达式1的值为循环变量的初值，表达式2的值为步长，表达式3的值为结束值
clear all;
clc;

%for语句练习%
start = 0;
ends = 10;
sum = 0;
for i = start : ends
   sum = sum + i;
end
disp(['总和为',num2str(sum)]);
disp(['平均值为',num2str(sum/(ends - start))]);
