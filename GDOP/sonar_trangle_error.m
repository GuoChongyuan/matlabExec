clear all
close all
clc

%% 初始化发射机和接收机的位置
%初始化发射机坐标
trans_coordinate = struct();
trans_coordinate.x = -7.5;
trans_coordinate.y = 0;

%初始化接收机坐标
return_coordinate = struct();
return_coordinate.x = 7.5;
return_coordinate.y = 0;

trans_to_return_length_e = 0.01;

%基于接收站参数
trans_to_target_trangle_e = 0.0015;
retutn_to_target_trangle_e = 0.0015;


%% 设置搜索范围
x  = -20 : 20;
y  = -20 : 20;

n = 41;%点数设置
%形成矩阵
for i = 1 : n
    for j = 1 : n
        trans_to_target_length = norm([x(i),y(j)] - [trans_coordinate.x,trans_coordinate.y] );
        return_to_target_length = norm([x(i),y(j)] - [return_coordinate.x,return_coordinate.y] );
        c_t_1 = norm([x(i),0] - [trans_coordinate.x,0] )./trans_to_target_length;%发射站余弦角
        c_t_2 = norm([0,y(j)] - [0,trans_coordinate.y] )./trans_to_target_length;%发射站正弦角
        c_r_1 = norm([x(i),0] - [return_coordinate.x,0] )./return_to_target_length;%发射站余弦角
        c_r_2 = norm([0,y(j)] - [0,return_coordinate.y] )./return_to_target_length;%发射站正弦角
        
        trangle_gdop_c = abs((c_r_2.*c_t_1 - c_r_1.*c_t_2)./(trans_to_target_length.*return_to_target_length));
        trangle_gdop(i,j) = sqrt((trans_to_target_trangle_e.^2+trans_to_return_length_e.^2./trans_to_target_length.^2)./return_to_target_length.^2 + (retutn_to_target_trangle_e.^2 + trans_to_return_length_e.^2./return_to_target_length.^2)./trans_to_target_length.^2)./trangle_gdop_c;
    end
end
%% 最小误差求解
figure(1)
mesh(x,y,trangle_gdop)
xlabel('x方向(单位:km)') 
ylabel('y方向(单位:km)') 
zlabel('误差值') 
title('基于接收基站的误差GDOP图') 

figure(2); 
[c,handle]=contour(x,y,trangle_gdop);%[c,h]=contour(x,y,z);  %c存放等高线上点对应的x和y，c的第一行点x值，第二行存点y值；h为等高线的句柄  
clabel(c,handle);%添加高度标签，h_clabel为高度标签的句柄 
xlabel('x方向(单位:km)') 
ylabel('y方向(单位:km)') 
title('基于接收基站的误差GDOP图') 
