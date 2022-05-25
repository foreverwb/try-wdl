version 1.0

task step1{
    meta {
        description: "Test Bandwidth And Resource Schedule"
    }
    input {
        String DOCKER = "alexeyebi/bowtie2_samtools"

        File input
        File anotherInput

        Int NUM_THREAD = 5
        String MEMORY = "10 GB"
        String DISK = "250 GB"

    }
    command {
        date;
        for i in `seq 1 $(cat /proc/cpuinfo |grep "physical id" |wc -l)`; do dd if=/dev/zero of=/dev/null bs=1K count=102400000 & done;
        sleep 5m;
        date;
    }
    runtime {
        docker: "${DOCKER}"
        cpu: "${NUM_THREAD}"
        memory: "${MEMORY}"
        disk: "${DISK}"
    }
}
