clear all;
close all;
clc;
%�趨�Ĳ��Ұ뾶
x_radio = 20;
y_radio = 20;

%��⵽�ķ�����������ľ���r_t
trans_to_target_length = 420;
%��⵽�ķ�����������-���ջ��ľ���r_r
trans_to_return_length = 840;
%��⵽�ķ����-�����ĽǶ�
trans_to_target_trangle = 45;
%��⵽�Ľ��ջ�-�����ĽǶ�
return_to_target_trangle = -45;

%��ʼ�����������
trans_coordinate = struct();
trans_coordinate.x = 0;
trans_coordinate.y = 0;

%��ʼ�����ջ�����
return_roordinate = struct();
return_roordinate.x = 600;
return_roordinate.y = 0;

%��ʼ���۲�������
target_coordinate = struct();
target_coordinate.x = 400;
target_coordinate.y = 400;

control = 10;              %��ʼ������
iter=500;                  %�ڲ����ؿ���ѭ����������
start_tempature=100;         %��ʼ�¶�
end_tempature = 0.001;     %ֹͣ�¶�

count = 1;                 %ͳ�Ƶ�������
min_sum(count) = sonar_error_min(trans_coordinate,return_roordinate,target_coordinate,...
                          trans_to_target_length,trans_to_return_length,trans_to_target_trangle,return_to_target_trangle);   %ÿ�ε������Ŀ�꺯������Сֵ  
%coordinate_plot(trans_coordinate,return_roordinate,target_coordinate)%��ʼĿ��λ��

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

