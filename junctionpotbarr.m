function PB = junctionpotbarr(A)


rfRaw = A;

qe = 1.60217646 * 10^(-19);
m = 1.66 * 10^(-27);
mIon = 174*m;

omegaT = 2*pi*25.38*10^6;
vRF = 250;

pPondConst = ((vRF)^2*(qe)^2)*10^6/(4*mIon*(omegaT)^2);

eRedPos = rfRaw(:,[1,2,3])*1000;
eRedE   = rfRaw(:,[4,5,6]);

for i = 1 : 1 : size(eRedE,1)
    eRedEMag(i,:) = eRedE(i,1)^2 + eRedE(i,2)^2 + eRedE(i,3)^2;
end

rfPot = pPondConst * eRedEMag * 1/qe;
rfPot = [eRedPos, rfPot];

xq = unique(rfPot(:,1));
yq = unique(rfPot(:,2));
zq = unique(rfPot(:,3));
index = 1;
for i = 1 : length(xq)
    for j = 1 : length(yq)
        for k = 1 : length(zq)
            rfPot_grid(i,j,k) = rfPot(index,4);
            index=index+1;
        end
    end
end


d1=61;
d2=311;
for i=d1 : d2
dataforzMin = rfPot_grid(1,i,:);   
dataforzMin = reshape(dataforzMin,1,size(dataforzMin,3));
functionforzMin(i-(d1-1)) = csapi(zq,dataforzMin);
tempzeros = fnzeros(fnder(functionforzMin(i-(d1-1))));
tempzeros = tempzeros(1,:);
if isempty(tempzeros);
   errorflag0=1;
   break;
else errorflag0=0;
end
%  tempzeros(tempzeros>60 | tempzeros<10) = [];
for j = 1 : length(tempzeros(1,:))
extremapoints(i-(d1-1),j) = tempzeros(1,j);
end
end

if errorflag0==1;
PB.potbarr = inf;
PB.junction= zeros(74,74);
PB.graph = NaN;
else 
    
extremapoints(extremapoints==0) = NaN;
extrema = [];
for i = 1 : d2-d1+1
    extrema = [extrema ;fnval(functionforzMin(i),extremapoints(i,:))];
    [zMin(i),zMinindex(i)] = min(extrema(i,:));
    zMinpoint(i) = extremapoints(i,zMinindex(i));
end

zMinpointdifference = max(zMinpoint)-min(zMinpoint);

temp3 = csapi(yq(d1:d2),zMin);

%  || (zMinpointdifference>7.5)
if (potbarr(temp3,-250,250)==inf)
    PB.potbarr = inf;
PB.junction= zeros(74,74);
PB.graph = NaN;
else
PB.potbarr = potbarr(temp3,-250,250);% !!! 최적화할 범위
PB.junction = zeros(74,74);
PB.graph = temp3;
end

end


% potential barrier 계산하는 코드를 집어넣었습니다.

end
