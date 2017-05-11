%matlab ����ʵ�� ģ���˻��㷨���� ������ֵ�����ú��޸ģ���л ARMYLAU��
%ʹ��ģ���˻�����f(x,y) = 3*cos(xy) + x + y2����Сֵ
%�⣺�������⣬���������ȴ����ȱ�Ϊ��
%����ʼ�¶�Ϊ30
%˥������Ϊ0.95
%��ɷ�������Ϊ10000
%Metropolis�Ĳ���Ϊ0.02
%��������Ϊ������һ�����Ž������µ�һ�����Ž��֮��С��ĳ���ݲ
%ʹ��METROPOLIS����׼�����ģ��, ��������
%* ����:2012��11-29
%* ����:steven
%*��EMAIL:hxs2004@126.com
%* ��������Ϊ�������Ž�֮��С��ĳС��
function [BestX,BestY]=SimulateAnnealing1
clear;
clc;
%// Ҫ������ֵ��Ŀ�꺯��,�������������
  XMAX= 4;
  YMAX = 4;
%��ȴ�����
 MarkovLength = 10000; %// ��ɷ�������
 DecayScale = 0.95; %// ˥������
 StepFactor = 0.02; %// ��������
 Temperature=30; %// ��ʼ�¶�
 Tolerance = 1e-8; %// �ݲ�
AcceptPoints = 0.0; %// Metropolis�������ܽ��ܵ�
rnd =rand;
% ���ѡ�� ��ֵ�趨
PreX = -XMAX * rand ;
PreY = -YMAX * rand;
PreBestX  = PreX;
PreBestY = PreY;
PreX = -XMAX * rand ;
PreY = -YMAX * rand;
BestX = PreX;
 BestY = PreY;
% ÿ����һ���˻�һ��(����), ֱ�������������Ϊֹ
mm=abs( ObjectFunction( BestX,BestY)-ObjectFunction (PreBestX, PreBestY));
while mm > Tolerance
Temperature=DecayScale*Temperature;
AcceptPoints = 0.0;
% �ڵ�ǰ�¶�T�µ���loop(��MARKOV������)��
for i=0:MarkovLength:1
% 1) �ڴ˵㸽�����ѡ��һ��
p=0;
while p==0
     NextX = PreX + StepFactor*XMAX*(rand-0.5);
    NextY = PreY + StepFactor*YMAX*(rand-0.5);
    if p== (~(NextX >= -XMAX && NextX <= XMAX && NextY >= -YMAX && NextY <= YMAX))
        p=1;
    end
end
% 2) �Ƿ�ȫ�����Ž�
if (ObjectFunction(BestX,BestY) > ObjectFunction(NextX,NextY))
% ������һ�����Ž�
PreBestX =BestX;
PreBestY = BestY;
% ��Ϊ�µ����Ž�
BestX=NextX;
BestY=NextY;
end
% 3) Metropolis����
if( ObjectFunction(PreX,PreY) - ObjectFunction(NextX,NextY) > 0 )
  %// ����, �˴�lastPoint����һ�������ĵ����½��ܵĵ㿪ʼ
PreX=NextX;
PreY=NextY;
AcceptPoints=AcceptPoints+1;
else
 changer = -1 * ( ObjectFunction(NextX,NextY) - ObjectFunction(PreX,PreY) ) / Temperature ;
rnd=rand;
p1=exp(changer);
double (p1);
if p1 > rand             %// ������, ����ԭ��
    PreX=NextX;
    PreY=NextY;
    AcceptPoints=AcceptPoints+1;
end
end
end
mm=abs( ObjectFunction( BestX,BestY)-ObjectFunction (PreBestX, PreBestY));
end
disp('��Сֵ�ڵ�:');
BestX
BestY
disp( '��СֵΪ:{0}');
ObjectFunction(BestX, BestY)
end