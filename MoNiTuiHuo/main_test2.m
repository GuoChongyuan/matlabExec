clear all;
close all;
clc;

%��ʼ�����������
x_y_input = inputdlg({'��������','��������'},'��ʼ�����������',1,{'0','0'});
trans_coordinate = struct();
trans_coordinate.x = str2double(x_y_input(1));
trans_coordinate.y = str2double(x_y_input(2));

%��ʼ�����ջ�����
x_y_input = inputdlg({'��������','��������'},'��ʼ�����ջ�����',1,{'6','0'});
return_roordinate = struct();
return_roordinate.x = str2double(x_y_input(1));
return_roordinate.y = str2double(x_y_input(2));

%��ʼ���۲�������
x_y_input = inputdlg({'��������','��������'},'��ʼ���۲�������',1,{'3','3'});
target_coordinate = struct();
target_coordinate.x = str2double(x_y_input(1));
target_coordinate.y = str2double(x_y_input(2));

input = inputdlg({'��⵽�ķ�����������ľ���r_t','��⵽�ķ�����������-���ջ��ľ���r_r','%��⵽�ķ����-�����ĽǶ�','%��⵽�Ľ��ջ�-�����ĽǶ�'},'����������',1,{'4','8','45','45'});
%��⵽�ķ�����������ľ���r_t
trans_to_target_length = str2double(input(1));
%��⵽�ķ�����������-���ջ��ľ���r_r
trans_to_return_length = str2double(input(2));
%��⵽�ķ����-�����ĽǶ�
trans_to_target_trangle = str2double(input(3));
%��⵽�Ľ��ջ�-�����ĽǶ�
return_to_target_trangle = str2double(input(4));

%�趨�Ĳ��Ұ뾶
x_y_input = inputdlg({'������Ұ뾶','������Ұ뾶'},'�趨���Ұ뾶',1,{'1','1'});
x_radio = str2double(x_y_input(1)); 
y_radio = str2double(x_y_input(2));

input = inputdlg({'��ʼ������','�ڲ����ؿ���ѭ����������','��ʼ�¶�','ֹͣ�¶�'},'�˻��������',1,{'10','500','100','0.001'});
control = str2double(input(1));              %��ʼ������
iter=str2double(input(2));                 %�ڲ����ؿ���ѭ����������
start_tempature=str2double(input(3));         %��ʼ�¶�
end_tempature = str2double(input(4));     %ֹͣ�¶�

count = 1;                 %ͳ�Ƶ�������
min_sum(count) = sonar_error_min(trans_coordinate,return_roordinate,target_coordinate,...
                          trans_to_target_length,trans_to_return_length,trans_to_target_trangle,return_to_target_trangle);   %ÿ�ε������Ŀ�꺯������Сֵ  
coordinate_plot(trans_coordinate,return_roordinate,target_coordinate)%��ʼĿ��λ��

tmp_coordinate = struct();
tmp_coordinate.x = target_coordinate.x;
tmp_coordinate.y = target_coordinate.y;

accept = 0; % Ĭ���ǲ����Խ��ܵĽ��

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
    count = count + 1;
    min_sum(count) = sonar_error_min(trans_coordinate,return_roordinate,target_coordinate,...
                          trans_to_target_length,trans_to_return_length,trans_to_target_trangle,return_to_target_trangle);   %ÿ�ε������Ŀ�꺯������Сֵ
end  
figure;
coordinate_plot(trans_coordinate,return_roordinate,target_coordinate)%����Ŀ��λ��   

figure;
plot(min_sum)

target_coordinate.x
target_coordinate.y
