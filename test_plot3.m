x=-4:4;y=x;
[xa,ya]=meshgrid(x,y);            %���� x-y ���ꡰ��㡱����
z=xa.^2+ya.^2;                         %�������ϵĺ���ֵ
subplot(1,2,1), mesh(x,y,z);  %��ά����ͼ

subplot(1,2,2), surf(x,y,z);    %��ά����ͼ
colormap(hot); 
