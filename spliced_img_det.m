clear;
clc;
close all;

folder = 'test_images/';

for i = 9:9
    % Construct the file path for the image
    filename = [folder, num2str(i), '.png'];
    
    figure();
    % Read the image
    im = imread(filename);
    subplot(1, 2, 1); imshow(im); title("Spliced image");
    
    % Decolorize the image
    im = double(rgb2ycbcr(im));
    sigmas = get_sigmas(im);
    
    idx1 = sigmas >= 0.05;
    idx2 = sigmas < 0.05;
    sigmas(idx1) = 1;
    sigmas(idx2) = 0;
    
    se = strel('square', 16);
    sigmas1 = imdilate(sigmas, se);
    
    subplot(1, 2, 2); imshow(sigmas1); title("Detection");
end
