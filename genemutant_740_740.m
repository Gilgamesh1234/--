function M = genemutant_740_740(C)
p = 0.01; % 변이 임계 확률
pixels = 2;
[row,col] = size(C);
d = 170/row; % 작은 전극 하나의 길이, 단위 um
M = C;

mtemp1 = M(1:80/d+1,2:90/d-1);
mtemp2 = M(80/d+2:170/d-1,2:170/d-1);
for i = 1 : size(mtemp1,1)
   for j = 1 : size(mtemp1,2)
   if rand<p
       mtemp1(i,j) = ~mtemp1(i,j);
   end
   end
end

for i = 1 : size(mtemp2,1)
    for j = 1 : size(mtemp2,2)
   if rand<p
       mtemp2(i,j) = ~mtemp2(i,j);
   end
    end
end
M(1:80/d+1,2:90/d-1) = mtemp1;
M(80/d+2:170/d-1,2:170/d-1) = mtemp2;

   

M = flip(M,2);
UpperM = triu(M,1);
DiaM = diag(M);
M = flip(UpperM+diag(DiaM)+UpperM',2);
M(:,1)=0;
M(170/d,:)=0;


% M = bwareaopen(M,pixels,4);


BW=bwlabel(M,4);  % 섬 O
M(BW~=BW(80/d+1,90/d))=0; % 섬 X






M = SubstituteJunction_740_740(M);

end