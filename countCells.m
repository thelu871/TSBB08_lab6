im = double(imread('blod256.tif'));

binvect = [0:1:255];
histo = hist(im(:), binvect);
figure(1);plot(binvect, histo, '.-b');
axis tight; title('histogram')

figure(2);colormap(gray(256))
subplot(2,3,1), imagesc(im, [0 255]);
axis image; title('image nuf0c'); colorbar

T1=75;
thresh1=im>T1;
subplot(2,3,2), imagesc(thresh1, [0 1]);%b
axis image; colorbar
title('thresholded image 1');

T2=55;
thresh2=im>T2;
subplot(2,3,3), imagesc(thresh2, [0 1]);%c
axis image; colorbar
title('thresholded image 2');
SE=[1 1 1; 1 1 1; 1 1 1];
b=thresh1;
c=thresh2;
e=zeros(128);

while ~isequal(b,e)
    e= b;
    d=imdilate(b,SE);
    b=d.*c;
end
figure(2)
%remove no blood cells
noBloodCell=bwareaopen(b, 50);
subplot(2,3,4), imagesc(noBloodCell, [0 1]);
axis image; colorbar
title('Remove no blood cells');

%fill cell
fill=imfill(noBloodCell,'holes');
subplot(2,3,5), imagesc(fill, [0 1]);
axis image; colorbar
title('Fill in holes');
%count
CC = bwconncomp(fill,4);
Num=CC.NumObjects

