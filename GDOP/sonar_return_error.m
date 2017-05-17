clear all
close all
clc

%% ��ʼ��������ͽ��ջ���λ��
%��ʼ�����������
trans_coordinate = struct();
trans_coordinate.x = -7.5;
trans_coordinate.y = 0;

%��ʼ�����ջ�����
return_coordinate = struct();
return_coordinate.x = 7.5;
return_coordinate.y = 0;

trans_to_return_length_e = 0.0015;

%���ڽ���վ����
trans_target_return_length_e = 0.0075;
retutn_to_target_trangle_e = 0.0005;%�������в�û�и����ӣ����Ǻ�����˵��������˾��ȣ������


%% ����������Χ
x  = -20 : 20;
y  = -20 : 20;

n = 41;%��������
%�γɾ���
for i = 1 : n
    for j = 1 : n
        trans_to_target_length = norm([x(i),y(j)] - [trans_coordinate.x,trans_coordinate.y] );
        return_to_target_length = norm([x(i),y(j)] - [return_coordinate.x,return_coordinate.y] );
        c_t_1 = norm([x(i),0] - [trans_coordinate.x,0] )./trans_to_target_length;%����վ���ҽ�
        c_t_2 = norm([0,y(j)] - [0,trans_coordinate.y] )./trans_to_target_length;%����վ���ҽ�
        c_r_1 = norm([x(i),0] - [return_coordinate.x,0] )./return_to_target_length;%����վ���ҽ�
        c_r_2 = norm([0,y(j)] - [0,return_coordinate.y] )./return_to_target_length;%����վ���ҽ�
        return_gdop_c = abs((c_t_1.*c_r_1 + c_t_2.* c_r_2)./return_to_target_length);
        return_gdop(i,j) = sqrt((trans_target_return_length_e.^2 + 2.*trans_to_return_length_e.^2)/(return_to_target_length.^2)+((c_t_1 + c_r_1).^2 + (c_t_2 + c_r_2).^2).*(trans_target_return_length_e.^2+(trans_to_return_length_e.^2)/(return_to_target_length.^2)))./return_gdop_c;
    end
end
%% ��С������
figure(1)
mesh(x,y,return_gdop)
xlabel('x����(��λ:km)') 
ylabel('y����(��λ:km)') 
zlabel('���ֵ') 
title('���ڽ��ջ�վ�����GDOPͼ') 

figure(2); 
[c,handle]=contour(x,y,return_gdop);%[c,h]=contour(x,y,z);  %c��ŵȸ����ϵ��Ӧ��x��y��c�ĵ�һ�е�xֵ���ڶ��д��yֵ��hΪ�ȸ��ߵľ��  
clabel(c,handle);%��Ӹ߶ȱ�ǩ��h_clabelΪ�߶ȱ�ǩ�ľ�� 
xlabel('x����(��λ:km)') 
ylabel('y����(��λ:km)') 
title('���ڽ��ջ�վ�����GDOPͼ') 
