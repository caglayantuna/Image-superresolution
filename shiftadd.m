function SR=shiftadd(s,nrofim);
[row col band]=size(s{1});
SR=zeros(2*row,2*col,band);
if nrofim<4;
for i=1:band;
       SR(1:2:2*row-1,1:2:2*col-1,i)=s{1}(:,:,i);
       SR(2:2:2*row,2:2:2*col,i)=s{1}(:,:,i);
      SR(1:2:2*row-1,2:2:2*col,i)=s{2}(:,:,i);
       SR(2:2:2*row,1:2:2*col-1,i)=s{3}(:,:,i);
end
       else;
    for i=1:band;
       SR(1:2:2*row-1,1:2:2*col-1,i)=s{1}(:,:,i);
       SR(2:2:2*row,2:2:2*col,i)=s{3}(:,:,i);
      SR(1:2:2*row-1,2:2:2*col,i)=s{2}(:,:,i);
       SR(2:2:2*row,1:2:2*col-1,i)=s{4}(:,:,i);
    end
end

end