function [L]=laplacienoperator(Hr,mask) 
        
[row_tmat col_tmat]=size(Hr);
Laplacien = sparse(row_tmat*col_tmat,row_tmat*col_tmat);

template = single(toeplitz_generator(1,2,3,row_tmat));
for m = 1 : row_tmat
    for n = 1 : row_tmat
        if template(m,n) ~= 0
            t = template(m,n);
            Laplacien(col_tmat*(m-1)+1:col_tmat*(m), col_tmat*(n-1)+1:col_tmat*(n)) = toeplitz_generator(mask(t,1),mask(t,2),mask(t,3),col_tmat);
        end
    end
L=Laplacien;
end