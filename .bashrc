export SYSTEMC_HOME=/usr/local/systemc-2.3.2
export SYSTEMC_INCLUDE=$SYSTEMC_HOME/include
export SYSTEMC_LIBDIR=$SYSTEMC_HOME/lib-linux64

export LD_LIBRARY_PATH=$SYSTEMC_LIBDIR:$LD_LIBRARY_PATH

export MTI_HOME=/opt/intelFPGA/22.2/questa_fse

export GCC_HOME=$MTI_HOME/gcc-7.4.0-linux_x86_64

export PATH=$MTI_HOME/bin:$GCC_HOME/bin:$PATH
