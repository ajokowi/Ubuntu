FROM ubuntu:24.04

# Install SSH server dan sudo
RUN apt-get update && apt-get install -y openssh-server sudo && rm -rf /var/lib/apt/lists/*

# Konfigurasi direktori SSH
RUN mkdir /var/run/sshd

# Tambahkan user baru (Ganti 'ubuntuuser' dan 'PasswordDisini' sesuai keinginan)
RUN useradd -rm -d /home/ubuntuuser -s /bin/bash -g root -G sudo -u 1000 ubuntuuser
RUN echo 'fmc:fmc' | chpasswd

# Izinkan login SSH via password
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /stop/etc/ssh/sshd_config

# Railway menggunakan port dinamis via variabel $PORT
ENV PORT=22
EXPOSE 22

# Jalankan SSH server di latar depan
CMD ["/usr/sbin/sshd", "-D", "-p", "22"]
