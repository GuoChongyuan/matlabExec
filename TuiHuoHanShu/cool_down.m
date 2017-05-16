clear all;
close all;
clc;
%% 设定参数
start_temperater = 100 ;%初始温度
attenuation_factor = 0.99;%衰减因子
number = 100;%总的降温次数
count = 1 : 100;%迭代总次数
pi = 3.1415926;

%% 函数求解
for k = 1 : number
    y1(k) = start_temperater./log10(1+k);%经典降温
    y2(k) = start_temperater./(1+k);%快速降温
    y3(k) = start_temperater .* attenuation_factor.^k .*(cos(pi./(2.*(1-k./number)))+cos(pi./(2.*start_temperater.*(1-k./number))));
end
%% 绘图
plot(count,y1,'p');
hold on
plot(count,y2,'--');
hold on
plot(count,y3,'r');