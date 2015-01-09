#!/system/bin/sh
COUNTRYCODE=$(getprop $1)
FILEPATH=$2
CPACTION="no"
TLV_TYPE_A="WW"
TLV_TYPE_C="THA"

#please sync to HWVersion.h
HW_ID_EVB=7
HW_ID_SR=1
HW_ID_ER=3
HW_ID_PR=6
HW_ID_MP=5
HW_ID_RF=0

HWID_DETECT=$(cat /sys/module/intel_mid_sfi/parameters/hardware_id)

#echo "YTLI TLV_TYPE=$(TLV_TYPE),FILEPATH=$(FILEPATH),COUNTRYCODE=$(COUNTRYCODE)"
TLV_TYPE=$TLV_TYPE_A

if [ "$COUNTRYCODE" == "THA" ]; then
  CPACTION="yes"
  cp $FILEPATH/patch_nvm_$TLV_TYPE_C.tlv \
    /config/telephony/patch_nvm.tlv

elif [ "$COUNTRYCODE" == "TH" ]; then
  CPACTION="yes"
  cp $FILEPATH/patch_nvm_$TLV_TYPE_C.tlv \
    /config/telephony/patch_nvm.tlv

#elif [ "$COUNTRYCODE" == "WW" ]; then
#  CPACTION="yes"
#  cp $FILEPATH/patch_nvm_$TLV_TYPE.tlv \
#    /config/telephony/patch_nvm.tlv
#
#elif [ "$COUNTRYCODE" == "TW" ]; then
#  CPACTION="yes"
#  cp $FILEPATH/patch_nvm_$TLV_TYPE.tlv \
#    /config/telephony/patch_nvm.tlv
#
#elif [ "$COUNTRYCODE" == "JP" ]; then
#  CPACTION="yes"
#  cp $FILEPATH/patch_nvm_$TLV_TYPE.tlv \
#    /config/telephony/patch_nvm.tlv
#
#elif [ "$COUNTRYCODE" == "AU" ]; then
#  CPACTION="yes"
#  cp $FILEPATH/patch_nvm_$TLV_TYPE.tlv \
#    /config/telephony/patch_nvm.tlv
#
#elif [ "$COUNTRYCODE" == "ID" ]; then
#  CPACTION="yes"
#  cp $FILEPATH/patch_nvm_$TLV_TYPE.tlv \
#    /config/telephony/patch_nvm.tlv
#
#elif [ "$COUNTRYCODE" == "KR" ]; then
#  CPACTION="yes"
#  cp $FILEPATH/patch_nvm_$TLV_TYPE.tlv \
#    /config/telephony/patch_nvm.tlv
#
#elif [ "$COUNTRYCODE" == "HK" ]; then
#  CPACTION="yes"
#  cp $FILEPATH/patch_nvm_$TLV_TYPE.tlv \
#    /config/telephony/patch_nvm.tlv
#
#elif [ "$COUNTRYCODE" == "SG" ]; then
#  CPACTION="yes"
#  cp $FILEPATH/patch_nvm_$TLV_TYPE.tlv \
#    /config/telephony/patch_nvm.tlv
#
## It's no  country code written in factory process
## when contry code is WWE in shipping image
#elif [ "$COUNTRYCODE" == "WWE" ]; then
#  CPACTION="yes"
#  cp $FILEPATH/patch_nvm_$TLV_TYPE.tlv \
#    /config/telephony/patch_nvm.tlv
else
  CPACTION="yes"
  cp $FILEPATH/patch_nvm_$TLV_TYPE.tlv \
    /config/telephony/patch_nvm.tlv
fi

if [ $? -ne 0 -o "$CPACTION" == "no" ]; then
  setprop persist.modem.tlv.cpaction "nodone"
else
  chown system:radio /config/telephony/patch_nvm.tlv
  chmod 664 /config/telephony/patch_nvm.tlv
  setprop persist.modem.tlv.cpaction "done"
fi
