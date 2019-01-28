#!/bin/bash
source helper.sh;

make trace-processor

trace-kernel() {
for itr in $(seq 1)
do
    $qemubin -trace exec_tb_block -smp 2 -m 8G -cpu kvm64 \
        -drive file="$workdir/qemu-disk.ext4,if=ide,format=raw" \
        -kernel bzImage.vanilla -nographic -no-reboot \
        -append "nokaslr panic=-1 console=ttyS0 root=/dev/sda rw init=/bin/bash" \
             2> trace-tmp;
    cat trace-tmp | ./bin/trace-parser | sort | uniq | ./trace2line.sh > lines
    cat lines | ./line2config.sh > kernel.config
    cat lines | ./file2config.sh > driver.config
    cat kernel.config driver.config > new.config
    rm trace-tmp;
done
}
trace-kernel "$1";

