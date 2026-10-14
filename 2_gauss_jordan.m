%gauss-jordan method
A = input('Enter your coefficient matrix: ');
B = input('Enter your source vector: ');
N = length(B);
Aug = [A B];

for j = 1:N
     if Aug(j,j) == 0
        disp('Zero pivot encountered. Method cannot continue.');
        return
    end
 
    Aug(j,:) = Aug(j,:) / Aug(j,j);
  for i = [1:j-1, j+1:N]
        Aug(i,:) = Aug(i,:) - Aug(i,j) * Aug(j,:);
  end
end

x = Aug(:, end);
disp('Solution vector is ');
disp(x);

