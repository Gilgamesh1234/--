function A = getjunction_740_740(k,d)
d = d*1000; % 전극 조각 하나의 길이, 단위 um
p1 = 0.8;
p2 = 0.2;
pixels = 6; % 덩어리로 인정하는 전극수
U1 = randsample([1 2],(80/d)*(50/d),true,[p2 p1])-1;
U1 = reshape(U1,80/d,50/d);
L1 = randsample([1 2],(50/d)*(130/d),true,[p2 p1])-1;
L1 = reshape(L1,50/d,130/d);
U2 = randsample([1 2],(130/d)*(40/d),true,[p1 p2])-1;
U2 = reshape(U2,130/d,40/d);
L2 = randsample([1 2],(40/d)*(170/d),true,[p1 p2])-1;
L2 = reshape(L2,40/d,170/d);

R(170/d,170/d)=0;

R(1:80/d,40/d+1:90/d)=U1;

R(80/d+1:130/d,40/d+1:170/d)=L1;

R(1:130/d,1:40/d)=U2;

R(130/d+1:170/d,1:170/d)=L2;

R(1:80/d,90/d)=1;
R(80/d+1,90/d:170/d)=1;



R = flip(R,2);
Upper=triu(R,1);
Dia =diag(R);
R = flip((Upper+diag(Dia)+Upper'),2);
R(:,1)=0;
R(170/d,:)=0;


% R = bwareaopen(R,pixels,4);


  BW=bwlabel(R,4);
  R(BW~=BW(80/d+1,90/d))=0; % 외부에 둥둥떠다니는 섬 X




A = SubstituteJunction_740_740(R);
% 
% Firstquad(37,37) = 0;
% Firstquad(1:33,5:9)=1;
% Firstquad(29:33,5:37)=1;
% 
% Firstquad(20:37,1:18) = R;
% 
% Secondquad = rot90(Firstquad);
% 
% Thirdquad = rot90(Secondquad);
% 
% Fourthquad = rot90(Thirdquad);
% 
% Fulljunction = [Secondquad Firstquad ; Thirdquad Fourthquad];
% 
% A = Fulljunction; % A는 74*74 행렬
% 
% A = imfill(A,'holes'); % 구멍 X

end