function T = toeplitz_generator(a,b,c,n)

T=toeplitz([b,a,zeros(1,n-2)],[b,c,zeros(1,n-2)]);
end