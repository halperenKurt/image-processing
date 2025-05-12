clc;
clear;

img = imread('bird.jpeg');  
if size(img,3) == 3
    img = rgb2gray(img); 
end

% MANUAL HISTOGRAM EQUALIZATION 
function equalizedImage = customHistEqualization(image)
    image = double(image);
    [height, width] = size(image);
    total_pixels = height * width;
    intensityDist = zeros(1,256);
    for row = 1:height
        for col = 1:width
            grayLevel = image(row, col) + 1;
            intensityDist(grayLevel) = intensityDist(grayLevel) + 1;
        end
    end

    cumulative = cumsum(intensityDist);
    minNonZero = min(cumulative(cumulative > 0));
    normalizedCDF = round((cumulative - minNonZero) / (total_pixels - minNonZero) * 255);

    equalizedImage = zeros(height, width);
    for row = 1:height
        for col = 1:width
            originalVal = image(row, col) + 1;
            equalizedImage(row, col) = normalizedCDF(originalVal);
        end
    end
    equalizedImage = uint8(equalizedImage);         
end

img_eq_manual = customHistEqualization(img);

% BUILT-IN HISTOGRAM EQUALIZATION
img_eq_builtin = histeq(img);

figure('Name','Histogram Equalization');
subplot(1,3,1); imshow(img); title('Original Image');
subplot(1,3,2); imshow(img_eq_manual); title('Manual Histogram Equalization');
subplot(1,3,3); imshow(img_eq_builtin); title('Built-in Histogram Equalization');

N = 5; 
kernel = ones(N, N) / (N * N);

% MANUAL AVERAGING FILTER
[rows, cols] = size(img);
pad_size = floor(N / 2);
img_padded = padarray(double(img), [pad_size pad_size], 'replicate');
img_avg_manual = zeros(rows, cols);

for i = 1:rows
    for j = 1:cols
        region = img_padded(i:i+N-1, j:j+N-1);
        img_avg_manual(i,j) = sum(region(:) .* kernel(:));
    end
end
img_avg_manual = uint8(img_avg_manual); % Görselleştirme için dönüşüm

% BUILT-IN AVERAGING FILTER
img_avg_builtin = imfilter(img, kernel, 'replicate');

figure('Name','Averaging Filter');
subplot(1,3,1); imshow(img); title('Original Image');
subplot(1,3,2); imshow(img_avg_manual); title(['Manual Averaging Filter ', num2str(N), 'x', num2str(N)]);
subplot(1,3,3); imshow(img_avg_builtin); title('Built-in Averaging Filter');

