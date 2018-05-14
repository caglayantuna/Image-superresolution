function [F]=shiftmatrix(x,y,row,col,nrofim)

%x:motion parameters by x direction with type of cell
%y:motion parameters by y direction with type of cell
%row col: size of will be reconstructed SR image
n = row*col;
f1= speye(n,n);

%x direction
for i=1:nrofim-1
      if x{i}>0&&x{i}<1 
          ex1(1:n,1)=x{i};
     fx1{i} = spdiags(ex1, 0, n, n);
     fx2{i} = spdiags(1-ex1, 1, n, n);
     
      elseif x{i}<0&&x{i}>-1
     ex2(1:n,1)=abs(x{i});
         fx1{i} = spdiags(1-ex2, 0, n, n);
     fx2{i} = spdiags(ex2, -1, n, n);
      
      elseif x{i}<-1
     ex3(1:n,1)=abs(x{i});
         fx1{i} = spdiags(2-ex3, 0, n, n);
     fx2{i} = spdiags(ex3-1, 1, n, n);
      fy1{i}(1,:) =0; 
     fy2{i}(1,:)=0; 
   
      elseif x{i}>1
     ex4(1:n,1)=x{i};
     fx1{i} = spdiags(ex4-1, 0, n, n);
     fx2{i} = spdiags(2-ex4, -1, n, n);
     fy1{i}(n,:) =0; 
     fy2{i}(n,:)=0; 
   end
fx{i}=fx1{i}+fx2{i};
fx{i}(row+1:row:row*col,col:col:row*col)=0;
end
%y direction
for i=1:nrofim-1
     if y{i}>0&&y{i}<1
         ey1(1:n,1)=y{i};
     fy1{i} = spdiags(ey1, 0, n, n);
     fy2{i} = spdiags(1-ey1, row, n, n);
     
     elseif y{i}<0&&y{i}>-1
         ey2(1:n,1)=abs(y{i});
     fy1{i} = spdiags(1-ey2, 0, n, n);
     fy2{i}= spdiags(ey2, -col, n, n);
     
     elseif y{i}<-1
         ey3(1:n,1)=abs(y{i});
     fy1{i} = spdiags(2-ey3, -1, n, n);
     fy2{i}= spdiags(ey3-1, -col-1, n,n); 
     fy1{i}(:,1) =0; 
     fy2{i}(:,1)=0; 
     
     elseif y{i}>1
         ey4(1:n,1)=y{i};
     fy1{i} = spdiags(2-ey4,0, n, n);
     fy2{i}= spdiags(ey4-1, row, n,n); 
     end
     fy{i}=fy1{i}+fy2{i};
end
for i=1:nrofim-1
    F{i+1}=fx{i}*fy{i};
F{1}=f1;
end
end