FROM restreamio/gstreamer:latest-dev AS builder

# Set workspace for builder.
WORKDIR /root/project

# Transfer sources to the build container context.
COPY src .

RUN mkdir -p build

# Perform building.
RUN gcc basic-tutorial-1.c -o build/basic-tutorial-1 `pkg-config --cflags --libs gstreamer-1.0`

FROM restreamio/gstreamer:latest-prod AS runner

# Place built executable inside ultimate image.
COPY --from=builder /root/project/build/basic-tutorial-1 /bin/basic-tutorial-1

# Set default entry command for image.
ENTRYPOINT [ "/bin/basic-tutorial-1" ]