FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    qemu-system-x86 \
    novnc \
    websockify \
    git \
    curl \
    python3 \
    && apt-get clean

# Working directory
WORKDIR /vm

# Copy disk and startup script
COPY win10.qcow2 .
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Clone noVNC
RUN git clone https://github.com/novnc/noVNC.git /novnc && \
    git clone https://github.com/novnc/websockify /novnc/utils/websockify

EXPOSE 6080

CMD ["/start.sh"]
