function [l2norm3]=l2normlaplacien3(s,W,nrofim);
initial=imresize(s{1},2,'bicubic');
[row col band]=size(initial);
[initialvector lr]=preparetoreconstruction(s,nrofim,initial);
for i=1:band
lowresvec=lr(:,i);
iter=0;
max_iter=6;
operatormask=[0,-1,0;-1,4,-1;0,-1,0];
 L=laplacienoperator(initial(:,:,i),operatormask);
while iter < max_iter
     initialvector(:,i)=initialvector(:,i)+0.003*W'*(W*initialvector(:,i)-lowresvec)+0.01*L*initialvector(:,i);
     iter=iter+1;
end
sr(:,:,i)=reshape(real(initialvector(:,i)),col,row)';
l2norm32(:,:,i) = medfilt2(sr(:,:,i),[3 3]);
l2norm3(:,:,i)=l2norm32(2:end-1,2:end-1,i);
end
end