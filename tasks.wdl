version 1.0

task step1{
    meta {
        description: "Test Bandwidth And Resource Schedule"
    }
    input {
        String DOCKER = "alexeyebi/bowtie2_samtools"

        File BigFile
        File SmallFile

        Int NUM_THREAD = 5
        String MEMORY = "10 GB"
        String DISK = "250 GB"

    }
    command {
        sudo mkdir /tmp/memory;
        mount -t tmpfs -o size=$num tmpfs /tmp/memory;
        dd if=/dev/zero of=/tmp/memory/block bs=5K count=1024000 &;
        for i in `seq 1 $(cat /proc/cpuinfo | grep "physical id" | wc -l)`; do dd if=/dev/zero of=/dev/null & done;
        sleep 1m;
        ps ux;
        free;
        sleep 10m;
    }
    runtime {
        docker: "${DOCKER}"
        cpu: "${NUM_THREAD}"
        memory: "${MEMORY}"
        disk: "${DISK}"
    }
}
