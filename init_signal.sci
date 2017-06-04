//  Muratcan İTAP Sezgisel yöntemler ve uygulamaları dersi projesi
//  Sinyal matrisinin oluşturulduğu ve başlangıç değerlerinin atandığı fonksiyon
function Signal_Matrix = init_signal(TSP_List_Town)
    n = size(TSP_List_Town,1);
    Signal_Matrix = zeros(n,n);
    for i=1:n
        for j=1:n
            Signal_Matrix(i,j) = 500;
        end
    end
endfunction
