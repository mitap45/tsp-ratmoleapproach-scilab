//  Muratcan İTAP Sezgisel yöntemler ve uygulamaları dersi projesi
//  bir fareye ait en yakın q adet şehrin ziyaret edilmeyen şehirler arasından seçilmesini yapan fonksiyon

function Closess = closes(DistanceMat, index, q, n)
    Closes = repmat(DistanceMat, 1);
    count = 1;
    Closess = zeros(q,1);
    for i=1:q
        minPlace=1;
        minValue = %inf;
        for j=1:n
            if(Closes(index, j) < minValue) &  Closes(index, j)~=0 then
                minPlace = j;
                minValue = Closes(index, j);
            end
        end
        Closes(index, minPlace) = %inf;
        Closess(count,1) = minPlace;
        count = count + 1;
    end
endfunction
