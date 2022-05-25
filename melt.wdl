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
    }

    scatter(pair in zip(BigFiles,SmallFiles)){
        call tvc.step1{
            input:BigFile=pair.left,
                SmallFile=pair.right,
                DOCKER=DOCKER,
                NUM_THREAD=NUM_THREAD,
                MEMORY=MEMORY,
                DISK=DISK
        }
    }
}
