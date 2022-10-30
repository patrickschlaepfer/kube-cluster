FROM ubuntu:focal

# Python 3 3.9.9
# Kubernetes client (kubectl) 1.22.4
# Kubernetes context switcher (kubectx)
# Kustomize 4.4.1

ENV DOCKER_HOSTNAME=${DOCKER_HOSTNAME:-hostname123}

RUN apt update -y
RUN apt install -y software-properties-common curl

# Add python 3.9
RUN add-apt-repository -y ppa:deadsnakes/ppa
RUN apt install -y python3.9
RUN ln -s /usr/bin/python3.9 /usr/local/bin/python3

# Add kustomize
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
RUN mv kustomize /usr/local/bin

# Add kubectl
RUN curl -LOs "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN mv kubectl /usr/local/bin
RUN chmod +x /usr/local/bin/kubectl

# Add kubens
RUN curl -LOs "https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubens_v0.9.4_linux_x86_64.tar.gz"
RUN gunzip /kubens_v0.9.4_linux_x86_64.tar.gz
RUN tar xvf kubens_v0.9.4_linux_x86_64.tar -C /usr/local/bin
RUN rm /kubens_v0.9.4_linux_x86_64.tar

# /root/.kube/config
RUN mkdir -p /root/.kube
COPY control1.yml /root/.kube/config

WORKDIR /forgeops/bin
ENTRYPOINT ["/forgeops/bin/cdk"]
