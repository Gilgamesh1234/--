function out = HeaderTruncate(filename);
out = [];
len = 1000000; % Pre-allocation for speed up
part = zeros(6, len);
ipart = 0;
fid = fopen(filename, 'r');
if fid < 0, error('Cannot open file'); end
while 1  % Infinite loop
  s = fgets(fid);
  if ischar(s)
    data = sscanf(s, '%f %f %f %f %f %f',6);
    if length(data) == 6
      ipart = ipart + 1;
      part(:, ipart) = data;
      if ipart == len
        out = cat(2, out, part);
        ipart = 0;
      end
    end
  else  % End of file:
    break;
  end
end
out = cat(2, out, part(:, 1:ipart));
out = out';
out(1,:) = []; % �����κ��� coordinate space�̹Ƿ� ����
end
%% Example

%% rfRaw = HeaderTruncate('RF_rail_elec_field.dat');
%% HeaderTruncate�� �μ��� ����
%% .dat������ ���� â '���� ����' �ȿ� �־�� �մϴ�

