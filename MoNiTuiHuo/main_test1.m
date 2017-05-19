clear all;
close all;
clc;
%% 变化参数
%误差值
trans_target_return_length_e = 0.01;
retutn_to_target_trangle_e = 0.0005;
trans_target_length_e = 0.0075;
trans_to_target_trangle_e = 0.0005;

%% 参数记录
trans_to_return_length_e = 0.02;
%初始化发射机坐标
trans_coordinate = struct();
trans_coordinate.x = -7.5 + trans_to_return_length_e.*rand();
trans_coordinate.y = 0;

%初始化接收机坐标
return_roordinate = struct();
return_roordinate.x = 7.5 +  trans_to_return_length_e.*rand();
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
iter=50;                  %内部蒙特卡洛循环迭代次数
count = 500;%迭代总次数
n = 41;

%% 退火算法参数的准备
tmp_coordinate = struct();
tmp_coordinate.x = target_coordinate.x;
tmp_coordinate.y = target_coordinate.y;


for i = 1 : n
    for j = 1 : n
    %假定目标位置  
    target_coordinate.x = x(i);
    target_coordinate.y = y(j);
    % 观测值记录仿真
    %检测到的发射机-被测点的角度
    trans_to_target_trangle = atan((target_coordinate.y - trans_coordinate.y)./(target_coordinate.x - trans_coordinate.x)) + 2.*trans_to_target_trangle_e.*rand() - trans_to_target_trangle_e;
    %检测到的接收机-被测点的角度
    return_to_target_trangle = atan((target_coordinate.y - return_roordinate.y)./(target_coordinate.x - return_roordinate.x)) + 2.*retutn_to_target_trangle_e.*rand() - retutn_to_target_trangle_e;
    %检测到的发射机到被测点的距离r_t
    trans_to_target_length = norm([target_coordinate.x,target_coordinate.y] - [trans_coordinate.x,trans_coordinate.y]) + 2.*trans_target_length_e.*rand() - trans_target_length_e;
    %检测到的发射机—被测点-接收机的距离r_r
    trans_to_return_length = norm([target_coordinate.x,target_coordinate.y] - [return_roordinate.x,return_roordinate.y])+ trans_to_target_length + 2.*trans_target_return_length_e.*rand() - trans_target_return_length_e;
    
    tmp_start_tempature =  start_tempature .* attenuation_factor.^1 .*(cos(pi./(2.*(1-1./count)))+cos(pi./(2.*start_tempature.*(1-1./count))));
%% 退火算法进行计算
        for k = 1 : count - 1  %最终的时候能够到达能量最小值0
            for m = 1:iter  %多次迭代扰动，一种蒙特卡洛方法，温度降低之前多次实验
                    min_sum_1 = sonar_error_min(trans_coordinate,return_roordinate,target_coordinate,...
                                      trans_to_target_length,trans_to_return_length,trans_to_target_trangle,return_to_target_trangle);        %计算原目标函数的最小值 
                    tmp_coordinate=rand_coodinate(target_coordinate,x_radio,y_radio);      %产生随机扰动
                    min_sum_2 = sonar_error_min(trans_coordinate,return_roordinate,tmp_coordinate,...
                                      trans_to_target_length,trans_to_return_length,trans_to_target_trangle,return_to_target_trangle);   %扰动后的目标函数的最小值 

                    delta_e=min_sum_2 - min_sum_1;  %新老距离的差值，相当于能量
                    if delta_e < 0                    %新坐标优秀于旧坐标，采用新坐标
                        target_coordinate = tmp_coordinate;
                    else                        %温度越低，越不太可能接受新解；新老距离差值越大，越不太可能接受新解
                        if exp(-(delta_e/tmp_start_tempature))>rand() %以概率选择是否接受新解
                            target_coordinate = tmp_coordinate;      %可能得到较差的解
                        else
                            continue;
                        end
                    end
            end
            tmp_start_tempature =  start_tempature .* attenuation_factor.^k .*(cos(pi./(2.*(1-k./count)))+cos(pi./(2.*start_tempature.*(1-k./count))));
            
            if tmp_start_tempature <= 0
                break;
            else
                continue;
            end
        end
%%
        result(i,j) = norm([x(i),y(j)]-[target_coordinate.x,target_coordinate.y]); %针对于当前点的GDOP误差
    end
end

figure(1)
mesh(x,y,result)
xlabel('x方向(单位:km)') 
ylabel('y方向(单位:km)') 
zlabel('误差值') 
title('基于发射基站的误差GDOP图') 

figure(2); 
[c,handle]=contour(x,y,result);%[c,h]=contour(x,y,z);  %c存放等高线上点对应的x和y，c的第一行点x值，第二行存点y值；h为等高线的句柄  
clabel(c,handle);%添加高度标签，h_clabel为高度标签的句柄 
xlabel('x方向(单位:km)') 
ylabel('y方向(单位:km)') 
title('基于接收基站的误差GDOP图') 
