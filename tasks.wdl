version 1.0

task step1{
    meta {
        description: "Test Bandwidth And Resource Schedule"
    }
    input {
        String DOCKER = "ubuntu:18.04"

        File BigFile
        File SmallFile

        Int NUM_THREAD = 5
        String MEMORY = "10 GB"
        String DISK = "250 GB"
        String SLEEP = "10m"

    }
    command {
        mkdir -p input
        dd if=/dev/zero of=/input/res.txt bs=1K count=1024000;
        for i in `seq 1 $(cat /proc/cpuinfo | grep "physical id" | wc -l)`; do dd if=/dev/zero of=/dev/null & done;
        sleep ${SLEEP};
    }
    runtime {
        docker: "${DOCKER}"
        cpu: "${NUM_THREAD}"
        memory: "${MEMORY}"
        disk: "${DISK}"
    }
    output {
        # get all the output as array
        Array[File] output_step1 = glob("*")
    }
}

task step2{
    meta {
        description: "Test IO"
    }
    input {
        String DOCKER = "ubuntu:18.04"

        Array[File] step1_output

        Int NUM_THREAD = 5
        String MEMORY = "10 GB"
        String DISK = "250 GB"
        String SLEEP = "10m"
    }
    command {
        ls ${sep = ' ' step1_output} > output.txt
        sleep ${SLEEP};
    }
    runtime {
        docker: "${DOCKER}"
        cpu: "${NUM_THREAD}"
        memory: "${MEMORY}"
        disk: "${DISK}"
    }

    output {
        # get all the output as array
        Array[File] output_step2 = glob("*")
    }
}
