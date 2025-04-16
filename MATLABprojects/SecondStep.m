A = randi([0, 255], 100, 100); 

sorted_values = sort(A(:), 'descend');
figure;
plot(sorted_values);
title('Sorted Intensities');
xlabel('Pixel Index');
ylabel('Intensity');


t = 150; 
RGB = zeros(100, 100, 3, 'uint8'); 
RGB(:,:,1) = uint8(A > t) * 255; 
figure;
imshow(RGB);
title('Thresholded Red Image');

X = A(1:50, 1:50);
figure;
imshow(X, []);
title('Top Left Quadrant of A');

A_mean = mean(A(:));
A_adjusted = A - A_mean;
figure;
imshow(A_adjusted, []);
title('A with Mean Intensity Subtracted');

y = 1:12;
z = reshape(y, [4,3]);
disp('Reshaped Matrix z:');
disp(z);

v = [1 8 8 2 1 3 9 8];
x = sum(v == 8);
disp(['Number of 8s in v: ', num2str(x)]);
