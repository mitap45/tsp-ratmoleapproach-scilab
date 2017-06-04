//  Muratcan İTAP Sezgisel yöntemler ve uygulamaları dersi projesi
//  Alınan şehrin o fare tarafından ziyaret edilip edilmediğinin belirlendiği fonksiyon

function state = is_visited(MolesMat, i, p, n)
    state = %f;
    for j=2:n
        if MolesMat(i,j) == p then
            state = %t;
        end
    end
endfunction
