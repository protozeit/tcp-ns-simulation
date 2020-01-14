#                                                                                                                    # Copyright (C) 2001 by USC/ISI                                                                                      # All rights reserved.                                                                                               #                                                                                                                    # Redistribution and use in source and binary forms are permitted                                                    # provided that the above copyright notice and this paragraph are                                                    # duplicated in all such forms and that any documentation, advertising                                               # materials, and other materials related to such distribution and use                                                # acknowledge that the software was developed by the University of                                                   # Southern California, Information Sciences Institute.  The name of the                                              # University may not be used to endorse or promote products derived from                                             # this software without specific prior written permission.                                                           #                                                                                                                    # THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED                                               # WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF                                               # MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.                                                              #                                                                                                                                                                                                                                         # @(#) $Header: /cvsroot/nsnam/ns-2/tcl/ex/udpdata.tcl,v 1.1 2001/11/20 21:46:38 buchheim Exp $ (USC/ISI)                                                                                                                                 #                                                                                                                    #  This is a simple demonstration of how to send data in UDP datagrams                                               #    
#

set ns [new Simulator]

$ns color 1 Yellow
$ns color 2 Green

# open trace files
set f [open out.tr w]
$ns trace-all $f
set nf [open out.nam w]
$ns namtrace-all $nf


# create topology
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link $n2 $n3 1.5Mb 20ms DropTail

# set Queue Size 
$ns queue-limit $n2 $n3 10

# node position (for NAM)
$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient right

$ns duplex-link-op $n2 $n3 queuePos 0.5

# setup a TCP connection 
set tcp [new Agent/TCP] 
$tcp set class_ 2
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink
$ns connect $tcp $sink
$tcp set fid_ 1

set ftp [new Application/Traffic/CBR]
$ftp attach-agent $tcp
$ftp set type_ CBR

# setup a UDP connection
set udp [new Agent/UDP]
$ns attach-agent $n1 $udp
set null [new Agent/Null]
$ns attach-agent $n3 $null
$ns connect $udp $null
$udp set fid_ 2

set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set type_ CBR
$cbr set packet_size_ 1000
$cbr set rate_ 1mb
$cbr set random_ false

# Schedule events
$ns at 0.1 "$cbr start"
$ns at 1.0 "$ftp start"
$ns at 4.0 "$ftp stop"
$ns at 4.5 "$cbr stop"

$ns at 5.0 "finish"

proc finish {} {
    global ns f nf
    $ns flush-trace

    close $f
    close $nf
    puts "running nam..."
    exec nam out.nam &
    exit 0
}

#Run the simulation
$ns run
