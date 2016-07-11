% a,b라는 sequence를 받아 그 결과로 생성된 R1, R2, R3, R4 Junction을 만듭니다.(segments,
% sequence를 포함한 Junction type을 만듭니다.)
function C = genecross_740_740(P1,P2) % a,b sequence를 인수로 받아 4개 Junction이 모인 Cell type [R1,R2,R3,R4]를 만듭니다.
% Cell은 여러 type이 모인 데이터 구조입니다. array와 비슷합니다.
[row,col] = size(P1);

d = 740/row; % 작은 전극 하나의 길이, 단위 um
A = P1(200/d+1:370/d,370/d+1:540/d);
B = P2(200/d+1:370/d,370/d+1:540/d);
UpperA = triu(flip(A,2),1);
DiaA = diag(flip(A,2));
UpperB = triu(flip(B,2),1);
DiaB = diag(flip(B,2));
a = reshape(UpperA+diag(DiaA),1,[]);
b = reshape(UpperB+diag(DiaB),1,[]);

c = zeros(1,length(a));

p = 0.5; % 0이 나올 확률
rs = randsample([1 2],length(a),true,[p 1-p])-1; % 난수 발생
for i = 1 : length(a)
    if rs(i)==0
    c(i)=a(i); % 0이 나오면 a의 것을
    else
   c(i) = b(i); % 1이 나오면 b의 것을 가져옴
    end
end

c = reshape(c,170/d,170/d);
UpperC = triu(c,1);
DiaC = diag(c);
c = flip(UpperC+UpperC'+diag(DiaC),2);


C=c;



end