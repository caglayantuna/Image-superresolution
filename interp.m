function int=interp(s,nrofim);
[row col band]=size(s{1});

for i=1:nrofim
  for l=1:band
  int{i}(:,:,l)=imresize(s{i}(:,:,l),2,'bicubic');
  end
end
 end