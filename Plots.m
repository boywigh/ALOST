figure
for i=1:4

    imshow(M,[]);

rect = getrect;
I=imcrop(I1,rect);
I5=imcrop(MINDI,rect);
I6=imcrop(MINDL,rect);
I7=imcrop(MINDP,rect);
I8=imcrop(MINDA,rect);
rmse1(i,1) = RMSE(I(:), I5(:));
rmse1(i,2) = RMSE(I(:), I6(:));
rmse1(i,3) = RMSE(I(:), I7(:));
rmse1(i,4) = RMSE(I(:), I8(:));
DiceCoef(i,1) = DC(I, I5);
DiceCoef(i,2) = DC(I, I6);
DiceCoef(i,3) = DC(I, I7);
DiceCoef(i,4) = DC(I, I8);

%%


end
%DiceCoef=rmse1;
st={'r','g','b','y','k','m','c'};
figure(20),
for i=1:4
hold on
    plot(rmse1(:,i),st{i});
end

grid on
xlabel('Search region');
ylabel('RMSE value');
legend('MIND I','MIND MP','MIND PC','ALOST');

figure(21),
DiceCoef=DiceCoef/max(DiceCoef(:));
for i=1:4
hold on
    plot((DiceCoef(:,i)+0.1)/max(DiceCoef(:,i)),st{i});
%plot(DiceCoef(:,i),st(i));
end

grid on
xlabel('Search region');
ylabel('Average DC value');
legend('MIND','MIND MP','MIND PC','ALOST');



figure(22),
descrip={'MIND' 'MIND_MP' 'MIND PC' 'ALOST'};
boxplot(DiceCoef,descrip);
%for i=1:4
%hold on
%    plot((DiceCoef(:,i)+0.1)/max(DiceCoef(:,i)),st{i});
%end

grid on
xlabel('Descriptors');
ylabel('Dice Coefficients');
