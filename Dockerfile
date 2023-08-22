# Use the official Ubuntu base image
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update package repositories and install required packages
RUN apt-get update -y && \
    apt-get install -y software-properties-common && \
    apt-add-repository --yes --update ppa:ansible/ansible && \
    apt-get install -y ansible python3-pip && \
    pip3 install pywinrm && \
    apt-get install -y openssh-server && \
    mkdir -p /var/run/sshd

# Clean up APT cache
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /ansible

# Copy your Ansible playbook and configuration files if needed
# COPY ansible.cfg .
# COPY playbook.yml .

# Set the root password (for demonstration purposes, you can change this)
RUN echo 'root:password' | chpasswd

# Expose SSH port
EXPOSE 22

# Start SSH server and a bash shell by default
CMD service ssh start && /bin/bash
