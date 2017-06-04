//  Muratcan İTAP Sezgisel yöntemler ve uygulamaları dersi projesi
//  Farelerin şehirlere yerleştirilip ilk ziyaret yerleri kendileri olacak şekilde ayarlandığı fonksiyon

function Moles_Matrix = place_moles(TSP_List_Town)
    n = size(TSP_List_Town,1);
    Moles_Matrix = zeros(n,n);
    for i=1:n
        Moles_Matrix(i,1) = i;
    end
endfunction
