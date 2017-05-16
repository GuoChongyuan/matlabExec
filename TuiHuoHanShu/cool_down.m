clear all;
close all;
clc;
%% �趨����
start_temperater = 100 ;%��ʼ�¶�
attenuation_factor = 0.99;%˥������
number = 100;%�ܵĽ��´���
count = 1 : 100;%�����ܴ���
pi = 3.1415926;

%% �������
for k = 1 : number
    y1(k) = start_temperater./log10(1+k);%���併��
    y2(k) = start_temperater./(1+k);%���ٽ���
    y3(k) = start_temperater .* attenuation_factor.^k .*(cos(pi./(2.*(1-k./number)))+cos(pi./(2.*start_temperater.*(1-k./number))));
end
%% ��ͼ
plot(count,y1,'p');
hold on
plot(count,y2,'--');
hold on
plot(count,y3,'r');