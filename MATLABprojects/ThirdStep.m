function flipped_img = flip_vertical(img)
    [rows, ~] = size(img);
    flipped_img = img(rows:-1:1, :);
end

function flipped_img = flip_horizontal(img)
    [~, cols] = size(img);
    flipped_img = img(:, cols:-1:1);
end

function negative_img = negative_image(img)
    negative_img = 255 - img;
end

function swapped_img = swap_red_green(img)
    swapped_img = img;
    swapped_img(:,:,1) = img(:,:,2); 
    swapped_img(:,:,2) = img(:,:,1); 
end

function averaged_img = average_with_mirror(img)
    mirror_img = flip_horizontal(img);
    averaged_img = (double(img) + double(mirror_img)) / 2;
    averaged_img = uint8(averaged_img); 
end

function out = random_add_subtract(img)
    rand_val = randi([-255, 255]); 
    out = double(img) + rand_val;  
    out = max(min(out, 255), 0);   
    out = uint8(out);
end

clc; clear; close all;

img = imread('araba.jpeg'); 

if size(img,3) == 3
    img = rgb2gray(img); 
end


color_img = imread('araba.jpeg');

img_flip_v = flip_vertical(img);
img_flip_h = flip_horizontal(img);
img_negative = negative_image(img);
color_swap = swap_red_green(color_img);
img_avg_mirror = average_with_mirror(img);
img_random = random_add_subtract(img);

figure;

subplot(2,3,1), imshow(img_flip_v), title('Flipped Vertically');
subplot(2,3,2), imshow(img_flip_h), title('Flipped Horizontally');
subplot(2,3,3), imshow(img_negative), title('Negative Image');
subplot(2,3,4), imshow(color_swap), title('Swapped Red & Green');
subplot(2,3,5), imshow(img_avg_mirror), title('Averaged with Mirror');
subplot(2,3,6), imshow(img_random), title('Random Add/Subtract');