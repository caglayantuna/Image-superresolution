function W=systemmatrix(D,B,F,nrofim)
for i=1:nrofim
W{i}=D*B*F{i};
end
W=reshape(W,nrofim,1);
W=cell2mat(W);
end