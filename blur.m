function [a]=blur(Hr)
[row col]=size(Hr(:,:,1));
%operator
n = row*col;
e = ones(n,1);
a1 = spdiags([e e e], -1:1, n, n);
a2 = spdiags([e e e], -row-1:-row+1, n, n);
a3 = spdiags([e e e],col-1:col+1, n, n);%blur matrix
a=a1+a2+a3;
a(1:row:n-row,col:col:n)=0;
a(row:row:n-row,2*col+1:col:n-col)=0;
a(row:row:n,col+1:col:n-col+1)=0;
a(row+1:row:n-row+1,col:col:n)=0;
a(row:row:n,1:col:n-col)=0;
a(2:row:n-row,col:col:n-col)=0;
a=a/9;
end
