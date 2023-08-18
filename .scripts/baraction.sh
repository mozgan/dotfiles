#!/bin/sh

hostname="${HOSTNAME:-${hostname:-$(hostname)}}"

# === === === DISK === === ===
hddicon() {
    echo ""
}

hdd() {
    free="$(df -h /home | grep /dev | awk '{print $3}' | sed 's/G/Gb/')"
    total="$(df -h /home | grep /dev | awk '{print $2}' | sed 's/G/Gb/')"
    perc="$(df -h /home | grep /dev/ | awk '{print $5}')"

    echo "$perc ($free / $total)"
}

# === === === RAM === === ===
memicon() {
    echo ""
}

mem() {
    used="$(free | grep Mem: | awk '{print $3}')"
    total="$(free | grep Mem: | awk '{print $2}')"
    human_used="$(free -h | grep Mem: | awk '{print $3}' | sed s/i//g)"
    human_total="$(free -h | grep Mem: | awk '{print $2}' | sed s/i//g)"

    ram="$(( 200 * $used/$total - 100 * $used/$total ))% ($human_used / $human_total) "

    echo "$ram"
}

# === === === CPU === === ===
cpuicon() {
    echo ""
}

cpu() {
    read cpu a b c previdle rest < /proc/stat
    prevtotal=$((a+b+c+previdle))
    sleep 0.5
    read cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))

    echo "$cpu%"
}

cputemp() {
    if ! [ -x "$(command -v sensors)" ]; then
	echo ""
    else
	temp="$(sensors | grep CPU: | grep + | awk '{ print $2 }')"
	echo "($temp)"
    fi
}

# === === === VOLUME === === ===
volicon() {
    VOLONOFF="$(amixer -D pulse get Master | grep Left: | sed 's/[][]//g' | awk '{print $6}')"

    VOLON="♪"
    VOLOFF="♪"

    if [ "$VOLONOFF" = "on" ]; then
        echo "$VOLON"
    else
        echo "$VOLOFF"
    fi
}

vol() {
    #VOL="$(amixer -D pulse get Master | grep Left: | sed 's/[][]//g' | awk '{print $5}')"
    #VOL=`amixer get Master | awk -F'[][]' 'END{ print $4":"$2 }' | sed 's/on://g'`
    VOL=`amixer get Master | awk -F'[][]' 'END{ print $2 }'`

    echo "$VOL"
}

# === === === PACKAGES === === ===
pkgicon() {
    echo ""
}

pkgs() {
    pkgs="$(dpkg -l | grep -c ^i)"
    echo "$pkgs"
}

# === === === UPGRADES === === ===
upgradeicon() {
    echo ""
}

upgrades(){
    upgrades="$(aptitude search '~U' | wc -l)"
    echo "$upgrades"
}


# === === === UPGRADES === === ===
networkicon() {
    wire="$(ip a | grep "eth0\|enp" | grep inet | wc -l)"
    wifi="$(ip a | grep wlp7s0 | grep inet | wc -l)"

    if [ $wire = 1 ]; then
        echo ""
    elif [ $wifi = 1 ]; then
        echo ""
    else
        echo "睊"
    fi
}

ipaddress() {
    address="$(ip a | grep .255 | grep wlp | cut -d ' ' -f6 | sed 's/\/24//')"
    echo "$address"
}



SLEEP=1

while :; do
    echo "+@fg=1; $(cpuicon) +@fg=0; $(cpu) $(cputemp) |\
+@fg=3; $(hddicon) +@fg=0; $(hdd) |\
+@fg=1; $(memicon) +@fg=0; $(mem) |\
+@fg=2; $(pkgicon) +@fg=0; $(pkgs) |\
+@fg=2; $(upgradeicon) +@fg=0; $(upgrades) |\
+@fg=4; $(networkicon) +@fg=0; $(ipaddress) |\
+@fg=5; $(volicon) +@fg=0; $(vol)\
    "

    sleep $SLEEP
done



