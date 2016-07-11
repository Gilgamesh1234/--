delete('C:/Users/CPO/Desktop/2016_Juho/CPOinput/CPOinput*.dat');
delete('C:/Users/CPO/Desktop/2016_Juho/Data/R*.dat');
delete('C:/Users/CPO/Desktop/2016_Juho/Data/H*.dat');
delete('C:/Users/CPO/Desktop/2016_Juho/Data/H*.yyy');
delete('C:/Users/CPO/Desktop/2016_Juho/Data/H*.yzz');
delete('C:/Users/CPO/Desktop/2016_Juho/Data/H*.yxx');


loopnumber = 1000 ; %% �����˰��� ���� Ƚ���Դϴ�.
poolnumber = 64; %% ������ Ǯ �ȿ� �ִ� �θ� ����
selectnumber = 8; %% ������ Ǯ���� ���õǴ� �θ� ����

d = 0.005; % ���簢�� ���� �ϳ��� �� ���� ����
k = 148; %% �� ���� �ִ� ������ ����
G = getgrid(k,d);

logpotbarr=zeros(loopnumber,poolnumber);
logjunction = cell(loopnumber,poolnumber);
% loggraph.graph = zeros(loopnumber,poolnumber);

for i = 1 : poolnumber
    P{i} = getjunction_740_740(k,d); % n���� �θ� ������Ǯ ����
end

for i = 1 : poolnumber
    CPOinput(P{i},G,i); % �θ��ص��� input file �ۼ�
end


system('CPOMultitest.bat');  % batch file�� CPO ����
for i = 1 : poolnumber
    filename = sprintf('C:/Users/CPO/Desktop/2016_Juho/Data/R%d.dat',i);
    initPB(i) = junctionpotbarr(HeaderTruncate(filename));
    initPB(i).junction = P{i};% potential barrier�� ����մϴ�.
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
        CPOinput(M{i},G,i); % �ڽ����� input file �ۼ�
    end
    
    system('CPOMultitest1_1.bat');  % batch file�� CPO ����
    
    
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
        JunctionImagename=sprintf('C:/Users/CPO/Dropbox/2016����_�̿�Ʈ��/Junction_Evolution_Algorithm/figures/junction%d_%d.jpg',loop,num_replaced);
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
            Imagename=sprintf('C:/Users/CPO/Dropbox/2016����_�̿�Ʈ��/Junction_Evolution_Algorithm/figures/potbarrgraph%d_%d.jpg',loop,num_replaced);
            saveas(Image,Imagename);
            close all;
        end
        end
        
    end
    
    
    
    for i = 1 : poolnumber
        if (logpotbarr(loop,i) ~= inf) && (logpotbarr(loop,i) ~= 0)
                currentpotbarr(i) = logpotbarr(loop,i); % inf, 0 �� ��� �ƴ� ��� potbarr�� ������Ʈ
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

save('C:/Users/CPO/Dropbox/2016����_�̿�Ʈ��/Junction_Evolution_Algorithm/figures/matlab.mat');