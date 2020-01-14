#!/bin/bash

./reno_vegas_trans_rate.awk SANET_reno_vegas.tr
echo ;
echo -n TCP TAHOE --  ; ./trans_rate.awk SANET_tahoe.tr
echo -n TCP RENO --  ; ./trans_rate.awk SANET_reno.tr
echo -n TCP VEGAS --  ; ./trans_rate.awk SANET_vegas.tr
echo -n TCP SACK --  ; ./trans_rate.awk SANET_sack.tr
