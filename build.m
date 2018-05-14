clear all; close all; clc;

test_mask = single(-1 * ones(3,3));
test_mask(2,2) = 8;
test_matrix = single(reshape(1:24,6,4)')

[row_tmask,col_tmask] = size(test_mask);
[row_tmat,col_tmat] = size(test_matrix);


Blur_matrix = single(zeros(row_tmat*col_tmat,row_tmat*col_tmat));

template = single(toeplitz_generator(1,2,3,row_tmat))

for m = 1 : row_tmat
    for n = 1 : row_tmat
        if template(m,n) ~= 0
            t = template(m,n);
            Blur_matrix(col_tmat*(m-1)+1:col_tmat*(m), col_tmat*(n-1)+1:col_tmat*(n)) = toeplitz_generator(test_mask(t,1),test_mask(t,2),test_mask(t,3),col_tmat);
        end
    end
end


%% test scheme

result1 = filter2(test_mask, test_matrix)

test_vector = reshape(test_matrix',row_tmat*col_tmat,1);

result2_vector = Blur_matrix * test_vector;

result2 = reshape(result2_vector,col_tmat,row_tmat)'