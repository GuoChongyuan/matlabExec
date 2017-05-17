clear all
close all
clc

%% ��ʼ��������ͽ��ջ���λ��
%��ʼ�����������
trans_coordinate = struct();
trans_coordinate.x = 0;
trans_coordinate.y = 0;

trans_to_return_length_e = 0.0015;

%���ڷ���վ
trans_to_target_length_e = 0.0075;
trans_to_target_trangle_e = 0.0005;


%% ����������Χ
x  = -20 : 20;
y  = -20 : 20;

n = 41;%��������
%�γɾ���
for i = 1 : n
    for j = 1 : n
        trans_gdop(i,j) = sqrt(trans_to_target_length_e.^2 + trans_to_target_trangle_e .^2 .* norm([x(i),y(j)] - [trans_coordinate.x,trans_coordinate.y]).^2+trans_to_return_length_e.^2);
    end
end
%% ��С������
figure(1)
mesh(x,y,trans_gdop)
xlabel('x����(��λ:km)') 
ylabel('y����(��λ:km)') 
zlabel('���ֵ') 
title('���ڷ����վ�����GDOPͼ') 

figure(2); 
[c,handle]=contour(x,y,trans_gdop,5);%[c,h]=contour(x,y,z);  %c��ŵȸ����ϵ��Ӧ��x��y��c�ĵ�һ�е�xֵ���ڶ��д��yֵ��hΪ�ȸ��ߵľ��  
clabel(c,handle);%���Ӹ߶ȱ�ǩ��h_clabelΪ�߶ȱ�ǩ�ľ�� 
xlabel('x����(��λ:km)') 
ylabel('y����(��λ:km)') 
title('���ڷ����վ�����GDOPͼ') 