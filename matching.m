%Mapping code

clc;
M = zeros(256,1,'uint8'); %// Store mapping - Cast to uint8 to respect data type

image1 = imread('lena_dark.png'); %image with poor contrast
imagergb = imread('good.png'); % image with better quality
image2 = rgb2gray(imagergb); %Convert color to gray image

subplot(2,4,1);
imshow(image1);
title('Image with poor contast');


num_of_pixel1=size(image1,1)*size(image1,2);
num_of_pixel2=size(image2,1)*size(image2,2);

histogram1=zeros(256,1);
pdf1=zeros(256,1);

%Compute histograms of 1st Image

for i=1:size(image1,1)
    for j=1:size(image1,2)
        value1=image1(i,j);
        histogram1(value1+1)=histogram1(value1+1)+1;
        pdf1(value1+1)=histogram1(value1+1)/num_of_pixel1;
    end
end

subplot(2,4,2);
plot(histogram1);
grid on;
ylabel('no. of pixels with intensity levels---->');
xlabel('Grey level Intensity---->'); title('Histogram of Original image')
 
subplot(2,4,3);
plot(pdf1);
grid on;
ylabel('Relative frequency---->');
xlabel('Grey level Intensity---->'); title('Normalized Histogram(pdf) of Original image')

%cdf of 1st Image

cdf1=zeros(256,1);
sum1=0;
cum1=zeros(256,1);

for i=1:size(pdf1)
    sum1=sum1+histogram1(i);
    cum1(i)=sum1;
    cdf1(i)=cum1(i)/num_of_pixel1;
end

subplot(2,4,4);
plot(cdf1);
grid on;
ylabel('Cumulative Sum---->');
xlabel('Grey level Intensity---->'); title('cdf of Original image')


%// Compute histograms of 2nd Image
histogram2=zeros(256,1);
pdf2=zeros(256,1);

for x=1:size(image2,1)
    for y=1:size(image2,2)
        value2=image2(x,y);
        histogram2(value2+1)=histogram2(value2+1)+1;
        pdf2(value2+1)=histogram2(value2+1)/num_of_pixel2;
    end
 end
% subplot(2,2,2);
% plot(histogram2);
% grid on;
% ylabel('no. of pixels with intensity levels---->');
% xlabel('Grey level Intensity---->'); title('Histogram of Second image')

% subplot(2,2,3);
% plot(pdf2);
% grid on;
% ylabel('Relative frequency---->');
% xlabel('Grey level Intensity---->'); title('Normalized Histogram(pdf) of Second image')


%cdf of 2nd Image

cdf2=zeros(256,1);
sum2=0;
cum2=zeros(256,1);

for i=1:size(pdf2)
    sum2=sum2+histogram2(i);
    cum2(i)=sum2;
    cdf2(i)=cum2(i)/num_of_pixel2;
end

% subplot(2,2,4);
% plot(cdf2);
% grid on;
% ylabel('Cumulative Sum---->');
% xlabel('Grey level Intensity---->'); title('cdf of Second image')

%// Compute the mapping

for idx = 1 : 256
    [~,ind] = min(abs(cdf1(idx) - cdf2));
    M(idx) = ind-1;
end


%// Now apply the mapping to get first image to make
%// the image look like the distribution of the second image

out = M(double(image1)+1);

subplot(2,4,5);
imshow(out);
title('Adjusted First Image');

num_of_pixel_m=size(out,1)*size(out,2);
histogram_m=zeros(256,1);
pdf_m=zeros(256,1);

%// Compute histograms of Adjusted Image

for i=1:size(out,1)
    for j=1:size(out,2)
        value_m=out(i,j);
        histogram_m(value_m+1)=histogram_m(value_m+1)+1;
        pdf_m(value_m+1)=histogram_m(value_m+1)/num_of_pixel_m;
    end
end

subplot(2,4,6);
plot(histogram_m);
grid on;
ylabel('no. of pixels with intensity levels---->');
xlabel('Grey level Intensity---->'); title('Histogram of Adjusted first image')


subplot(2,4,7);
plot(pdf_m);
grid on;
ylabel('Relative frequency---->');
xlabel('Grey level Intensity---->'); title('pdf of Adjusted First image')

cdf_m=zeros(256,1);
sum_m=0;

cum_m=zeros(256,1);

for i=1:size(pdf_m)
    sum_m=sum_m+histogram_m(i);
    cum_m(i)=sum_m;
   cdf_m(i)=cum_m(i)/num_of_pixel_m;
end

subplot(2,4,8);
plot(cdf_m);
grid on;
ylabel('Cumulative Sum---->');
xlabel('Grey level Intensity---->'); title('cdf of Adjusted First image')
 

 

 

 

 

 

 

 

 

 

 