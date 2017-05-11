x=-4:4;y=x;
[xa,ya]=meshgrid(x,y);            %生成 x-y 坐标“格点”矩阵
z=xa.^2+ya.^2;                         %计算格点上的函数值
subplot(1,2,1), mesh(x,y,z);  %三维网格图

subplot(1,2,2), surf(x,y,z);    %三维曲面图
colormap(hot); 
