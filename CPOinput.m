% write CPOinput.txt
function CPOinput(A,G,i)   % Junction 타입의 변수 A, G를 인수로 받습니다. i는 index
                        % G는 grid이므로 모든 CPOinput.m에서 
                           % 동일하게 인수로 받습니다.
k = size(G,1); % S가 k*k행렬이므로 k값을 받아옵니다.
S = zeros(k,k);
d = 740/k;
S(200/d+1:370/d,370/d+1:540/d)=A(200/d+1:370/d,370/d+1:540/d);

format compact;
filename = sprintf('C:/Users/CPO/Desktop/2016_Juho/CPOinput/CPOinput%d.dat',i);
fileID = fopen(filename,'w'); % Write 즉 쓰기용으로 CPOinput.txt라는 파일을 엽니다. 
formatSpec0 = 'nh PO3D.DAT-general test data fil\r\nC:/Users/CPO/Desktop/2016_Juho/Data/H%d.dat name of hidden output file, for processed data\r\nC:/Users/CPO/Desktop/2016_Juho/Data/R%d.dat  name of main ray output file, for ray data\r\nn   bbbv  n/p/m/a for print level, cumulative, blank comment start, colour electrodes\r\n1 1 0 0   voltage reflection symmetries in x,y,z,x=y planes\r\n2     number of different voltages (time-independent)\r\n0.01  5    0   allowed consistency error, side/length ratio check, allow outside zs\r\nn  apply inscribing correction (a/s/n=always/sometimes/never)\r\n';
formatSpec1 = 'rez  rectangle, z=constant      Ground plane\r\n-0.01  z value of plane\r\n0 0      x,y of 1st end of diagonal\r\n0.4 0.4      x,y of 2nd end of diagonal\r\n1  1  numbers of 2 applied voltages (can be same)\r\n25    25      total nr of subdivs and 0, or subdivs in  x and y directions\r\ncolour    1\r\nrez  rectangle, z=constant\r\n0  z value of plane\r\n0.09 0.37      x,y of 1st end of diagonal\r\n0.37 0.09      x,y of 2nd end of diagonal\r\n1  1  numbers of 2 applied voltages (can be same)\r\n10    10      total nr of subdivs and 0, or subdivs in  x and y directions\r\ncolour    1\r\nrez  rectangle, z=constant\r\n0  z value of plane\r\n0.09 0.37      x,y of 1st end of diagonal\r\n0.04 0.17      x,y of 2nd end of diagonal\r\n2  2  numbers of 2 applied voltages (can be same)\r\n12    0      total nr of subdivs and 0, or subdivs in  x and y directions\r\ncolour    2\r\nrez  rectangle, z=constant\r\n0  z value of plane\r\n0.17 0.09      x,y of 1st end of diagonal\r\n0.37 0.04      x,y of 2nd end of diagonal\r\n2  2  numbers of 2 applied voltages (can be same)\r\n12    0      total nr of subdivs and 0, or subdivs in  x and y directions\r\ncolour    2\r\n';
formatSpec2 = 'rez  rectangle, z=constant\r\n0  z value of plane\r\n%f %f      x,y of 1st end of diagonal\r\n%f %f      x,y of 2nd end of diagonal\r\n2  2  numbers of 2 applied voltages (can be same)\r\n1    0      total nr of subdivs and 0, or subdivs in  x and y directions\r\ncolour    2\r\n';
formatSpec3 = 'end of electrode information\r\n0     1  0.5    final nmbr segs, nmbr steps, weight\r\n1e-07               0.001      Q inacc,non-0 total Q,improve matrix,import,diel inacc\r\nend of segment information\r\n0.0000000E+00       \r\n1.0000000E+00       \r\nn      no more magnetic fields from menu\r\nn y n    gd   potentials and fields along a 3D grid\r\n1 371 151    Number of grid points in x,y,z directions\r\n0 -0.37 0 0.002 0.002 0.002  Coordinates of grid origin and spacing in x, y and z\r\n-0.01    inaccuracy of evaluation\r\nn n n        no more potentials and fields along a line\r\nno ray information\r\n0 0 0 0      symmetries of rays in yz,zx,xy and x=y planes\r\n';


% 전극에 가해지는 전압이 0인지 1인지에 따라 1 1 2 2가 나뉘므로 텍스트를 3개로 나눕니다.
fprintf(fileID,formatSpec0,i,i);
fprintf(fileID,formatSpec1);
for i=1 : k
    for j=1 : k
if S(i,j) == 0
  
else 
    fprintf(fileID,formatSpec2,G{i,j}(1,1),G{i,j}(1,2),G{i,j}(2,1),G{i,j}(2,2));
   
    
end
    end
end
fprintf(fileID,formatSpec3);
fclose(fileID); % 파일 닫기
end
