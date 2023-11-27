clc;
clear;
close all;

filename = 'images/4cam_auth/canong3_02_sub_08.tif';
img = imread(filename);
img = uint8(rgb2gray(img));
noisy_img = getNoisyImage(img);
imshow(img);
figure; imshow(noisy_img);

function noisy_img = getNoisyImage(img)
    noisy_img = double(img);
    noise = zeros(size(img));
    [w, h] = size(img);

    for i = 1:w
        for j = 1:h
            if ((i-w/2)^2 + (j-h/2)^2 > (min(w, h)/8)^2 && (i-w/2)^2 + (j-h/2)^2 < (min(w, h)/3)^2)
                noise(i, j) = 50*randn(1, 1);
                noisy_img(i, j) = noisy_img(i, j)+noise(i, j);
            end
        end
    end
    noisy_img = uint8(noisy_img);
end

