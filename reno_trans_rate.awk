#!/usr/bin/awk -f

BEGIN {
        sendLineReno = 0;
        recvLineReno = 0;
        fowardLineReno = 0;
}
 
$0 ~/^s.* AGT.* tcp/ {
        sendLineReno ++ ;
}
 
$0 ~/^r.* AGT.* tcp/ {
        recvLineReno ++ ;
}
 
$0 ~/^f.* RTR.* tcp/ {
        fowardLineReno ++ ;
}
 
END {
        printf "TCP RENO --- s:%d r:%d, r/s Ratio:%.4f, f:%d \n", sendLineReno, recvLineReno, (recvLineReno/sendLineReno),fowardLineReno;
}
