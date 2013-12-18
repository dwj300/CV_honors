function mean_shift_demo()
    clear;
    % Football.jpg
    filename = 'images/football.jpg';
    I = imread(filename);
    figure, imshow(I);
    S = ms(I, 20, 20, 20);
    figure, imshow(S);
    title('Mean Shift - hs = 20, hr = 20, M = 10');
    S = ms(I, 5, 5, 10);
    figure, imshow(S);
    title('Mean Shift - hs = 5, hr = 5, M = 10');
    S = ms(I, 50, 50, 50);
    figure, imshow(S);
    title('Mean Shift - hs = 50, hr = 50, M = 50');
    
    % coins.png
    filename = 'images/coins.png';
    I = imread(filename);
    figure, imshow(I);
    S = ms(I, 11, 11, 11);
    figure, imshow(S);
    title('Mean Shift - hs = 11, hr = 11, M = 11');
    S = ms(I, 4, 4, 4);
    figure, imshow(S);
    title('Mean Shift - hs = 4, hr = 4, M = 4  ');
    S = ms(I, 40, 40, 25);
    figure, imshow(S);
    title('Mean Shift - hs = 40, hr = 40, M = 25');
    
    % peppers.png
    filename = 'images/peppers.png';
    I = imread(filename);
    figure, imshow(I);
    S = ms(I, 25, 25, 25);
    figure, imshow(S);
    title('Mean Shift - hs = 25, hr = 25, M = 25');
    S = ms(I, 8, 8, 8);
    figure, imshow(S);
    title('Mean Shift - hs = 8, hr = 8, M = 8');
    S = ms(I, 50, 50, 50);
    figure, imshow(S);
    title('Mean Shift - hs = 50, hr = 50, M = 50');
    
    % truck.gif
    filename = 'images/truck.gif';
    I = imread(filename);
    figure, imshow(I);
    S = ms(I, 11, 11, 10);
    figure, imshow(S);
    title('Mean Shift - hs = 11, hr = 11, M = 10');
    S = ms(I, 4, 4, 5);
    figure, imshow(S);
    title('Mean Shift - hs = 4, hr = 4, M = 5');
    S = ms(I, 23, 23, 25);
    figure, imshow(S);
    title('Mean Shift - hs = 23, hr = 23, M = 25');
  end
