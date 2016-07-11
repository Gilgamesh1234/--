function A = SubstituteJunction_740_740(R)


[row,col] = size(R);
d = 170/row; % ���� ���� �� ���� ����, ���� um
width = row/17*37; % 1��и��� �� ��(= �� ��)

R(1:80/d,90/d)=1; % ����
R(80/d+1,90/d:170/d)=1;
R(:,1)=0;
R(170/d,:)=0;

Firstquad(width,width) = 0;  % 1��и� ����
Firstquad(1:200/d,40/d+1:90/d)=1; % 18*18 ������ ��и�
Firstquad(280/d+1:330/d,170/d+1:370/d)=1; % 18*18 ������ ��и�

Firstquad(200/d+1:370/d,1:170/d) = R;

Secondquad = rot90(Firstquad);

Thirdquad = rot90(Secondquad);

Fourthquad = rot90(Thirdquad);

Fulljunction = [Secondquad Firstquad ; Thirdquad Fourthquad];


A = Fulljunction; % segments��� element�� R�� �����մϴ�.
A = imfill(A,'holes'); % ���� X
% 





end