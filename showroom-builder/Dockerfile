# Use Red Hat UBI9 as the base image
FROM registry.access.redhat.com/ubi9

# Install necessary tools
RUN dnf install -y \
    git \
    nodejs \
    wget && \
    dnf clean all

RUN wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq &&\
    chmod +x /usr/bin/yq


RUN npm install -g gulp @antora/cli@2.3.4 @antora/site-generator-default@2.3.4

# Create a user named 'antora'
# RUN useradd -ms /bin/bash antora
RUN useradd -u 1001 -ms /bin/bash antora && \
    mkdir -p /antora && \
    chown -R antora:antora /antora

# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Change ownership of the entrypoint script to the antora user
RUN chown antora:antora /entrypoint.sh

# Switch to the 'antora' user
USER antora
EXPOSE 80
# Set the entrypoint script as the command to run when the container starts
ENTRYPOINT ["/entrypoint.sh"]
