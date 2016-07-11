function A = SubstituteJunction_740_740(R)


[row,col] = size(R);
d = 170/row; % 전극 조각 한 변의 길이, 단위 um
width = row/17*37; % 1사분면의 행 수(= 열 수)

R(1:80/d,90/d)=1; % 수선
R(80/d+1,90/d:170/d)=1;
R(:,1)=0;
R(170/d,:)=0;

Firstquad(width,width) = 0;  % 1사분면 생성
Firstquad(1:200/d,40/d+1:90/d)=1; % 18*18 제외한 사분면
Firstquad(280/d+1:330/d,170/d+1:370/d)=1; % 18*18 제외한 사분면

Firstquad(200/d+1:370/d,1:170/d) = R;

Secondquad = rot90(Firstquad);

Thirdquad = rot90(Secondquad);

Fourthquad = rot90(Thirdquad);

Fulljunction = [Secondquad Firstquad ; Thirdquad Fourthquad];


A = Fulljunction; % segments라는 element에 R을 저장합니다.
A = imfill(A,'holes'); % 구멍 X
% 





end