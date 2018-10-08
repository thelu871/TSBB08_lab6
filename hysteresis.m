nuf = double(imread('nuf0c.tif'));
binvect = [0:1:255];
histo = hist(nuf(:), binvect);
figure(1);plot(binvect, histo, '.-b');
axis tight; title('histogram')


figure(2)
colormap(gray(256))
subplot(2,2,1), imagesc(nuf, [0 255]);
axis image; title('image nuf0c'); colorbar


T1=145;
im_thresh1=nuf>T1;
subplot(2,2,2), imagesc(im_thresh1, [0 1]);%b
axis image; colorbar
title('thresholded image 1');

T2=105;
im_thresh2=nuf>T2;
subplot(2,2,3), imagesc(im_thresh2, [0 1]);%c
axis image; colorbar
title('thresholded image 2');
SE=[1 1 1; 1 1 1; 1 1 1];
b=im_thresh1;
c=im_thresh2;
e=zeros(128);

while ~isequal(b,e)
    e= b;
    d=imdilate(b,SE);
    b=d.*c;
    figure(2)
    subplot(2,2,4), imagesc(b, [0 1]);
    axis image; colorbar
    title('resulted image');
    pause(0.1)
end

