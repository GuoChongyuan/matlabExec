clear all;
close all;
clc;
%% ԭʼ������¼
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
%% �˻��㷨������׼��

count = 1;                 %ͳ�Ƶ�������
min_sum(count) = sonar_error_min(trans_coordinate,return_roordinate,target_coordinate,...
                          trans_to_target_length,trans_to_return_length,trans_to_target_trangle,return_to_target_trangle);   %ÿ�ε������Ŀ�꺯������Сֵ  
%coordinate_plot(trans_coordinate,return_roordinate,target_coordinate)%��ʼĿ��λ��

tmp_coordinate = struct();
tmp_coordinate.x = target_coordinate.x;
tmp_coordinate.y = target_coordinate.y;
%% �˻��㷨���м���
while start_tempature > end_tempature
    for i = 1:iter  %��ε����Ŷ���һ�����ؿ��巽�����¶Ƚ���֮ǰ���ʵ��
            min_sum_1 = sonar_error_min(trans_coordinate,return_roordinate,target_coordinate,...
                              trans_to_target_length,trans_to_return_length,trans_to_target_trangle,return_to_target_trangle);        %����ԭĿ�꺯������Сֵ 
            tmp_coordinate=rand_coodinate(target_coordinate,x_radio,y_radio);      %��������Ŷ�
            min_sum_2 = sonar_error_min(trans_coordinate,return_roordinate,tmp_coordinate,...
                              trans_to_target_length,trans_to_return_length,trans_to_target_trangle,return_to_target_trangle);   %�Ŷ����Ŀ�꺯������Сֵ 

            delta_e=min_sum_2 - min_sum_1;  %���Ͼ���Ĳ�ֵ���൱������
            if delta_e < 0                    %�����������ھ����꣬����������
                target_coordinate = tmp_coordinate;
            else                        %�¶�Խ�ͣ�Խ��̫���ܽ����½⣻���Ͼ����ֵԽ��Խ��̫���ܽ����½�
                if exp(-(delta_e/start_tempature))>rand() %�Ը���ѡ���Ƿ�����½�
                    target_coordinate = tmp_coordinate;      %���ܵõ��ϲ�Ľ�
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
            targetx(i) = target_coordinate.x;
    end
    count = count + 1;
    min_sum(count) = sonar_error_min(trans_coordinate,return_roordinate,target_coordinate,...
                          trans_to_target_length,trans_to_return_length,trans_to_target_trangle,return_to_target_trangle);   %ÿ�ε������Ŀ�꺯������Сֵ
end
%%
%figure;
%coordinate_plot(trans_coordinate,return_roordinate,target_coordinate)%����Ŀ��λ��   

%figure;
%plot(min_sum)

target_coordinate.x
target_coordinate.y
