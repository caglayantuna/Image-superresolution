function [shiftx shifty] = estimate_shift(s,n)

h = waitbar(0, 'Shift Estimation');
set(h, 'Name', 'Please wait...');

nr = length(s);
delta_est=zeros(nr,2);
p = [n n]; % only the central (aliasing-free) part of NxN pixels is used for shift estimation
sz = size(s{1});
sz=sz(:,1:2);
S1 = fftshift(fft2(s{1})); % Fourier transform of the reference image
for i=2:nr
  waitbar(i/nr, h, 'Shift Estimation');
  S2 = fftshift(fft2(s{i})); % Fourier transform of the image to be registered
  S2(S2==0)=1e-10;
  Q = S1./S2;
  A = angle(Q); % phase difference between the two images

  % determine the central part of the frequency spectrum to be used
  beginy = floor(sz(1)/2)-p(1)+1;
  endy = floor(sz(1)/2)+p(1)+1;
  beginx = floor(sz(2)/2)-p(2)+1;
  endx = floor(sz(2)/2)+p(2)+1;
  
  % compute x and y coordinates of the pixels
  x = ones(endy-beginy+1,1)*[beginx:endx];
  x = x(:);
  y = [beginy:endy]'*ones(1,endx-beginx+1);
  y = y(:);
  v = A(beginy:endy,beginx:endx);
  v = v(:);

  % compute the least squares solution for the slopes of the phase difference plane
  M_A = [x y ones(length(x),1)];
  r = M_A\v;
  delta_est(i,:) = -[r(2) r(1)].*sz/2/pi;
%   shiftx={abs(delta_est(2,2)),abs(delta_est(3,2)),abs(delta_est(4,2))};
%   shifty={abs(delta_est(2,1)),abs(delta_est(3,1)),abs(delta_est(4,1))};
for a=2:nr
shiftx{a-1}=(delta_est(a,2));
shifty{a-1}=(delta_est(a,1));
end
end

close(h);