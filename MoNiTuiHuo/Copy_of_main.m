clear all;
close all;
clc;
%�趨�Ĳ��Ұ뾶
x_radio = 1;
y_radio = 1;

%��⵽�ķ�����������ľ���r_t
trans_to_target_length = 4;
%��⵽�ķ�����������-���ջ��ľ���r_r
trans_to_return_length = 7;
%��⵽�ķ����-�����ĽǶ�
trans_to_target_trangle = -0.645;
%��⵽�Ľ��ջ�-�����ĽǶ�
returnToTargetTrangle = 0.3200;

%��ʼ�����������
trans_coordinate = struct();
trans_coordinate.x = 0;
trans_coordinate.y = 0;

%��ʼ�����ջ�����
return_roordinate = struct();
return_roordinate.x = 5;
return_roordinate.y = 0;

%��ʼ���۲�������
target_coordinate = struct();
target_coordinate.x = 4;
target_coordinate.y = 3;

control = 10;              %��ʼ������
iter=1000;                 %�ڲ����ؿ���ѭ����������
temperature=100;         %��ʼ�¶�

count = 1;                 %ͳ�Ƶ�������
min_sum(count) = sonar_error_min(trans_coordinate,return_roordinate,target_coordinate,...
                          trans_to_target_length,trans_to_return_length,trans_to_target_trangle,returnToTargetTrangle);   %ÿ�ε������Ŀ�꺯������Сֵ  
coordinate_plot(trans_coordinate,return_roordinate,target_coordinate)%��ʼĿ��λ��

tmp_coordinate = struct();
tmp_coordinate.x = target_coordinate.x;
tmp_coordinate.y = target_coordinate.y;

while temperature>99.99     %ֹͣ�����¶�
    
     min_sum_1 = sonar_error_min(trans_coordinate,return_roordinate,target_coordinate,...
                          trans_to_target_length,trans_to_return_length,trans_to_target_trangle,returnToTargetTrangle);        %����ԭĿ�꺯������Сֵ 
        tmp_coordinate=rand_coodinate(target_coordinate,x_radio,y_radio);      %��������Ŷ�
        min_sum_2 = sonar_error_min(trans_coordinate,return_roordinate,tmp_coordinate,...
                          trans_to_target_length,trans_to_return_length,trans_to_target_trangle,returnToTargetTrangle);   %�Ŷ����Ŀ�꺯������Сֵ 
        
        delta_e=min_sum_2 - min_sum_1;  %���Ͼ���Ĳ�ֵ���൱������
        if delta_e<0        %��·�ߺ��ھ�·�ߣ�����·�ߴ����·��
            target_coordinate = tmp_coordinate;
        else                        %�¶�Խ�ͣ�Խ��̫���ܽ����½⣻���Ͼ����ֵԽ��Խ��̫���ܽ����½�
            if exp(-delta_e/temperature)>rand() %�Ը���ѡ���Ƿ�����½�
                target_coordinate = tmp_coordinate;      %���ܵõ��ϲ�Ľ�
            end
        end        
    count = count + 1;
    min_sum(count) = sonar_error_min(trans_coordinate,return_roordinate,target_coordinate,...
                          trans_to_target_length,trans_to_return_length,trans_to_target_trangle,returnToTargetTrangle);   %ÿ�ε������Ŀ�꺯������Сֵ
    temperature=temperature*0.99;   %�¶Ȳ����½�
  
end  
figure;
coordinate_plot(trans_coordinate,return_roordinate,target_coordinate)%����Ŀ��λ��   

target_coordinate.x
target_coordinate.y

figure;
plot(min_sum)
