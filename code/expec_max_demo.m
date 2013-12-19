% em demo

coins=imread('Images/coins.png');
tol = 10^(-6)/3;

disp('Coins:')
figure('Name','coins.png','NumberTitle','off')
imshow(coins)

maskOut = em(coins,3 ,20,tol,1,5,4); 
figure('Name','Coins 3-20','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(coins,3 ,75,tol,1,5,4); 
figure('Name','Coins 3-75','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(coins,3 ,150,tol,1,5,4); 
figure('Name','Coins 3-150','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(coins,3 ,300,tol,1,5,4); 
figure('Name','Coins 3-300','NumberTitle','off')
imshow(maskOut, [])



football=imread('Images/football.jpg');
tol = 10^(-6);

disp('Football:')
figure('Name','football.jpg','NumberTitle','off')
imshow(football)

maskOut = em(football,10 ,1000,tol*1000,1,5,4); 
figure('Name','Football tol=10e-3','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(football,10 ,1000,tol*100,1,5,4); 
figure('Name','Football tol=10e-4','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(football,10 ,1000,tol*10,1,5,4); 
figure('Name','Football tol=10e-5','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(football,10 ,1000,tol,1,5,4); 
figure('Name','Football tol=10e-6','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(football,10 ,1000,tol/10,1,5,4); 
figure('Name','Football tol=10e-7','NumberTitle','off')
imshow(maskOut, [])


peppers=imread('Images/peppers.png');
tol = 10^(-6);

disp('Peppers:')
figure('Name','peppers.png','NumberTitle','off')
imshow(peppers)

maskOut = em(peppers,2 ,1000,tol,1,5,4); 
figure('Name','Peppers 2','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(peppers,5 ,1000,tol,1,5,4); 
figure('Name','Peppers 5','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(peppers,10,1000,tol,1,5,4); 
figure('Name','Peppers 10','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(peppers,15,1000,tol,1,5,4); 
figure('Name','Peppers 15','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(peppers,20,1000,tol,1,5,4); 
figure('Name','Peppers 20','NumberTitle','off')
imshow(maskOut, [])



truck=imread('Images/truck.gif');
tol = 10^(-6);

disp('Truck:')
figure('Name','truck.gif','NumberTitle','off')
imshow(truck)

maskOut = em(truck,2 ,1000,tol,0,5,4); 
figure('Name','Truck 2','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(truck,5 ,1000,tol*100,0,5,4); 
figure('Name','Truck 5','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(truck,10,1000,tol*100,0,5,4); 
figure('Name','Truck 10','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(truck,15,1000,tol*1000,0,5,4); 
figure('Name','Truck 15','NumberTitle','off')
imshow(maskOut, [])

maskOut = em(truck,20,1000,tol*1000,0,5,4); 
figure('Name','Truck 20','NumberTitle','off')
imshow(maskOut, [])

