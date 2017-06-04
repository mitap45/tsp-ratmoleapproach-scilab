//  Muratcan İTAP Sezgisel yöntemler ve uygulamaları dersi projesi
//  Farelerin tur uzunluklarının bulunup küçükten büyüğe sıralandığı fonksiyon

function B = moles_tour_length(MolesMat, RealDistanceMat, n)
    A = zeros(n,2);
    //Her farenin toplam tur uzunluğu bulunuyor.
    for i=1:n
        sum = 0
        for j=1:n-1
            sum = sum + RealDistanceMat( MolesMat(i,j), MolesMat(i,j+1));
        end
        A(i,1) = sum;
        A(i,2) = i;
    end
    //Tur uzunluğuna göre artan sıralama yapılıyor.
    B=gsort(A,'lr','i')
    
endfunction
