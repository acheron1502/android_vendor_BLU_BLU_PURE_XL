#!/system/bin/sh
  echo 1 > /sys/module/sec/parameters/recovery_done		#koshi   
if ! applypatch -c EMMC:recovery:8706048:fb8b56276e5f26914d4f6382625870a19e48f446; then
  log -t recovery "Installing new recovery image"
  applypatch -b /system/etc/recovery-resource.dat EMMC:boot:7356416:33cdd3fdb3df1bf4a1c26037e0d835e1c4d32c8c EMMC:recovery fb8b56276e5f26914d4f6382625870a19e48f446 8706048 33cdd3fdb3df1bf4a1c26037e0d835e1c4d32c8c:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
  if applypatch -c EMMC:recovery:8706048:fb8b56276e5f26914d4f6382625870a19e48f446; then		#koshi
	echo 0 > /sys/module/sec/parameters/recovery_done		#koshi
        log -t recovery "Install new recovery image completed"
        
  if applysig /system/etc/recovery.sig recovery; then
    sync
    log -t recovery "Apply recovery image signature completed"
  else
    log -t recovery "Apply recovery image signature fail!!"
  fi

    
  else
	echo 2 > /sys/module/sec/parameters/recovery_done		#koshi
        log -t recovery "Install new recovery image not completed"
  fi
else
  echo 0 > /sys/module/sec/parameters/recovery_done         #koshi
  log -t recovery "Recovery image already installed"
fi
if ! applypatch -c EMMC:tee2:408064:bf2c8cf0786b3afbfeb19038eb96eb48477e1f67; then
  log -t recovery "Installing new t-base image"
  applypatch -t /system/etc/trustzone.bin EMMC:tee2:408064:bf2c8cf0786b3afbfeb19038eb96eb48477e1f67 
else
  log -t recovery "t-base image already installed"
fi
