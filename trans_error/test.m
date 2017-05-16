clear all
close all
clc

%% 初始化发射机和接收机的位置
%初始化发射机坐标
trans_coordinate = struct();
trans_coordinate.x = 0;
trans_coordinate.y = 0;

trans_to_target_length_e = 1.5;
trans_to_target_trangle_e = 0.0005;
trans_to_return_length_e = 5;

%% 设置搜索范围
x  = -20 : 20;
y  = -20 : 20;

n = 41;%点数设置
%形成矩阵
for i = 1 : n
    for j = 1 : n
        result(i,j) = sqrt(trans_to_target_length_e.^2 + trans_to_target_trangle_e .^2 .* ((x(i)-trans_coordinate.x).^2+(y(j)-trans_coordinate.y)^2)+trans_to_return_length_e.^2);
    end
end
%% 最小误差求解
figure(1)
mesh(x,y,result)
xlabel('x方向(单位:km)') 
ylabel('y方向(单位:km)') 
zlabel('误差值') 
title('基于发射基站的误差GDOP图') 

figure(2); 
[c,handle]=contour(x,y,result,5);%[c,h]=contour(x,y,z);  %c存放等高线上点对应的x和y，c的第一行点x值，第二行存点y值；h为等高线的句柄  
clabel(c,handle);%添加高度标签，h_clabel为高度标签的句柄 
xlabel('x方向(单位:km)') 
ylabel('y方向(单位:km)') 
title('基于发射基站的误差GDOP图') 
%hold on
%result=1.*(result>=-1000 & result<=1000);
%mesh(x,y,result);