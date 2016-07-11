% a,b��� sequence�� �޾� �� ����� ������ R1, R2, R3, R4 Junction�� ����ϴ�.(segments,
% sequence�� ������ Junction type�� ����ϴ�.)
function C = genecross_740_740(P1,P2) % a,b sequence�� �μ��� �޾� 4�� Junction�� ���� Cell type [R1,R2,R3,R4]�� ����ϴ�.
% Cell�� ���� type�� ���� ������ �����Դϴ�. array�� ����մϴ�.
[row,col] = size(P1);

d = 740/row; % ���� ���� �ϳ��� ����, ���� um
A = P1(200/d+1:370/d,370/d+1:540/d);
B = P2(200/d+1:370/d,370/d+1:540/d);
UpperA = triu(flip(A,2),1);
DiaA = diag(flip(A,2));
UpperB = triu(flip(B,2),1);
DiaB = diag(flip(B,2));
a = reshape(UpperA+diag(DiaA),1,[]);
b = reshape(UpperB+diag(DiaB),1,[]);

c = zeros(1,length(a));

p = 0.5; % 0�� ���� Ȯ��
rs = randsample([1 2],length(a),true,[p 1-p])-1; % ���� �߻�
for i = 1 : length(a)
    if rs(i)==0
    c(i)=a(i); % 0�� ������ a�� ����
    else
   c(i) = b(i); % 1�� ������ b�� ���� ������
    end
end

c = reshape(c,170/d,170/d);
UpperC = triu(c,1);
DiaC = diag(c);
c = flip(UpperC+UpperC'+diag(DiaC),2);


C=c;



end