#!/usr/bin/awk -f

BEGIN {
        sendLineReno = 0;
        sendLineVegas = 0;
        recvLineReno = 0;
        recvLineVegas = 0;
        fowardLineReno = 0;
        fowardLineVegas = 0;
}
 
$0 ~/^s.* (_1_|_6_) AGT.* tcp/ {
        sendLineReno ++ ;
}
 
$0 ~/^s.* (_0_|_5_) AGT.* tcp/ {
        sendLineVegas ++ ;
}

$0 ~/^r.* (_1_|_6_) AGT.* tcp/ {
        recvLineReno ++ ;
}
 
$0 ~/^r.* (_0_|_5_) AGT.* tcp/ {
        recvLineVegas ++ ;
}
 
$0 ~/^f.* (_1_|_6_) RTR.* tcp/ {
        fowardLineReno ++ ;
}
 
$0 ~/^f.* (_0_|_5_) RTR.* tcp/ {
        fowardLineVegas ++ ;
}
 
END {
        printf "TCP RENO --- s:%d r:%d, r/s Ratio:%.4f, f:%d \n", sendLineReno, recvLineReno, (recvLineReno/sendLineReno),fowardLineReno;
        printf "TCP VEGAS --- s:%d r:%d, r/s Ratio:%.4f, f:%d \n", sendLineVegas, recvLineVegas, (recvLineVegas/sendLineVegas),fowardLineVegas;
}
