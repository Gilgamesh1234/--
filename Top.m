delete('C:/Users/CPO/Desktop/2016_Juho/CPOinput/CPOinput*.dat');
delete('C:/Users/CPO/Desktop/2016_Juho/Data/R*.dat');
delete('C:/Users/CPO/Desktop/2016_Juho/Data/H*.dat');
delete('C:/Users/CPO/Desktop/2016_Juho/Data/H*.yyy');
delete('C:/Users/CPO/Desktop/2016_Juho/Data/H*.yzz');
delete('C:/Users/CPO/Desktop/2016_Juho/Data/H*.yxx');


loopnumber = 1000 ; %% 유전알고리즘 시행 횟수입니다.
poolnumber = 64; %% 유전자 풀 안에 있는 부모 갯수
selectnumber = 8; %% 유전자 풀에서 선택되는 부모 갯수

d = 0.005; % 정사각형 전극 하나의 한 변의 길이
k = 148; %% 한 변에 있는 전극의 갯수
G = getgrid(k,d);

logpotbarr=zeros(loopnumber,poolnumber);
logjunction = cell(loopnumber,poolnumber);
% loggraph.graph = zeros(loopnumber,poolnumber);

for i = 1 : poolnumber
    P{i} = getjunction_740_740(k,d); % n개의 부모 유전자풀 생성
end

for i = 1 : poolnumber
    CPOinput(P{i},G,i); % 부모해들의 input file 작성
end


system('CPOMultitest.bat');  % batch file로 CPO 실행
for i = 1 : poolnumber
    filename = sprintf('C:/Users/CPO/Desktop/2016_Juho/Data/R%d.dat',i);
    initPB(i) = junctionpotbarr(HeaderTruncate(filename));
    initPB(i).junction = P{i};% potential barrier를 계산합니다.
    fclose('all');
end

for i = 1 : poolnumber
    currentpotbarr(i)= initPB(i).potbarr;
end

delete('C:/Users/CPO/Desktop/2016_Juho/CPOinput/CPOinput*.dat');
delete('C:/Users/CPO/Desktop/2016_Juho/Data/R*.dat');
delete('C:/Users/CPO/Desktop/2016_Juho/Data/H*.dat');
delete('C:/Users/CPO/Desktop/2016_Juho/Data/H*.yyy');
delete('C:/Users/CPO/Desktop/2016_Juho/Data/H*.yzz');
delete('C:/Users/CPO/Desktop/2016_Juho/Data/H*.yxx');


for loop = 1 : loopnumber
    
    
    sequence = Roulettewheel(currentpotbarr,selectnumber);
    
    for i = 1 : selectnumber/2
        C{i} = genecross_740_740(P{sequence(2*i-1)},P{sequence(2*i)});
        M{i} = genemutant_740_740(C{i});
    end
    
    for i = 1 : selectnumber/2
        CPOinput(M{i},G,i); % 자식해의 input file 작성
    end
    
    system('CPOMultitest1_1.bat');  % batch file로 CPO 실행
    
    
    fclose('all');
    
    for i = 1 : selectnumber/2 % save information of offsprings
        filename = sprintf('C:/Users/CPO/Desktop/2016_Juho/Data/R%d.dat',i);
        MB(i) = junctionpotbarr(HeaderTruncate(filename));
        MB(i).junction = M{i}; 
    end
    
    fclose('all');
    
    for i = 1 : selectnumber/2 % replacement operation
        if currentpotbarr(sequence(2*i-1))>MB(i).potbarr
            num_replaced = sequence(2*i-1);
            replacement = 1;
        else if currentpotbarr(sequence(2*i))>MB(i).potbarr
            num_replaced = sequence(2*i);
            replacement = 1;
            else replacement = 0;
            end
        end
        
        if replacement == 1
        P{num_replaced} = MB(i).junction; % replacement
        
        logpotbarr(loop,num_replaced) = MB(i).potbarr;
        logjunction{loop,num_replaced} = MB(i).junction;
        gcf = imagesc(MB(i).junction,[0 1]);
        JunctionImagename=sprintf('C:/Users/CPO/Dropbox/2016졸프_이온트랩/Junction_Evolution_Algorithm/figures/junction%d_%d.jpg',loop,num_replaced);
        saveas(gcf,JunctionImagename);
        if isstruct(MB(i).graph)
            I=fnplt((MB(i).graph));
            % loggraph(loop,sequence(i)) = PB(i).graph;
%             logpotbarrmean(loop,sequence(num_replaced))=diff(fnval(fnint(MB(i).graph),[-170 170]))/340;
        else
            I =1;
        end
        if size(I,1)==2
            Image = figure();
            plot(I(1,:),I(2,:));
            axis([-250 250 0 0.25]);
            xlabel('Distance from center of junction trap (um)');
            ylabel('Ion potential (eV)');
            Imagename=sprintf('C:/Users/CPO/Dropbox/2016졸프_이온트랩/Junction_Evolution_Algorithm/figures/potbarrgraph%d_%d.jpg',loop,num_replaced);
            saveas(Image,Imagename);
            close all;
        end
        end
        
    end
    
    
    
    for i = 1 : poolnumber
        if (logpotbarr(loop,i) ~= inf) && (logpotbarr(loop,i) ~= 0)
                currentpotbarr(i) = logpotbarr(loop,i); % inf, 0 둘 모두 아닌 경우 potbarr을 업데이트
        end
    end
    
    
    fclose('all');
    delete('C:/Users/CPO/Desktop/2016_Juho/CPOinput/CPOinput*.dat');
    delete('C:/Users/CPO/Desktop/2016_Juho/Data/R*.dat');
    delete('C:/Users/CPO/Desktop/2016_Juho/Data/H*.dat');
    delete('C:/Users/CPO/Desktop/2016_Juho/Data/H*.yyy');
    delete('C:/Users/CPO/Desktop/2016_Juho/Data/H*.yzz');
    delete('C:/Users/CPO/Desktop/2016_Juho/Data/H*.yxx');
end

save('C:/Users/CPO/Dropbox/2016졸프_이온트랩/Junction_Evolution_Algorithm/figures/matlab.mat');