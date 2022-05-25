version 1.0

import "./tasks.wdl" as tvc
workflow melt {
    input{
        Array[File] input1
        Array[File] input2https://github.com/2uschauer/testwdl

        String DOCKER = "alexeyebi/bowtie2_samtools"

        Int NUM_THREAD = 5
        String MEMORY = "10 GB"
        String DISK = "250 GB"
    }

    scatter(pair in zip(input1,input2)){
        call tvc.call_MELT_step1{
            input:input1=pair.left,
                input2=pair.right,
                docker=DOCKER,
                NUM_THREAD=NUM_THREAD,
                MEMORY=MEMORY,
                DISK=DISK
        }
    }
}
