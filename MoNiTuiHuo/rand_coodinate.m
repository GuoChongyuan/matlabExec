function tmp_coordinate=rand_coodinate(target_coordinate,x_radio,y_radio)  
    
    %���ܱ߲���һ������Ŷ�
    %��������Ŷ�
    p1=2.*x_radio.*rand();
    p2=2.*y_radio.*rand();
    
    tmp_coordinate.x = target_coordinate.x + p1 - x_radio;%����ʼ���ܵ�λ�ö�λ�����½�
    tmp_coordinate.y = target_coordinate.y + p2 - y_radio;
  
    