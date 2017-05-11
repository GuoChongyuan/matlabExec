clear all;
close all;
clc;
%设定的查找半径
x_radio = 1;
y_radio = 1;

%检测到的发射机到被测点的距离r_t
trans_to_target_length = 4;
%检测到的发射机—被测点-接收机的距离r_r
trans_to_return_length = 7;
%检测到的发射机-被测点的角度
trans_to_target_trangle = -0.645;
%检测到的接收机-被测点的角度
returnToTargetTrangle = 0.3200;

%初始化发射机坐标
trans_coordinate = struct();
trans_coordinate.x = 0;
trans_coordinate.y = 0;

%初始化接收机坐标
return_roordinate = struct();
return_roordinate.x = 5;
return_roordinate.y = 0;

%初始化观测点的坐标
target_coordinate = struct();
target_coordinate.x = 4;
target_coordinate.y = 3;

control = 10;              %初始化因子
iter=1000;                 %内部蒙特卡洛循环迭代次数
temperature=100;         %初始温度

count = 1;                 %统计迭代次数
min_sum(count) = sonar_error_min(trans_coordinate,return_roordinate,target_coordinate,...
                          trans_to_target_length,trans_to_return_length,trans_to_target_trangle,returnToTargetTrangle);   %每次迭代后的目标函数的最小值  
coordinate_plot(trans_coordinate,return_roordinate,target_coordinate)%初始目标位置

tmp_coordinate = struct();
tmp_coordinate.x = target_coordinate.x;
tmp_coordinate.y = target_coordinate.y;

while temperature>99.99     %停止迭代温度
    
     min_sum_1 = sonar_error_min(trans_coordinate,return_roordinate,target_coordinate,...
                          trans_to_target_length,trans_to_return_length,trans_to_target_trangle,returnToTargetTrangle);        %计算原目标函数的最小值 
        tmp_coordinate=rand_coodinate(target_coordinate,x_radio,y_radio);      %产生随机扰动
        min_sum_2 = sonar_error_min(trans_coordinate,return_roordinate,tmp_coordinate,...
                          trans_to_target_length,trans_to_return_length,trans_to_target_trangle,returnToTargetTrangle);   %扰动后的目标函数的最小值 
        
        delta_e=min_sum_2 - min_sum_1;  %新老距离的差值，相当于能量
        if delta_e<0        %新路线好于旧路线，用新路线代替旧路线
            target_coordinate = tmp_coordinate;
        else                        %温度越低，越不太可能接受新解；新老距离差值越大，越不太可能接受新解
            if exp(-delta_e/temperature)>rand() %以概率选择是否接受新解
                target_coordinate = tmp_coordinate;      %可能得到较差的解
            end
        end        
    count = count + 1;
    min_sum(count) = sonar_error_min(trans_coordinate,return_roordinate,target_coordinate,...
                          trans_to_target_length,trans_to_return_length,trans_to_target_trangle,returnToTargetTrangle);   %每次迭代后的目标函数的最小值
    temperature=temperature*0.99;   %温度不断下降
  
end  
figure;
coordinate_plot(trans_coordinate,return_roordinate,target_coordinate)%最终目标位置   

target_coordinate.x
target_coordinate.y

figure;
plot(min_sum)
