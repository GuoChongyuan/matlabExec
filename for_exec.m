%for���
%for���ĸ�ʽΪ��
%for ѭ������ =���ʽ1�����ʽ2�����ʽ3
%   ѭ�������
%end
%���б��ʽ1��ֵΪѭ�������ĳ�ֵ�����ʽ2��ֵΪ���������ʽ3��ֵΪ����ֵ
clear all;
clc;

%for�����ϰ%
start = 0;
ends = 10;
sum = 0;
for i = start : ends
   sum = sum + i;
end
disp(['�ܺ�Ϊ',num2str(sum)]);
disp(['ƽ��ֵΪ',num2str(sum/(ends - start))]);
