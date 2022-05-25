version 1.0

import "./tasks.wdl" as tvc
workflow melt {
    input{
        Array[File] input1
        Array[File] input2

        String DOCKER

        Int NUM_THREAD
        String MEMORY
        String DISK
    }

    scatter(pair in zip(input1,input2)){
        call tvc.step1{
            input:input1=pair.left,
                input2=pair.right,
                docker=DOCKER,
                NUM_THREAD=NUM_THREAD,
                MEMORY=MEMORY,
                DISK=DISK
        }
    }
}
