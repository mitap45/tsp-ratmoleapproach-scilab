//  Muratcan İTAP Sezgisel yöntemler ve uygulamaları dersi projesi
//  Sinyal iletim katsayıları matrisinin oluşturulmasını yapan fonksiyon
//  Minimum ve Maximum değerler arasından rastgele seçilmiştir.
//  Minimum ve Maximum değerler denemeler sonrası optimum olanları alınmıştır.

function Coefficient_Matrix = coefficient_signal(TSP_List_Town)
    RMax = 1.75;
    RMin = 0.30;
    n = size(TSP_List_Town,1);
    Coefficient_Matrix = zeros(n,n);
    //Coefficient_Matrix = grand(n,n,'unf',RMin,RMax)
    for i=1:n
        for j=1:n
            if i<j then
                Coefficient_Matrix(i,j) = grand(1,1,'unf',RMin,RMax);
            elseif i>j then
                Coefficient_Matrix(i,j) = Coefficient_Matrix(j,i);
            else
                Coefficient_Matrix(i,j) = 0;
            end
        end
    end
endfunction
