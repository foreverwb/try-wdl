version 1.0

import "./tasks.wdl" as tvc
workflow melt {
    input{
        Array[File] input
        Array[File] anotherInput

        String DOCKER

        Int NUM_THREAD
        String MEMORY
        String DISK
    }

    scatter(pair in zip(input,anotherInput)){
        call tvc.step1{
            input:input=pair.left,
                anotherInput=pair.right,
                docker=DOCKER,
                NUM_THREAD=NUM_THREAD,
                MEMORY=MEMORY,
                DISK=DISK
        }
    }
}
