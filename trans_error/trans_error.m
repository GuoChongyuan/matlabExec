clear all
close all
clc

%% ��ʼ��������ͽ��ջ���λ��
%��ʼ�����������
trans_coordinate = struct();
trans_coordinate.x = 0;
trans_coordinate.y = 0;
trans_to_target_trangle = 90;

trans_to_target_length_e = 7.5;
trans_to_target_trangle_e = 0.27;
trans_to_return_length_e = 15;

%% ����������Χ
x  = -20 : 20;
y  = -20 : 20;

n = 41;%��������
%�γɾ���
for i = 1 : n
    for j = 1 : n
      length = sqrt((x(i) - trans_coordinate.x).^2+ (y(j) - trans_coordinate.y).^2);
      %trans_to_target_trangle = atand((y(j) - trans_coordinate.y)./(x(i) - trans_coordinate.x));
      %�������
        x_error = cosd(trans_to_target_trangle).^2 .* trans_to_target_length_e.^2 + length.^2 .* sind(trans_to_target_trangle).^2. * trans_to_target_trangle_e.^2 + trans_to_return_length_e.^2;
        y_error = sind(trans_to_target_trangle).^2 .* trans_to_target_length_e.^2 + length.^2 .* cosd(trans_to_target_trangle).^2 .* trans_to_target_trangle_e.^2 + trans_to_return_length_e.^2;
        result(i,j) = sqrt(x_error + y_error);
    end
end
%% ��С������
figure(1); 
[c,handle]=contour(result,25);%[c,h]=contour(x,y,z);  %c��ŵȸ����ϵ��Ӧ��x��y��c�ĵ�һ�е�xֵ���ڶ��д��yֵ��hΪ�ȸ��ߵľ��  
clabel(c,handle);%��Ӹ߶ȱ�ǩ��h_clabelΪ�߶ȱ�ǩ�ľ�� 
xlabel('x����(��λ:km)') 
ylabel('y����(��λ:km)') 
title('GDOPͼ') 
%mesh(x,y,result)
%hold on
%result=1.*(result>=-1000 & result<=1000);
%mesh(x,y,result);

