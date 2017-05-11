clear all;
close all;
clc;
%设定的查找半径
x_radio = 20;
y_radio = 20;

%检测到的发射机到被测点的距离r_t
trans_to_target_length = 420;
%检测到的发射机—被测点-接收机的距离r_r
trans_to_return_length = 840;
%检测到的发射机-被测点的角度
trans_to_target_trangle = 45;
%检测到的接收机-被测点的角度
return_to_target_trangle = -45;

%初始化发射机坐标
trans_coordinate = struct();
trans_coordinate.x = 0;
trans_coordinate.y = 0;

%初始化接收机坐标
return_roordinate = struct();
return_roordinate.x = 600;
return_roordinate.y = 0;

%初始化观测点的坐标
target_coordinate = struct();
target_coordinate.x = 400;
target_coordinate.y = 400;

control = 10;              %初始化因子
iter=500;                  %内部蒙特卡洛循环迭代次数
start_tempature=100;         %初始温度
end_tempature = 0.001;     %停止温度

count = 1;                 %统计迭代次数
min_sum(count) = sonar_error_min(trans_coordinate,return_roordinate,target_coordinate,...
                          trans_to_target_length,trans_to_return_length,trans_to_target_trangle,return_to_target_trangle);   %每次迭代后的目标函数的最小值  
%coordinate_plot(trans_coordinate,return_roordinate,target_coordinate)%初始目标位置

tmp_coordinate = struct();
tmp_coordinate.x = target_coordinate.x;
tmp_coordinate.y = target_coordinate.y;

while start_tempature > end_tempature
     tmp_start_tempature =  start_tempature / (log(control + 1))
     while start_tempature < tmp_start_tempature
           control = control + 1;
           start_tempature = tmp_start_tempature;
           tmp_start_tempature =  start_tempature / (log(control + 1));
     end
     start_tempature = tmp_start_tempature;

    count = count + 1;
end

