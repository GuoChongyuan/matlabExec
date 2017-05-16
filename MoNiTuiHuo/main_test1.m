clear all;
close all;
clc;
%% ������¼
%��ʼ�����������
trans_coordinate = struct();
trans_coordinate.x = 0;
trans_coordinate.y = 0;

%��ʼ�����ջ�����
return_roordinate = struct();
return_roordinate.x = 8;
return_roordinate.y = 0;

%��ʼ���۲�������
target_coordinate = struct();
target_coordinate.x = 0.1;
target_coordinate.y = 0.1;

%�趨���Ŷ��뾶
x_radio = 1;
y_radio = 1;

% ����������Χ
x  = -20 : 20;
y  = -20 : 20;

start_tempature=100;         %��ʼ�¶�
attenuation_factor = 0.99;%˥������
pi = 3.1415926;
iter=500;                  %�ڲ����ؿ���ѭ����������
count = 1000;%�����ܴ���

number = 1 : count + 1;

%% �۲�ֵ��¼
%��⵽�ķ����-�����ĽǶ�
trans_to_target_trangle = 0.25;
%��⵽�Ľ��ջ�-�����ĽǶ�
return_to_target_trangle = -0.25;
%��⵽�ķ�����������ľ���r_t
trans_to_target_length = 5.6569;
%��⵽�ķ�����������-���ջ��ľ���r_r
trans_to_return_length = 11.3137;
%% �˻��㷨������׼��
tmp_coordinate = struct();
tmp_coordinate.x = target_coordinate.x;
tmp_coordinate.y = target_coordinate.y;


%% �˻��㷨���м���
for k = 1 : count + 1 %���յ�ʱ���ܹ�����������Сֵ0
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
                    continue;
                end
            end
    end
    tmp_start_tempature =  start_tempature .* attenuation_factor.^k .*(cos(pi./(2.*(1-k./count)))+cos(pi./(2.*start_tempature.*(1-k./count))));
    start_tempature = tmp_start_tempature;
    min_sum(k) = sonar_error_min(trans_coordinate,return_roordinate,target_coordinate,...
                          trans_to_target_length,trans_to_return_length,trans_to_target_trangle,return_to_target_trangle);   %ÿ�ε������Ŀ�꺯������Сֵ
end
%%
figure(1);
coordinate_plot(trans_coordinate,return_roordinate,target_coordinate)%����Ŀ��λ�� 

figure(2)
plot(number,min_sum);

target_coordinate.x
target_coordinate.y
