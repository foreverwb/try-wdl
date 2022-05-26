version 1.0

import "./tasks.wdl" as tvc
workflow melt {
    input{
        Array[File] BigFiles
        Array[File] SmallFiles

        String DOCKER

        Int NUM_THREAD
        String MEMORY
        String DISK
        String STEP1SLEEP = "10m"
        String STEP2SLEEP = "10m"
    }

    scatter(pair in zip(BigFiles,SmallFiles)){
        call tvc.step1{
            input:BigFile=pair.left,
                SmallFile=pair.right,
                DOCKER=DOCKER,
                NUM_THREAD=NUM_THREAD,
                MEMORY=MEMORY,
                DISK=DISK,
                SLEEP=STEP1SLEEP
        }
    }
    call tvc.step2{
        input: step1_output=flatten(step1.output_step1),
            DOCKER=DOCKER,
            NUM_THREAD=NUM_THREAD,
            MEMORY=MEMORY,
            DISK=DISK,
            SLEEP=STEP2SLEEP
    }
}
