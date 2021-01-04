#!/bin/bash
#--------------CopyRight----------------
#  Name: DA VLSI Exercise Upload Tool
#  Version Number: 1.00a
#  Type: Application
#  Language: bash shell
#  Date: 13.Oct.14
#  Author: vonjack
#  Email: fga@mail.ustc.edu.cn
#--------------Environment--------------
#  Terminal: cols=80 lines=24
#  RedHat Linux i686
#  GNU Bash
#---------------------------------------

#---------------Define------------------
ECHO="echo -ne"
DSTDIR="/js1/songch/DA_Submissions"
USAGEMSG="Usage: upload_hm.sh [your exercise dir]\n"
ZIPMSG="Compress failed!\nPlease check your dictionary permission!\n"
SENDMSG="Uploaded failed!\nPlease check your account permission!\n"
SUCCEEDMSG="Uploaded successed!\n"

OK=0
FALSE=1

#---------------Variable----------------
SRCDIR=''
ZIPFILENAME=''
SRCBASENAME=''

#---------------Function-----------------

#main
function Main()
{
    SRCDIR=~/DA_VLSI_Lab7
    ZIPFILENAME=${USER}_Lab7.tar.gz
    
    rm -rf ${SRCDIR}/alib-52
    rm -rf ${SRCDIR}/WORK
    rm -rf ${SRCDIR}/csrc
    rm -rf ${SRCDIR}/simv.daidir
    tar czf $ZIPFILENAME ${SRCDIR}/

    if [ $? -ne 0 ]
    then
        $ECHO $ZIPMSG
        return $FALSE
    fi

    scp $ZIPFILENAME songch@localhost:$DSTDIR

    if [ $? -ne 0 ]
    then
        $ECHO $SENDMSG
        return $FALSE
    fi

    $ECHO $SUCCEEDMSG

    return $OK
}
#-----------------Main-------------------

Main $*
