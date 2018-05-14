function D=downfunction(HR)
HR=double(HR);
[rowX, colX] = size(HR(:,:,1));

D = sparse((rowX/2)*(colX/2),(rowX)*(colX));
rowD = 0;
for i = 1:2:rowX;
    for j = 1:2:colX;
        colD = colX*(i-1)+j;
        rowD = rowD+1;
        D(rowD,colD) = 1;
    end
end
end

