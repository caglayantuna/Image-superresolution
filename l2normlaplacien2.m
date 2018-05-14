function [l2norm2]=l2normlaplacien2(s,W,nrofim);
initial=imresize(s{1},2,'bicubic');
[row col band]=size(initial);
[initialvector lr]=preparetoreconstruction(s,nrofim,initial);
for i=1:band
lowresvec=lr(:,i);
iter=0;
max_iter=30;
operatormask=[1,-2,1;-2,5,-2;1,-2,1];
 L=laplacienoperator(initial(:,:,i),operatormask);
while iter < max_iter
     initialvector(:,i)=initialvector(:,i)+0.01*W'*(W*initialvector(:,i)-lowresvec)+0.001*L*initialvector(:,i);
     iter=iter+1;
end
sr(:,:,i)=reshape(real(initialvector(:,i)),col,row)';
l2norm22(:,:,i) = medfilt2(sr(:,:,i),[3 3]);
l2norm2(:,:,i)=l2norm22(2:end-1,2:end-1,i);
end
end