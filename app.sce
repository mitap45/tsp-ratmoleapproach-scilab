//  Muratcan İTAP Sezgisel yöntemler ve uygulamaları dersi projesi
//  Kör fare algoritmasının GSP (Gezgin Satıcı Problemi) problemi üzerinde uygulanması.
//  Uygulamanın ana fonksiyonu bu dosyasır.

//çalışma boyunce geçen süre
timer();

funcprot(0);
//örnek olarak tur listeleri.
filenames = ['wi29.tsp'];
//filenames = ['dj38.tsp'];
//filenames = ['berlin52.tsp'];


//Dizindeki bütün fonksiyonlar getd() komutuyla yükleniyor.
getd();

//tsp dosyası okunuyor.
[TSP_Cycle,TSPSize,TSPComment] = read_tsp(filenames(1));

//Mesafe matrisi oluşturuluyor.
DistanceMat = compute_tsp_dist(TSP_Cycle);

//fareler şehirlere yerleştirilip ilk ziyaret yerleri kendileri olacak şekilde ayarlanıyor.
MolesMat = place_moles(TSP_Cycle);

//fare matirisinin kopyası alınıyor.
FakeMolesMat = repmat(MolesMat, 1);;

//Signal matrisi oluşturulup başlangıç değerleri atanıyor.
SignalMat = init_signal(TSP_Cycle);

//katsayı matrisi oluşturuluyor.
CoefficientMat = coefficient_signal(TSP_Cycle);

//gidilecek iki şehir en yakın q adet şehir arasından seçiliyor. Denemelerle en iyi değerin bu olduğuna karar verilmiş.
q = 8;

//sinyal kayıp katsayısı Denemelerle en iyi değerin bu olduğuna karar verilmiş.
w = 1300;

//sabit sinyal ekleme değeri Denemelerle en iyi değerin bu olduğuna karar verilmiş.
v=12;

//uzaklık matrisinin kopyası alınıyor.
RealDistanceMat = repmat(DistanceMat, 1);

//durdurma koşulu 10 iterasyon olarak belirlenmiştir.
for iterasyon=1:5
    //uzaklık ve fare matrislerinin kopyası alınıyor.
    MolesMat = repmat(FakeMolesMat, 1);
    DistanceMat = repmat(RealDistanceMat, 1);
    
    //her fare için gideceği şehirler belirleniyor.
    for i = 1:TSPSize
        counter=2;
        //Tur tamamlanana kadar en yakın q adet şehirden iki tanesi seçiliyor
        while MolesMat(i,TSPSize)==0,
            //fareye ait ziyaret edilmemiş şehirlerden q adet en yakını bulunuyor ve ClosesMat matrisine atılıyor.
            ClosesMat = closes(DistanceMat, i, q, TSPSize);
            maxValue = -%inf;
            MaxPlaces = [0;0];
            //Bulunan q adet şehirden formile göre bir çift seçiliyor.
            for j=1:q
                for h=1:q
                    //seçilen ikilinin aynı olmaması ve ziyaret edilmemiş olmasının kontrolü yapılıyor.
                    if (j~=h) & (is_visited(MolesMat,i,MaxPlaces(1,1), TSPSize)) & (is_visited(MolesMat,i,MaxPlaces(2,1), TSPSize)) then
                        value = SignalMat(i,j) - (RealDistanceMat(i,j)^2/SignalMat(i,j))*CoefficientMat(i,j) + SignalMat(j,h) - (RealDistanceMat(j,h)^2/SignalMat(j,h))*CoefficientMat(j,h);
                        if value > maxValue then
                            maxValue = value;
                            MaxPlaces =[ClosesMat(j,1);ClosesMat(h,1)];
                        //eşitse i. noktaya(faraeye) toplam uzaklığı az olan ikili seçilir.
                        elseif value == maxValue then
                            sumDistance = RealDistanceMat(i,j) + RealDistanceMat(i,h);
                            sumDistanceMax = RealDistanceMat(i,MaxPlaces(1,1)) + RealDistanceMat(i,MaxPlaces(2,1));
                            if sumDistance < sumDistanceMax then
                                maxValue = value;
                                MaxPlaces =[ClosesMat(j,1);ClosesMat(h,1)];
                            end
                        end
                    end
                end
            end
            
            //seçilenlerin tekrar seçilmemesi için uzaklık matrisi güncelleniyor.
            DistanceMat(i,MaxPlaces(1,1)) = 0;
            DistanceMat(i,MaxPlaces(2,1)) = 0;
            
            //seçilen ikili ziyaret edilen matris listesine alınıyor.
            MolesMat(i,counter) = MaxPlaces(1,1);
            MolesMat(i,counter+1) = MaxPlaces(2,1);
            counter=counter+2;
                
            //end
            
        end
        
    end
    
    //her farenin tur uzunlukları bulunup küçükten büyüğe sıralanıyor.
    TourLengthMat = moles_tour_length(MolesMat, RealDistanceMat, TSPSize);
    
    //sinyaller formüle göre güncelleniyor.
    SignalMat = update_signal(SignalMat, RealDistanceMat, w, TSPSize);

    //en kısa turu yapan farenin gitttiği yolun sinyalleri güncelleniyor.
    for c=1:TSPSize
        SignalMat(TourLengthMat(1,2),c) = SignalMat(TourLengthMat(1,2),c) + v;
    end

end

//en kısa tur ve en kısa turu yapan farenin gösterilmesi.
printf('En kısaturu yapan fare : %d. fare \nEn kısa tur uzunluğu: %f', TourLengthMat(1,2), TourLengthMat(1,1));

//Geçen süre
time = timer();
