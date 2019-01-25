%Histogram, PDF and CDF

clc;
imagergb = imread('good.png'); 
image_new = rgb2gray(imagergb); % convert color to gray
num_of_pixel=size(image_new,1)*size(image_new,2);

subplot(2,2,1);
imshow(image_new);
grid on;


histogram=zeros(256,1);
pdf=zeros(256,1);
for i=1:size(image_new,1)
    for j=1:size(image_new,2)
        value=image_new(i,j);
        histogram(value+1)=histogram(value+1)+1;
        pdf(value+1)=histogram(value+1)/num_of_pixel;
    end
end


subplot(2,2,2);
plot(histogram); 
grid on;
ylabel('no. of pixels with intensity levels---->','FontSize', 9);
xlabel('Grey level Intensity---->','FontSize', 9); 
title('Histogram of the image','FontSize', 9)

subplot(2,2,3);
plot(pdf); 
grid on;
ylabel('Relative frequency--->','FontSize', 9);
xlabel('Grey level Intensity---->','FontSize', 9); 
title('Normalized Histogram (pdf)','FontSize', 9)



% To compute cdf

probc=zeros(256,1);
sum=0;
cum=zeros(256,1);
output=zeros(256,1);
no_bins=255;

for i=1:size(pdf)
    sum=sum+histogram(i);
    cum(i)=sum;
    probc(i)=cum(i)/num_of_pixel;
    output(i)=round(probc(i)*no_bins);
end


subplot(2,2,4);
plot(probc); 
grid on;
ylabel('Cumulative Sum--->','FontSize', 9);
xlabel('Grey level Intensity---->','FontSize', 9); 
title('Cumulative Distribution Frequency','FontSize', 9)




