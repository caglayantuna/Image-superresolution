function [initialvector lr]=preparetoreconstruction(s,nrofim,initial)
[row col band]=size(initial);
for l=1:band
    initialvector(:,l)=reshape((initial(:,:,l))',row*col,1);
end
initialvector=double(initialvector);
s=reshape(s,nrofim,1);

for i=1:nrofim;
    for l=1:band
    a{i}(:,l)=reshape((s{i}(:,:,l))',(row/2)*(col/2),1);
    end
end
LR=cell2mat(a');
lr=double(LR);
end