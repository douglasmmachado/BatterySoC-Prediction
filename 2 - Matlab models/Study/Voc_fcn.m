function [result] = Voc_fcn(n,t, Tf, Vo)

    b = (tan(1.5)/1.8) - ((tan(-((3503.67-11.17*n)/(Tf-9.87*n)) + 1.5))/1.8);
    a = Vo  - tan(1.5)/b;
    c = pi/(Tf-9.87*n);

    result = a + tan(-t*c + 1.5)/b;