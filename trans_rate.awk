#!/usr/bin/awk -f

BEGIN {
        sendLine = 0;
        recvLine = 0;
        fowardLine = 0;
}
 
$0 ~/^s.* AGT.* tcp/ {
        sendLine ++ ;
}
 
$0 ~/^r.* AGT.* tcp/ {
        recvLine ++ ;
}
 
$0 ~/^f.* RTR.* tcp/ {
        fowardLine ++ ;
}
 
END {
        printf "s:%d r:%d, r/s Ratio:%.4f, f:%d \n", sendLine, recvLine, (recvLine/sendLine),fowardLine;
}
