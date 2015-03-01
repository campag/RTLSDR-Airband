S = rtl_airband_asm.s

C = rtl_airband.cpp hello_fft/mailbox.c hello_fft/gpu_fft.c hello_fft/gpu_fft_base.c hello_fft/gpu_fft_twiddles.c hello_fft/gpu_fft_shaders.c

B = rtl_airband

F = -L/opt/vc/lib/ -lbcm_host -I/opt/vc/include -I/opt/vc/include/interface/vcos/pthreads -I/opt/vc/include/interface/vmcs_host/linux
F += -lrt -lm -lvorbisenc -lmp3lame -lshout -lpthread -lrtlsdr -o $(B)

#RPI1
#CC = g++
#T = -mcpu=arm1176jzf-s -march=armv6zk -mfpu=vfp 
#F += -O3 -mtune=arm1176jzf-s

#RPI2 g++ (v4.6 as std with Raspbian Wheezy)
CC = g++
T = -mfpu=neon-vfpv4 -march=armv7-a
F += -O3 -DRPI2

#RP2 g++-4.8
#CC = g++-4.8
#T = -mcpu=cortex-a7 -mfloat-abi=hard -mfpu=neon-vfpv4
#F += -O3 -DRPI2 -Ofast -ftree-vectorize
## -ftreevectorizer-verbose=1

$(B):
	as -o rtl_airband_asm.o $(S) $(T)
	$(CC) $(F) $(T) $(C) $(S)

clean:
	rm -f $(B)
	rm -f rtl_airband_asm.o
