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
        date;
        for i in `seq 1 $(cat /proc/cpuinfo | grep "physical id" | wc -l)`; do dd if=/dev/zero of=/dev/null & done;
        sleep 10m;
        date;
        ps aux | grep -w dd | awk '{print $2}' | xargs  kill -9;
        date;
    }
    runtime {
        docker: "${DOCKER}"
        cpu: "${NUM_THREAD}"
        memory: "${MEMORY}"
        disk: "${DISK}"
    }
}
