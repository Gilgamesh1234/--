function pot_barr = potbarr(Fit_func,x1,x2)

xzeros = fnzeros(fnder(Fit_func),[x1 x2]); % Fit_func의 극댓점, 극솟점을 구한다
xzeros = xzeros(1,:); % 구간이 아니라 한 점이므로 1st row만 갖고온다

%     [fmin,xL] = fnmin(Fit_func,[x1 x2]);
%     Fit_func.coefs = -Fit_func.coefs;
%     [pseudofmax,xH] = fnmin(Fit_func,[x1 x2]);
%     fmax = -pseudofmax;

    extremas = [xzeros, x1, x2];
    extremas = sort(extremas);
for i = 1 : length(extremas)-1
    
    potdiff(i) = fnval(Fit_func,extremas(i+1)) - fnval(Fit_func,extremas(i)); % 모든 극댓점, 극솟점 간의 
    %                                                                       potential 차이를 구함
end

[pot_barr,I]= max(abs(potdiff)); % 그중 가장 큰 것을 potential barrier로 지정
xRight = extremas(I+1); % potential barrier를 만드는 두 극점 중 오른쪽 것
xLeft = extremas(I); % 왼쪽 것


end

%% Fit_func should be 1-D
%% Fit_func 형태의 1-dimension 인수를 넣어야 합니다.

