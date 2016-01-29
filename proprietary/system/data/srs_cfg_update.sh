#Gionee tangwei 20150604 add for dts config file CR01471094

if [ -e /data/misc/.srs_update_flag ]; then
    echo "INFO: no update for SRS cfg."
else
    echo "INFO: SRS cfg will be updated."
    touch /data/misc/.srs_update_flag
    rm /data/misc/srs_processing.cfg
    cp /system/data/srs_processing.cfg /data/misc/srs_processing.cfg
    chmod 0666 /data/misc/srs_processing.cfg
fi
