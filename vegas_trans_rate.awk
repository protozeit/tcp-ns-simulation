#!/usr/bin/awk -f

BEGIN {
        sendLineVegas = 0;
        recvLineVegas = 0;
        fowardLineVegas = 0;
}
 
$0 ~/^s.* AGT.* tcp/ {
        sendLineVegas ++ ;
}
 
$0 ~/^r.* AGT.* tcp/ {
        recvLineVegas ++ ;
}
 
$0 ~/^f.* RTR.* tcp/ {
        fowardLineVegas ++ ;
}
 
END {
        printf "TCP VEGAS --- s:%d r:%d, r/s Ratio:%.4f, f:%d \n", sendLineVegas, recvLineVegas, (recvLineVegas/sendLineVegas),fowardLineVegas;
}
