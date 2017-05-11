clear all;
close all;
clc;

%初始化发射机坐标
x_y_input = inputdlg({'横向坐标','纵向坐标'},'初始化发射机坐标',1,{'0','0'});
trans_coordinate = struct();
trans_coordinate.x = str2double(x_y_input(1));
trans_coordinate.y = str2double(x_y_input(2));

%初始化接收机坐标
x_y_input = inputdlg({'横向坐标','纵向坐标'},'初始化接收机坐标',1,{'6','0'});
return_roordinate = struct();
return_roordinate.x = str2double(x_y_input(1));
return_roordinate.y = str2double(x_y_input(2));

%初始化观测点的坐标
x_y_input = inputdlg({'横向坐标','纵向坐标'},'初始化观测点的坐标',1,{'3','3'});
target_coordinate = struct();
target_coordinate.x = str2double(x_y_input(1));
target_coordinate.y = str2double(x_y_input(2));

input = inputdlg({'检测到的发射机到被测点的距离r_t','检测到的发射机—被测点-接收机的距离r_r','%检测到的发射机-被测点的角度','%检测到的接收机-被测点的角度'},'测量和数据',1,{'4','8','45','45'});
%检测到的发射机到被测点的距离r_t
trans_to_target_length = str2double(input(1));
%检测到的发射机—被测点-接收机的距离r_r
trans_to_return_length = str2double(input(2));
%检测到的发射机-被测点的角度
trans_to_target_trangle = str2double(input(3));
%检测到的接收机-被测点的角度
return_to_target_trangle = str2double(input(4));

%设定的查找半径
x_y_input = inputdlg({'横向查找半径','纵向查找半径'},'设定查找半径',1,{'1','1'});
x_radio = str2double(x_y_input(1)); 
y_radio = str2double(x_y_input(2));

input = inputdlg({'初始化因子','内部蒙特卡洛循环迭代次数','初始温度','停止温度'},'退火参数设置',1,{'10','500','100','0.001'});
control = str2double(input(1));              %初始化因子
iter=str2double(input(2));                 %内部蒙特卡洛循环迭代次数
start_tempature=str2double(input(3));         %初始温度
end_tempature = str2double(input(4));     %停止温度

count = 1;                 %统计迭代次数
min_sum(count) = sonar_error_min(trans_coordinate,return_roordinate,target_coordinate,...
                          trans_to_target_length,trans_to_return_length,trans_to_target_trangle,return_to_target_trangle);   %每次迭代后的目标函数的最小值  
coordinate_plot(trans_coordinate,return_roordinate,target_coordinate)%初始目标位置

tmp_coordinate = struct();
tmp_coordinate.x = target_coordinate.x;
tmp_coordinate.y = target_coordinate.y;

accept = 0; % 默认是不可以接受的结果

while start_tempature > end_tempature
    for i = 1:iter  %多次迭代扰动，一种蒙特卡洛方法，温度降低之前多次实验
            min_sum_1 = sonar_error_min(trans_coordinate,return_roordinate,target_coordinate,...
                              trans_to_target_length,trans_to_return_length,trans_to_target_trangle,return_to_target_trangle);        %计算原目标函数的最小值 
            tmp_coordinate=rand_coodinate(target_coordinate,x_radio,y_radio);      %产生随机扰动
            min_sum_2 = sonar_error_min(trans_coordinate,return_roordinate,tmp_coordinate,...
                              trans_to_target_length,trans_to_return_length,trans_to_target_trangle,return_to_target_trangle);   %扰动后的目标函数的最小值 

            delta_e=min_sum_2 - min_sum_1;  %新老距离的差值，相当于能量
            if delta_e < 0                    %新坐标优秀于旧坐标，采用新坐标
                target_coordinate = tmp_coordinate;
            else                        %温度越低，越不太可能接受新解；新老距离差值越大，越不太可能接受新解
                if exp(-(delta_e/start_tempature))>rand() %以概率选择是否接受新解
                    target_coordinate = tmp_coordinate;      %可能得到较差的解
                else
                   tmp_start_tempature =  start_tempature / (log(control + 1));
                   while start_tempature < tmp_start_tempature
                       contorl = control + 1;
                       start_tempature = tmp_start_tempature;
                       tmp_start_tempature =  start_tempature / (log(control + 1));
                   end
                   start_tempature = tmp_start_tempature;
                end
            end
    count = count + 1;
    min_sum(count) = sonar_error_min(trans_coordinate,return_roordinate,target_coordinate,...
                          trans_to_target_length,trans_to_return_length,trans_to_target_trangle,return_to_target_trangle);   %每次迭代后的目标函数的最小值
end  
figure;
coordinate_plot(trans_coordinate,return_roordinate,target_coordinate)%最终目标位置   

figure;
plot(min_sum)

target_coordinate.x
target_coordinate.y
