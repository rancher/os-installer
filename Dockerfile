FROM debian:jessie
ADD ./scripts /scripts
RUN /scripts/bootstrap

ENV RANCHEROS_VERSION v0.1.1

ADD https://github.com/rancherio/os/releases/download/v0.1.1/vmlinuz /dist/vmlinuz
ADD https://github.com/rancherio/os/releases/download/v0.1.1/initrd /dist/initrd

ENTRYPOINT ["/scripts/lay-down-os"]
CMD ["/dev/sda"]
