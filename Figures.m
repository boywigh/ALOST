figure('Name','Features Used in Registration');
subplot(1,3,1), imshow(I1,[]); title('Moving Image');
subplot(1,3,2), imshow(LP(:,:,1,1),[]); title('Local Phase');
subplot(1,3,3), imshow(PC,[]); title('Phase Congurency');

figure('Name','Registerd Images');
subplot(2,3,1), imshow(I1,[]); title('Moving Image');
subplot(2,3,2), imshow(I2,[]); title('Reference Image');
subplot(2,3,3), imshow(MINDI,[]); title('MIND I');
subplot(2,3,4), imshow(MINDL,[]); title('MIND MP');
subplot(2,3,5), imshow(MINDP,[]); title('MIND PC');
subplot(2,3,6), imshow(MINDA,[]); title('ALOST');

figure('Name','Difference in Registerd Images');
subplot(2,3,1), imshow(I1,[]); title('Moving Image');
subplot(2,3,2), imshow(I2,[]); title('Reference Image');
subplot(2,3,3), imshow(I2-MINDI,[]); title('MIND I');
subplot(2,3,4), imshow(I2-MINDL,[]); title('MIND MP');
subplot(2,3,5), imshow(I2-MINDP,[]); title('MIND PC');
subplot(2,3,6), imshow(I2-MINDA,[]); title('ALOST');
