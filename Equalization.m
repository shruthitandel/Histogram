clc;
%clear all;
%Equalisation

% Let's compute and display the histogram.

image_new=imread('lena_dark.png');
num_of_pixel=size(image_new,1)*size(image_new,2);


subplot(2,4,1);
imshow(image_new);
grid on;
title('Original Image before Equalization','FontSize', 9)


histogram=zeros(256,1);
pdf=zeros(256,1);
for i=1:size(image_new,1)
    for j=1:size(image_new,2)
        value=image_new(i,j);
        histogram(value+1)=histogram(value+1)+1;
        pdf(value+1)=histogram(value+1)/num_of_pixel;
    end
end


subplot(2,4,2);
plot(histogram); 
grid on;
ylabel('no. of pixels with intensity levels---->','FontSize', 9);
xlabel('Grey level Intensity---->','FontSize', 9); 
title('Histogram of the original image','FontSize', 9)


subplot(2,4,3);
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


subplot(2,4,4);
plot(probc); 
grid on;
ylabel('Cumulative Sum--->','FontSize', 9);
xlabel('Grey level Intensity---->','FontSize', 9); 
title('Cumulative Distribution Frequency','FontSize', 9)


%Histogram Equalization
histogram_equalisation=uint8(zeros(size(image_new,1),size(image_new,2)));

for i=1:size(image_new,1)
    for j=1:size(image_new,2)
            histogram_equalisation(i,j)=output(image_new(i,j)+1);
    end
end


histogram_eq_new=zeros(256,1);
pdf_new = zeros(256,1);

for i1=1:size(histogram_equalisation,1)
    for j1=1:size(histogram_equalisation,2)
        value1=histogram_equalisation(i1,j1);
        histogram_eq_new(value1+1)=histogram_eq_new(value1+1)+1;
        pdf_new(value1+1) = histogram_eq_new(value1+1)/num_of_pixel;       
    end


end

probc1=zeros(256,1);
sum1=0;
cum1=zeros(256,1);
no_bins1=255;


for i=1:size(pdf_new)
    sum1=sum1+histogram_eq_new(i);
    cum1(i)=sum1;
    probc1(i)=cum1(i)/num_of_pixel;
end

subplot(2,4,5);
imshow(histogram_equalisation);
title('Image after Equalization','FontSize', 9);

subplot(2,4,6);
plot(histogram_eq_new);
ylabel('no. of pixels with intensity levels---->','FontSize', 9);
xlabel('Grey level Intensity---->','FontSize', 9);
title('Equalized Histogram','FontSize', 9);

subplot(2,4,7);
plot(pdf_new);
ylabel('Relative Frequency--->','FontSize', 9);
xlabel('Grey level Intensity---->','FontSize', 9); 
title('Equalized Normalized Histogram(pdf)', 'FontSize', 9);

subplot(2,4,8);
plot(probc1);
ylabel('Cumulative Sum---->','FontSize', 9);
xlabel('Grey level Intensity---->','FontSize', 9); 
title('Equalized cdf','FontSize', 9 );


