clear all
close all
clc

%% 初始化发射机和接收机的位置
%初始化发射机坐标
trans_coordinate = struct();
trans_coordinate.x = 0;
trans_coordinate.y = 0;
trans_to_target_trangle = 90;

trans_to_target_length_e = 7.5;
trans_to_target_trangle_e = 0.27;
trans_to_return_length_e = 15;

%% 设置搜索范围
x  = -20 : 20;
y  = -20 : 20;

n = 41;%点数设置
%形成矩阵
for i = 1 : n
    for j = 1 : n
      length = sqrt((x(i) - trans_coordinate.x).^2+ (y(j) - trans_coordinate.y).^2);
      %trans_to_target_trangle = atand((y(j) - trans_coordinate.y)./(x(i) - trans_coordinate.x));
      %计算误差
        x_error = cosd(trans_to_target_trangle).^2 .* trans_to_target_length_e.^2 + length.^2 .* sind(trans_to_target_trangle).^2. * trans_to_target_trangle_e.^2 + trans_to_return_length_e.^2;
        y_error = sind(trans_to_target_trangle).^2 .* trans_to_target_length_e.^2 + length.^2 .* cosd(trans_to_target_trangle).^2 .* trans_to_target_trangle_e.^2 + trans_to_return_length_e.^2;
        result(i,j) = sqrt(x_error + y_error);
    end
end
%% 最小误差求解
figure(1); 
[c,handle]=contour(result,25);%[c,h]=contour(x,y,z);  %c存放等高线上点对应的x和y，c的第一行点x值，第二行存点y值；h为等高线的句柄  
clabel(c,handle);%添加高度标签，h_clabel为高度标签的句柄 
xlabel('x方向(单位:km)') 
ylabel('y方向(单位:km)') 
title('GDOP图') 
%mesh(x,y,result)
%hold on
%result=1.*(result>=-1000 & result<=1000);
%mesh(x,y,result);

