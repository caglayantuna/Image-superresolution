function [result]=l1btv(W,s,nrofim);
initial=imresize(s{1},2,'bicubic');
[row col band]=size(initial);
[initialvector lr]=preparetoreconstruction(s,nrofim,initial);
for i=1:band
lowresvec=lr(:,i);
iter=1;
max_iter=3;
x={0.5,-0.5};
y={0.5,-0.5};
I=speye(row*col,col*row);
S=shiftmatrix(x,y,row,col,3);
while iter < max_iter
     initialvector(:,i)=initialvector(:,i)-0.001*W'*sign(W*initialvector(:,i)-lowresvec)+(I-S{2})*sign(initialvector(:,i)-S{3}*initialvector(:,i));
     iter=iter+1;
end
sr(:,:,i)=reshape(real(initialvector(:,i)),col,row)';
huberresult2(:,:,i) = medfilt2(sr(:,:,i),[3 3]);
result(:,:,i)=huberresult2(2:end-1,2:end-1,i);
end

end