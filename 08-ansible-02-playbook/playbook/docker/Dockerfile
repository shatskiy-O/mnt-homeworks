FROM centos:7

# Установка необходимых пакетов
RUN yum -y install openssh-server sudo && \
    yum clean all && \
    ssh-keygen -A

# Настройка пользователя root
RUN echo 'root:Teremok2011' | chpasswd

# Запуск SSHD в фоновом режиме
CMD ["/usr/sbin/sshd", "-D"]
