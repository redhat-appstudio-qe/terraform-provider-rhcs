FROM registry.access.redhat.com/ubi9/go-toolset:latest AS builder
COPY . .

ENV GOFLAGS=-buildvcs=false
RUN git config --global --add safe.directory /opt/app-root/src
#RUN git config --global --add safe.directory /opt/app-root/src && \
RUN make prepare_release

FROM registry.access.redhat.com/ubi9/ubi-micro:latest
LABEL description="Terraform Provider RHCS"
LABEL io.k8s.description="Terraform Provider RHCS"
LABEL com.redhat.component="terraform-provider-rhcs"
LABEL distribution-scope="release"
LABEL name="terraform-provider-rhcs" release="2.1" url="https://github.com/jinqi7/terraform-provider-rhcs"
LABEL vendor="Red Hat, Inc."
LABEL version="2.1"

COPY --from=builder /opt/app-root/src/releases /releases
