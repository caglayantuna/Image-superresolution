function [B]=blur2(Hr)

test_mask=(1/16)*[1,2,1;
           1,4,1;
           1,2,1];

[row_tmat col_tmat band]=size(Hr);
Blur_matrix = sparse(row_tmat*col_tmat,row_tmat*col_tmat);

template = single(toeplitz_generator(1,2,3,row_tmat));
for m = 1 : row_tmat
    for n = 1 : row_tmat
        if template(m,n) ~= 0
            t = template(m,n);
            Blur_matrix(col_tmat*(m-1)+1:col_tmat*(m), col_tmat*(n-1)+1:col_tmat*(n)) = toeplitz_generator(test_mask(t,1),test_mask(t,2),test_mask(t,3),col_tmat);
        end
    end
B=Blur_matrix;
end