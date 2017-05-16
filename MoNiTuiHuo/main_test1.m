clear all;
close all;
clc;
%% 参数记录
%初始化发射机坐标
trans_coordinate = struct();
trans_coordinate.x = 0;
trans_coordinate.y = 0;

%初始化接收机坐标
return_roordinate = struct();
return_roordinate.x = 8;
return_roordinate.y = 0;

%初始化观测点的坐标
target_coordinate = struct();
target_coordinate.x = 0.1;
target_coordinate.y = 0.1;

%设定的扰动半径
x_radio = 1;
y_radio = 1;

% 设置搜索范围
x  = -20 : 20;
y  = -20 : 20;

start_tempature=100;         %初始温度
attenuation_factor = 0.99;%衰减因子
pi = 3.1415926;
iter=500;                  %内部蒙特卡洛循环迭代次数
count = 1000;%迭代总次数

number = 1 : count + 1;

%% 观测值记录
%检测到的发射机-被测点的角度
trans_to_target_trangle = 0.25;
%检测到的接收机-被测点的角度
return_to_target_trangle = -0.25;
%检测到的发射机到被测点的距离r_t
trans_to_target_length = 5.6569;
%检测到的发射机—被测点-接收机的距离r_r
trans_to_return_length = 11.3137;
%% 退火算法参数的准备
tmp_coordinate = struct();
tmp_coordinate.x = target_coordinate.x;
tmp_coordinate.y = target_coordinate.y;


%% 退火算法进行计算
for k = 1 : count + 1 %最终的时候能够到达能量最小值0
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
                    continue;
                end
            end
    end
    tmp_start_tempature =  start_tempature .* attenuation_factor.^k .*(cos(pi./(2.*(1-k./count)))+cos(pi./(2.*start_tempature.*(1-k./count))));
    start_tempature = tmp_start_tempature;
    min_sum(k) = sonar_error_min(trans_coordinate,return_roordinate,target_coordinate,...
                          trans_to_target_length,trans_to_return_length,trans_to_target_trangle,return_to_target_trangle);   %每次迭代后的目标函数的最小值
end
%%
figure(1);
coordinate_plot(trans_coordinate,return_roordinate,target_coordinate)%最终目标位置 

figure(2)
plot(number,min_sum);

target_coordinate.x
target_coordinate.y
