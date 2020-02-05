x = [0 2 4 6 8 10 12 14 16 18 20 22 24];
y = [59 56 53 54 60 67 72 74 75 74 70 65 61];
z = lagrange(x, y, 11);
hold on 
scatter(x, y);
plot(11, z, 'or');