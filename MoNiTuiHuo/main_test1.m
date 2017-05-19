clear all;
close all;
clc;
%% �仯����
%���ֵ
trans_target_return_length_e = 0.01;
retutn_to_target_trangle_e = 0.0005;
trans_target_length_e = 0.0075;
trans_to_target_trangle_e = 0.0005;

%% ������¼
trans_to_return_length_e = 0.02;
%��ʼ�����������
trans_coordinate = struct();
trans_coordinate.x = -7.5 + trans_to_return_length_e.*rand();
trans_coordinate.y = 0;

%��ʼ�����ջ�����
return_roordinate = struct();
return_roordinate.x = 7.5 +  trans_to_return_length_e.*rand();
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
iter=50;                  %�ڲ����ؿ���ѭ����������
count = 500;%�����ܴ���
n = 41;

%% �˻��㷨������׼��
tmp_coordinate = struct();
tmp_coordinate.x = target_coordinate.x;
tmp_coordinate.y = target_coordinate.y;


for i = 1 : n
    for j = 1 : n
    %�ٶ�Ŀ��λ��  
    target_coordinate.x = x(i);
    target_coordinate.y = y(j);
    % �۲�ֵ��¼����
    %��⵽�ķ����-�����ĽǶ�
    trans_to_target_trangle = atan((target_coordinate.y - trans_coordinate.y)./(target_coordinate.x - trans_coordinate.x)) + 2.*trans_to_target_trangle_e.*rand() - trans_to_target_trangle_e;
    %��⵽�Ľ��ջ�-�����ĽǶ�
    return_to_target_trangle = atan((target_coordinate.y - return_roordinate.y)./(target_coordinate.x - return_roordinate.x)) + 2.*retutn_to_target_trangle_e.*rand() - retutn_to_target_trangle_e;
    %��⵽�ķ�����������ľ���r_t
    trans_to_target_length = norm([target_coordinate.x,target_coordinate.y] - [trans_coordinate.x,trans_coordinate.y]) + 2.*trans_target_length_e.*rand() - trans_target_length_e;
    %��⵽�ķ�����������-���ջ��ľ���r_r
    trans_to_return_length = norm([target_coordinate.x,target_coordinate.y] - [return_roordinate.x,return_roordinate.y])+ trans_to_target_length + 2.*trans_target_return_length_e.*rand() - trans_target_return_length_e;
    
    tmp_start_tempature =  start_tempature .* attenuation_factor.^1 .*(cos(pi./(2.*(1-1./count)))+cos(pi./(2.*start_tempature.*(1-1./count))));
%% �˻��㷨���м���
        for k = 1 : count - 1  %���յ�ʱ���ܹ�����������Сֵ0
            for m = 1:iter  %��ε����Ŷ���һ�����ؿ��巽�����¶Ƚ���֮ǰ���ʵ��
                    min_sum_1 = sonar_error_min(trans_coordinate,return_roordinate,target_coordinate,...
                                      trans_to_target_length,trans_to_return_length,trans_to_target_trangle,return_to_target_trangle);        %����ԭĿ�꺯������Сֵ 
                    tmp_coordinate=rand_coodinate(target_coordinate,x_radio,y_radio);      %��������Ŷ�
                    min_sum_2 = sonar_error_min(trans_coordinate,return_roordinate,tmp_coordinate,...
                                      trans_to_target_length,trans_to_return_length,trans_to_target_trangle,return_to_target_trangle);   %�Ŷ����Ŀ�꺯������Сֵ 

                    delta_e=min_sum_2 - min_sum_1;  %���Ͼ���Ĳ�ֵ���൱������
                    if delta_e < 0                    %�����������ھ����꣬����������
                        target_coordinate = tmp_coordinate;
                    else                        %�¶�Խ�ͣ�Խ��̫���ܽ����½⣻���Ͼ����ֵԽ��Խ��̫���ܽ����½�
                        if exp(-(delta_e/tmp_start_tempature))>rand() %�Ը���ѡ���Ƿ�����½�
                            target_coordinate = tmp_coordinate;      %���ܵõ��ϲ�Ľ�
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
        result(i,j) = norm([x(i),y(j)]-[target_coordinate.x,target_coordinate.y]); %����ڵ�ǰ���GDOP���
    end
end

figure(1)
mesh(x,y,result)
xlabel('x����(��λ:km)') 
ylabel('y����(��λ:km)') 
zlabel('���ֵ') 
title('���ڷ����վ�����GDOPͼ') 

figure(2); 
[c,handle]=contour(x,y,result);%[c,h]=contour(x,y,z);  %c��ŵȸ����ϵ��Ӧ��x��y��c�ĵ�һ�е�xֵ���ڶ��д��yֵ��hΪ�ȸ��ߵľ��  
clabel(c,handle);%��Ӹ߶ȱ�ǩ��h_clabelΪ�߶ȱ�ǩ�ľ�� 
xlabel('x����(��λ:km)') 
ylabel('y����(��λ:km)') 
title('���ڽ��ջ�վ�����GDOPͼ') 
