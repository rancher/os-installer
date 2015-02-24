FROM ubuntu:14.04.1
ADD ./scripts/bootstrap /scripts/bootstrap
RUN /scripts/bootstrap
ADD ./scripts /scripts
ADD ./dist /dist

CMD ["/bin/bash"]
