function pot_barr = potbarr(Fit_func,x1,x2)

xzeros = fnzeros(fnder(Fit_func),[x1 x2]); % Fit_func�� �ش���, �ؼ����� ���Ѵ�
xzeros = xzeros(1,:); % ������ �ƴ϶� �� ���̹Ƿ� 1st row�� ����´�

%     [fmin,xL] = fnmin(Fit_func,[x1 x2]);
%     Fit_func.coefs = -Fit_func.coefs;
%     [pseudofmax,xH] = fnmin(Fit_func,[x1 x2]);
%     fmax = -pseudofmax;

    extremas = [xzeros, x1, x2];
    extremas = sort(extremas);
for i = 1 : length(extremas)-1
    
    potdiff(i) = fnval(Fit_func,extremas(i+1)) - fnval(Fit_func,extremas(i)); % ��� �ش���, �ؼ��� ���� 
    %                                                                       potential ���̸� ����
end

[pot_barr,I]= max(abs(potdiff)); % ���� ���� ū ���� potential barrier�� ����
xRight = extremas(I+1); % potential barrier�� ����� �� ���� �� ������ ��
xLeft = extremas(I); % ���� ��


end

%% Fit_func should be 1-D
%% Fit_func ������ 1-dimension �μ��� �־�� �մϴ�.

