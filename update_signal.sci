//  Muratcan İTAP Sezgisel yöntemler ve uygulamaları dersi projesi
//  Sinyal değerlerinin formile göre güncellenmesini yapan fonksiyon
function SignalMat = update_signal(SignalMat,RealDistanceMat, w, n)
    for i=1:n
        for j=1:n
            if i~=j then
                SignalMat(i,j) = SignalMat(i,j) - (RealDistanceMat(i,j)/w);
            end
        end
    end
endfunction
