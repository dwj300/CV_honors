% main for em

coins=imread('coins.png');
tol = 10^(-6);

disp('Coins:')
figure('Name','coins.png','NumberTitle','off')
imshow(coins)

maskOut = em(coins,2 ,1000,tol,0,5,4); 
figure('Name','Coins 2','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(coins,5 ,1000,tol,0,5,4); 
figure('Name','Coins 5','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(coins,10 ,1000,tol,0,5,4); 
figure('Name','Coins 10','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(coins,15 ,1000,tol,0,5,4); 
figure('Name','Coins 15','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(coins,50 ,1000,tol,0,5,4); 
figure('Name','Coins 50','NumberTitle','off')
imshow(maskOut, [])



football=imread('football.jpg');
tol = 10^(-6);

disp('Football:')
figure('Name','football.jpg','NumberTitle','off')
imshow(football)

maskOut = em(football,2 ,1000,tol,0,5,4); 
figure('Name','Football 2','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(football,5 ,1000,tol,0,5,4); 
figure('Name','Football 5','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(football,10 ,1000,tol,0,5,4); 
figure('Name','Football 10','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(football,15 ,1000,tol,0,5,4); 
figure('Name','Football 15','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(football,50 ,1000,tol,0,5,4); 
figure('Name','Football 50','NumberTitle','off')
imshow(maskOut, [])


peppers=imread('peppers.png');
tol = 10^(-6);

disp('Peppers:')
figure('Name','peppers.png','NumberTitle','off')
imshow(peppers)

maskOut = em(peppers,2 ,1000,tol,0,5,4); 
figure('Name','Peppers 2','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(peppers,5 ,1000,tol,0,5,4); 
figure('Name','Peppers 5','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(peppers,10,1000,tol,0,5,4); 
figure('Name','Peppers 10','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(peppers,15,1000,tol,0,5,4); 
figure('Name','Peppers 15','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(peppers,50,1000,tol,0,5,4); 
figure('Name','Peppers 50','NumberTitle','off')
imshow(maskOut, [])

