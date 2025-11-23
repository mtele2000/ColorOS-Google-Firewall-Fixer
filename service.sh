#!/system/bin/sh

until [ $(getprop sys.boot_completed) -eq 1 ] ; do
  sleep 2
done

# 不做检测函数，等待一分钟，等待系统完整加载默认 iptables 规则
sleep 60

SCRIPT_DIR=${0%/*}

source ${SCRIPT_DIR}/common.sh

if [ -f "$LOGFILE" ]; then
    cp -f "$LOGFILE" "$BAKLOG"
    echo "[$(date)] 日志已备份，开始新日志记录" > "$LOGFILE"
else
    echo "[$(date)] 日志开始记录" > "$LOGFILE"
fi

echo "[$(date)] 开始处理防火墙规则..." >> "$LOGFILE"

remove_reject_rules "fw_INPUT"

remove_reject_rules "fw_OUTPUT"

echo "[$(date)] 防火墙规则处理完成" >> "$LOGFILE"
