clear all
close all
clc

%% ��ʼ��������ͽ��ջ���λ��
%��ʼ�����������
trans_coordinate = struct();
trans_coordinate.x = -7500;
trans_coordinate.y = 0;
trans_to_target_trangle = 90;

trans_to_target_length_e = 7.5;
trans_to_target_trangle_e = 0.27;
trans_to_return_length_e = 15;

%% ����������Χ
x  = -20 : 1 : 20;
y  = -20 : 1 : 20;

n = 41;%��������
%�γɾ���
[x,y]=meshgrid(x,y); 
length = sqrt((x - trans_coordinate.x).^2+ (y - trans_coordinate.y).^2);
%�������
x_error = cosd(trans_to_target_trangle).^2 .* trans_to_target_length_e.^2 + length.^2 .* sind(trans_to_target_trangle).^2 * trans_to_target_trangle_e.^2 + trans_to_return_length_e.^2;
y_error = sind(trans_to_target_trangle).^2 .* trans_to_target_length_e.^2 + length.^2 .* cosd(trans_to_target_trangle).^2 * trans_to_target_trangle_e.^2 + trans_to_return_length_e.^2;
result = sqrt(x_error + y_error);

%% ��С������
mesh(x,y,result)
hold on
result=1.*(result>=-1000 & result<=1000);
mesh(x,y,result);

